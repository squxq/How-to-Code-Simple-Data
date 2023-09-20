;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname itemization.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Consider designing the system for controlling a New Year's Eve
;display. Design a data definition to represent the current state 
;of the countdown, which falls into one of three categories: 
;
; - not yet started
; - from 10 to 1 seconds before midnight
; - complete (Happy New Year!)

;; Countdown is one of:
;; - false
;; - Natural[1, 10]
;; - "Complete!"
;; interp.
;;   false           means countdown has not yet started
;;   Natural[1, 10]  means countdown is running and how many seconds left
;;   "Complete!"     means countdown is over

;; examples
(define CD1 false)
(define CD2 10) ;just started running
(define CD3 3) ;almost over
(define CD4 "Complete!")

;; Template v1
#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(and (number? c) (<= 1 c) (<= c 10)) (... c)]
        [else (...)]))

;; Template v2
#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(number c) (... c)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: false
;; - atomic non-distinct: Natural[1, 10]
;; - atomic distinct: "Complete!"