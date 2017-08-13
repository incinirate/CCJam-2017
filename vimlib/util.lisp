(defmacro assert-types! (&args ty)
  "Assertion that all of ARGS are of type TY"
  `(progn ,@(map (lambda (x) `(assert-type! ,x ,ty)) args)))

(defun gen-lv (val size)
  "Create a list of the range `(1 size)` with the value VAL in each position,
   and if VAL is a list then a shallow copy is performed"
  (let* [(out '())]
    (if (list? val)
      (for i 1 size 1
        (push-cdr! out (append '() val)))
      (for i 1 size 1 
        (push-cdr! out val)))
    out))

(defun gen-lf (func size)
  "Create a list from the results of FUNC mapped over the range `(1 size)`"
  (let* [(out '())]
    (for i 1 size 1 
      (push-cdr! out (func i)))
    out))

(defun slot-num? (tag) :hidden
  (when (symbol? tag)
    (let* [(elm (symbol->string tag))
           (match (string/match elm "<%d*>"))]
      (when (= match elm)
        (string/sub match 2 (pred (n match)))))))

(defun parse-slots (args-in &body)
  "More versatile slot (<>) parsing with support for multiple slots of the same index
   Ex. `(+ <1> (* <1> <2>))`"
  (let [(args (if (nil? args-in) '() args-in))
        (call '())]
    (for-each item body
      (with (slot-chk (slot-num? item))
        (if (! (nil? slot-chk))
          (if (= slot-chk "")
            (with (symb (gensym))
              (push-cdr! args symb)
              (push-cdr! call symb))
            (if (>= (n args) (tonumber slot-chk))
              (push-cdr! call (nth args (tonumber slot-chk)))
              (if (= (succ (n args)) (tonumber slot-chk))
                (with (symb (gensym))
                  (push-cdr! args symb)
                  (push-cdr! call symb))
                (error! (string/format "skipping from arg %n to %n" (n args) (tonumber slot-chk)) 2))))
          (if (list? item)
            (with (recurse-list (parse-slots args (unpack item)))
              (push-cdr! call (cadr recurse-list)))
            (push-cdr! call item)))))
    (list args call)))

(defmacro cut-across (vars &func)
  "Partially apply a function FUNC for each variable in VARS, where each <1> (or <> for the first instance) is
   replaced by the variable and any <2>s are replaced by the index of variable in VARS. Values are evaluated
   every time the resulting function is called."
  (let* [(tree (parse-slots nil func))
         (args (car tree))
         (call (cadr tree))
         (counter 0)]
    (cond 
      [(= (n args) 2)
        `(progn ,@(map (lambda (av) 
                         (inc! counter)
                         `((lambda ,args ,@call) ,av ,counter)) vars))]
      [(= (n args) 1)
        `(progn ,@(map (lambda (av) `((lambda ,args ,@call) ,av)) vars))]
      [true (error! "Expected either one or two arguments to cut-across" 2)])))

(defmacro slot-across (vars &func)
  "The same as [[cut-across]] except it packs all the outputs from the applied functions into a list which is returned"
  (let* [(tree (parse-slots nil func))
         (args (car tree))
         (call (cadr tree))
         (counter 0)]
    (cond 
      [(= (n args) 2)
        `(list ,@(map (lambda (av) 
                         (inc! counter)
                         `((lambda ,args ,@call) ,av ,counter)) vars))]
      [(= (n args) 1)
        `(list ,@(map (lambda (av) `((lambda ,args ,@call) ,av)) vars))]
      [true (error! "Expected either one or two arguments to slot-across" 2)])))

(defmacro default (chk var default-val)
  (if (nil? default-val)
    `(if (nil? ,chk)
      ,var
      ,chk)
    `(if (nil? ,chk)
      ,default-val
      ,var)))
  