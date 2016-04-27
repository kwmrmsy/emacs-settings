(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)
(global-set-key "\M-n" 'mark-paragraph)

(defvar my/bg-color "#001100")
(set-background-color my/bg-color)
(set-foreground-color "#EEFFFF")

(setq inhibit-startup-message t)

(show-paren-mode 1)
(column-number-mode t)

(which-function-mode t)

;;M-h delete word
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))
(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-word (- arg)))
(global-set-key "\M-h" 'backward-delete-word)

;;C-c C-k カーソルから行先頭まで削除
(global-set-key (kbd "C-c C-k") '(lambda () (interactive) (kill-line 0)))

;;C-w action：リージョンが活性化されていればリージョンカット、非活性であれば直前の単語をカット(kill)
(defun kill-region-or-backward-kill-word ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark))
    (backward-kill-word 1)))
(global-set-key "\C-w" 'kill-region-or-backward-kill-word)

;;C-t action:ウィンドウが複数あれば移動、一つならウィンドウ作成
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))

(global-set-key "\C-t" 'other-window-or-split)

;;trr22
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/trr22")
;;(autoload 'trr "/usr/share/emacs/site-lisp/trr22/trr" nil t)


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

;;yes or no to y or n
(fset 'yes-or-no-p 'y-or-n-p)
;;C-k で改行コードも含めて行を削除
(setq kill-whole-line t)
;;white space
(global-whitespace-mode 1)
;; regionをdeleteで一括削除
(delete-selection-mode t)

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

(setq
   ;; クリップボードでコピー＆ペーストできるようにする
   x-select-enable-clipboard t
   ;; PRIMARY selectionを使う(Windowsでは対象外)
   x-select-enable-primary t
   ;; クリップボードでコピー・カットした文字列を
   ;; キルリングにも保存させる
   save-interprogram-paste-before-kill t
   ;; エラー時などはベル音ではなくて画面を1回点滅させる
   visible-bell t
   ;; バックアップファイルはカレントディレクトリではなく
   ;; ~/.emacs.d/backups 以下に保存する
   backup-directory-alist `(("." . ,(concat user-emacs-directory
                                            "backups"))))
