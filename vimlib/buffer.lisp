(import vimlib/util (default indself for-eachi))
(import vimlib/enums enums)
(import vimlib/parse/parser parser)

(defun init-buffer (file-handle meta)
  (with (metaz (or meta {}))
    (.<! metaz :size (or (.> meta :size) 1))
    (.<! metaz :pos 1)
    (.<! metaz :got 0)
    (with (new-buff { :handle file-handle
                      :cdata '()
                      :meta metaz
                      :parser (parser/gen-parser "lua")
                      :parsed {} })
      (fill-data new-buff)
      new-buff)))

(defun set-size (buffer size)
  (.<! buffer :meta :size size)
  (fill-data buffer))

(defun fill-data (buffer)
  (indself (.> buffer :handle :open))
  (print! (pretty (.> buffer :meta)) (.> buffer :meta :got) (.> buffer :meta :size) (+ (.> buffer :meta :pos) (.> buffer :meta :size) -1))
  (io/read)
  (for i (.> buffer :meta :got) (+ (.> buffer :meta :pos) (.> buffer :meta :size) -1) 1
    (push-cdr! (.> buffer :cdata) (car (indself (.> buffer :handle :read) 1))))
  (print! (pretty (drop (.> buffer :cdata) (- (.> buffer :meta :pos) 1))))
  (io/read)
  (with (parse-out (indself (.> buffer :parser :parse-lines) (drop (.> buffer :cdata) (- (.> buffer :meta :pos) 1)) (.> buffer :meta :pos)))
    (print! (pretty parse-out))
    (for-eachi (j pline) (nth parse-out 1)
      (.<! (.> buffer :parsed) (+ (.> buffer :meta :pos) j -1) pline))))