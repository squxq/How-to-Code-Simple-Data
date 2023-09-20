;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname style-rules-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; style-rules-starter.rkt

;PROBLEM:
;
;You're redesigning the SeatNum data definition from lecture, and you're not
;sure if you've done it correctly. When you ask a TA for feedback, she tells
;you that you haven't followed our style rules and she asks you to re-format 
;your data definition before she gives you feedback.
;
;a) Why is it important to follow style rules?
;
;b) Fix the data definition below so that it follows our style rules. Be sure to 
;consult the style rules page so that you make ALL the required changes, of which 
;there are quite a number.

;Following style rules in programming is essential because it enhances code readability,
;eases collaboration among developers, and simplifies code maintenance. Consistent style
;improves code quality, facilitates effective code reviews, and allows for the automation
;of error detection and correction. It also ensures portability, supports career advancement,
;encourages adherence to best practices, aids in documentation, and promotes consistency
;across projects, making it a fundamental aspect of professional software development.

;; Data Defnitions:

;; SeatNum is Natural[1,32]
;; interp. the number of a seat in a row, 1 and 32 are aisle seats

;; Examples:
(define SN1 1)
(define SN2 15)
(define SN3 32)

;; Template:
#;
(define (fn-for-seat-num sn)
  (... sn))

;; Template rules used:
;; - atomic non-distinct: Natural[1,32]
