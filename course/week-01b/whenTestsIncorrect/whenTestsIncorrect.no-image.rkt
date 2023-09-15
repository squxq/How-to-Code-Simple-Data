;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname whenTestsIncorrect.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;DESIGN a function called area that consumes the length of one side 
;of a square and produces the area of the square.
;
;Remember, when we say DESIGN, we mean follow the recipe.
;
;Leave behind commented out versions of the stub and template.

;; Number -> Number
;; given the length of one side of the square, produce the area of the square

; this is not a good purpose, because it repeats the signature
;; given number produce number

;(define (area s) 0) ; stub
; a good dummy value to produce is 0

;(check-expect (area 3) 3) ; for now, pretend you didn't notice this mistake
(check-expect (area 3) 9)
(check-expect (area 3.2) (* 3.2 3.2))

;(define (area s) ; template
; 	(... s))

(define (area s)
	(* s s))