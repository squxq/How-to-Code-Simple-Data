;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname double-all-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; double-starter.rkt

;; =================
;; Data definitions:

;Remember the data definition for a list of numbers we designed in Lecture 5f:
;(if this data definition does not look familiar, please review the lecture)

;; ListOfNumber is one of:
;;  - empty
;;  - (cons Number ListOfNumber)
;; interp. a list of numbers
(define LON1 empty)
(define LON2 (cons 60 (cons 42 empty)))
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons Number ListOfNumber)
;;  - self-reference: (rest lon) is ListOfNumber

;; =================
;; Functions:

;PROBLEM:
;
;Design a function that consumes a list of numbers and doubles every number 
;in the list. Call it double-all.

;; ListOfNumber -> ListOfNumber
;; produce the double of all elements present in the given list

;; Stub:
#;
(define (double-all lon) LON1)

;; Tests:
(check-expect (double-all LON1) empty)
(check-expect (double-all LON2) (cons 120 (cons 84 empty)))
(check-expect (double-all (cons 091374 (cons -4325 (cons 5532 empty))))
              (cons (* 091374 2) (cons (* -4325 2) (cons (* 5532 2) empty))))

;; Template:
;; <Used template from ListOfNumber>

(define (double-all lon)
  (cond [(empty? lon) empty]
        [else
         (cons (* (first lon) 2)
              (double-all (rest lon)))]))