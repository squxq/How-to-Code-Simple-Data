;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname function-writing-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; function-writing-starter.rkt

;PROBLEM:

;Write a function that consumes two numbers and produces the larger of the two.

(define (larger a b)
  (if (> a b)
      a
      (if (< a b)
          b
          "Both numbers are equal")))

(larger 9 4)
; outputs 9, 9 > 4

(larger 4 9)
; outputs 9, 4 < 9

(larger 4 4)
; outputs "Both numbers are equal"