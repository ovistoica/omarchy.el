;;; omarchy-test.el --- Tests for omarchy.el  -*- lexical-binding: t; -*-

;;; Commentary:
;;
;; Batch-runnable ERT tests for the font height handling in `omarchy.el'.
;; In batch mode `display-graphic-p' is nil and `frame-list' holds a
;; single terminal frame, so display-dependent primitives are stubbed
;; with `cl-letf' where a graphical frame needs to be simulated.
;;
;; Run from the repository root with:
;;
;;   $ emacs -Q --batch -L . -l ert -l test/omarchy-test.el \
;;           -f ert-run-tests-batch-and-exit

;;; Code:

(require 'ert)
(require 'cl-lib)
(require 'server)
(require 'omarchy)

(defmacro omarchy-test--with-clean-font-state (&rest body)
  "Run BODY with the font-related global state reset before and after."
  (declare (indent 0))
  `(let ((omarchy-font-height nil)
         (omarchy--warned-unusable-height nil)
         (omarchy--pending-font nil))
     (unwind-protect
         (progn ,@body)
       (remove-hook 'server-after-make-frame-hook #'omarchy--apply-pending-font))))

(defun omarchy-test--plist-height (args)
  "Return the `:height' value from the `set-face-attribute' ARGS list."
  (plist-get (nthcdr 2 args) :height))

;;; omarchy--sane-height-p

(ert-deftest omarchy-test-sane-height-p ()
  "Only integers at or above the minimum sane height are usable."
  (should-not (omarchy--sane-height-p 1))
  (should-not (omarchy--sane-height-p 'unspecified))
  (should-not (omarchy--sane-height-p 19))
  (should (omarchy--sane-height-p 20))
  (should (omarchy--sane-height-p 120)))

;;; omarchy--resolve-font-height

(ert-deftest omarchy-test-resolve-font-height-explicit-wins ()
  "An explicit HEIGHT overrides both the custom and the current height."
  (omarchy-test--with-clean-font-state
    (let ((omarchy-font-height 130))
      (cl-letf (((symbol-function 'face-attribute) (lambda (&rest _) 140)))
        (should (= 150 (omarchy--resolve-font-height (selected-frame) 150)))))))

(ert-deftest omarchy-test-resolve-font-height-custom-wins-over-current ()
  "`omarchy-font-height' overrides the height in effect on the frame."
  (omarchy-test--with-clean-font-state
    (let ((omarchy-font-height 130))
      (cl-letf (((symbol-function 'face-attribute) (lambda (&rest _) 140)))
        (should (= 130 (omarchy--resolve-font-height (selected-frame))))))))

(ert-deftest omarchy-test-resolve-font-height-preserves-sane-current ()
  "A usable current height is preserved when nothing else is given."
  (omarchy-test--with-clean-font-state
    (cl-letf (((symbol-function 'face-attribute) (lambda (&rest _) 140))
              ((symbol-function 'display-warning)
               (lambda (&rest _) (ert-fail "unexpected warning"))))
      (should (= 140 (omarchy--resolve-font-height (selected-frame)))))))

(ert-deftest omarchy-test-resolve-font-height-poisoned-falls-back-and-warns-once ()
  "A poisoned current height falls back to 110 and warns exactly once."
  (omarchy-test--with-clean-font-state
    (let ((warnings 0))
      (cl-letf (((symbol-function 'face-attribute) (lambda (&rest _) 1))
                ((symbol-function 'display-warning)
                 (lambda (&rest _) (cl-incf warnings))))
        (should (= 110 (omarchy--resolve-font-height (selected-frame))))
        (should (= 110 (omarchy--resolve-font-height (selected-frame))))
        (should (= 1 warnings))))))

(ert-deftest omarchy-test-resolve-font-height-honours-fallback-option ()
  "`omarchy-fallback-font-height' controls the value used for a poisoned height."
  (omarchy-test--with-clean-font-state
    (let ((omarchy-fallback-font-height 90))
      (cl-letf (((symbol-function 'face-attribute) (lambda (&rest _) 1))
                ((symbol-function 'display-warning) #'ignore))
        (should (= 90 (omarchy--resolve-font-height (selected-frame))))))))

;;; omarchy-apply-font without a graphical frame

(ert-deftest omarchy-test-apply-font-defers-without-graphic-frame ()
  "Without a graphical frame the font is queued for the first client frame."
  (omarchy-test--with-clean-font-state
    (let ((set-calls nil))
      (cl-letf (((symbol-function 'set-face-attribute)
                 (lambda (&rest args) (push args set-calls))))
        (omarchy-apply-font "X")
        (should (equal '("X" . nil) omarchy--pending-font))
        (should (memq #'omarchy--apply-pending-font server-after-make-frame-hook))
        (should-not set-calls)))))

;;; omarchy--apply-pending-font

(ert-deftest omarchy-test-apply-pending-font-runs-once-and-cleans-up ()
  "The pending font is applied, the queue cleared and the hook removed."
  (omarchy-test--with-clean-font-state
    (let ((calls nil))
      (setq omarchy--pending-font '("Fira Code" . 120))
      (add-hook 'server-after-make-frame-hook #'omarchy--apply-pending-font)
      (cl-letf (((symbol-function 'display-graphic-p) (lambda (&rest _) t))
                ((symbol-function 'omarchy-apply-font)
                 (lambda (font &optional height) (push (list font height) calls))))
        (omarchy--apply-pending-font)
        (should (equal '(("Fira Code" 120)) calls))
        (should-not omarchy--pending-font)
        (should-not (memq #'omarchy--apply-pending-font
                          server-after-make-frame-hook))))))

;;; omarchy-apply-font with a graphical frame

(defmacro omarchy-test--with-graphic-frame (current-height set-calls &rest body)
  "Run BODY as if a graphical frame with CURRENT-HEIGHT existed.
`set-face-attribute' calls are pushed onto the variable SET-CALLS."
  (declare (indent 2))
  `(let ((,set-calls nil))
     ;; `font-family-list' is a C primitive: redefining it makes native-comp
     ;; build a trampoline in-process, which loads libraries whose `defface's
     ;; call `set-face-attribute'.  Stub it in an outer form so that happens
     ;; before the face functions below are replaced.
     (cl-letf (((symbol-function 'font-family-list)
                (lambda (&rest _) '("Iosevka Nerd Font Mono"))))
       (cl-letf (((symbol-function 'omarchy--graphic-frame) #'selected-frame)
                 ((symbol-function 'face-attribute) (lambda (&rest _) ,current-height))
                 ((symbol-function 'display-warning) #'ignore)
                 ((symbol-function 'set-face-attribute)
                  (lambda (&rest args) (push args ,set-calls))))
         ,@body))))

(ert-deftest omarchy-test-apply-font-poisoned-height-uses-fallback ()
  "A poisoned current height is replaced by the fallback when applying."
  (omarchy-test--with-clean-font-state
    (omarchy-test--with-graphic-frame 1 set-calls
      (omarchy-apply-font "Iosevka Nerd Font Mono")
      (should (= 1 (length set-calls)))
      (should (= 110 (omarchy-test--plist-height (car set-calls)))))))

(ert-deftest omarchy-test-apply-font-sane-height-preserved ()
  "A usable current height survives a font family change."
  (omarchy-test--with-clean-font-state
    (omarchy-test--with-graphic-frame 140 set-calls
      (omarchy-apply-font "Iosevka Nerd Font Mono")
      (should (= 1 (length set-calls)))
      (should (= 140 (omarchy-test--plist-height (car set-calls)))))))

(ert-deftest omarchy-test-apply-font-unknown-font-is-noop ()
  "A font missing from `font-family-list' is not applied."
  (omarchy-test--with-clean-font-state
    (omarchy-test--with-graphic-frame 140 set-calls
      (omarchy-apply-font "No Such Font")
      (should-not set-calls))))

;;; omarchy--repair-default-height

(ert-deftest omarchy-test-repair-default-height-poisoned ()
  "A poisoned height on a graphical frame is repaired to the fallback."
  (omarchy-test--with-clean-font-state
    (omarchy-test--with-graphic-frame 1 set-calls
      (omarchy--repair-default-height)
      (should (= 1 (length set-calls)))
      (should (= 110 (omarchy-test--plist-height (car set-calls)))))))

(ert-deftest omarchy-test-repair-default-height-sane-untouched ()
  "A usable height on a graphical frame is left alone."
  (omarchy-test--with-clean-font-state
    (omarchy-test--with-graphic-frame 140 set-calls
      (omarchy--repair-default-height)
      (should-not set-calls))))

(provide 'omarchy-test)
;;; omarchy-test.el ends here
