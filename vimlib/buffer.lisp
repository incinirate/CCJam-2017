(import vimlib/util (default))
(import vimlib/enums enums)

(defun init-buffer (file-handle meta)
  (with (meta (default meta {}))
    (^= meta (on! :size) (default (.> meta :size) 1))
    (^= meta (on! :pos) 0)
    (^= meta (on! :got) 0)
    (with (new-buff { :handle file-handle
                      :cdata ""
                      :meta meta })
      (fill-data new-buff)
      new-buff)))

(defun set-size (buffer size)
  )

(defun fill-data (buffer)
  )