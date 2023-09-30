;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname total-string-length-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; total-string-length-starter.rkt

;; ==========
;; Constants:

(define ALLOWED-CHARACTERS
  (list
   "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
   "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
   ))

;; =================
;; Data definitions:

;Remember the data definition for a list of strings we designed in Lecture 5c:
;(if this data definition does not look familiar, please review the lecture)

;; ListOfString is one of: 
;;  - empty
;;  - (cons String ListOfString)
;; interp. a list of strings

;; Examples:
(define LS0 empty) 
(define LS1 (cons "a" empty))
(define LS2 (cons "a" (cons "b" empty)))
(define LS3 (cons "c" (cons "b" (cons "a" empty))))
(define LS4 (cons "Hello how are you" (cons "Hi, im fine what about you?" empty)))
(define LS5 (cons "lorem ipsum" (cons "3475623485jsdhfakjs dfjaQ#$!%# !w" empty)))

;; Template:
#;
(define (fn-for-los los) 
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; Template rules used: 
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons String ListOfString)
;; - atomic non-distinct: (first los) is  String
;; - self-reference: (rest los) is ListOfString

;; =====================
;; Function Definitions:

;PROBLEM:
;
;Design a function that consumes a list of strings and determines the total 
;number of characters (single letters) in the list. Call it total-string-length.

;; ListOfString -> Natural
;; produce the total number of characters (single letters) in all the strings in given list of strings

;; Stub:
#;
(define (total-string-length los) 0)

;; Tests:
(check-expect (total-string-length LS0) 0)
(check-expect (total-string-length LS1) 1)
(check-expect (total-string-length LS2) 2)
(check-expect (total-string-length LS3) 3)
(check-expect (total-string-length LS4) 34)
(check-expect (total-string-length LS5) 25)

;; Template:
;; <Used template from ListOfString>

(define (total-string-length los) 
  (cond [(empty? los) 0]
        [else
         (+ (count-characters (first los))
              (total-string-length (rest los)))]))


;; ========
;; Helpers:

;; String -> Boolean
;; produce true if given character is allowed (defined in constants)

;; Stub:
#;
(define (is-allowed-char? char) false)

;; Tests:
(check-expect (is-allowed-char? "a") true)
(check-expect (is-allowed-char? "R") true)
(check-expect (is-allowed-char? "?") false)
(check-expect (is-allowed-char? "0") false)

;; Template:
#;
(define (is-allowed-char? char)
  (... char))

(define (is-allowed-char? char)
  (member char ALLOWED-CHARACTERS))


;; String -> Natural
;; produce the number of allowed characters in given string

;; Stub:
#;
(define (count-characters str) 0)

;; Tests:
(check-expect (count-characters "") 0)
(check-expect (count-characters "Hello, World! 123") 10)
(check-expect (count-characters "!@!$@$345730") 0)
(check-expect (count-characters "ljkashdfkjashdf") 15)

;; Template:
#;
(define (count-characters str)
  (... str))

(define (count-characters str)
  (cond [(= (string-length str) 0) 0]
        [else (if (is-allowed-char? (substring str 0 1))
             (+ 1 (count-characters (substring str 1)))
             (count-characters (substring str 1)))]))