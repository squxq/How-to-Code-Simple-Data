;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functionComposition.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; arrange-images-starter.rkt (problem statement)

;PROBLEM:
;
;In this problem imagine you have a bunch of pictures that you would like to 
;store as data and present in different ways. We'll do a simple version of that 
;here, and set the stage for a more elaborate version later.
;
;(A) Design a data definition to represent an arbitrary number of images.
;
;(B) Design a function called arrange-images that consumes an arbitrary number
;    of images and lays them out left-to-right in increasing order of size.

;; Constants:

(define BLANK (square 0 "solid" "white"))

;; Data Definitions:

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images

;; Examples:
(define LOI0 empty)
(define LOI1 (cons (square 10 "solid" "blue") empty))
(define LOI2 (cons (rectangle 10 20 "solid" "blue")
                   (cons (rectangle 20 30 "solid" "green") empty)))

;; Template:
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Image ListOfImage)
;; - self-reference: (rest loi)

;; Function Definitions

;; ListOfImage -> Image
;; lay out images left to right in increasing order of size, which means:
;; sort images in increasing order of size and then lay them out left to right

;; Stub:
#;
(define (arrange-images loi) BLANK)

;; Tests:
;(check-expect (arrange-images empty) BLANK)
;; there is no need to test the base case

;; these tests are not good enout because they don't check that the list is both sorted and laid out
(check-expect (arrange-images LOI1)
                              (beside (square 10 "solid" "blue") BLANK))
(check-expect (arrange-images LOI2)
                              (beside (rectangle 10 20 "solid" "blue")
                                      (rectangle 20 30 "solid" "green") BLANK))
(check-expect (arrange-images (cons (rectangle 20 30 "solid" "green")
                                    (cons (rectangle 10 20 "solid" "blue") empty)))
                              (beside (rectangle 10 20 "solid" "blue")
                                      (rectangle 20 30 "solid" "green") BLANK))

;; Template:
#;
(define (fn-for-loi loi)
  (fn-for-loi-comp-1 (fn-for-loi-comp-2 loi)))

(define (arrange-images loi)
  (layout-images (sort-images loi)))


;; ListOfImage -> Image
;; place images beside each other in order of list
;; !!!
;; Stub:
(define (layout-images loi) BLANK)


;; ListOfImage -> ListOfImage
;; sort images in increasing order of size
;; !!!
;; Stub:
(define (sort-images loi) loi)