(import locs)

(defun after-word (str start)
  (with ((rs re) (string/find str "%w+" start))
    (if (= rs start)
      (succ re)
      start)))

(defun char (window k prev)
  (with (bufc (.> window :buffers (.> window :selbuf)))
    (case k
      ["w" ;; Goto next word
        (let* [(lines (drop (.> bufc 1 :cdata) (pred (.> bufc 2 :line))))
               (after (after-word (.> lines 1) (succ (.> bufc 2 :char))))
               (_ (^~ lines (on! 1) (cut string/sub <> after)))
               (next (locs/find-word lines))]

          ;; (if (and (= (car next) 1) (= (nth next 2) 1))
          ;;   (progn
          ;;     (with (nexter (locs/find-word lines))
                (if (= (car next) 1)
                  (.<! bufc 2 { :line (+ (.> bufc 2 :line) (car next) -1) :char (+ (nth next 2) after -1) })
                  (.<! bufc 2 { :line (+ (.> bufc 2 :line) (car next) -1) :char (nth next 2) })))]
            ;; (.<! bufc 2 { :line (car next) :char (nth next 2) })))]
      ["q" (fail!)]
      [else nil])))

{ :char char }