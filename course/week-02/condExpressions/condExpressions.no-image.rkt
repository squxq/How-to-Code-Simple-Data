;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname condExpressions.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 20 "solid" "red"))
(define I3 (rectangle 20 10 "solid" "red"))

;; Image -> String
;; produce shape of image, one of "tall", "square" or "wide"
(check-expect (aspect-ratio I1) "tall")
(check-expect (aspect-ratio I2) "square")
(check-expect (aspect-ratio I3) "wide")

;(define (aspect-ratio img) "")  ;stub

;(define (aspect-ratio img)      ;template
;  (... img))

#;
(define (aspect-ratio img)  
  (if (> (image-height img) (image-width img))
      "tall"
      (if (= (image-height img) (image-width img))
          "square"
          "wide")))

; using "cond"
(define (aspect-ratio img)
	(cond [(> (image-height img) (image-width img)) "tall"]
				[(= (image-height img) (image-width img)) "square"]
				[else "wide"]))

; both () and [] are equivalent, but by convention, we use [] around question/answer pairs in cond.
; this makes the cond easier to read.

; expression
(cond [(> 1 2) "bigger"]
	[(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 1
(cond [false "bigger"]
	[(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 2
(cond [(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 3
(cond [false "equal"]
	[(< 1 2) "smaller"])

; step 4
(cond [(< 1 2) "smaller"])

; step 5
(cond [true "smaller"])

; step 6 - smaller
"smaller"