;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname listMechanisms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; an empty list of any type of value
empty
; outputs empty

; a list with "Flames" on the front of an empty list
(cons "Flames" empty) ; a list of 1 element
; outputs (cons "Flames" empty)

(cons "Leafs" (cons "Flames" empty)) ; a list of 2 elements
; outputs (cons "Leafs" (cons "Flames" empty))

(cons (string-append "C" "anucks") empty)
; outputs (cons "Canucks" empty)

(cons 10 (cons 9 (cons 10 empty))) ; a list of 3 elements
; ouputs (cons 10 (cons 9 (cons 10 empty)))

(cons (square 10 "solid" "blue") (cons (triangle 20 "solid" "green") empty))
; (cons (square 10 "solid" "blue") (cons (triangle 20 "solid" "green") empty))

(define L1 (cons "Flames" empty))
(define L2 (cons 10 (cons 9 (cons 10 empty))))
(define L3 (cons (square 10 "solid" "blue") 
           (cons (triangle 20 "solid" "green") empty)))

(first L1)
; outputs "Flames"

(first L2)
; outputs 10

(first L3)
; outputs (square 10 "solid" "blue")

(rest L1)
; outputs empty

(rest L2)
; outputs (cons 9 (cons 10 empty))

(rest L3)
; outputs (cons (triangle 20 "solid" "green") empty)

(first (rest L2)) ; get the second element of L2
; outputs 9

(first (rest (rest L2))) ; get the third element of L2
; outputs 10

(empty? empty)
; outputs true

(empty? L1)
; outputs false

(empty? 1)
; outputs false