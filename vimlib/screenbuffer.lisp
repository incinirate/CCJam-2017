(import extlib/cc/term term)
(import extlib/cc/io (read))
(import vimlib/util (assert-types! gen-lv cut-across slot-across default))

(defmacro inset-one (buff x y va vl) :hidden
  "Replace one part VA (number index) of a blit triad `(text backgroundColor foregroundColor)` at the position X, Y of BUFF with VL"
  (with (fstr (gensym))
    `(^= (nth (.> ,buff :cur-rep) ,y) (on! ,va)
      (with (,fstr (nth (nth (.> ,buff :cur-rep) ,y) ,va))
        (.. (string/sub ,fstr 1 (pred ,x)) ,vl (string/sub ,fstr (succ ,x)))))))

(defun set-pixel (buff x y d b f)
  "Set the pixel X, Y of BUFF with the values D (text), B (bg), and F (fg)"
  
  (cut-across (d b f)
    when (! (nil? <>)) (inset-one buff x y <2> <1>))

  (^= (.> buff :old-rep) (on! y) true))

(defun draw-buff (buff)
  "Blit the buffer BUFF to the screen"
  (for i 1 (.> buff :height) 1
    (let* [(crep (nth (.> buff :cur-rep) i))
           (orep (nth (.> buff :old-rep) i))]
      (when orep
        (term/setCursorPos 1 i)
        (apply term/blit (slot-across (1 3 2)
                          nth crep <>))
        (^= (.> buff :old-rep) (on! i) false)))))

(defun clear-buff (buff color)
  (.<! buff :old-rep (gen-lv true (.> buff :height)))
  (.<! buff :cur-rep (gen-lv 
                       (gen-lv (string/rep (default color "7") (.> buff :width)) 3)
                       (.> buff :height))))

(defun gen-buffer (w h)
  "Generate a new buffer with the width H and height H"
  (assert-types! w h number)
  { :old-rep (gen-lv true h)
    :cur-rep (gen-lv (gen-lv (string/rep "7" w) 3) h)
    :width w
    :height h })

(define screen-buffer (gen-buffer (term/getSize)))
