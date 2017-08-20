(defun find-word (lines)
  (loop [(i 1)
         (break false)
         (out '(1 1 1))]
    [break out]
    (with ((nxs nxe) (string/find (nth lines i) "%w+"))
      (recur (succ i) (! (nil? nxs)) `(,i ,(or nxs 1) ,(or nxe 1))))))

{}