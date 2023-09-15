;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname poorlyFormedProblems.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;PROBLEM:
;
;DESIGN a function that consumes an image and determines whether the 
;image is tall.
;
;Remember, when we say DESIGN, we mean follow the recipe.
;
;Leave behind commented out versions of the stub and template.

;; Image -> Boolean
;; produce true if the image is tall

; new purpose
;; produce true if the image is tall (height is greater than width)

; functions that produce a boolean have a name that ends in a question mark

;(define (tall? img) false) ; stub

(check-expect (tall? (rectangle 2 3 "solid" "red")) true)
(check-expect (tall? (rectangle 3 2 "solid" "red")) false)
(check-expect (tall? (rectangle 3 3 "solid" "red")) false)

;(define (tall? img)
; 	(... img))

;(define (tall? img)
;	(if (> (image-height img) (image-width img))
;		true
;		false)) ; highlighted

; it's possible to rewrite the function definition as:
(define (tall? img)
	(> (image-height img) (image-width img)))