;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bobble-evaluation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; bobble-evaluation-starter.rkt

;PROBLEM:

;Given the following function definition:

;(define (bobble s)
;  (if (<= (string-length s) 6)
;      (string-append s "ible")
;      s))

;Write out the step-by-step evaluation of the expression:

;(bobble (substring "fungus" 0 4))

;Be sure to show every intermediate evaluation step (including the original expression
;and the final result, our answer has 7 steps).

(define (booble s)
  (if (<= (string-length s) 6)
      (string-append s "ible")
      s))

; expression
(booble (substring "fungus" 0 4))

; step 1
(booble "fung")

; step 2
(if (<= (string-length "fung") 6)
    (string-append "fung" "ible")
    "fung")

; step 3
(if (<= 4 6) (string-append "fung" "ible") "fung")

; step 4
(if true (string-append "fung" "ible") "fung")

; step 5
(string-append "fung" "ible")

; step 6 - output
"fungible"