;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname triangle-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; triangle-starter.rkt

;PROBLEM:

;Write an expression that uses triangle, overlay, and rotate to produce an image similar to this:

;You can consult the DrRacket help desk for information on how to use triangle and overlay.
;Don't worry about the exact size of the triangles.

; triangles for visual reference
(triangle 40 "solid" "green")
(triangle 40 "solid" "yellow")
; outputs 2 equilateral triangles with size 40 solid green and yellow

(overlay (triangle 40 "solid" "green") (rotate 180 (triangle 40 "solid" "yellow")))
; outputs 2 overlayed triangles like the previous ones, this time, the yellow one is rotated 180deg