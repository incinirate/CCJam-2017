(import vimlib/screenbuffer buffer)

(import vimlib/imanager)

(define vim-vars { :state "normal"
                   :running true })

(vimlib/imanager/init)

(while (.> vim-vars :running)
  (vimlib/imanager/update)
  (buffer/draw-buff buffer/screen-buffer))
