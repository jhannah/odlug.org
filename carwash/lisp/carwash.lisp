(defvar *welcome-msg* "Welcome to Frobazz Gas and Go.")
(defvar *enter-money-prompt*)
(setf *enter-money-prompt* "That'll be ~s ~s please.  You've entered ~s ~s: ")
(defvar *is-working* t)
(defvar *wash-codes*)
(defvar *number-file-name* "/Users/ben/workspace/lisp/carwash.numbers")

(defstruct wash-type 
  type msg amount funcs)

(defvar wash-types)

(setf wash-types
  (list
   (make-wash-type 
    :type "Stupendous" 
    :msg "Would you be interested in a Stupendous wash today?" 
    :amount '((dollars . 7) (coins . 3)) 
    :funcs '(wash soak wax))
   (make-wash-type 
    :type "Clean"
    :msg "Perhaps a Clean wash then?" 
    :amount '((dollars . 6) (coins . 2))
    :funcs '(wash soak))
   (make-wash-type
    :type "Simple"
    :msg "No, then would you like a Simple wash" 
    :amount '((dollars . 5) (coins . 1))
    :funcs '(wash))))

(defun currencies (a-lst)
  (if (null (car a-lst))
	  nil
	(cons (caar a-lst) (currencies (cdr a-lst)))))

(defun perform-wash-type (func)
  (format t "carwash-machine executing function: [~s]~%" func))

(defun wash()
  (perform-wash-type 'wash))

(defun soak()
  (perform-wash-type 'soak))

(defun wax()
  (perform-wash-type 'wax))

(defun *is-working*()
  *is-working*)

(defmacro carwash-machine (func)
  "the simulated carwash machine"
  `(funcall ,func))

(defun rcv-currency (amt amt-rcvd currency)
  "recieve money"
  (format t *enter-money-prompt* amt currency amt-rcvd currency)
  (read))

(defun rcv-deposit (amt amt-rcvd currency)
  "receive money until you have enough or too much"
  (if (or (> amt-rcvd amt) (= amt-rcvd amt))
      amt-rcvd
    (rcv-deposit amt (+ amt-rcvd (rcv-currency amt amt-rcvd currency)) currency)))

(defstruct wash-code
  code wash-type)

(defun verify-code(lst)
  (format t "Enter your code: ")
  (let ((code (read)))
    (if (eql code (wash-code-code (car lst)))
        (let ((wash-type (wash-code-wash-type (car lst))))
          (setf *wash-codes* (remove (car lst) *wash-codes*))
          (update-db)
          wash-type)
      (verify-code (cdr lst)))))

(defun collect-money (amt amt-rcvd currency)
  "collect the approprate amount and return change if necessary"
  (let ((amt-col (rcv-deposit amt amt-rcvd currency)))
    (if (> amt-col amt) 
        (progn
          (format t "Your change is ~s ~s.~%" (- amt-col amt) currency))
      t)
    t))

(defun gen-uniq-num ()
  (get-internal-run-time))

(defun update-db ()
  (with-open-file (output *number-file-name* :direction :output
                          :if-does-not-exist :create :if-exists :supersede)
                  (with-standard-io-syntax (print *wash-codes* output))))

(defun issue-code (wash-type)
  (let ((uniq-num (gen-uniq-num)))
    (setf *wash-codes* (cons (make-wash-code :code uniq-num :wash-type wash-type) *wash-codes*))
    (update-db)
    uniq-num))

(defun perform-wash (wash-type)
  "performs the wash cycle for a particular wash-type"
  (format t "Choose currency: ~s~%" (currencies (wash-type-amount wash-type)))
  (let* ((currency (read))
         (amount (assoc currency (wash-type-amount wash-type))))
    (if (null amount)
        (progn
          (format t "~s isn't a valid currency.~%" currency)
          (perform-wash wash-type))
      (if (collect-money (cdr amount) 0 (car amount))
          (if (y-or-n-p "Would you like the wash now?")
              (mapcar (lambda (func) (carwash-machine func)) (wash-type-funcs wash-type))
            (issue-code wash-type))))))

(defun read-codes ()
  (with-open-file (input *number-file-name*
                       :if-does-not-exist :create)
                (read input nil)))

(defun car-wash ()
  "main function that drives the car wash"
  (setf *wash-codes* (read-codes))
  (format t "~s~%" *welcome-msg*)
  (if (*is-working*)
      (if (y-or-n-p "Do you have a code to enter?")
          (mapcar (lambda (func) (carwash-machine func)) (wash-type-funcs (verify-code *wash-codes*)))
        (dolist (wash-type wash-types)
          (if (y-or-n-p (wash-type-msg wash-type))
              (return 
               (progn 
                 (format t "~s wash selected.~%" (wash-type-type wash-type))
                 (perform-wash wash-type))))))
    (format t "Sorry the car wash isn't working.")))

(car-wash)