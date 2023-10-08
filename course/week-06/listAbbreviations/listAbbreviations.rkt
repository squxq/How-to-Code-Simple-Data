;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname listAbbreviations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(cons "a" (cons "b" (cons "c" empty)))
;; outputs (cons "a" (cons "b" (cons "c" empty)))

(list "a" "b" "c")
;; outputs (list "a" "b" "c")

(list (+ 1 2) (+ 3 4) (+ 5 6))
;; outputs (list 3 7 11)

(define L1 (list "b" "c"))
(define L2 (list "d" "e" "f"))

(cons "a" L1) ; produce new list by adding "a" to front of L1
;; outputs (list "a" "b" "c")

(list "a" L1) ; produce new list with "a" as first element and L1 as second element
;; outputs (list "a" (list "b" "c"))

(list L1 L2)
;; outputs (list (list "b" "c") (list "d" "e" "f"))

(append L1 L2)
;; outputs (list "b" "c" "d" "e" "f")

(cons "a" (cons "b" (cons "c" empty)))
(list "a" "b" "c")
;; these two lists are still the same