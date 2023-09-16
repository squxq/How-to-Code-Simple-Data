;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname boxify-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; boxify-starter.rkt

;PROBLEM:
;
;Use the How to Design Functions (HtDF) recipe to design a function that consumes an image, 
;and appears to put a box around it. Note that you can do this by creating an "outline" 
;rectangle that is bigger than the image, and then using overlay to put it on top of the image. 
;For example:
;
;(boxify (ellipse 60 30 "solid" "red")) should produce (open image file):
;(overlay (ellipse 60 30 "solid" "red") (rectangle 62 32 "outline" "black"))

;
;Remember, when we say DESIGN, we mean follow the recipe.
;
;Leave behind commented out versions of the stub and template.

;; Image -> Image
;; create a outline rectangle bigger than the given image

; stub
;(define (boxify img) (rectangle 20 10 "ouline" "black"))

; tests
(check-expect (boxify (ellipse 60 30 "solid" "red")) (overlay (ellipse 60 30 "solid" "red") (rectangle 62 32 "outline" "black"))) ; open image file

(define TRIANGLE (triangle 40 "solid" "red"))
(check-expect (boxify (triangle 40 "solid" "red")) (overlay TRIANGLE (rectangle (+ (image-width TRIANGLE) 2) (+ (image-height TRIANGLE) 2) "outline" "black"))) ; open image file

; template
;(define (boxify img)
;  (... img))

; function definition
(define (boxify img)
  (overlay img (rectangle (+ (image-width img) 2) (+ (image-height img) 2) "outline" "black")))