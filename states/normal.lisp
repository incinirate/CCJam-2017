(import lua/math math)

(import extlib/cc/os os)
(import extlib/cc/term term)
(import extlib/cc/colors colors)

(import vimlib/buffer buffer)

(defun ev-char (c) 57)
(defun draw ()
  (term/setBackgroundColor colors/green)
  (term/clear)
  (term/setCursorPos 3 3)
  (term/write "Hello Urn!")
  (term/setCursorPos 3 5)
  (term/write (pretty (nub (map (lambda () (math/random 0 10)) (range 1 50))))))

(define left '("Hello world!"))
(defun update ()
  (os/pullEvent)
  (os/startTimer (/ 1 20))
  (buffer/set-pixel buffer/screen-buffer (- 16 (n (nth left 1))) 4 (string/sub (nth left 1) 1 1) "4" "f")
  (^= left head (string/sub (nth left 1) 2)))
