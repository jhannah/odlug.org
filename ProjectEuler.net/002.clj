;;; Juan Vazquez 
;;; https://github.com/javazquez
;;; http://javazquez.com

(defn euler2 
    ([] (euler2 0 1))
    ([f s]
        (loop [num1 f num2 s acc 0]
            (let [total (+ num1 num2)]
                (if (> total 4000000) 
                acc
                (recur num2 total (if (zero? (rem total 2)) (+ acc total) acc))
            )))))
;user=> (euler2)
;4613732    
    
