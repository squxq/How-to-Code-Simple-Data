;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname atomicNonDistinct.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Imagine that you are designing a program that, among other things, 
;has information about the names of cities in its problem domain.
;
;Design a data definition to represent the name of a city. 

;INFORMATION:        DATA          
;
;Vancouver           "Vancouver"
;
;Boston              "Boston"

;; CityName is String ; type comment
;; interp. the name of a city ; interpretation

; examples
(define CN1 "Boston")
(define CN2 "Vancouver")

; template
#;
(define (fn-for-city-name cn)
  (... cn))

;; Template rules used:
;; atomic non-distinct: String