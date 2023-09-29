;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Design a World Program with Compound Data. You can be as creative as you like, but keep it simple. Above all, follow the recipes!
;You must also stay within the scope of the first part of the course. Do not use language features we have not seen in the videos. 
;
;If you need inspiration, you can choose to create a program that allows you to click on a spot on the screen to create a flower, which then grows over time.
;If you click again the first flower is replaced by a new one at the new position.
;
;You should do all your design work in DrRacket. Following the step-by-step recipe in DrRacket will help you be sure that you have a quality solution.

(require 2htdp/image)
(require 2htdp/universe)

;; A yard where we can plant flowers in different spots and watch them grow

;; =====================
;; Constants:

(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define MTS (overlay (rectangle WIDTH HEIGHT "solid" "Deep Sky Blue") (empty-scene WIDTH HEIGHT)))

(define STEM-COLOR "lawn green")
(define SMALL-PETAL (square 20 "solid" "deep pink"))
(define LARGE-PETAL (above SMALL-PETAL (beside SMALL-PETAL SMALL-PETAL SMALL-PETAL) SMALL-PETAL))

;; =====================
;; Data Definitions:

;; Size is one of:
;;  - Natural[1, 3]
;;  - "small petal"
;;  - "large petal"
;; interp. Natural[1, 3] represents the size of a flower's stem when it's growing in block units (20x20 squares),
;;         "small petal" is the under-developed petal that uses 1 unit (stem's size is 4 units)
;;         "large petal" is the fully-developed petal which assumes a "+" shape 3 by 3 units (stem's size is 4 units)

;; Examples:
(define S0 1)               ; 20x20 stem
(define S1 2)               ; 20x40 stem
(define S2 3)               ; 20x60 stem
(define S3 "small petal")   ; 20x80 stem / 20x20 petal
(define S4 "large petal")   ; 20x80 stem / 60x60 petal (Area = 5 * 20x20)

;; Template:
#;
(define (fn-for-size s)
  (cond [(number? s) (... s)]
        [(and (string? s) (string=? s "small petal")) (...)]
        [(string=? s "large petal") (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic non-distinct: Natural[1, 3]
;; - atomic distinct: "small petal"
;; - atomic distinct: "large petal"


(define-struct flower (x y s))
;; Flower is (make-flower Natural[0, WIDTH] Natural[0, HEIGHT] Size)
;; interp. (make-flower x y s) is a flower with:
;;         x is the flower's x coordinate
;;         y is the flower's y coordinate
;;         s is the flower's size (stem and petal)

;; Examples:
(define F0 (make-flower (/ WIDTH 2) (/ HEIGHT 2) 1))
(define F1 (make-flower (/ WIDTH 3) (/ HEIGHT 4) 3))
(define F2 (make-flower 324 874 "small petal"))
(define F3 (make-flower 1469 438 "large petal"))

;; Template:
#;
(define (fn-for-flower f)
  (... (flower-x f)
       (flower-y f)
       (cond [(number? (flower-s f)) (... (flower-s f))]
        [(and (string? (flower-s f)) (string=? (flower-s f) "small petal")) (...)]
        [(string=? (flower-s f) "large petal") (...)])))

;; Template rules used:
;; - compound rule: 3 fields

;; =====================
;; Function Definitions:

;; Flower -> Flower
;; start the world with: (main (make-flower 800 450 1))

(define (main f)
  (big-bang f                         ; Flower
    (on-tick grow-flower (/ 1 4))     ; Flower -> Flower
    (to-draw render-flower)           ; Flower -> Image
    (on-mouse new-flower)))           ; Flower Integer Integer MouseEvent -> Flower


;; Flower -> Flower
;; produce the next growing stage of the current flower (if not fully developed - "large petal")

;; Stub:
#;
(define (grow-flower f) F0)

;; Tests:
(check-expect (grow-flower F0) (make-flower (flower-x F0) (flower-y F0) 2))
(check-expect (grow-flower F1) (make-flower (flower-x F1) (flower-y F1) "small petal"))
(check-expect (grow-flower F2) (make-flower (flower-x F2) (flower-y F2) "large petal"))
(check-expect (grow-flower F3) F3)

;; Template:
;; <Used template from Flower>

(define (grow-flower f)
  (make-flower (flower-x f) (flower-y f)
       (cond [(and (number? (flower-s f)) (< (flower-s f) 3)) (+ (flower-s f) 1)]
        [(and (number? (flower-s f)) (= (flower-s f) 3)) "small petal"]
        [(string? (flower-s f)) "large petal"])))


;; Flower -> Image
;; produce an image of the flower in its current position and growing stage

;; Stub:
#;
(define (render-flower f) STEM)

;; Tests:
(check-expect (render-flower F0) (place-image (rectangle 20 20 "solid" STEM-COLOR) (flower-x F0) (flower-y F0) MTS))
(check-expect (render-flower F1) (place-image (rectangle 20 60 "solid" STEM-COLOR) (flower-x F1) (- (flower-y F1) 20) MTS))
(check-expect (render-flower F2) (place-image (above SMALL-PETAL (rectangle 20 80 "solid" STEM-COLOR)) (flower-x F2) (- (flower-y F2) 40) MTS))
(check-expect (render-flower F3) (place-image (above LARGE-PETAL (rectangle 20 80 "solid" STEM-COLOR)) (flower-x F3) (- (flower-y F3) 60) MTS))

;; Template:
;; <Used template from Flower>

(define (render-flower f)
  (cond [(number? (flower-s f)) (place-image (rectangle 20 (* (flower-s f) 20) "solid" STEM-COLOR) (flower-x f) (- (flower-y f) (- (/ (* (flower-s f) 20) 2) 10)) MTS)]
                     [(and (string? (flower-s f)) (string=? (flower-s f) "small petal")) (place-image (above SMALL-PETAL (rectangle 20 80 "solid" STEM-COLOR)) (flower-x f) (- (flower-y f) 40) MTS)]
                     [(string=? (flower-s f) "large petal") (place-image (above LARGE-PETAL (rectangle 20 80 "solid" STEM-COLOR)) (flower-x f) (- (flower-y f) 60) MTS)]))


;; Flower Integer Integer MouseEvent -> Flower
;; when mouse is pressed ("button-down") create a new flower at mouse position

;; Stub:
#;
(define (new-flower f x y me) F0)

;; Tests:
(check-expect (new-flower F0 749 85 "button-down") (make-flower 749 85 1))
(check-expect (new-flower F0 749 85 "move") F0)
(check-expect (new-flower F1 0 0 "button-down") (make-flower 0 0 1))
(check-expect (new-flower F2 1495 547 "button-down") (make-flower 1495 547 1))
(check-expect (new-flower F3 (/ WIDTH 2) (/ HEIGHT 2) "button-down") (make-flower (/ WIDTH 2) (/ HEIGHT 2) 1))

;; Template:
#;
(define (new-flower f x y me)
  (cond [(mouse=? me "button-down") (x y (...
                                          (flower-x f)
                                          (flower-y f)
                                          (cond [(number? (flower-s f)) (... (flower-s f))]
                                                [(and (string? (flower-s f)) (string=? (flower-s f) "small petal")) (...)]
                                                [(string=? (flower-s f) "large petal") (...)])))]
        [else f]))

(define (new-flower f x y me)
  (cond [(mouse=? me "button-down") (make-flower x y 1)]
        [else f]))