(require :two.js)
(def util (require "./utility.wisp"))
(require "./style.css")
(defmacro cos [x] `(Math.cos ~x))
(defmacro sin [x] `(Math.sin ~x))
(defmacro tan [x] `(Math.tan ~x))
(defmacro rgba [r g b a] `(+ "rgba(" ~r "," ~g "," ~b "," ~a ")"))
(defmacro add!
  [target num]
  `(set! ~target (+ ~num ~target)))

(def two 
  (new Two {:fullscreen true
            :autostart true
            :type Two.Types.webgl}))

(.appendTo two document.body)
(def rect 
  (.map (util.range 100) 
        (fn [x]
            (let [r (.makeRectangle two (+ (/ two.width 2)) (/ two.height 2) (+ 400 (* x -5)) (+ 400 (* x -5)))]
                 (r.noStroke)              
                 r))))

(.bind two :update
  (fn [t] 
      (.forEach rect (fn [r i] (do
                                  (set! r.fill (rgba (+ 127 (* (cos (+ (* t 0.05) (* i 0.1))) 127))
                                                     (+ 127 (* (cos (+ (* t 0.02) (* i 0.2))) 127))
                                                     (+ 127 (* (cos (+ (* t 0.03) (* i 0.3))) 127))
                                                     0.05))
                                  (add! (.-rotation r) (* i 0.001)))))))
