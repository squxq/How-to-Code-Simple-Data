;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; You are working on an extension to DrRacket.
; The extension operates on the icons displayed in the DrRacket user interface.
; This includes (open image file) and (open image file) and the other icons you see.
;
; Create a data definition for a non-primitive data type called Icon and a function definition to   
; determine what command each Icon is responsible for. Follow the HtDF and HtDD recipes.

;; Data Definitions

;; Icon is Image
;; interp. the image of an icon
;(define I1 [open image file])
;(define I2 [open image file])

#;
(define (fn-for-icon icon)
  (... icon))

;; Template rules used:
;; atomic non-distinct: Image

;; Functions

;; Icon -> String
;; given one of the two possible icons produce its related command

;(define (icon-cmd icon) "debug") ;stub

;; tests
;(check-expect (icon-cmd [open image file]) "stepper")
;(check-expect (icon-cmd [open image file]) "run")

;; took template from Icon
;(define (icon-cmd icon)
;  (cond [(image=? icon [open image file]) "stepper"]
;        [(image=? icon [open image file]) "run"]))