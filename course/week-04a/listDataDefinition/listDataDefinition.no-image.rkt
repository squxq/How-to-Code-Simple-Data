;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname listDataDefinition.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Imagine that you are designing a program that will keep track of
;your favorite Quidditch teams. (http://iqasport.org/).
;
;Design a data definition to represent a list of Quidditch teams.

;Information:
;UBC
;McGill
;Team Who Must Not Be Named

;Data:
;"UBC"
;"McGill"
;"Team Who Must Not Be Named"
;
;empty
;
;(cons "UBC"
;      (cons "McGill" empty))


;; Data Definitions:

;; ListOfString is one of:
;;  - empty
;;  - (cons String ListOfString) ; self reference
;; interp. a list of strings

;; Note:
;ListOfString is one of:
;  - empty
;  - (cons String ListOfString) -> self reference
;
;The self reference lets us match arbitrarily long lists.
;; End of Note

;; Examples:
(define LOS0 empty)
(define LOS1 (cons "McGill" empty))
(define LOS2 (cons "UBC" (cons "McGill" empty)))

;; Template:
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else (... (first los)                  ; String
                   (fn-for-los (rest los)))]))  ; ListOfString

;; Template rules used:
;; one of: 2 cases
;; atomic distinct: empty
;; compound rule: (cons String ListOfString)


;PROBLEM:
;
;We want to know whether your list of favorite Quidditch teams includes
;UBC! Design a function that consumes ListOfString and produces true if 
;the list includes "UBC".
