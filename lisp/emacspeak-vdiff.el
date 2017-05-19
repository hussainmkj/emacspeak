;;; emacspeak-vdiff.el --- Speech-enable VDIFF  -*- lexical-binding: t; -*-
;;; $Author: tv.raman.tv $
;;; Description:  Speech-enable VDIFF An Emacs Interface to vdiff
;;; Keywords: Emacspeak,  Audio Desktop vdiff
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
;;; MERCHANTABILITY or FITNVDIFF FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Emacs; see the file COPYING.  If not, write to
;;; the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

;;}}}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;{{{  introduction

;;; Commentary:
;;; VDIFF ==  vimdiff
;;; Installable from melpa, vdiff enables synchronized movement
;;; through diff buffers without resorting to an extra control-panel
;;; as is the case with ediff.

;;; Code:

;;}}}
;;{{{  Required modules

(require 'cl)
(declaim  (optimize  (safety 0) (speed 3)))
(require 'emacspeak-preamble)

;;}}}
;;{{{ Map Faces:

(voice-setup-add-map
 '(
   (vdiff-addition-face voice-brighten)
   (vdiff-change-face voice-bolden)
   (vdiff-closed-fold-face voice-smoothen)
   (vdiff-open-fold-face voice-lighten)
   (vdiff-refine-added voice-brighten)
   (vdiff-refine-changed voice-lighten)
   (vdiff-subtraction-face voice-smoothen)
   (vdiff-subtraction-fringe-face voice-smoothen-extra)
   (vdiff-target-face voice-monotone)))

;;}}}
;;{{{ Interactive Commands:


(defadvice vdiff-refine-all-hunks (after emacspeak pre act comp)
  "Provide auditory feedback."
  (when (ems-interactive-p)
    (emacspeak-auditory-icon 'task-done)))
(cl-loop
 for f in
 '(vdiff-buffers vdiff-buffers3 vdiff-magit-compare
  vdiff-current-file vdiff-files vdiff-files3)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
  "Provide auditory feedback."
  (when (ems-interactive-p)
    (emacspeak-auditory-icon 'task-done)
    (emacspeak-speak-mode-line)))))
  
  
;;}}}


;;{{{ open/close Folds:
(cl-loop
 for f in
 '(vdiff-open-all-folds vdiff-open-fold)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
     "Provide auditory feedback."
     (when (ems-interactive-p)
       (emacspeak-auditory-icon 'open-object)
       (emacspeak-speak-line)))))

(cl-loop
 for f in
 '(vdiff-close-all-folds vdiff-close-fold vdiff-close-other-folds)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
     "Provide auditory feedback."
     (when (ems-interactive-p)
       (emacspeak-auditory-icon 'close-object)
       (emacspeak-speak-line)))))

;;}}}
;;{{{ Navigation:
(defadvice vdiff--scroll-function (around emacspeak pre act comp)
  "Silence messages."
  (ems-with-messages-silenced ad-do-it))

(cl-loop
 for f in
 '(vdiff-next-fold vdiff-next-hunk vdiff-previous-fold vdiff-previous-hunk)
 do
 (eval
  `(defadvice ,f (after emacspeak pre act comp)
     "Provide auditory feedback."
     (when (ems-interactive-p)
       (emacspeak-speak-line)
       (emacspeak-auditory-icon 'large-movement)))))

;;}}}
(provide 'emacspeak-vdiff)
;;{{{ end of file

;;; local variables:
;;; folded-file: t
;;; byte-compile-dynamic: t
;;; end:

;;}}}
