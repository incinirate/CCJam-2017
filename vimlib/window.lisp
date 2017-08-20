(import lua/basic (dofile))
(import extlib/cc/fs fs)

(import vimlib/util (default))

(define plugins (map (lambda (x) (dofile (.. ".vimplugins/" x))) (list (unpack (fs/list ".vimplugins")))))

(defun gen-window (buffer)
  { :pref-w 0
    :pref-h 0
    :buffer buffer
    :selbuf 1
    :buffers `((,buffer ,{ :line 1 :char 1 }))
    :prop { :focus false }

    :update update-window })

;; (defun draw-window (window)
;;   (print! 1))                    Now done in imangager, possibly should abstract into this class?

(defun update-window (window &ev)
  (for-each plugin plugins
    (when (.> plugin (car ev))
      ((.> plugin (car ev)) window (cadr ev) '()))))