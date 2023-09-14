;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname discoveringPrimitives) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(triangle 40 "solid" "purple")
; outputs a filled purple equilateral triangle with sides being 40

(/ 3 4)
; outputs 0.75 but I would like to round the number

; after searching the documentation
(round (/ 3 4))
; outputs 1