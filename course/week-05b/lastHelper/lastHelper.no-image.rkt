;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname lastHelper.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
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

;; For Testing:
(define I1 (rectangle 10 20 "solid" "blue"))
(define I2 (rectangle 20 30 "solid" "green"))
(define I3 (rectangle 40 60 "solid" "red"))

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
              (beside I1
                      I2 BLANK))
(check-expect (arrange-images (cons I2
                                    (cons I1 empty)))
              (beside I1
                      I2 BLANK))

;; Template:
#;
(define (fn-for-loi loi)
  (fn-for-loi-comp-1 (fn-for-loi-comp-2 loi)))

(define (arrange-images loi)
  (layout-images (sort-images loi)))


;; ListOfImage -> Image
;; place images beside each other in order of list

;; Stub:
#;
(define (layout-images loi) BLANK)

;; Tests:
(check-expect (layout-images LOI0) BLANK)
(check-expect (layout-images LOI1) (beside (square 10 "solid" "blue") BLANK))
(check-expect (layout-images LOI2) (beside I1
                                           I2 BLANK))

;; Template: <used template from ListOfImage>

(define (layout-images loi)
  (cond [(empty? loi) BLANK]
        [else
         (beside (first loi)
                 (layout-images (rest loi)))]))


;; ListOfImage -> ListOfImage
;; sort images in increasing order of size (area)

;; Stub:
#;
(define (sort-images loi) loi)

;; Tests:
(check-expect (sort-images empty) empty)
(check-expect (sort-images LOI1) LOI1)
(check-expect (sort-images LOI2) LOI2)
(check-expect (sort-images (cons I2
                                 (cons I1 empty))) LOI2)
(check-expect (sort-images (cons I2 (cons I2
                                          (cons I1 empty))))
              (cons I1 (cons I2
                             (cons I2 empty))))

;; Template: <used template from ListOfImage>

(define (sort-images loi)
  (cond [(empty? loi) empty]
        [else
         (insert (first loi)
                 (sort-images (rest loi)))])) ; result of natural recursion will be sorted


;; Image ListOfImage -> ListOfImage
;; insert given image in proper place in given list of image (in increasing order of size)
;; ASSUME: loi is already sorted

;; Stub:
#;
(define (insert img loi) loi)

;; Tests:
(check-expect (insert I1 empty) (cons I1 empty))                                         ; beginning 
(check-expect (insert I1 (cons I2 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; beginning
(check-expect (insert I2 (cons I1 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; middle
(check-expect (insert I3 (cons I1 (cons I2 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; end

;; Template: <used template from ListOfImage>
#;
(define (insert img loi)
  (cond [(empty? loi) (... img)]
        [else
         (... img (first loi)
              (insert (... img) (rest loi)))]))

(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger? img (first loi))
             (cons (first loi) (insert img (rest loi)))
             (cons img loi))]))


;; Image Image -> Boolean
;; produce true if given img1 is larger than given img2 (by area)
;; !!!
;; Stub:
#;
(define (larger? img1 img2) true)

;; Tests:
(check-expect (larger? I1 I2) false)
(check-expect (larger? I1 I3) false)
(check-expect (larger? I2 I1) true)
(check-expect (larger? I3 I1) true)
(check-expect (larger? I2 I3) false)
(check-expect (larger? I3 I2) true)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 6 "solid" "red")) false)

;; Template:
#;
(define (larger? img1 img2)
  (... img1 img2))

(define (larger? img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))