(import vimlib/util (default))

(defun init-buffer (file-handle meta)
  (^= (on! :size) meta (default (.> meta :size) 1))
  { :handle file-handle
    :cdata (fill-data file-handle (.> meta :size))
    :meta meta })

(defun set-size (buffer size)
  )

(defun fill-data ()
  )