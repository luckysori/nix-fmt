;;; nix-fmt.el --- Reformat using `nix fmt'  -*- lexical-binding: t; -*-

;; Copyright (C) 2024  Lucas Soriano del Pino

;; Author: Lucas Soriano del Pino <lucas_soriano@fastmail.com>
;; Keywords: languages
;; URL: https://github.com/luckysori/nix-fmt
;; Package-Requires: ((emacs "24") (reformatter "0.3"))
;; Version: 0.1

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Provides commands and a minor mode for easily reformatting code
;; using the external `nix fmt' program.

;; This package depends on the presence of a `flake.nix', with a
;; `formatter' as part of its `outputs' attribute set. The only
;; `formatter' currently supported is `treefmt' (via `treefmt-nix').

;; Enable `nix-fmt-on-save-mode' locally to your project with a
;; form in your .dir-locals.el like this:

;; ((prog-mode . ((eval . (nix-fmt-on-save-mode)))))

;;; Code:

;; Minor mode and customisation

(require 'reformatter)

(defgroup nix-fmt nil
  "Reformat using the `nix fmt' command."
  :group 'languages)

(defcustom nix-fmt-command "nix"
  "Command used for reformatting."
  :type 'string)

;; Commands for reformatting

;;;###autoload (autoload 'nix-fmt-buffer "nix fmt" nil t)
;;;###autoload (autoload 'nix-fmt-region "nix fmt" nil t)
;;;###autoload (autoload 'nix-fmt-on-save-mode "nix fmt" nil t)
(reformatter-define nix-fmt
  :program nix-fmt-command
  ;; Here we are passing extra arguments to `treefmt'. If the user
  ;; were to use a different nix `formatter', this would almost
  ;; certainly not work!
  ;;
  ;; TODO: Support other formatters, such as `nixfmt'.
  :args (list "fmt" "--" "--stdin" input-file)
  :input-file (reformatter-temp-file-in-current-directory)
  :lighter " nix-fmt"
  :group 'nix-fmt)

(provide 'nix-fmt)
;;; nix-fmt.el ends here
