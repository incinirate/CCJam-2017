(import lua/math math)

(import extlib/cc/os os)

(import vimlib/window (gen-window draw-window))
(import vimlib/container (gen-container push-cont pop-cont))
(import vimlib/buffer (init-buffer))

(define imanager-vars {})

(defun init ()
  (^= imanager-vars (on! :container) (gen-container))
  (push-cont (.> imanager-vars :container) (gen-window))
  (os/queueEvent "fakeNews"))

(defun update ()
  (os/pullEvent)
  (for-each window (.> imanager-vars :windows)
    (draw-window window)))
