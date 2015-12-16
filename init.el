(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)

(defvar my/bg-color "#111100")
(set-background-color my/bg-color)
(set-foreground-color "#EEFFFF")

(setq inhibit-startup-message t)

(show-paren-mode 1)
(column-number-mode t)

(which-function-mode t)


;;C-t action
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key "\C-t" 'other-window-or-split)

;;trr22
(add-to-list 'load-path "/usr/share/emacs/site-lisp/trr22")
(autoload 'trr "/usr/share/emacs/site-lisp/trr22/trr" nil t)

(setq x-select-enable-clipboard t)

;; frame size
(if (boundp 'window-system)
    (setq default-frame-alist
      (append (list
	   '(width  . 70)
	   '(height .  40)
	   )
	  default-frame-alist)))
(setq initial-frame-alist default-frame-alist)

;;white space settings
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
			 trailing       ; 行末
			 tabs           ; タブ
			 spaces         ; スペース
			 empty          ; 先頭/末尾の空行
			 space-mark     ; 表示のマッピング
			 tab-mark
			 ))
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
	;; WARNING: the mapping below has a problem.
	;; When a TAB occupies exactly one column, it will display the
	;; character ?\xBB at that column followed by a TAB which goes to
	;; the next TAB column.
	;; If this is a problem for you, please, comment the line below.
	(tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

;; スペースは全角のみを可視化
(setq whitespace-space-regexp "\\(\u3000+\\)")

;; 保存前に自動でクリーンアップ
(setq whitespace-action '(auto-cleanup))

(global-whitespace-mode 1)

(set-face-attribute 'whitespace-trailing nil
		    :background my/bg-color
		    :foreground "DeepPink"
		    :underline t)
(set-face-attribute 'whitespace-tab nil
		    :background my/bg-color
		    :foreground "LightSkyBlue"
		    :underline t)
(set-face-attribute 'whitespace-space nil
		    :background my/bg-color
		    :foreground "GreenYellow"
		    :weight 'bold)
(set-face-attribute 'whitespace-empty nil
		    :background my/bg-color)
