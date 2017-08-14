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
    (when (= s (.> self :pos))
      (.<! self :pos (+ end 1))
      true)))

;; TODO
(defun eat (stream))
(defun eat-while (stream))
(defun skip-to (stream))
(defun skip-to-end (stream))
(defun eol (stream))
(defun next (stream))
(defun back-up (stream))
(defun current (stream))

(gen-stream "Hey")