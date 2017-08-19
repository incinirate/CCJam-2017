(import vimlib/util (default indself))
(import vimlib/enums enums)
(import vimlib/parse/parser parser)

(defun init-buffer (file-handle meta)
  (with (meta (default meta {}))
    (.<! meta :size (default (.> meta :size) 1))
    (.<! meta :pos 1)
    (.<! meta :got 0)
    (with (new-buff { :handle file-handle
                      :cdata '()
                      :meta meta
                      :parser (parser/gen-parser "lua") })
      (fill-data new-buff)
      new-buff)))

(defun set-size (buffer size)
  (.<! buffer :meta :size size)
  (fill-data buffer))

(defun fill-data (buffer)
  (indself (.> buffer :handle :open))
  (for i (.> buffer :meta :got) (+ (.> buffer :meta :pos) (.> buffer :meta :size) -1) 1
    (push-cdr! (.> buffer :cdata) (car (indself (.> buffer :handle :read) 1))))
  (indself (.> buffer :meta :parser :parse-lines) (drop (.> buffer :cdata) (- (.> buffer :pos) 1)) (.> buffer :pos)))