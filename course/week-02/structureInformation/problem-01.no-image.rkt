;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;You are given the following Types Comment and interpretation for the speed of the car:  
;
;;; CarSpeed is Number[0, 200]
;;; interp. the speed of a car in km/h: 0 means stopped, 200 is the maximum speed

;; Data Definitions:

;; CarSpeed is Number[0, 200]
;; interp. the speed of a car in km/h: 0 means stopped, 200 is maximum speed

;; Examples:
(define CS1 0) ;stopped
(define CS2 70) ;70km/h
(define CS3 110) ;110km/h
(define CS4 130) ;130km/h
(define CS5 200) ;maximum car speed

;; Template
#;
(define (fn-for-car-speed cs)
  (... cs))

;; Template rules used:
;; - atomic non-distinct: Number[0, 200]

;PROBLEM:
;
;You are then asked to design a function called speeding? that checks if a car's speed is over the speed limit of 110 km/hr. 

;; Functions:

;; CarSpeed -> Boolean
;; produce true if car speed is over 110 km/h, else return false

;; Stub:
#;
(define (speeding? cs) false)

;; Tests:
(check-expect (speeding? CS1) false)
(check-expect (speeding? CS2) false)
(check-expect (speeding? CS3) false)
(check-expect (speeding? CS4) true)
(check-expect (speeding? CS5) true)

;; <used template from CarSpeed>
(define (speeding? cs)
  (> cs 110))