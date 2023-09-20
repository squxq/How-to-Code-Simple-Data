;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tlight-w-fail-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; tlight-w-fail-starter.rkt

;PROBLEM:
;
;Design a data definition for a traffic light that can either be disabled,
;or be one of red, yellow, or green.

;; Data Definitions:

;; TLight is one of:
;; - false
;; - "red"
;; - "yellow"
;; - "green"
;; interp. false means the light is disabled, otherwise the color of the light

;; Examples:
(define TL1 false)
(define TL2 "red")
(define TL3 "yellow")
(define TL4 "green")

;; Template
(define (fn-for-tlight tl)
  (cond [(false? tl) (...)]
        [(string=? tl "red") (...)]
        [(string=? tl "yellow") (...)]
        [(string=? tl "green") (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: false
;; - atomic distinct: "red"
;; - atomic distinct: "yellow"
;; - atomic distinct: "green"