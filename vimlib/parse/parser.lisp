(define langs '("lua"))

(define lang-api ,(with (result `{})
                    (for-each lang langs
                      (push-cdr! result lang)
                      (push-cdr! result `(progn
                                           (import ,(string->symbol (.. "vimlib/parse/lang/" lang)))
                                           { "init-state" ,(string->symbol (.. "vimlib/parse/lang/" lang "/init-state"))
                                             "next-token" ,(string->symbol (.. "vimlib/parse/lang/" lang "/next-token")) })))
                    result))

(defun gen-parser (lang)
  { :lang lang
    :cache {}
    :state (.> lang-api (<> (on "init-state") (on lang)))
    
    :prev-state prev-state })

(defun prev-state (parser line-index)
  (with (idx (apply math/max (append (filter 
                                       (cut < <> line-index)
                                       (keys (.> parser :cache))) '(0))))
    (when (> idx 0)
      (.> parser :cache idx))))