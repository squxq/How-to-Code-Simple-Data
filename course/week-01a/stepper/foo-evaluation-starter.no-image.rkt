;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname foo-evaluation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; foo-evaluation-starter.rkt

;PROBLEM:

;Given the following function definition:

;(define (foo s)
;  (if (string=? (substring s 0 1) "a")
;      (string-append s "a")
;      s))

;Write out the step-by-step evaluation of the expression: 

;(foo (substring "abcde" 0 3))

;Be sure to show every intermediate evaluation step.

(define (foo s)
  (if (string=? (substring s 0 1) "a")
      (string-append s "a")
      s))

; expression
(foo (substring "abcde" 0 3))

; step 1
(foo "abc")

; step 2
(if (string=? (substring "abc" 0 1) "a")
    (string-append "abc" "a")
    "abc")

; step 3
(if (string=? "a" "a")
    (string-append "abc" "a")
    "abc")

; step 4
(if true (string-append "abc" "a") "abc")

; step 5
(string-append "abc" "a")

; step 6 - output
"abca"