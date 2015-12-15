(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)

(set-background-color "#110011")
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

;;
;; whitespace
;;
(require 'whitespace)
(setq whitespace-style '(face           ; faceで可視化
                         trailing       ; 行末
                         tabs           ; タブ
                         empty          ; 先頭/末尾の空行
                         space-mark     ; 表示のマッピング
                         tab-mark
                         ))

(setq whitespace-display-mappings
      '((tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t])))

(global-whitespace-mode 1)