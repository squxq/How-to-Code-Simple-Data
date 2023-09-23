;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname traffic-light-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; traffic-light-starter.rkt

;Design an animation of a traffic light. 
;
;Your program should show a traffic light that is red, then green, 
;then yellow, then red etc. For this program, your changing world 
;state data definition should be an enumeration.
;
;Here is what your program might look like if the initial world 
;state was the red traffic light:
;(open image file)
;Next:
;(open image file)
;Next:
;(open image file)
;Next is red, and so on.
;
;To make your lights change at a reasonable speed, you can use the 
;rate option to on-tick. If you say, for example, (on-tick next-color 1) 
;then big-bang will wait 1 second between calls to next-color.
;
;Remember to follow the HtDW recipe! Be sure to do a proper domain 
;analysis before starting to work on the code file.
;
;Note: If you want to design a slightly simpler version of the program,
;you can modify it to display a single circle that changes color, rather
;than three stacked circles. 

;; A traffic light that cycles between red, green and yellow lights each second

;; =====================
;; Constants

(define WIDTH 100)
(define HEIGHT (* WIDTH 3))

(define CIRCLE_RADIUS (* WIDTH (/ 2 5)))
(define MTS (overlay (overlay
                      (above (overlay (circle CIRCLE_RADIUS "outline" "red")
                                              (square WIDTH "solid" "transparent"))
                                     (overlay (circle CIRCLE_RADIUS "outline" "yellow")
                                              (square WIDTH "solid" "transparent"))
                                     (overlay (circle CIRCLE_RADIUS "outline" "green")
                                              (square WIDTH "solid" "transparent")))
                                     (rectangle WIDTH HEIGHT "solid" "black"))
                     (empty-scene WIDTH HEIGHT)))

(define CIRCLE_X (/ WIDTH 2))

(define CIRCLE_0_Y (/ HEIGHT 6))
(define CIRCLE_1_Y (/ HEIGHT 2))
(define CIRCLE_2_Y (* HEIGHT (/ 5 6)))

;; =====================
;; Data Definitions:

;; TrafficLight is one of:
;; - "red"
;; - "green"
;; - "yellow"
;; interp. represents the 3 options of traffic lights

;; <Examples are redundant for enumerations.>

;; Template
(define (fn-for-traffic-light tl)
  (cond [(string=? tl "red") (...)]
        [(string=? tl "green") (...)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "red"
;; - atomic distinct: "green"
;; - atomic distinct: "yellow"

;; =====================
;; Function Definitions

;; TrafficLight -> TrafficLight
;; start the world with (main "red") or (main "green") or (main "yellow")
;;
(define (main tl)
  (big-bang tl               ; TrafficLight
    (on-tick next-color 1)     ; TrafficLight -> TrafficLight
    (to-draw render-color))) ; TrafficLight -> Image


;; TrafficLight -> TrafficLight
;; produce the next color in order: red -> green -> yellow -> ...

;; Stub:
#;
(define (next-color tl) "red")

;; Tests:
(check-expect (next-color "red") "green")
(check-expect (next-color "green") "yellow")
(check-expect (next-color "yellow") "red")

;; <Took template from TrafficLight>
(define (next-color tl)
  (cond [(string=? tl "red") "green"]
        [(string=? tl "green") "yellow"]
        [else "red"]))


;; TrafficLight -> Image
;; produce filled circle of current traffic light and outlined circles of the innactive traffic lights

;; Stub:
#;
(define (render-color tl) (circle 0 "solid" "white"))

;; Tests:
(check-expect (render-color "red")
              (place-image (circle CIRCLE_RADIUS "solid" "red")
                           CIRCLE_X CIRCLE_0_Y MTS))
(check-expect (render-color "green")
              (place-image (circle CIRCLE_RADIUS "solid" "green")
                           CIRCLE_X CIRCLE_2_Y MTS))
(check-expect (render-color "yellow")
              (place-image (circle CIRCLE_RADIUS "solid" "yellow")
                           CIRCLE_X CIRCLE_1_Y MTS))

;; <Took template from TrafficLight>
(define (render-color tl)
  (cond [(string=? tl "red")
         (place-image (circle CIRCLE_RADIUS "solid" "red")
                           CIRCLE_X CIRCLE_0_Y MTS)]
        [(string=? tl "green")
         (place-image (circle CIRCLE_RADIUS "solid" "green")
                           CIRCLE_X CIRCLE_2_Y MTS)]
        [else (place-image (circle CIRCLE_RADIUS "solid" "yellow")
                           CIRCLE_X CIRCLE_1_Y MTS)]))