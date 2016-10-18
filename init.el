;;(load "${CVSDIR}/jsk_tendon_robot/install/tendon-init.el")
;;(load "/home/kawamura/ros/indigo/src/jsk-ros-pkg/jsk_tendon_robot/install/tendon-init.el")

(global-set-key "\C-h" 'delete-backward-char)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)
(global-set-key "\M-j" 'backward-char)
(global-set-key "\M-k" 'forward-char)
;;(global-set-key "\C-" 'mark-paragraph)
(global-unset-key "\C-\\")
(global-set-key "\C-M" 'set-mark-command)
(global-set-key "\C-U" 'undo)

;; M-n and M-p
(global-unset-key "\M-p")
(global-unset-key "\M-n")
(defun scroll-up-in-place (n)
       (interactive "p")
       (previous-line n)
       (scroll-down n))
(defun scroll-down-in-place (n)
       (interactive "p")
       (next-line n)
       (scroll-up n))
(global-set-key "\M-n" 'scroll-down-in-place)
(global-set-key "\M-p" 'scroll-up-in-place)

;;paren
(show-paren-mode 1)
;; ;; C-qで移動
(defun match-paren (arg)
  "Go to the matching parenthesis if on parenthesis."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        )
  )
(global-set-key "\C-Q" 'match-paren)

;;global(gtags)
;;(setq load-path (cons "." load-path))
;;(require 'gtags)
;;(global-set-key "\M-t" 'gtags-find-tag)
;;(global-set-key "\M-r" 'gtags-find-rtag)
;;(global-set-key "\M-s" 'gtags-find-symbol)
;;(global-set-key "\M-i" 'gtags-pop-stack)

;;color
(defvar my/bg-color "#000019")
(set-background-color my/bg-color)
(set-foreground-color "#FFFFFF")

(column-number-mode t)
(which-function-mode t)

;;tabを空白に
;;(add-hook 'lisp-mode-hook '(lambda () (setq tab-width 2)))
;;(setq-default indent-tabs-mode nil)
(setq-default tab-width 4 indent-tabs-mode nil)

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
(setq intial-frame-alist default-frame-alist)

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

;;tendon-init.elから重複しない設定
(require 'cl)
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar installing-package-list
  '(
    ;; package list to use
    whitespace
    smartparens
    rainbow-delimiters
    ))

;; automatically install
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))

(add-to-list 'load-path "~/.emacs.d/elpa/")
(add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
(add-to-list 'load-path "/opt/ros/hydro/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
;; (require 'rosemacs-config)

;; inhibit startup screen
(setq inhibit-startup-screen t)

;; delete initial scratch message
(setq initial-scratch-message "")


;; tab->space
(setq-default tab-width 4 indent-tabs-mode nil)

;; smartparents
;; (require 'smartparens-config)
;; (smartparens-global-mode t)
;; (show-smartparens-global-mode t)

;; rainbow-delimiters を使うための設定
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; 括弧の色を強調する設定
(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index))))
    (cl-callf color-saturate-name (face-foreground face) 30))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)


; server start for emacs-client
(require 'server)
(unless (server-running-p)
  (server-start))

(when (require 'saveplace nil t)
  (setq-default save-place t)
  (setq save-place-file "~/.emacs.d/saved-places"))

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
