;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname slowMotionHtDFRecipe) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; step 1 - signature, purpose and stub
;; Number -> Number ; signature
;; produce 2 times the given number ; purpose
;(define (double n) 0) ; stub

; step 2 - define examples (also known as [unit] tests), wrap each in check-expect
(check-expect (double 3) 6)
(check-expect (double 4.2) 8.4)
; Number -> real numbers, integers, natural, etc.
; These two examples serve to really illustrate that I don't just mean integers.
; run the code and check if both tests run, although they will fail that goal is to see if they are well-formed

; step 3 - template and inventory
;(define (double n)
;	(... n))

; step 4 - code the function body
(define (double n)
	(* 2 n))

; step 5 - test and debug until correct
; simply run the program and fix possible issues (errors and warnings)