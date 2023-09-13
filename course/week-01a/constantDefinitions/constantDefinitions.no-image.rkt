;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname constantDefinitions.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define WIDTH 400)
(define HEIGHT 600)

; expression
(* WIDTH HEIGHT)

; step 1
(* 400 HEIGHT)
; step 2
(* 400 600)
; step 3 - outputs 
240000

(define IMG_CAT "alt: img_cat") ; images are values and all values are expressions
; alt: img_cat

; rotate is for images only
; (define RCAT (rotate -10 IMG_CAT))
; (define LCAT (rotate 10 IMG_CAT))

(define RCAT "alt: img_cat_rotated_right")
(define LCAT "alt: img_cat_rotated_left")

RCAT
; outputs the IMG_CAT rotated 10deg to the right

LCAT
; outputs the IMG_CAT rotated 10deg to the left