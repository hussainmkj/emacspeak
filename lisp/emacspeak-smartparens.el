;;; emacspeak-smartparens.el --- Speech-enable SMARTPARENS  -*- lexical-binding: t; -*-
;;; $Author: tv.raman.tv $
;;; Description:  Speech-enable SMARTPARENS An Emacs Interface to smartparens
;;; Keywords: Emacspeak,  Audio Desktop smartparens
;;{{{  LCD Archive entry:

;;; LCD Archive Entry:
;;; emacspeak| T. V. Raman |raman@cs.cornell.edu
;;; A speech interface to Emacs |
;;; $Date: 2007-05-03 18:13:44 -0700 (Thu, 03 May 2007) $ |
;;;  $Revision: 4532 $ |
;;; Location undetermined
;;;

;;}}}
;;{{{  Copyright:
;;;Copyright (C) 1995 -- 2007, 2011, T. V. Raman
;;; Copyright (c) 1994, 1995 by Digital Equipment Corporation.
;;; All Rights Reserved.
;;;
;;; This file is not part of GNU Emacs, but the same permissions apply.
;;;
;;; GNU Emacs is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2, or (at your option)
;;; any later version.
;;;
;;; GNU Emacs is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNSMARTPARENS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Emacs; see the file COPYING.  If not, write to
;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;}}}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;{{{  introduction

;;; Commentary:
;;; SMARTPARENS ==   Automatic insertion, wrapping and paredit-like navigation
;;; with user defined pairs
;;; this module speech-enables smartparens.

;;; Code:

;;}}}
;;{{{  Required modules
(eval-when-compile (require 'cl))
(require 'cl-lib)
(cl-declaim  (optimize  (safety 0) (speed 3)))
(require 'emacspeak-preamble)

;;}}}
;;{{{ Map Faces:

(voice-setup-add-map
 '(
   (sp-pair-overlay-face voice-lighten)
   (sp-show-pair-enclosing voice-bolden)
   (sp-show-pair-match-face voice-animate)
   (sp-show-pair-mismatch-face voice-monotone)
   (sp-wrap-overlay-closing-pair voice-smoothen)
   (sp-wrap-overlay-face voice-smoothen)
   (sp-wrap-overlay-opening-pair voice-bolden)
   (sp-wrap-tag-overlay-face voice-bolden)))

;;}}}
;;{{{ Advice low-level helpers:

(defadvice sp--pair-overlay-create (after emacspeak pre act comp)
  "Provide auditory feedback."
  (emacspeak-auditory-icon 'item))

;;}}}
;;{{{ Navigators And Killers bound in smartparens:

(cl-loop
 for f in
 '(
   sp-splice-sexp-killing-around sp-splice-sexp-killing-backward
                                 sp-splice-sexp-killing-forward sp-kill-sexp
                                 sp-copy-sexp sp--kill-or-copy-region)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
     "Provide auditory feedback."
     (when (ems-interactive-p)
       (emacspeak-speak-current-kill 1)
       (emacspeak-auditory-icon 'delete-object)))))

(cl-loop
 for f in
 '(
   sp-absorb-sexp sp-emit-sexp
   sp-add-to-next-sexp sp-add-to-previous-sexp
   sp-backward-barf-sexp sp-forward-barf-sexp
   sp-backward-sexp sp-down-sexp
   sp-backward-up-sexp sp-select-next-thing sp-backward-symbol
   sp-beginning-of-previous-sexp sp-beginning-of-next-sexp
   sp-beginning-of-sexp sp-backward-slurp-sexp
   sp-convolute-sexp sp-comment
   sp-end-of-next-sexp sp-end-of-previous-sexp
   sp-extract-before-sexp sp-extract-after-sexp
   sp-forward-parallel-sexp sp-backward-parallel-sexp
   sp-forward-slurp-sexp sp-backward-unwrap-sexp
   sp-forward-symbol sp-mark-sexp
   sp-highlight-current-sexp sp-forward-whitespace
   sp-html-previous-tag sp-html-next-tag
   sp-next-sexp sp-previous-sexp
   sp-rewrap-sexp sp-swap-enclosing-sexp
   sp-ruby-forward-sexp sp-ruby-backward-sexp
   sp-select-next-thing sp-select-previous-thing
   sp-select-next-thing-exchange sp-end-of-sexp
   sp-split-sexp sp-join-sexp
   sp-transpose-sexp
   sp-unwrap-sexp sp-backward-down-sexp
   sp-up-sexp sp-forward-sexp)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
     "Provide auditory feedback."
     (when (ems-interactive-p)
       (let ((emacspeak-show-point 'large-movement))
         (emacspeak-auditory-icon 'large-movement)
         (emacspeak-speak-line))))))

;;}}}
(provide 'emacspeak-smartparens)
;;{{{ end of file

;;; local variables:
;;; folded-file: t
;;; byte-compile-dynamic: t
;;; end:

;;}}}
