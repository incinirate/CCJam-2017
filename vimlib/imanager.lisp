(import lua/math math)

(import extlib/cc/os os)

(import vimlib/window (gen-window draw-window))
(import vimlib/container (gen-container push-cont pop-cont))
(import vimlib/buffer (init-buffer))
(import vimlib/screenbuffer (screen-buffer))
(import vimlib/emptyhandle empty-handle)
(import vimlib/enums enums)

(define imanager-vars {})

(defun init ()
  (^= imanager-vars (on! :container) (gen-container))
  (push-cont (.> imanager-vars :container) (gen-window (init-buffer (empty-handle/gen-handle))))
  (os/queueEvent "fakeNews"))

(defun update ()
  (os/pullEvent)
  (with (cont (.> imanager-vars :container))
    (draw-container (cont 1 1 (.> screen-buffer :width) (.> screen-buffer :height)))))

(defun draw-container (cont cpos)
  (let* [(pos (append '() cpos)) ;; TODO assess neccessity of cloning here
         (dw (/ (.> pos 3) (n (.> cont :content))))
         (dh (/ (.> pos 4) (n (.> cont :content))))]
    (for-each child (.> cont :content)
      (with (childpos (append '() pos))
        (.<! childpos 3 dw)
        (.<! childpos 4 dh)
        (if (.> child :orient)
          (draw-container child childpos)
          (draw-buffer child childpos)))
      (case (.> cont :orient) ;; TODO hoist orientation case out of loop
        [enums/*cont-horiz* (^~ pos (on! 1) (cut + <> dw))]
        [enums/*cont-vert*  (^~ pos (on! 2) (cut + <> dh))]))))

(defun draw-buffer (buffer pos)
  )