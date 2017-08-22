(import extlib/cc/term term)

(import screenbuffer sb)

(defun read (history)
  (let* [((lpos hpos) (term/getCursorPos))
         (rpos (term/getSize))]
    (sb/write-buffer sb/screen-buffer lpos hpos (string/sub text tpl))))