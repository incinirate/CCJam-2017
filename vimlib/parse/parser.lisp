(import vimlib/util (for-eachi lkeys))
(import vimlib/parse/stream stream-factory)

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
    :lang-api (.> lang-api lang)
    :cache {}
    :state nil
    
    :prev-state prev-state :parse-lines parse-lines :parse-line parse-line })

(defun prev-state (parser line-index)
  (with (idx (apply math/max (append (filter 
                                       (cut < <> line-index)
                                       (map string->number (lkeys (.> parser :cache)))) '(0))))
    (when (> (string->number idx) 0)
      (.> parser :cache idx))))

(defun parse-lines (parser lines line-index)
  (with (result '(() false))
    (.<! parser :cache (map 
                         (cut .> parser :cache <>)
                         (filter
                           (cut <= <> line-index)
                           (lkeys (.> parser :cache)))))
    (for-eachi (i line) lines
      (.<! parser :state {})
      (with (temp-state (or
                          (debug (.> parser :cache (+ line-index i -2)))
                          (self parser :prev-state line-index)
                          ((.> parser :lang-api :init-state))))
        (for-pairs (k v) temp-state
          (.<! parser :state k v)))
      (with (previous-state {})
        (when (.> parser :cache (+ line-index i -1))
          (for-pairs (k v) (.> parser :cache (+ line-index i -1))
            (.<! previous-state k v)))

        (push-cdr! (nth result 1) (self parser :parse-line line (+ line-index i -1)))
        
        (.<! parser :cache (+ line-index i -1) {})
        (for-pairs (k v) (.> parser :state)
          (when (and (= i (n lines)) (/= (.> previous-state k) (.> parser :state k)))
            (.<! result 2 true))
          (.<! parser :cache (+ line-index i -1) k v))))
    result))


(defun parse-line (parser line line-index)
  (let [(result '())
        (stream (stream-factory/gen-stream line))]
    (while (! (self stream :eol))
      (with (token ((.> parser :lang-api :next-token) stream (.> parser :state)))
        (push-cdr! result token)
        (push-cdr! result (self stream :current))
        (.<! stream :start (.> stream :pos))))
    (if (= (n result) 0)
      `("other" ,line)
      result)))