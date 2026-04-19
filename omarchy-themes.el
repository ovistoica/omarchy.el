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
;; (`rose-pine', `osaka-jade', `flexoki-light', `default-black') require
;; this file so they share a single `custom-theme-load-path' entry and
;; `omarchy-themes' family symbol for `modus-themes-theme'.
;;
;; See Info node `(modus-themes) Complete example of a package that is
;; derived from Modus'.

;;; Code:

(require 'modus-themes)

;;;; Add themes from this package to the `custom-theme-load-path'

;;;###autoload
(when load-file-name
  (let ((dir (file-name-directory load-file-name)))
    (add-to-list 'custom-theme-load-path dir)))

(provide 'omarchy-themes)
;;; omarchy-themes.el ends here
