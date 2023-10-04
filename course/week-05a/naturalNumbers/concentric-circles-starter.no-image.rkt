;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname concentric-circles-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; concentric-circles-starter.rkt

;PROBLEM:
; 
; Design a function that consumes a natural number n and a color c, and produces n 
; concentric circles of the given color.
; 
; So (concentric-circles 5 "black") should produce (open image file)

;; Natural Color -> Image
;; produce given natural number, n, concentric circles of given color, c

;; Stub:
#;
(define (concentric-circles n c) (circle 0 "outline" "white"))

;; Tests:
(check-expect (concentric-circles 0 "black") (circle 0 "outline" "black"))
(check-expect (concentric-circles 1 "black")
              (overlay (circle (* 1 10) "outline" "black") (circle 0 "outline" "black")))
(check-expect (concentric-circles 2 "black")
              (overlay (circle (* 2 10) "outline" "black") (circle (* 1 10) "outline" "black")
                       (circle 0 "outline" "black")))
(check-expect (concentric-circles 3 "black")
              (overlay (circle (* 3 10) "outline" "black") (circle (* 2 10) "outline" "black")
                       (circle (* 1 10) "outline" "black") (circle 0 "outline" "black")))

;; Template:
#;
(define (concentric-circles n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (concentric-circles (sub1 n)))]))

(define (concentric-circles n c)
  (cond [(zero? n) (circle n "outline" c)]
        [else
         (overlay (circle (* n 10) "outline" c)
              (concentric-circles (sub1 n) c))]))