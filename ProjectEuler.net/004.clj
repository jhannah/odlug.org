;;; Juan Vazquez 
;;; https://github.com/javazquez

(defn isPalindrom?[value](= (str value ) (apply str (reverse  (str value)))))

 (def gen-prod
	(loop[x 999 y 999 acc '()]
	  (if (< x 100)  acc
	    (let [nacc (if (isPalindrom?(* x y)) (cons (* x y) acc) acc)]
              (if (< y 100)
	        (recur (dec x) 999 nacc)
		(recur x (dec y) nacc))))))

;run it
 (reduce max gen-prod)
;user =>906609				
