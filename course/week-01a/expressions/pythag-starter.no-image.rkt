;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname pythag-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:

;Assume that the two short sides of a right triangle have length 3 and 4.
;What is the length of the long side? Recall that the Pythagorean Theorem
;tells us that:

;Write a BSL expression that produces the value of ? for this triangle 
;where the other two sides have lengths 3 and 4.

(sqrt (+ (sqr 3) (sqr 4)))
; outputs 5

(sqrt 2)
; outputs #i1.4142135623730951