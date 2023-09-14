;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname debug-rectangle-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; debug-rectangle-starter.rkt

;PROBLEM:

;Uncomment the code below and fix the error(s).

;(rectangle 10 solid red)

(rectangle 10 solid red)
; outputs solid: this variable is not defined

(rectangle 10 "solid" red)
; outputs red: this variable is not defined

(rectangle 10 "solid" "red")
; outputs rectangle: expects 4 arguments, but found only 3

(rectangle 10 20 "solid" "red")
; outputs the red rectangle