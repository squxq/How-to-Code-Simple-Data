;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname evaluation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(+ 2 (* 3 4) (- (+ 1 2) 3))
; outputs 14
; + is an operator, all the expressions that follow the operator are the operands

; expression
(+ 2 (* 3 4) (- (+ 1 2) 3))

; step 1
(+ 2 12      (- (+ 1 2) 3))
; step 2
(+ 2 12      (- 3       3))
; step 3
(+ 2 12                  0)
; step 4 - output
14