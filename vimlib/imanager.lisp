(import lua/math math)

(import extlib/cc/term term)
(import extlib/cc/os os)

(import vimlib/theme (colors))

(import vimlib/window (gen-window))
(import vimlib/container (gen-container push-cont pop-cont))
(import vimlib/buffer (init-buffer))
(import vimlib/screenbuffer (screen-buffer write-buff))
(import vimlib/emptyhandle empty-handle)
(import vimlib/enums enums)
(import vimlib/util (default slot-across))

(define imanager-vars {})

(defun init ()
  (.<! imanager-vars :container (gen-container enums/*cont-vert*))
  ;; (with (cont1 (gen-container))
  ;;   (push-cont cont1 (gen-window (init-buffer (empty-handle/gen-handle) { :size (.> screen-buffer :height) })))
  ;;   (push-cont cont1 (gen-window (init-buffer (empty-handle/gen-handle) { :size (.> screen-buffer :height) })))
  ;;   (push-cont cont1 (gen-window (init-buffer (empty-handle/gen-handle) { :size (.> screen-buffer :height) })))
  ;;   (push-cont (.> imanager-vars :container) cont1))
  ;; (with (cont2 (gen-container))
  ;;   (push-cont cont2 (gen-window (init-buffer (empty-handle/gen-handle) { :size (.> screen-buffer :height) })))
  ;;   (push-cont cont2 (gen-window (init-buffer (empty-handle/gen-handle) { :size (.> screen-buffer :height) })))
  ;;   (push-cont (.> imanager-vars :container) cont2))
  
  (push-cont (.> imanager-vars :container) (gen-window (init-buffer (empty-handle/gen-handle) { :size (pred (.> screen-buffer :height)) })))

  (os/queueEvent "fakeNews"))

(defun update ()
  (term/setCursorPos (unpack (slot-across (:char :line) .> imanager-vars :container :content 1 :buffers 1 2 <>)))
  (term/setCursorBlink true)
  (update-container (.> imanager-vars :container) (os/pullEvent))
  (with (cont (.> imanager-vars :container))
    (draw-container cont `(1 1 ,(.> screen-buffer :width) ,(.> screen-buffer :height)))))

(defun update-container (cont &ev)
  (for-each child (.> cont :content)
    (if (.> child :orient)
      (update-container child)
      (self child :update (unpack ev)))))

(defun draw-container (cont cpos)
  (let* [(pos (append '() cpos)) ;; TODO assess neccessity of cloning here
         (dw (/ (.> pos 3) (if (= (.> cont :orient) enums/*cont-horiz*) (n (.> cont :content)) 1)))
         (dh (/ (.> pos 4) (if (= (.> cont :orient) enums/*cont-vert*)  (n (.> cont :content)) 1)))]
    (for-each child (.> cont :content)
      (with (childpos (append '() pos))
        (.<! childpos 3 dw)
        (.<! childpos 4 dh)
        (if (.> child :orient)
          (draw-container child childpos)
          (draw-buffer child childpos)))
      (cond ;; TODO hoist orientation case out of loop
        [(= (.> cont :orient) enums/*cont-horiz*) (^~ pos (on! 1) (cut + <> dw))]
        [(= (.> cont :orient) enums/*cont-vert*)  (^~ pos (on! 2) (cut + <> dh))]))))

(defun draw-buffer (window pos)
  (term/setTextColor (^ 2 1))
  (for i (.> window :buffer :meta :pos) (+ (.> window :buffer :meta :pos) (.> window :buffer :meta :size)) 1
    (when-with (text-p (.> window :buffer :parsed i))
      ;; (write-buff screen-buffer 12 2 "ab" "bc" "cd"))))
      (with (xp `(,(.> pos 1)))
      (for j 1 (n text-p) 2
        (with (part (nth text-p (+ j 1)))
          (when (= (type part) "string")
            ;; (when (nil? (.> colors (nth text-p j))) (print! text-p) (fail!))
            (write-buff screen-buffer (car xp) (+ i (.> pos 2) -1) part   
              (string/rep "7" (n part)) (string/rep (default (.> colors (nth text-p j)) "f") (n part)))
            (.<! xp 1 (+ (car xp) (n part))))))))))