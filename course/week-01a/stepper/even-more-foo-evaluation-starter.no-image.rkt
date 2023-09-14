;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname even-more-foo-evaluation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; even-more-foo-evaluation-starter.rkt

;PROBLEM:

;Given the following function definition:

;(define (farfle s)
;  (string-append s s))

;Write out the step-by-step evaluation of the expression: 

;(farfle (substring "abcdef" 0 2))

;Be sure to show every intermediate evaluation step.

(define (farfle s)
  (string-append s s))

; expression
(farfle (substring "abcdef" 0 2))

; step 1
(farfle "ab")

; step 2
(string-append "ab" "ab")

; step 3 - output
"abab"