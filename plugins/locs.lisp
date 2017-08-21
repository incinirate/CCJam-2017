(defun find-word (lines)
  (loop [(i 1)
         (break false)
         (out '(1 1 1))]
    [break out]
    (with ((nxs nxe) (string/find (nth lines i) "%w+"))
      (recur (succ i) (or (! (nil? nxs)) (= i (n lines))) `(,i ,(or nxs 1) ,(or nxe 1))))))

(defun after-word (str start)
  (with ((rs re) (string/find str "%w+" start))
    (if (= rs start)
      (succ re)
      start)))

{}