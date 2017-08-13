(import vimlib/util (default))
(import vimlib/enums enums)

(defun gen-container (ori) { :content '()
                             :orient (default ori enums/*cont-horiz*) })

(defun push-cont (container element)
  (push-cdr! (.> container :content) element))

(defun pop-cont (container index)
  (remove-nth! (.> container :content) index))