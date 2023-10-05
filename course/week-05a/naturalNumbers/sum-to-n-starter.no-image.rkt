;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum-to-n-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; sum-to-n-starter.rkt

;  PROBLEM:
;  
;  Design a function that produces the sum of all the naturals from 0 to a given n.

;; Natural -> Natural
;; produce the sum of all the natural numbers from 0 to given natural number n

;; Stub:
#;
(define (sum-all n) 0)

;; Tests:
(check-expect (sum-all 0) 0)
(check-expect (sum-all 10) 55)
(check-expect (sum-all 100) 5050)

;; Template:
#;
(define (sum-all n)
  (cond [(zero? n) 0]
        [else
         (... n
              (sum-all (sub1 n)))]))

(define (sum-all n)
  (cond [(zero? n) 0]
        [else
         (+ n
              (sum-all (sub1 n)))]))