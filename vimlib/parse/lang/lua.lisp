(define keywords (create-lookup
  '(:and :break :do :else :elseif :end :false :for :function :if :in
    :local :nil :not :or :repeat :return :then :true :until :while)))
(define api (create-lookup '(:drawPixel)))
(define escapable (create-lookup '(:a :b :f :n :r :t :v "\\" "\"" "'")))

(defun init-state ()
  { :c-token "root" 
    :starter "" })

(defun next-token (stream state)
  (print! "c" (self stream :current))
  (case (.> state :c-token)
    ["root"
      (with (char (self stream :next))
        (cond
          [(and (= char "-") (self stream :eat "%-"))
            (if (self stream :match "%[%[")
              (progn 
                (if (self stream :skip-to "%]%]")
                  (progn 
                    (self stream :next)
                    (.<! state :c-token "root"))
                  (self stream :skip-to-end))
                "comment")
              (progn
                (self stream :skip-to-end)
                "comment"))]
          [(or (= char "\"") (= char "'"))
            (.<! state :c-token "string")
            (.<! state :starter char)
            "string"]
          [(and (= char ".") (self stream :match "%d+")) "number"]
          [(and (= char "0") (self stream :eat "[xX]"))
            (self stream :eat-while "%x")
            "number"]
          [(string/find char "%d")
            (self stream :eat-while "%d")
            (self stream :match "\\.%d+")
            (if (string/find (or (self stream :peek) "") "[%w_]")
              "other"
              "number")]
          [(and (= char "[") (self stream :eat "%["))
            (.<! state :c-token "multiline-string")
            "string"]
          [(string/find char "[%w_]")
            (self stream :eat-while "[%w_]")
            (with (word (self stream :current))
              (cond
                [(.> keywords word) "keyword"]
                [(.> api word) "api"]
                [true "other"]))]
          [true "other"]))]
    ["string"
      (with (char (self stream :next))
        (cond
          [(= char "\\")
            (with (escaped (self stream :peek))
              (if (and escaped (.> escapable escaped))
                (progn
                  (self stream :next)
                  "escape")
                "string"))]
          [(= char (.> state :starter))
            (.<! state :starter "")
            (.<! state :c-token "root")]
          [(self stream :eol)
            (.<! state :c-token "root")]
          [true "string"]))]
    ["multiline-string"
      (with (char (self stream :next))
        (cond
          [(= char "\\")
            (with (escaped (self stream :peek))
                (if (and escaped (.> escapable escaped))
                  (progn
                    (self stream :next)
                    "escape")
                  "string"))]
          [(and (= char "]") (self stream :eat "%]"))
            (.<! state :c-token "root")
            "string"]
          [true "string"]))]
    [else
      (error! (.. "Invalid parse state `" (.> state :c-token) "`"))]))
