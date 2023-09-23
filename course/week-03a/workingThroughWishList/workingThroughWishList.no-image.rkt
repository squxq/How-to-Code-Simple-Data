;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname workingThroughWishList.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Use the How to Design Worlds recipe to design an interactive
;program in which a cat starts at the left edge of the display 
;and then walks across the screen to the right. When the cat
;reaches the right edge it should just keep going right off 
;the screen.
;
;Once your design is complete revise it to add a new feature,
;which is that pressing the space key should cause the cat to
;go back to the left edge of the screen. When you do this, go
;all the way back to your domain analysis and incorporate the
;new feature.
;
;To help you get started, here is a picture of a cat (open image file), which we
;have taken from the 2nd edition of the How to Design Programs 
;book on which this course is based.

(require 2htdp/image)
(require 2htdp/universe)

;; A cat that walks from left to right across the screen.

;; =================
;; Constants:

(define WIDTH 600)
(define HEIGHT 400)

(define CTR-Y (/ HEIGHT 2))

(define MTS (empty-scene WIDTH HEIGHT))

(define CAT_IMG (square 0 "solid" "white")) ; open image file

;; =================
;; Data definitions:

;; Cat is Natural
;; interp. x position of the cat in screen coordinates

;; Examples:
(define C1 0)           ; left edge
(define C2 (/ WIDTH 2)) ; middle
(define C3 WIDTH)       ; right edge

;; Template
#;
(define (fn-for-cat c)
  (... c))

;; Template rules used:
;; - atomic non-distinct: Natural

;; =================
;; Functions:

;; Cat -> Cat
;; start the world with (main 0)
;; 
(define (main c)
  (big-bang c                           ; Cat
            (on-tick   advance-cat)     ; Cat -> Cat
            (to-draw   render)))        ; Cat -> Image

;; Cat -> Cat
;; produce the next cat, by advancing it 1 pixel to right

;; Stub:
#;
(define (advance-cat c) 0)

;; Tests:
(check-expect (advance-cat 3) 4)

;; <Used template from Cat.>
(define (advance-cat c)
  (+ c 1))

;; Cat -> Image
;; render the cat image at appropriate place on MTS 

;; Stub:
#;
(define (render c) MTS)

;; Tests:
(check-expect (render 4)
              (place-image CAT_IMG 4 CTR-Y MTS))

;; <Used template from Cat.>
(define (render c)
  (place-image CAT_IMG c CTR-Y MTS))