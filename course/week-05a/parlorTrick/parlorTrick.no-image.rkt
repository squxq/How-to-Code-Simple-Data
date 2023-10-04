;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname parlorTrick.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Your friend has just given you a new pad, and it runs a prototype version of Racket. 
;
;This is great, you can make it do anything. There's just one problem, this version of 
;racket doesn't include numbers as primitive data. There just are no numbers in it!
;
;But you need natural numbers to write your next program.
;
;No problem you say, because you remember the well-formed self-referential data definition 
;for Natural, as well as the idea that add1 is kind of like cons, and sub1 is kind of like
;rest. Your idea is to make add1 actually be cons, and sub1 actually be rest...

;; NATURAL is one of:
;; - empty
;; - (cons "!" NATURAL)
;; interp. a natural number, the number of "!" in the list is the number

;; Examples:
(define N0 empty)         ; 0
(define N1 (cons "!" N0)) ; 1
(define N2 (cons "!" N1)) ; 2
(define N3 (cons "!" N2)) ; 3
(define N4 (cons "!" N3)) ; 4
(define N5 (cons "!" N4)) ; 5
(define N6 (cons "!" N5)) ; 6
(define N7 (cons "!" N6)) ; 7
(define N8 (cons "!" N7)) ; 8
(define N9 (cons "!" N8)) ; 9

;; These are the primitives that operate on NATURAL:
(define (ZERO? n) (empty? n))     ; Any -> Boolean
(define (ADD1 n) (cons "!" n))    ; NATURAL -> NATURAL
(define (SUB1 n) (rest n))        ; NATURAL[>0] -> NATURAL

;; Template:
(define (fn-for-NATURAL n)
  (cond [(ZERO? n) (...)]
        [else
         (... n
              (fn-for-NATURAL (SUB1 n)))]))


;; NATURAL NATURAL -> NATURAL
;; produce a + b

;; Stub:
#;
(define (ADD a b) N0)

;; Tests:
(check-expect (ADD N2 N0) N2)
(check-expect (ADD N0 N3) N3)
(check-expect (ADD N3 N4) N7)

;; Template: <took template from NATURAL>

(define (ADD a b)
  (cond [(ZERO? b) a]
        [else
         (ADD (ADD1 a) (SUB1 b))]))


;; NATURAL NATURAL -> NATURAL
;; produce a - b

;; Stub:
#;
(define (SUB a b) N0)

;; Tests:
(check-expect (SUB N2 N0) N2)
(check-expect (SUB N7 N3) N4)

;; Template: <took template from NATURAL>

(define (SUB a b)
  (cond [(ZERO? b) a]
        [else
         (SUB (SUB1 a) (SUB1 b))]))


;; NATURAL NATURAL -> NATURAL
;; produce a * b for given natural numbers

;; Stub:
#;
(define (TIMES a b) N0)

;; Tests:
(check-expect (TIMES N0 N2) N0)
(check-expect (TIMES N2 N0) N0)
(check-expect (TIMES N2 N4) N8)

;; Template: <took template from NATURAL>

(define (TIMES a b)
  (cond [(ZERO? b) empty]
        [else
         (ADD a
              (TIMES a (SUB1 b)))]))


;; NATURAL -> NATURAL
;; produce a!, given natural number a

;; Stub:
#;
(define (FACTORIAL a) N0)

;; Tests:
(check-expect (FACTORIAL N0) N1)
(check-expect (FACTORIAL N1) N1)
(check-expect (FACTORIAL N3) N6)

;; Template: <took template from NATURAL>

(define (FACTORIAL n)
  (cond [(ZERO? n) (cons "!" empty)]
        [else
         (TIMES n
              (FACTORIAL (SUB1 n)))]))