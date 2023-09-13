;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cflag-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; cflag-starter.rkt

;PROBLEM:

;The background for the Canadian Flag (without the maple leaf) is this:
        
;Write an expression to produce that background. (If you want to get the
;details right, officially the overall flag has proportions 1:2, and the 
;band widths are in the ratio 1:2:1.)

(define (canRect w h color)
  (rectangle w h "solid" color))

; problem solution
(beside (canRect 10 20 "red") (canRect 20 20 "white") (canRect 10 20 "red"))

; 1st try on a maple leaf
(beside (canRect 10 20 "red") (overlay (star 10 "solid" "red") (canRect 20 20 "white")) (canRect 10 20 "red"))

; complete canadian flag
(beside (canRect 100 200 "red") (overlay (scale 1/8 (bitmap/url "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Maple_Leaf.svg/1200px-Maple_Leaf.svg.png")) (canRect 200 200 "white")) (canRect 100 200 "red"))
