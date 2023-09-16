;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fullSpeedHtDFRecipe.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:

;Design a function that consumes a number and produces twice that number. 
;Call your function double. Follow the HtDF recipe and leave behind commented 
;out versions of the stub and template.

;The HtDF recipe consists of the following steps:

;1. [Signature, purpose and stub.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S1)
;2. [Define examples, wrap each in check-expect.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S2)
;3. [Template and inventory.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S3)
;4. [Code the function body.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S4)
;5. [Test and debug until correct](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S5)

; step 1
; Number -> Number ; signature
; produce 2 times the given number ; purpose
; (define (double n) 0) ; stub

; step 2  
(check-expect (double 3) 6)
(check-expect (double 4.2) (* 2 4.2))
; if the examples run tells me that they are well formed

; step 3
; (define (double n)
;   (... n))

; step 4 - with a copy of the template
(define (double n)
  (* 2 n))

; step 5
; run the code and check for tests errors