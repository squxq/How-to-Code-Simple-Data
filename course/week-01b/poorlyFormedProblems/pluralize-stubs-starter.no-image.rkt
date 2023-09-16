;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pluralize-stubs-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; pluralize-stubs-starter.rkt

;PROBLEM:
; 
;You are working on designing a function and have completed your signature and purpose. 
;
;Write three stubs with different bodies that are consistent with the signature and purpose below.
;Put the three stubs in a comment box.
;
;;; String -> String
;;; pluralizes str by appending "s" to the end 

; stubs
;(define (pluralize str) "")
;(define (pluralize str) "houses")
;(define (pluralize str) "gardens")

; tests
(check-expect (pluralize "house") "houses")
(check-expect (pluralize "garden") "gardens")
; for strings that are not empty
(check-expect (pluralize "") "")

; template
;(define (pluralize str)
;  (... str))

; function definition
(define (pluralize str)
  (if (> (string-length str) 0)
      (string-append str "s")
      ""))