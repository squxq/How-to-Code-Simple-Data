;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname season-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; Data Definitions

;; Season is one of:
;; - "spring"
;; - "summer"
;; - "fall"
;; - "winter"
;; interp. the four seasons of the year

;; <examples are redundant for enumeration>

#;
(define (fn-for-season s)
  (cond [(string=? "spring" s) (...)]
        [(string=? "summer" s) (...)]
        [(string=? "fall" s) (...)]
        [(string=? "winter" s) (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: "spring"
;; - atomic distinct: "summer"
;; - atomic distinct: "fall"
;; - atomic distinct: "winter"

;PROBLEM:
;
;Consider the problem of designing a function called next-season                
;that takes the given season and produces the season that follows. 

;; Function Definitions

;; Season -> Season
;; produce the next season after the given season

#;
(define (next-season s) "spring") ;stub

;; Tests:
(check-expect (next-season "spring") "summer")
(check-expect (next-season "summer") "fall")
(check-expect (next-season "fall") "winter")
(check-expect (next-season "winter") "spring")

;; <used template from Season>
(define (next-season s)
  (cond [(string=? "spring" s) "summer"]
        [(string=? "summer" s) "fall"]
        [(string=? "fall" s) "winter"]
        [(string=? "winter" s) "spring"]))