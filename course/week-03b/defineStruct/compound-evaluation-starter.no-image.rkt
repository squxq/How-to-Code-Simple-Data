;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compound-evaluation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; compound-evaluation-starter.rkt

;PROBLEM:
;
;
;Given the following definitions:
;
;(define-struct census-data (city population))
;
;(define (count-newborn cd)
;  (make-census-data
;   (census-data-city cd)
;   (add1 (census-data-population cd))))
;
;
;Write down the evaluation steps for the following expression.          
;
;(count-newborn (make-census-data "Vancouver" 603502))

(define-struct census-data (city population))

(define (count-newborn cd)
  (make-census-data
   (census-data-city cd)
   (add1 (census-data-population cd))))

;; Expression
(count-newborn (make-census-data "Vancouver" 603502))

;; Step 1:
(make-census-data
 (census-data-city
  (make-census-data
   "Vancouver"
   603502))
 (add1
  (census-data-population
   (make-census-data
    "Vancouver"
    603502))))

;; Step 2:
(make-census-data
 "Vancouver"
 (add1
  (census-data-population
   (make-census-data
    "Vancouver"
    603502))))

;; Step 3:
(make-census-data
 "Vancouver"
 (add1 603502))

;; Step 4 - definition:
(make-census-data "Vancouver" 603503)