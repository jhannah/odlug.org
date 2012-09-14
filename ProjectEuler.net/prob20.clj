;;;Juan Vazquez 
;;;https://github.com/javazquez
;;;http://javazquez.com

(defn sum-digits[num](reduce + (map #(- ( int %) 48 )(str num))))
;(defn sum2 [num] (reduce + (map #(Character/getNumericValue %)(str num)))) ;;another way to sum
(defn factorial [num] (reduce *' (range 1 (inc num))))
(sum-digits (factorial 100))
;648