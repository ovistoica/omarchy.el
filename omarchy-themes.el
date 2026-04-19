;;; omarchy-themes.el --- Shared definitions for Omarchy derived themes  -*- lexical-binding: t; -*-

;; Copyright (C) 2026 Ovidiu Stoica

;; Author: Ovidiu Stoica <ovidiu.stoica1094@gmail.com>
;; URL: https://github.com/ovistoica/omarchy.el
;; Version: 0.1.0
;; Package-Requires: ((emacs "29.1") (modus-themes "4.4"))
;; Keywords: faces, theme

;;; Commentary:
;;
;; Shared library for the Omarchy theme collection.  Individual themes
;; live in the `themes/' subdirectory and all `(require 'omarchy-themes)'
;; so they share a single `custom-theme-load-path' entry (the themes/
;; subdir, registered by the autoload below) and the `omarchy-themes'
;; family symbol passed to `modus-themes-theme'.
;;
;; See Info node `(modus-themes) Complete example of a package that is
;; derived from Modus'.

;;; Code:

(require 'modus-themes)

(defgroup omarchy-themes nil
  "Modus-derived themes bundled with omarchy.el.
Each bundled theme provides a `<theme>-palette-overrides' defcustom
in this group, in the same format as
`modus-themes-common-palette-overrides'."
  :group 'modus-themes
  :prefix "omarchy-themes-")

;;;; Add themes from this package to the `custom-theme-load-path'

;;;###autoload
(when load-file-name
  (let ((themes-dir (expand-file-name
                     "themes/"
                     (file-name-directory load-file-name))))
    (add-to-list 'custom-theme-load-path themes-dir)))

(provide 'omarchy-themes)
;;; omarchy-themes.el ends here
