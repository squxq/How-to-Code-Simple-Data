;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname evaluation-prims-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; PROBLEM:

; Write out the step-by-step evaluation for the following expression: 

; (+ (* 2 3) (/ 8 2))

; expression
(+ (* 2 3) (/ 8 2))

; step 1
(+ 6       (/ 8 2))
; step 2
(+ 6             4)
; step 3 - output
10


; PROBLEM:

; Write out the step-by-step evaluation for the following expression: 

; (* (string-length "foo") 2)

; expression
(* (string-length "foo") 2)

; step 1
(* 3                     2)
; step 2 - output
6