;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boolean-list-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; boolean-list-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;Design a data definition to represent a list of booleans. Call it ListOfBoolean. 

;; ListOfBoolean is one of:
;; - empty
;; - (cons Boolean ListOfBoolean)
;; interp. a list of booleans

;; Examples:
(define LOB0 empty)
(define LOB1 (cons false empty))
(define LOB2 (cons true (cons false empty)))
(define LOB3 (cons true (cons true (cons true empty))))

;; Template:
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else (...
         (first lob)                 ; Boolean
         (fn-for-lob (rest lob)))])) ; ListOfBoolean

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons Boolean ListOfBoolean)
;; - self-reference: (rest lob) is ListOfBoolean

;; =================
;; Functions:

;PROBLEM B:
;
;Design a function that consumes a list of boolean values and produces true 
;if every value in the list is true. If the list is empty, your function 
;should also produce true. Call it all-true?

;; ListOfBoolean -> Boolean
;; produce true if all elements in list of booleans are true; else false

;; Stub:
#;
(define (all-true? lob) false)

;; Tests:
(check-expect (all-true? LOB0) true)
(check-expect (all-true? LOB1) false)
(check-expect (all-true? LOB2) false)
(check-expect (all-true? LOB3) true)

;; Template:
;; <Used template from ListOfBoolean>

(define (all-true? lob)
  (cond [(empty? lob) true]
        [else (if (first lob)
          (all-true? (rest lob))
          false
         )]))