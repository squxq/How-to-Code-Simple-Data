;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname odd-from-n-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; odd-from-n-starter.rkt

;PROBLEM:
; 
; Design a function called odd-from-n that consumes a natural number n, and produces a list of all 
; the odd numbers from n down to 1. 
; 
; Note that there is a primitive function, odd?, that produces true if a natural number is odd.

;; ListOfNatural is one of:
;; - empty
;; - (cons Natural ListOfNatural)
;; interp. a list of natural numbers

;; Examples:
(define LON0 empty)
(define LON1 (cons 1 empty))
(define LON2 (cons 3 (cons 1 empty)))
(define LON3 (cons 5 (cons 3 (cons 1 empty))))
(define LON4 (cons 11 (cons 9 (cons 7 (cons 5 (cons 3 (cons 1 empty)))))))

;; Template:

(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Natural ListOfNatural)
;; - self-reference: (rest lon) is ListOfNatural


;; Natural -> ListOfNatural
;; produce a list of all the odd numbers (n = 2k + 1) from n down to 1

;; Stub:
#;
(define (odd-from-n n) LON0)

;; Tests:
;; Solution with one function
(check-expect (odd-from-n 0) LON0)
(check-expect (odd-from-n 1) LON1)
(check-expect (odd-from-n 2) LON1)
(check-expect (odd-from-n 4) LON2)
(check-expect (odd-from-n 5) LON3)
(check-expect (odd-from-n 11) LON4)

;; Solution with two functions (more performant)
(check-expect (odd-from-n-perf 0) LON0)
(check-expect (odd-from-n-perf 1) LON1)
(check-expect (odd-from-n-perf 2) LON1)
(check-expect (odd-from-n-perf 4) LON2)
(check-expect (odd-from-n-perf 5) LON3)
(check-expect (odd-from-n-perf 11) LON4)

;; Template:
#;
(define (odd-from-n n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (odd-from-n (sub1 n)))]))

;; Solution with one function
(define (odd-from-n n)
  (cond [(zero? n) empty]
        [else
         (if (odd? n)
             (cons n (odd-from-n (sub1 n)))
             (odd-from-n (sub1 n)))]))

;; Solution with two functions (more performant)
(define (odd-from-n-perf n)
  (cond [(odd? n) (odd-from-n-perf-layer n)]
        [(and (even? n) (not (= n 0))) (odd-from-n-perf-layer (sub1 n))]
        [else empty]))

(define (odd-from-n-perf-layer n)
  (cond [(= n 1) (cons 1 empty)]
        [else
         (cons n
              (odd-from-n-perf-layer (- n 2)))]))
