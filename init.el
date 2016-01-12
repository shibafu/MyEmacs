
;;melpaの設定
(require 'package)

;Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
 (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

; Initialize
(package-initialize)
;;ここまで

;;auto-complete c-headerの設定
(require 'auto-complete-c-headers)
(add-to-list 'ac-sources 'ac-source-c-headers)
(add-hook 'c++-mode-hook '(setq ac-source (append ac-source '(ac-source-c-headers))))
(add-hook 'c-mode-hook '(setq ac-source (append ac-source '(ac-source-c-headers))))

;;auto-completeの設定
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)


;;その他
(global-linum-mode t)
(load-theme 'wheatgrass t)
(enable-theme 'wheatgrass)


;;C-modeの設定大体はhookでバインド
(require 'cc-mode)

;;cc-mode-common-hook は　C/C++の設定
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (setq c-default-style "k&r") ;;カーニハン＆リッチースタイル
	    (setq setq c-basic-offset 2)
))

(add-to-list 'auto-mode-alist  '("\\.h\\" . c++-mode))

;;チェッカーflycheckの設定
(add-hook 'after-init-hook #'global-flycheck-mode)


;;elscreenの設定
;;; プレフィクスキーはC-z
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
;;; タブの先頭に[X]を表示しない
(setq elscreen-tab-display-kill-screen nil)
;;; header-lineの先頭に[<->]を表示しない
(setq elscreen-tab-display-control nil)
;;; バッファ名・モード名からタブに表示させる内容を決定する(デフォルト設定)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
         (lambda ()
           (format "Dired(%s)" dired-directory)))
        ("^Info-mode$" .
         (lambda ()
           (format "Info(%s)" (file-name-nondirectory Info-current-file))))
        ("^mew-draft-mode$" .
         (lambda ()
           (format "Mew(%s)" (buffer-name (current-buffer)))))
        ("^mew-" . "Mew")
        ("^irchat-" . "IRChat")
        ("^liece-" . "Liece")
        ("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell" . "shell")
        ("compilation" . "compile")
        ("-telnet" . "telnet")
        ("dict" . "OnlineDict")
        ("*WL:Message*" . "Wanderlust")))

;;elscreen-persistの設定
	;;; プレフィクスキーはC-z
	(setq elscreen-prefix-key (kbd "C-z"))
	(elscreen-start)
	(elscreen-persist-mode 1)

;;auto-complete-clang-asyncの設定
(require 'auto-complete-clang-async)
(add-hook 'c++-mode-hook
	  (lambda()
	    (setq ac-clang-complete-execute "~/bin/clang-complete")
	    (setq ac-source '(ac-source-clang-async))
	    (ac-clang-launch-completion-process)))
