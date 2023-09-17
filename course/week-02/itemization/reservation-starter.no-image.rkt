;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname reservation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; Data Definition

;; Reservation is one of:
;; - Natural[1, 100]
;; - "standby"
;; interp.
;;    Natural[1, 100] means a guaranteed seat for dinner where the number
;;                    corresponds to which reservation (not which seat).
;;    "standby"       means a standby spot, if all the reservations show
;;                    up this person will not be seated

;; Examples:
(define R1 1)
(define R2 70)
(define R3 100)
(define R4 "standby")

;; Template
#;
(define (fn-for-reservation r)
  (cond [(number? r) (... r)]
        [else (...)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic non-distinct: Natural[1,100]
;; - atomic distinct: "standby"

;PROBLEM:
;
;Consider the problem of designing a function called reservation 
;that produces an image with the given reservation.

;; Reservation -> Image
;; produces an image with the reservation number if there is a reservation, else returns an image that shows there is no reservation

;; Stub
#;
(define (reservation r) (square 0 "solid" "white"))

;; Tests
(check-expect (reservation R1) (text (string-append "Reservation Number: " (number->string R1) ".") 24 "brown"))
(check-expect (reservation R2) (text (string-append "Reservation Number: " (number->string R2) ".") 24 "brown"))
(check-expect (reservation R3) (text (string-append "Reservation Number: " (number->string R3) ".") 24 "brown"))
(check-expect (reservation R4) (text "This person has no Reservation." 24 "brown"))

;; <used template from Reservation>
(define (reservation r)
  (cond [(number? r) (text (string-append "Reservation Number: " (number->string r) ".") 24 "brown")]
        [else (text "This person has no Reservation." 24 "brown")]))