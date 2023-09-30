;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname designingLists.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;You've been asked to design a program having to do with all the owls
;in the owlery.
;
;(A) Design a data definition to represent the weights of all the owls. 
;    For this problem call it ListOfNumber.
;(B) Design a function that consumes the weights of owls and produces
;    the total weight of all the owls.
;(C) Design a function that consumes the weights of owls and produces
;    the total number of owls.

;; =====================
;; Data Definitions:

;; ListOfNumber is one of:
;; - empty
;; - (cons Number ListOfNumber)
;; interp. a list of numbers representing an owl weight in ounces

;; Examples:
(define LON0 empty)
(define LON1 (cons 32 empty))
(define LON2 (cons 95 (cons 57 empty)))

;; Template:
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else (...
               (first lon) ; Number
               (fn-for-lon (rest lon)))])) ; ListOfNumber

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons Number ListOfNumber)
;; - self-reference: (rest los) is ListOfNumber

;; =====================
;; Function Definitions:

;; ListOfNumber (v1-Number) -> Number
;; produce the sum of all numbers in given list of numbers (v1: with starting sum, sum = 0)

;; Stub:
#;
(define (total-weight lon) 0)

;; Tests:
(check-expect (total-weight-v2 LON0) 0)
(check-expect (total-weight-v2 LON1) 32)
(check-expect (total-weight-v2 LON2) (+ 95 57))

;; Template:
;; <Used template from ListOfNumber>
#;
(define (total-weight lon s)
  (cond [(empty? lon) s]
        [else (total-weight (rest lon) (+ s (first lon)))]))

;; or

(define (total-weight-v2 lon)
  (cond [(empty? lon) 0]
        [else (+ (first lon) (total-weight-v2 (rest lon)))]))


;; ListOfNumber (v1: Number) -> Number
;; produce the count of all elements in given list of numbers (v1: with starting count, count = 0)

;; Stub:
#;
(define (total-count lon) 0)

;; Tests:
(check-expect (total-count-v2 LON0) 0)
(check-expect (total-count-v2 LON1) 1)
(check-expect (total-count-v2 LON2) 2)

;; Note:
; Tests on lists at least two elements long are good for
; catching mistakes in not using the natural recursion properly.
;; End of Note 

;; Template:
;; <Used template from ListOfNumber>
#;
(define (total-count lon c)
  (cond [(empty? lon) c]
        [else (total-count (rest lon) (+ c 1))]))

;; or

(define (total-count-v2 lon)
  (cond [(empty? lon) 0]
        [else (+ 1 (total-count-v2 (rest lon)))]))