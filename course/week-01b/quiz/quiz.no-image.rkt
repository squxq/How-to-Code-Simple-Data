;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname quiz.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;This design quiz will have 3 phases:
;
;    In step one you will design a solution to a given problem.
;    In step two you will watch the assessment tutorial video (in the next tab).
;    In step three you will do a self-assessment of your solution.
;
;PROBLEM:
;
;Design a function that consumes two images and produces true if the first is larger than the second.
;
;Once you have submitted your solution, watch the assessment tutorial video in the next tab before completing your self-assessment.
;
;Your design will be assessed using the following rubric:
;
;    Is the program "commit ready"?
;    The file should be neat and tidy, no tests or code should be commented out other than stubs and templates and all scratch work should be removed. The identation should conform to course conventions and typing CMD-I (CTL-I on Windows) should not move anything. (But note that limitations of the peer tool mean that indentation can only be self-assessed.)
;    Is the design complete?
;    All HtDF design elements should be present, and each element should be well-formed.
;    Does the design have high internal quality?
;    The signature should be correct, the purpose should be clear and succinct, the examples should be sufficient to test and explain the function. The function name should be well chosen and should describe what the function does, not how it does it. The stub should match the signature. The template should be correct. The function body should be clear. When the program is run all the tests should pass, and those tests should cover the entire program.
;    Does the design satisfy the problem requirements?
;    The function design should satisfy the problem statement. If there is any ambiguity in the problem statement the function design should identify and resolve that ambiguity.

;; Image Image -> Boolean
;; return true if the first given image area is greater than the second

; stub
;(define (firstLarger? img1 img2) true)

; tests
(check-expect (firstLarger? (square 10 "solid" "red") (square 20 "solid" "red")) false) ; first is smaller than second
(check-expect (firstLarger? (square 10 "solid" "red") (square 10 "solid" "red")) false) ; first is as big as the second
(check-expect (firstLarger? (square 20 "solid" "red") (square 10 "solid" "red")) true) ; first is bigger than second

(check-expect (firstLarger? "not an image" "not an image") "Please provide two valid images.")
; at least one of the arguments is not a image

; template
;(define (firstLarger? img1 img2)
;  (... img1 img2))

; function definition
(define (firstLarger? img1 img2)
  (if (and (image? img1) (image? img2))
      (> (* (image-width img1) (image-height img1)) (* (image-width img2) (image-height img2)))
      "Please provide two valid images."))