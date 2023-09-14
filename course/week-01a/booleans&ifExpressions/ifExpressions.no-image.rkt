;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ifExpressions.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 10 "solid" "blue"))
I2

(if (< (image-width I1) (image-height I1)) ; here I1 and I2 can be changed
    "tall"
    "wide") ; when the "tall" expression is outputed "wide" gets highlighted and vice-versa
; if the constant used is I1, it outputs "tall" - 10 < 20
; if the constant used is I2, it outputs "wide" - 20 > 10

; expression
(if (< (image-width I2)
       (image-height I2))
    (image-width I2)
    (image-height I2))

; step 1
(if (< 20 ; (image-width "alt: solid blue rectangle with dimensions 20x10")
       (image-height I2))
    (image-width I2)
	  (image-height I2))

; step 2
(if (< 20
       (image-height I2))
    (image-width I2)
	  (image-height I2))

; step 3
(if (< 20
       10; (image-height "alt: solid blue rectangle with dimensions 20x10")
       )
    (image-width I2)
	  (image-height I2))

; step 4
(if (< 20
       10)
    (image-width I2)
	  (image-height I2))

; step 5
(if false
    (image-width I2)
	  (image-height I2))

; step 6
(image-height I2)

; step 7
10 ; (image-height "alt: solid blue rectangle with dimensions 20x10")

; step 8
10

(> (image-height I1) (image-height I2))
; outputs true

(> (image-width I1) (image-width I2))
; outputs true

(and (> (image-height I1) (image-height I2)) 
     (< (image-width I1) (image-width I2)))
; outputs true