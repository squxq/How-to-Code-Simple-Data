;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname letter-grade-error-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; letter-grade-error-starter.rkt

;PROBLEM:
;
;You're working with a revised version of the LetterGrade data definition that
;you saw in lecture to design a function that produces true if a given LetterGrade 
;represents a passing grade in a course. You're working through HtDF and have 
;completed the signature, purpose, stub and examples, but you're getting an 
;error message.  Uncomment the code in the box below and revise it until 
;all the tests run (even though several tests still fail).

;;; LetterGrade is one of: 
;;;  - "A"
;;;  - "B"
;;;  - "C"
;;;  - "D"
;;;  - "F"
;;; interp. a grade in a course
;;; <examples are redundant for enumerations>
;#;
;(define (fn-for-letter-grade lg)
;  (cond [(string=? "A" lg) (...)]
;        [(string=? "B" lg) (...)]
;        [(string=? "C" lg) (...)]
;        [(string=? "D" lg) (...)]
;        [(string=? "F" lg) (...)]))
;
;
;;; LetterGrade -> Boolean
;;; produce true if the LetterGrade represents a passing grade
;(check-expect (pass? A) true)
;(check-expect (pass? B) true)
;(check-expect (pass? C) true)
;(check-expect (pass? D) true)
;(check-expect (pass? F) false)
;
;(define (pass? lg) true)

;; Data Definitions:

;; LetterGrade is one of: 
;;  - "A"
;;  - "B"
;;  - "C"
;;  - "D"
;;  - "F"
;; interp. a grade in a course
;; <examples are redundant for enumerations>
#;
(define (fn-for-letter-grade lg)
  (cond [(string=? "A" lg) (...)]
        [(string=? "B" lg) (...)]
        [(string=? "C" lg) (...)]
        [(string=? "D" lg) (...)]
        [(string=? "F" lg) (...)]))


;; LetterGrade -> Boolean
;; produce true if the LetterGrade represents a passing grade

;; Stub:
#;
(define (pass? lg) true)

;; Tests:
(check-expect (pass? "A") true)
(check-expect (pass? "B") true)
(check-expect (pass? "C") true)
(check-expect (pass? "D") true)
(check-expect (pass? "F") false)

;; <took tamplate from LetterGrade>
(define (pass? lg)
  (cond [(string=? "A" lg) true]
        [(string=? "B" lg) true]
        [(string=? "C" lg) true]
        [(string=? "D" lg) true]
        [(string=? "F" lg) false]))