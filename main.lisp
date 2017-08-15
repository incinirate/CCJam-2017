(import vimlib/screenbuffer buffer)

(import vimlib/imanager)

(import vimlib/parse/parser parser)

(parser/gen-parser)

(define vim-vars { :state "normal"
                   :running true })

(vimlib/imanager/init)

(while (.> vim-vars :running)
  (vimlib/imanager/update)
  (buffer/draw-buff buffer/screen-buffer))
