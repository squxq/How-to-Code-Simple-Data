;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname largest-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; largest-starter.rkt

;; =================
;; Data definitions:

;Remember the data definition for a list of numbers we designed in Lecture 5f:
;(if this data definition does not look familiar, please review the lecture)

;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers

;; Examples:
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
(define LON3 (cons 60 (cons 42 (cons 132 empty))))

;; Template:
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Number ListOfNumber)
;;  - self-reference: (rest lon) is ListOfNumber

;; =====================
;; Function Definitions:

;PROBLEM:
;
;Design a function that consumes a list of numbers and produces the largest number 
;in the list. You may assume that all numbers in the list are greater than 0. If
;the list is empty, produce 0.

;; ListOfNumber -> Number
;; produce the largest number in the given list of numbers

;; Stub:
#;
(define (largest lon) 0)

;; Tests:
(check-expect (largest LON1) 0)
(check-expect (largest LON2) 60)
(check-expect (largest LON3) 132)

;; Template:
;; <Used template from ListOfNumber>

(define (largest lon)
  (cond [(empty? lon) 0]
        [else (if (> (first lon) (largest (rest lon)))
              (first lon)
              (largest (rest lon)))]))