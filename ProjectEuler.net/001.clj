;;;Juan Vazquez 
;;;https://github.com/javazquez
;;;http://javazquez.com

(reduce + (filter #(or (= 0 (rem % 5)) (= 0 (rem % 3))) (range 3 1000)))
