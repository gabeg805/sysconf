;; -----------------------------------------------------------------------------
;; File: shell-highlighting.el
;; Author: Gabe Gonzalez
;; 
;; Brief: Improved syntax highlighting for sh-mode.
;; 
;; -----------------------------------------------------------------------------

;; Light blue
(defface shell-builtin-face
  '((t (:bold t :foreground "#90ceeb")))
  "Used in sh-mode for builtin functions.")

;; Purple
(defface shell-builtin-ctrl-face
  '((t (:bold t :foreground "#ff4949")))
  "Used in sh-mode for builtin functions that control flow of a program.")

;; Green
(defface shell-bool-face
  '((t (:foreground "#008b00")))
  "Used in sh-mode for boolean (true/false) values.")

;; Light blue
(defface shell-logic-and-loop-face
  '((t (:bold t :foreground "#8a2be2")))
  "Used in sh-mode for loop control commands.")

;; Blue
(defface shell-function-name-face
  '((t (:bold t :foreground "#1f5eeb")))
  "Used in sh-mode for function names.")

;; Blue
(defface shell-function-exec-face
  '((t (:bold t :foreground "#1f5eeb")))
  "Used in sh-mode for functions that will be executed in a subshell.")

;; Blue/green
(defface shell-function-bin-face
  ;; '((t (:bold t :foreground "#45e0c0")))
  '((t (:bold t :foreground "#90ceeb")))
  "Used in sh-mode for commands that are in /usr/bin.")

;; Tan
(defface shell-variable-face
  '((t (:bold nil :foreground "#cdbe70")))
  "Used in sh-mode for variables being defined.")

;; Pink
(defface shell-string-face
  '((t (:bold nil :foreground "#cd52a9")))
  "Used in sh-mode for strings.")

;; Gray
(defface shell-comment-face
  '((t (:bold nil :foreground "#777777")))
  "Used in sh-mode for comments.")

;; Highlight comments (to override regular words being highlighted within
;; comments)
(font-lock-add-keywords 'sh-mode
  '(("^[ \t]*\\(\\#.*\\)" 1 'shell-comment-face prepend)))

;; Highlight numbers (if using comment below, use \\b instead of \b)
(add-hook 'after-change-major-mode-hook
  '(lambda () (font-lock-add-keywords
    nil
    '(("\\(\\b[-+]?[0-9]*\\.?[0-9]+\\(?:[eE][-+]?[0-9]+\\)?\\b\\)"
       1 'font-lock-constant-face prepend)))))

;; Highlight booleans
(font-lock-add-keywords 'sh-mode
 '(("\\(\\btrue\\b\\|\\bfalse\\b\\)" 1 'shell-bool-face prepend)))

;; Highlight builtin control commands
(font-lock-add-keywords 'sh-mode
 '(("^[ \t]*\\(\\bcase\\b\\|\\bcoproc\\b\\|\\bdo\\b\\|\\bdone\\b\\|\\belif\\b\\|\\belse\\b\\|\\besac\\b\\|\\bfi\\b\\|\\bfor\\b\\|\\bif\\b\\|\\bin\\b\\|\\bselect\\b\\|\\bthen\\b\\|\\buntil\\b\\|\\bwhile\\b\\)"
    1 'shell-logic-and-loop-face prepend)))

(font-lock-add-keywords 'sh-mode
 '(("\;[ \t]*\\(\\bdo\\b\\|\\bdone\\b\\|\\belif\\b\\|\\belse\\b\\|\\besac\\b\\|\\bfi\\b\\|\\bthen\\b\\)"
    1 'shell-logic-and-loop-face prepend)))

;; Highlight loop control commands
(font-lock-add-keywords 'sh-mode
 '(("^[ \t]*\\(\\bbreak\\b\\|\\bcontinue\\b\\|\\bexit\\b\\|\\bkill\\b\\|\\blogout\\b\\|\\breturn\\b\\|\\bshift\\b\\|\\btrap\\b\\)"
    1 'shell-builtin-ctrl-face prepend)))

(font-lock-add-keywords 'sh-mode
 '(("\;[ \t]*\\(\\bbreak\\b\\|\\bcontinue\\b\\|\\bexit\\b\\|\\bkill\\b\\|\\blogout\\b\\|\\breturn\\b\\|\\bshift\\b\\|\\btrap\\b\\)"
    1 'shell-builtin-ctrl-face prepend)))

(font-lock-add-keywords 'sh-mode
 '(("\|\|[ \t]*\\(\\bbreak\\b\\|\\bcontinue\\b\\|\\bexit\\b\\|\\bkill\\b\\|\\blogout\\b\\|\\breturn\\b\\|\\bshift\\b\\|\\btrap\\b\\)"
    1 'shell-builtin-ctrl-face prepend)))

(font-lock-add-keywords 'sh-mode
 '(("\&\&[ \t]*\\(\\bbreak\\b\\|\\bcontinue\\b\\|\\bexit\\b\\|\\bkill\\b\\|\\blogout\\b\\|\\breturn\\b\\|\\bshift\\b\\|\\btrap\\b\\)"
    1 'shell-builtin-ctrl-face prepend)))

;; Highlight builtin commands
(font-lock-add-keywords 'sh-mode
 '(("^[ \t]*\\(\\b\\.\\b\\|\\b\\:\\b\\|\\bsource\\b\\|\\bbuiltin\\b\\|\\bcd\\b\\|\\bdeclare\\b\\|\\btypeset\\b\\|\\becho\\b\\|\\beval\\b\\|\\bexec\\b\\|\\bexport\\b\\|\\bhash\\b\\|\\blet\\b\\|\\blocal\\b\\|\\breadarray\\b\\|\\bpopd\\b\\|\\bprintf\\b\\|\\bpushd\\b\\|\\bpopd\\b\\|\\bpwd\\b\\|\\bread\\b\\|\\breadonly\\b\\|\\bset\\b\\|\\bshopt\\b\\|\\btest\\b\\|\\btime\\b\\|\\btype\\b\\|\\bumask\\b\\|\\bunset\\b\\|\\bwait\\b\\)"
    1 'shell-builtin-face prepend)))

(font-lock-add-keywords 'sh-mode
 '(("\;[ \t]*\\(\\b\\.\\b\\|\\b\:\\b\\|\\bsource\\b\\|\\bbuiltin\\b\\|\\bcd\\b\\|\\bdeclare\\b\\|\\btypeset\\b\\|\\becho\\b\\|\\beval\\b\\|\\bexec\\b\\|\\bexport\\b\\|\\bhash\\b\\|\\blet\\b\\|\\blocal\\b\\|\\breadarray\\b\\|\\bpopd\\b\\|\\bprintf\\b\\|\\bpushd\\b\\|\\bpopd\\b\\|\\bpwd\\b\\|\\bread\\b\\|\\breadonly\\b\\|\\bset\\b\\|\\bshopt\\b\\|\\btest\\b\\|\\btime\\b\\|\\btype\\b\\|\\bumask\\b\\|\\bunset\\b\\|\\bwait\\b\\)"
    1 'shell-builtin-face prepend)))

;; Highlight function names
(font-lock-add-keywords 'sh-mode
 '(("\\([a-zA-Z_][a-zA-Z0-9_]*\\)\(\)$" 1 'shell-function-name-face prepend)))

;; Highlight variables
(font-lock-add-keywords 'sh-mode
  '(("^[ \t]*\\([a-zA-Z_][a-zA-Z0-9_]*\\)=" 1 'shell-variable-face prepend)))
(font-lock-add-keywords 'sh-mode
  '(("^[ \t]*local[ \t]*\\([a-zA-Z_][a-zA-Z0-9_]*\\)="
     1 'shell-variable-face prepend)))
;; (font-lock-add-keywords 'sh-mode
;;   '(("\\(\\${.*?}\\)" 1 'shell-variable-face prepend)))

;; Highlight strings
(font-lock-add-keywords 'sh-mode
  '(("\\(\".*?\"\\)" 1 'shell-string-face prepend)))
(font-lock-add-keywords 'sh-mode
  '(("\\('.*?'\\)" 1 'shell-string-face prepend)))

;; Highlight commands in /usr/bin
(font-lock-add-keywords 'sh-mode
  '(("\\(\\bagetty\\b\\|\\balsamixer\\b\\|\\bamixer\\b\\|\\bannotate\\b\\|\\baplay\\b\\|\\bapropos\\b\\|\\bautoconf\\b\\|\\bautoheader\\b\\|\\bautomake\\b\\|\\bavahi-browse\\b\\|\\bavahi-daemon\\b\\|\\bavahi-discover\\b\\|\\bavahi-publish\\b\\|\\bavahi-resolve\\b\\|\\bawk\\b\\|\\baws\\b\\|\\bbasename\\b\\|\\bbash\\b\\|\\bblkid\\b\\|\\bbzcat\\b\\|\\bbzdiff\\b\\|\\bbzgrep\\b\\|\\bcal\\b\\|\\bcat\\b\\|\\bchgrp\\b\\|\\bchmod\\b\\|\\bchown\\b\\|\\bchroot\\b\\|\\bchsh\\b\\|\\bchvt\\b\\|\\bclear\\b\\|\\bcmake\\b\\|\\bcompare\\b\\|\\bcp\\b\\|\\bcurl\\b\\|\\bcut\\b\\|\\bdate\\b\\|\\bdbus-daemon\\b\\|\\bdbus-launch\\b\\|\\bdbus-monitor\\b\\|\\bdbus-run-session\\b\\|\\bdconf\\b\\|\\bdd\\b\\|\\bdeallocvt\\b\\|\\bdf\\b\\|\\bdhcpcd\\b\\|\\bdiff\\b\\|\\bdir\\b\\|\\bdircolors\\b\\|\\bdirname\\b\\|\\bdisplay\\b\\|\\bdmenu\\b\\|\\bdoxygen\\b\\|\\bdu\\b\\|\\becho\\b\\|\\begrep\\b\\|\\beject\\b\\|\\bemacs\\b\\|\\benv\\b\\|\\bevince\\b\\|\\bexpr\\b\\|\\bfc-list\\b\\|\\bfdisk\\b\\|\\bfgrep\\b\\|\\bfile\\b\\|\\bfind\\b\\|\\bflock\\b\\|\\bfmt\\b\\|\\bfold\\b\\|\\bfree\\b\\|\\bfunzip\\b\\|\\bfuser\\b\\|\\bg++\\b\\|\\bgawk\\b\\|\\bgcc\\b\\|\\bgdb\\b\\|\\bgetent\\b\\|\\bgetopt\\b\\|\\bgimp\\b\\|\\bgit\\b\\|\\bgrep\\b\\|\\bgroupadd\\b\\|\\bgroupdel\\b\\|\\bgroupmod\\b\\|\\bgroups\\b\\|\\bgrpck\\b\\|\\bgrpconv\\b\\|\\bgunzip\\b\\|\\bgzip\\b\\|\\bhalt\\b\\|\\bhead\\b\\|\\bhostid\\b\\|\\bhostname\\b\\|\\bid\\b\\|\\bifstat\\b\\|\\bimgcmp\\b\\|\\bimginfo\\b\\|\\bimport\\b\\|\\binfo\\b\\|\\bip\\b\\|\\biptables\\b\\|\\biwconfig\\b\\|\\bjoin\\b\\|\\bjournalctl\\b\\|\\bkill\\b\\|\\bkillall\\b\\|\\blast\\b\\|\\bldd\\b\\|\\bless\\b\\|\\blink\\b\\|\\bln\\b\\|\\blocale\\b\\|\\blocalectl\\b\\|\\blocaledef\\b\\|\\blocale-gen\\b\\|\\blogin\\b\\|\\bloginctl\\b\\|\\blogrotate\\b\\|\\bls\\b\\|\\blsattr\\b\\|\\blsblk\\b\\|\\blscpu\\b\\|\\blsipc\\b\\|\\blslocks\\b\\|\\blslogins\\b\\|\\blsmem\\b\\|\\blsmod\\b\\|\\blsns\\b\\|\\blspci\\b\\|\\blsusb\\b\\|\\bmail\\b\\|\\bmake\\b\\|\\bman\\b\\|\\bmkdir\\b\\|\\bmkfs\\b\\|\\bmkswap\\b\\|\\bmktemp\\b\\|\\bmocp\\b\\|\\bmodinfo\\b\\|\\bmodprobe\\b\\|\\bmodutil\\b\\|\\bmore\\b\\|\\bmount\\b\\|\\bmv\\b\\|\\bnice\\b\\|\\bnohup\\b\\|\\bpacman\\b\\|\\bpactl\\b\\|\\bpasswd\\b\\|\\bpaste\\b\\|\\bpatch\\b\\|\\bpdflatex\\b\\|\\bperl\\b\\|\\bpgrep\\b\\|\\bpidof\\b\\|\\bping\\b\\|\\bpkill\\b\\|\\bpoweroff\\b\\|\\bprintf\\b\\|\\bps\\b\\|\\bpwd\\b\\|\\bpython\\b\\|\\bpython2\\b\\|\\bpython2.7\\b\\|\\bpython3\\b\\|\\bpython3.6\\b\\|\\braw\\b\\|\\breadlink\\b\\|\\breadprofile\\b\\|\\brealpath\\b\\|\\breboot\\b\\|\\brename\\b\\|\\brm\\b\\|\\brmdir\\b\\|\\bscp\\b\\|\\bsed\\b\\|\\bseq\\b\\|\\bsessreg\\b\\|\\bshred\\b\\|\\bshutdown\\b\\|\\bsleep\\b\\|\\bsort\\b\\|\\bsplit\\b\\|\\bssh\\b\\|\\bssh-add\\b\\|\\bssh-agent\\b\\|\\bssh-copy-id\\b\\|\\bsshd\\b\\|\\bssh-keygen\\b\\|\\bssh-keyscan\\b\\|\\bstartx\\b\\|\\bstat\\b\\|\\bstrace\\b\\|\\bstrings\\b\\|\\bstrip\\b\\|\\bstty\\b\\|\\bsu\\b\\|\\bsudo\\b\\|\\bswapoff\\b\\|\\bswapon\\b\\|\\bsync\\b\\|\\bsysctl\\b\\|\\bsystemctl\\b\\|\\btac\\b\\|\\btar\\b\\|\\btee\\b\\|\\btest\\b\\|\\bthunar\\b\\|\\btop\\b\\|\\btouch\\b\\|\\btput\\b\\|\\btr\\b\\|\\btracepath\\b\\|\\btransmission-gtk\\b\\|\\btty\\b\\|\\bumount\\b\\|\\buname\\b\\|\\buniq\\b\\|\\bunlink\\b\\|\\bunzip\\b\\|\\buptime\\b\\|\\burxvt\\b\\|\\buseradd\\b\\|\\buserdel\\b\\|\\busermod\\b\\|\\bvi\\b\\|\\bview\\b\\|\\bvim\\b\\|\\bvimdiff\\b\\|\\bvisudo\\b\\|\\bvlc\\b\\|\\bwatch\\b\\|\\bwc\\b\\|\\bwget\\b\\|\\bwhereis\\b\\|\\bwhich\\b\\|\\bwho\\b\\|\\bwhoami\\b\\|\\bwifi-menu\\b\\|\\bwrite\\b\\|\\bX\\b\\|\\bxargs\\b\\|\\bxauth\\b\\|\\bxbacklight\\b\\|\\bxcompmgr\\b\\|\\bxev\\b\\|\\bxhost\\b\\|\\bxkill\\b\\|\\bxmodmap\\b\\|\\bXorg\\b\\|\\bxprop\\b\\|\\bxrandr\\b\\|\\bxrdb\\b\\|\\bxsel\\b\\|\\bxset\\b\\|\\bxsetroot\\b\\|\\bxterm\\b\\|\\bzsh\\b\\)"
  1 'shell-function-bin-face prepend)))

;; ;; Highlight executed functions (This is not working. Keeping commented until
;; ;; I figure it out. The alternative is to put the color in custom-set-faces
;; ;; for sh-quoted-exec)
;; (font-lock-add-keywords 'sh-mode
;;     '(("\\$\\(\(dirname\\)" 1 'shell-function-exec-face prepend)))
