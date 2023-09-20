;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bump-up-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; bump-up-starter.rkt

;PROBLEM:
;
;Using the LetterGrade data definition below design a function that
;consumes a letter grade and produces the next highest letter grade. 
;Call your function bump-up.

;; Data definitions:

;; LetterGrade is one of: 
;;  - "A"
;;  - "B"
;;  - "C"
;; interp. the letter grade in a course
;; <examples are redundant for enumerations>
#;
(define (fn-for-letter-grade lg)
  (cond [(string=? lg "A") (...)]
        [(string=? lg "B") (...)]
        [(string=? lg "C") (...)]))

;; Template rules used:
;;  one-of: 3 cases
;;  atomic distinct: "A"
;;  atomic distinct: "B"
;;  atomic distinct: "C"


;; Functions:

;; LetterGrade -> LetterGrade
;; produce the next highest letter grade (no change for "A")

#;
(define (bump-up lg) "A") ;stub

;; Tests:
(check-expect (bump-up "A") "A")
(check-expect (bump-up "B") "A")
(check-expect (bump-up "C") "B")

;; <use template from LetterGrade>
(define (bump-up lg)
  (cond [(string=? lg "A") "A"]
        [(string=? lg "B") "A"]
        [(string=? lg "C") "B"]))