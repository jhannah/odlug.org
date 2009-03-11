(defvar welcome-msg "Welcome to Frobazz Gas and Go.")
(defvar enter-money-prompt "That'll be $%s please.  You've entered $%s")
(defvar is-working t)

(defstruct wash-type 
  type msg amount funcs)

(defvar wash-types)

(setf wash-types
  (list
   (make-wash-type 
    :type "Stupendous" 
    :msg "Would you be interested in a Stupendous wash today?" 
    :amount '(("dollars" . 7) ("coins" . 3)) 
    :funcs '(wash soak wax))
   (make-wash-type 
    :type "Clean"
    :msg "Perhaps a Clean wash then?" 
    :amount '(("dollars" . 6) ("coins" . 2))
    :funcs '(wash soak))
   (make-wash-type
    :type "Simple"
    :msg "No, then would you like a Simple wash" 
    :amount '(("dollars" . 5) ("coins" . 1))
    :funcs '(wash))))

(defun currencies (a-lst)
  (if (null (car a-lst))
	  nil
	(cons (caar a-lst) (currencies (cdr a-lst)))))

(defun print-to-buffer (str)
  "utility function to print something to the carwash machine buffer"
  (princ str (get-buffer-create "*carwash-machine*")))

(defun perform-wash-type (func)
  (print-to-buffer (format "carwash-machine executing function: [%s]\n" func)))

(defun wash()
  (perform-wash-type 'wash))

(defun soak()
  (perform-wash-type 'soak))

(defun wax()
  (perform-wash-type 'wax))

(defun is-working()
  is-working)

(defmacro carwash-machine (func)
  "the simulated carwash machine"
  `(funcall ,func))

(defun rcv-currency (amt amt-rcvd currency)
  "recieve money"
  (string-to-number 
   (read-from-minibuffer (format enter-money-prompt amt currency amt-rcvd currency))))

(defun rcv-deposit (amt amt-rcvd)
  "receive money until you have enough or too much"
  (if (or (> amt-rcvd amt) (= amt-rcvd amt))
      amt-rcvd
    (rcv-deposit amt (+ amt-rcvd (rcv-currency amt amt-rcvd)))))

(defun collect-money (amt amt-rcvd)
  "collect the approprate amount and return change if necessary"
  (let ((amt-col (rcv-deposit amt amt-rcvd)))
    (if (> amt-col amt) 
        (progn
          (print-to-buffer (format "Your change is $%s.\n" (- amt-col amt)))
          t)
      t)))

(defun perform-wash (wash-type)
  "performs the wash cycle for a particular wash-type"
  (if (collect-money (cdr (assoc (read-from-minibuffer (format "Choose currency: %s\n" (currencies (wash-type-amount wash-type)))) (wash-type-amount wash-type))) 0)
      (mapcar (lambda (func) (carwash-machine func)) (wash-type-funcs wash-type))))

(assoc "dollars" (list ("dollars" . 7) ("coins" . 6))

(mapcar (lambda (func) (carwash-machine func)) (wash-type-funcs (car wash-types)))
 
(defun car-wash ()
  "main function that drives the car wash"
  (interactive)
  (switch-to-buffer "*carwash-machine*")
  (mark-whole-buffer)
  (kill-region (point-min) (point-max))
  (print-to-buffer (format "%s\n" welcome-msg))
  (if (is-working)
      (dolist (wash-type wash-types)
	(if (y-or-n-p (wash-type-msg wash-type))
	    (return 
	     (progn 
	       (print-to-buffer (format "%s wash selected.\n" (wash-type-type wash-type)))
	       (perform-wash wash-type)))))
    (print-to-buffer "Sorry the car wash isn't working.")))

(car-wash)