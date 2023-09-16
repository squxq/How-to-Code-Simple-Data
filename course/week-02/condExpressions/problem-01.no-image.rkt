;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Problem:
;
;Given the following definition:   
;
;(define (absval n)
;  (cond [(> n 0) n]
;        [(< n 0) (* -1 n)]
;        [else 0]))
;
;Hand step the execution of:
;
;(absval -3)

(define (absval n)
  (cond [(> n 0) n]
        [(< n 0) (* -1 n)]
        [else 0]))

(absval -3)

; step 1
(cond ((> -3 0) -3) ((< -3 0) (* -1 -3)) (else 0))

; step 2
(cond (#false -3) ((< -3 0) (* -1 -3)) (else 0))

; step 3
(cond ((< -3 0) (* -1 -3)) (else 0))

; step 4
(cond (#true (* -1 -3)) (else 0))

; step 5
(* -1 -3)

; step 6 - output
3