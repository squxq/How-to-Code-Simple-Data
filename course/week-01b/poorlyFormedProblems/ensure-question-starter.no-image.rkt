;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname ensure-question-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; ensure-question-starter.rkt

;PROBLEM:
;
;Use the How to Design Functions (HtDF) recipe to design a function that consumes a string, and adds "?" 
;to the end unless the string already ends in "?".
;
;For this question, assume the string has length > 0. Follow the HtDF recipe and leave behind commented 
;out versions of the stub and template.

;; String -> String
;; if the given string does not end in "?" append "?"

; important information
; assume the string has length > 0

; stub
;(define (questionMark str) "")

; tests
(check-expect (questionMark "hello") "hello?")
; in case the string does not end in "?"
(check-expect (questionMark "how are you?") "how are you?")
; in case the string already ends in "?"

; template
;(define (questionMark str)
;  (... str))

; function definition
(define (questionMark str)
  (if (not (string=? (substring str (- (string-length str) 1) (string-length str)) "?"))
      (string-append str "?")
      str))