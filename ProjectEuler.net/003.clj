;;; Juan Vazquez 
;;; https://github.com/javazquez
;;; http://javazquez.com

(defn prime? [num]
    (if (< (count (filter #(zero? (rem num %))(range 1 num ))) 3)
    true
    false))

(defn factors [num](filter #(zero? (rem num %)) (range 2 (Math/sqrt num) )))

(reduce max (filter #(prime? %) (factors 600851475143)))
;user=>6857
