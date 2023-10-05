;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname decreasing-image-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; decreasing-image-starter.rkt

; PROBLEM:
; 
; Design a function called decreasing-image that consumes a Natural n and produces an image of all the numbers 
; from n to 0 side by side. 
; 
; So (decreasing-image 3) should produce (open image file)

;; ==========
;; Constants:

(define FONT-SIZE 20)
(define FONT-COLOR "black")

;; =================
;; Data Definitions:

;; Natural -> Image
;; produce an image of all the numbers from n to 0 side by side

;; Stub:
#;
(define (decreasing-image n) (square 0 "solid" "white"))

;; Tests:
(check-expect (decreasing-image 0) (text "0" FONT-SIZE FONT-COLOR))
(check-expect (decreasing-image 3)
              (beside (text "3" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "2" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "1" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "0" FONT-SIZE FONT-COLOR)))

;; Template:
#;
(define (decreasing-image n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (decreasing-image (sub1 n)))]))

(define (decreasing-image n)
  (cond [(zero? n) (text "0" FONT-SIZE FONT-COLOR)]
        [else
         (beside (text (number->string n) FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
              (decreasing-image (sub1 n)))]))