;;; Juan Vazquez 
;;; https://github.com/javazquez
;;; http://javazquez.com
	
(defn sum-divs  [num ](reduce + (filter #(zero? (rem num %)) (range 1 (+ 1(/ num 2 ))))))

(defn amicable? [n1 n2]
	(and (not (= n1 n2)) 
		(=(sum-divs n1) n2)
		(=(sum-divs n2) n1)))

(time(= 31626 (reduce +(filter #(amicable? % (sum-divs %))(range 1 10000)))))
