(defun gen-stream (string)
  { :string string
    :start 1
    :pos 1
    
    :peek peek :match match :eat eat :eat-while eat-while
    :skip-to skip-to :skip-to-end skip-to-end :eol eol
    :next next :back-up back-up :current current })

(defun peek (stream)
  (when-with (char (string/sub (.> stream :string) (.> stream :pos) (.> stream :pos)))
    char))

(defun match (stream pattern)
  (with ((start end) (string/find (.> stream :string) pattern (.> stream :pos)))
    (when (= start (.> self :pos))
      (.<! self :pos (+ end 1))
      true)))

(defun eat (stream pattern)
  (with (char (string/sub (.> stream :pos) (.> stream :pos)))
    (when (string/find char pattern)
      (^~ stream (on! :pos) succ)
      char)))

(defun eat-while (stream pattern)
  (with (st (.> stream :pos))
    (while (self stream :eat pattern))
    (> (.> stream :pos) st)))

(defun skip-to (stream char)
  (with ((start end) (string/find stream char (.> stream :pos)))
    (when (and start (>= start (.> stream :pos)))
      (.<! stream :pos end)
      true)))

(defun skip-to-end (stream)
  (.<! stream :pos (+ 1 (n (.> stream :string)))))

(defun eol (stream)
  (> (.> stream :pos) (n (.> stream :string))))

(defun next (stream)
  (when (<= (.> stream :pos) (n (.> stream :string)))
    (^~ stream (on! :pos) succ)
    (string/sub (.> stream :string) (- (.> stream :pos) 1) (- (.> stream :pos) 1))))

(defun back-up (stream n)
  (when (> (.> stream :pos) 1)
    (^~ stream (on! :pos) (cut - <> (or n 1)))
    true))

(defun current (stream)
  (string/sub (.> stream :start) (- (.> stream :pos) 1)))

(gen-stream "Hey")
