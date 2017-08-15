(import extra/argparse argparse)

(import vimlib/screenbuffer buffer)
(import vimlib/imanager)

(import vimlib/parse/parser parser)

(parser/gen-parser)

(define vim-vars { :state "normal"
                   :running true })


(with (spec (argparse/create))
  (argparse/add-help! spec)
  (argparse/add-argument! spec '("files")
    :help "The input files")
  
  (with (args (argparse/parse! spec arg))
    (vimlib/imanager/init)

    (while (.> vim-vars :running)
      (vimlib/imanager/update)
      (buffer/draw-buff buffer/screen-buffer))))
