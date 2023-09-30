;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname image-list-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; image-list-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;Design a data definition to represent a list of images. Call it ListOfImage.

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images

;; Examples:
(define LOI0 empty)
(define LOI1 (cons (square 10 "solid" "green") empty))
(define LOI2 (cons (square 10 "solid" "green") (cons (circle 34 "solid" "blue") empty)))
(define LOI3 (cons (square 10 "solid" "green")
                   (cons (rectangle 34 54 "solid" "blue")
                         (cons (triangle 90 "solid" "red") empty))))

;; Template:
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else (...
               (first loi)                   ; Image
               (fn-for-loi (rest loi)))]))   ; ListOfImage

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons Image ListOfImage)
;; - self-reference: (rest loi) is ListOfImage

;; =====================
;; Function Definitions:

;PROBLEM B:
;
;Design a function that consumes a list of images and produces a number 
;that is the sum of the areas of each image. For area, just use the image's 
;width times its height.

;; ListOfImage -> Number
;; produce the total area (width x height) of all images in given list of images

;; Stub:
#;
(define (total-area loi) 0)

;; Tests:
(check-expect (total-area LOI0) 0)
(check-expect (total-area LOI1) (* 10 10))
(check-expect (total-area LOI2) (+ (* 10 10)
                                   (* (image-width (circle 34 "solid" "blue")) (image-height (circle 34 "solid" "blue")))))
(check-expect (total-area LOI3) (+ (* 10 10) (* 34 54)
                                   (* (image-width (triangle 90 "solid" "red")) (image-height (triangle 90 "solid" "red")))))

;; Template:
;; <Used template from ListOfImage>

(define (total-area loi)
  (cond [(empty? loi) 0]
        [else (+
               (* (image-width (first loi)) (image-height (first loi)))
               (total-area (rest loi)))]))