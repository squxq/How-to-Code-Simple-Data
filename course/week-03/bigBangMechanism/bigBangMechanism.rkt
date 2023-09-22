;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bigBangMechanism) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(define SPEED 3)

;; ==================
;; Data Definitions:

;; Cat in Number
;; interp. x coordinate of cat

;; Examples
(define C1 0)

;; Template
(define (fn-for-cat c)
  (... c))

;; Template rules used:
;; - atomic non-distinct: Number

;; =====================
;; Function Definitions:

;; Cat -> Cat
;; increase cat x position by SPEED

;; Tests:
(check-expect (next-cat 0) SPEED)
(check-expect (next-cat 100) (+ 100 SPEED))

;; Stub:
#;
(define (next-cat c) 1)

;; <Used template from Cat.>

(define (next-cat c)
  (+ c SPEED))

;; Cat -> Image
;; add CAT-IMG to MTS at proper x coordinate and CTR-Y

;; Stub:
#;
(define (render-cat c) MTS)

;; Tests:
(check-expect (render-cat 100)
              (place-image CAT-IMG 100 CTR-Y MTS))

;; <Used template from Cat.>

(define (render-cat c)
  (place-image CAT-IMG c CTR-Y MTS))

; The value of CAT-IMG is an image of the cat
; The value of MTS is a blank background (empty scene)
; The value of CTR-Y is half-way down MTS on the y-axis

(big-bang 0                      ; Cat
          (on-tick next-cat)     ; Cat -> Cat
          (to-draw render-cat))  ; Cat -> Image