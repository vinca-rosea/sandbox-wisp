(defn range
  [& args]
  (def len (.-length args))
  (def from-to-step
    (cond
      (== len 1) [0 (get args 0) 1]
      (> len 1) [(get args 0) 
                 (get args 1)
                 (if (>= len 3) (get args 2) 1)]
      :else []))
  (def result [])
  (def from (get from-to-step 0))
  (def to (get from-to-step 1))
  (def step (get from-to-step 2))
  (if (<= from to)
    (loop [i from]
      (if (< i to)
        (do
          (.push result i)
          (recur (+ i step)))
        result))
    (loop [i from]
      (if (> i to)  
        (do
          (.push result i)
          (recur (+ i step)))
        result))))
