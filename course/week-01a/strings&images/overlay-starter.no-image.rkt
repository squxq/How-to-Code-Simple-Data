;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname overlay-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; overlay-starter.rkt

;PROBLEM:

;Write an expression that uses star and overlay to produce an image similar to this (open image file):

;You can consult the DrRacket help desk for information on how to use star and overlay. 
;Don't worry about the exact size of the stars.

; stars for visual reference
(star 10 "solid" "blue")
(star 25 "solid" "yellow")
(star 40 "solid" "blue")
; outputs 3 solid (filled) stars, 2 blue and 1 yellow

(overlay (star 10 "solid" "blue") (star 25 "solid" "yellow") (star 40 "solid" "blue"))
; outputs the previous 3 stars on top of each other (overlayed)