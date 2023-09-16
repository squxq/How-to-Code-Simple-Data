;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname less-than-five-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; less-than-five-starter.rkt

PROBLEM:

DESIGN function that consumes a string and determines whether its length is
less than 5.  Follow the HtDF recipe and leave behind commented out versions 
of the stub and template.

;; String -> Boolean
;; return true if given string length is less than five

; stub
;(define (less5? s) "")

; tests
(check-expect (less5? "home") true) ; word length less than 5
(check-expect (less5? "toast") false) ; word length equal to 5
(check-expect (less5? "gregarious") false) ; word length greater than 5

; template
;(define (less5? s)
;  (... s))

; function definition
(define (less5? s)
  (< (string-length s) 5))