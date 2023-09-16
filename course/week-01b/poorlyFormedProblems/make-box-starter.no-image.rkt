;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname make-box-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; make-box-starter.rkt

;PROBLEM:
;
;You might want to create boxes of different colours.
;
;Use the How to Design Functions (HtDF) recipe to design a function that consumes a color, and creates a 
;solid 10x10 square of that colour.  Follow the HtDF recipe and leave behind commented out versions of
;the stub and template.

; Strings, symbols, and color structs are allowed as colors.
; (image-color? x) -> boolean, x: any/c

;; Color <String, Symbol, Color Structs> -> Image
;; Return a solid 10x10 Square of given color

; stub
;(define (generateSquare color) (square 10 "solid" "red"))

; tests
(check-expect (generateSquare "red") (square 10 "solid" "red"))
(check-expect (generateSquare "Red") (square 10 "solid" "Red"))
; colors are not case sensitive, so both "red" and "Red" are allowed
(check-expect (generateSquare "light orange") (square 10 "solid" "light orange"))
(check-expect (generateSquare "lightorange") (square 10 "solid" "lightorange"))
; Spaces are not considered, so "light orange" is the same as "lightorange"
; the complete list of colors is the same as the colors allowed in color-database<%>
(check-expect (generateSquare "transparent") (square 10 "solid" "transparent"))
; and the color "transparent"
(check-expect (generateSquare "light brown") (square 10 "solid" "light brown"))
; and the additional variants of the colors: Brown, Cyan, Goldenrod, Gray, Green, Orange, Pink, Purple, Red, Turquoise, and Yellow, like "light brown"

;(struct color (red green blue alpha)
;  #:extra-constructor-name make-color)
;  red : (integer-in 0 255)
;  green : (integer-in 0 255)
;  blue : (integer-in 0 255)
;  alpha : (integer-in 0 255)

(check-expect (generateSquare (make-color 255 0 255)) (square 10 "solid" (make-color 255 0 255)))
; colors as color struct using the constructor make-color

(check-expect (generateSquare "hello") "Please provide a valid color.")
(check-expect (generateSquare "") "Please provide a valid color.")
; for Strings that are not valid colors

; template
;(define (generateSquare color)
;  (... color))

; function definition
(define (generateSquare color)
  (if (image-color? color)
      (square 10 "solid" color)
      "Please provide a valid color."))