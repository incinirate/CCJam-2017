(import lua/math math)

(import extlib/cc/os os)

(import vimlib/window (gen-window draw-window))
(import vimlib/container (gen-container push-cont pop-cont))
(import vimlib/buffer (init-buffer))
(import vimlib/emptyhandle empty-handle)

(define imanager-vars {})

(defun init ()
  (^= imanager-vars (on! :container) (gen-container))
  (push-cont (.> imanager-vars :container) (gen-window (init-buffer (empty-handle/gen-handle))))
  (os/queueEvent "fakeNews"))

(defun update ()
  (os/pullEvent)
  (with (cont (.> imanager-vars :container))
    ))
