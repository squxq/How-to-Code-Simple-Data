;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compare-images-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; compare-images-starter.rkt

;PROBLEM:

;Based on the two constants provided, write three expressions to determine whether: 

;1) IMAGE1 is taller than IMAGE2
;2) IMAGE1 is narrower than IMAGE2
;3) IMAGE1 has both the same width AND height as IMAGE2

(define IMAGE1 (rectangle 10 15 "solid" "red"))
(define IMAGE2 (rectangle 15 10 "solid" "red"))

IMAGE1
IMAGE2
; outputs the images for visual reference

; expression 1)
(if (> (image-height IMAGE1) (image-height IMAGE2))
    "IMAGE1 is taller than IMAGE2"
    "IMAGE1 is not taller than IMAGE2")

; expression 2)
(if (< (image-width IMAGE1) (image-width IMAGE2))
    "IMAGE1 is narrower than IMAGE2"
    "IMAGE1 is not narrower than IMAGE2")

; expression 3)
(if (and (= (image-width IMAGE1) (image-width IMAGE2)) (= (image-width IMAGE1) (image-width IMAGE2)))
    "IMAGE1 has both the same width AND height as IMAGE2"
    "IMAGE1 does not have both the same width AND height as IMAGE2")