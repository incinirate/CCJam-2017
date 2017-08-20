(defun find-word (lines)
  (loop [(i 1)
         (break false)
         (out '(1 1 1))]
    [break out]
    (with ((nxs nxe) (string/find (nth lines i) "%w+"))
      (recur (succ i) (or (! (nil? nxs)) (= i (n lines))) `(,i ,(or nxs 0) ,(or nxe 1))))))

{}