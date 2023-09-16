;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname blue-triangle-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; blue-triangle-starter.rkt

;PROBLEM:
;
;Design a function that consumes a number and produces a blue solid triangle of that size.
;
;You should use The How to Design Functions (HtDF) recipe, and your complete design should include
;signature, purpose, commented out stub, examples/tests, commented out template and the completed function.

;; Natural -> Image ; its a Natural because pixels are Natural Numbers
;; return a blue solid triangle with side size of given natural number (pixels)

; stub
;(define (generateTriangle num) (triangle 40 "solid" "blue"))

; tests
(check-expect (generateTriangle 20) (triangle 20 "solid" "blue"))
(check-expect (generateTriangle 0) "Must provide a Natural number.")
(check-expect (generateTriangle -10) "Must provide a Natural number.")

; template
;(define (generateTriangle num)
;  (... num))

; function definition
(define (generateTriangle num)
  (if (> num 0)
      (triangle num "solid" "blue")
      "Must provide a Natural number."))