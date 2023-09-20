;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname HtDDDesignQuiz.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; HtDD Design Quiz

;; Age is Natural
;; interp. the age of a person in years
(define A0 1)
(define A1 13)
(define A2 16)
(define A3 19)
(define A4 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural


;Problem 1:
;
;Consider the above data definition for the age of a person.
;
;Design a function called teenager? that determines whether a person
;of a particular age is a teenager (i.e., between the ages of 13 and 19).

;; ====================
;; Function Definitions:

;; Age -> Boolean
;; returns true if age is between 13 and 19 (is a teenager)

;; Stub
#;
(define (teenager? a) false)

;; Tests:
(check-expect (teenager? A0) false)
(check-expect (teenager? A1) true)
(check-expect (teenager? A2) true)
(check-expect (teenager? A3) true)
(check-expect (teenager? A4) false)

;; <Took template from Age.>
(define (teenager? a)
  (and (> a 12) (< a 20)))

;Problem 2:
;
;Design a data definition called MonthAge to represent a person's age
;in months.

;; ================
;; Data Defnitions:

;; MonthAge is Natural
;; interp. the age of a person in months

;; Examples:
(define MA0 12)
(define MA1 156)
(define MA2 192)
(define MA3 228)
(define MA4 300)

;; Template:
#;
(define (fn-for-month-age ma)
  (... ma))

;; Template rules used:
;; - atomic non-distinct: Natural


;Problem 3:
;
;Design a function called months-old that takes a person's age in years 
;and yields that person's age in months.

;; =====================
;; Function Definitions:

;; Age -> MonthAge
;; given an age in years, produces that person's age in months

;; Stub:
#;
(define (months-old a) 0)

;; Tests:
(check-expect (months-old A0) MA0)
(check-expect (months-old A1) MA1)
(check-expect (months-old A2) MA2)
(check-expect (months-old A3) MA3)
(check-expect (months-old A4) MA4)

;; <Took template from Age.>
(define (months-old a)
  (* a 12))

;Problem 4:
;
;Consider a video game where you need to represent the health of your
;character. The only thing that matters about their health is:
;
;  - if they are dead (which is shockingly poor health)
;  - if they are alive then they can have 0 or more extra lives
;
;Design a data definition called Health to represent the health of your
;character.
;
;Design a function called increase-health that allows you to increase the
;lives of a character.  The function should only increase the lives
;of the character if the character is not dead, otherwise the character
;remains dead.

;; =================
;; Data Definitions:

;; Health is one of:
;; - false
;; - Natural
;; interp. false represents the character is dead, else the number of extra lives the character has

;; Examples
(define H0 false)
(define H1 0)
(define H2 13)

;; Template:
#;
(define (fn-for-health h)
  (cond [(false? h) (...)]
        [else (... h)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - atomic non-distinct: Natural

;; =====================
;; Function Definitions:

;; Health -> Health
;; if the given health is not false increase it by 1, else the character remains dead (false)

;; Stub:
#;
(define (increase-health h) 0)

;; Tests:
(check-expect (increase-health H0) false)
(check-expect (increase-health H1) 1)
(check-expect (increase-health H2) 14)

;; <Took template from Health.>
(define (increase-health h)
  (cond [(false? h) false]
        [else (+ h 1)]))