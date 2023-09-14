;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname booleans) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

true ; outputs true

false ; outputs false

(define WIDTH 100)
(define HEIGHT 100)

(> WIDTH HEIGHT) ; > is a predicate
; outputs false - WIDTH = HEIGHT

(>= WIDTH HEIGHT) ; >= is a predicate
; outputs true

(= 1 2)
; outputs false - 1 < 2

(= 1 1)
; outputs true

(> 3 9)
; outputs false - 3 < 9

(string=? "foo" "bar")
; outputs false - those two strings are not equal

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 10 "solid" "blue"))

(< (image-width I1)
	 (image-width I2))
; outputs true - the width of I1 = 10 and the width of I2 = 20, 10 < 20