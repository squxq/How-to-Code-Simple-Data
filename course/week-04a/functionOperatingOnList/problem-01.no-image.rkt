;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Consider the following Data Definition for ListOfNumber:
;
;We would like to design a function that consumes a list of numbers and produces true if that list contains a negative number.

;; Data Definitions:

;; ListOfNumber is one of:
;; - empty
;; - (cons Number ListOfNumber)
;; interp. a list of numbers

;; Examples:
(define LON0 empty)
(define LON1 (cons 1 empty))
(define LON2 (cons 2 (cons -1 empty)))
(define LON3 (cons -4 (cons 10 empty)))

;; Template:
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else (...
               (first lon)                 ; Number
               (fn-for-lon (rest lon)))])) ; ListOfNumber

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons Number ListOfNumber)
;; - [coming soon]


;; Function Definitions:

;; ListOfNumber -> Boolean
;; produce true if the given list of numbers contains a negative number

;; Stub:
#;
(define (contains-negative? lon) false)

;; Tests:
(check-expect (contains-negative? LON0) false)
(check-expect (contains-negative? LON1) false)
(check-expect (contains-negative? LON2) true)
(check-expect (contains-negative? LON3) true)

;; Template:
;; <Used template from ListOfNumber>

(define (contains-negative? lon)
  (cond [(empty? lon) false]
        [else (if (< (first lon) 0)
               true
               (contains-negative? (rest lon)))]))