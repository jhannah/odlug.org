;;; Juan Vazquez 
;;; https://github.com/javazquez
;;; http://javazquez.com

(defn sum-name [idx name]
	" take the index and name string and multiply idx by name score..idx starts at 0 so inc it" 
	(* (inc idx) (reduce +(map #( inc(.indexOf "abcdefghijklmnopqrstuvwxyz" (str %))) (.toLowerCase name))) ))	
	
(def sorted-names (sort (.split (slurp "supplemental_files/names_p20.txt") "," )) )

(= 871198282 (reduce +(map-indexed sum-name sorted-names)))