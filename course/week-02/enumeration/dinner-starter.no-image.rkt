;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname dinner-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; dinner-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;You are working on a system that will automate delivery for 
;YesItCanFly! airlines catering service. 
;There are three dinner options for each passenger, chicken, pasta 
;or no dinner at all. 
;
;Design a data definition to represent a dinner order. Call the type 
;DinnerOrder.

;; DinnerOrder is one of:
;; - "chicken"
;; - "pasta"
;; - false
;; interp. the dinner order, false being no dinner order

;; <examples are redundant for enumerations>

;; Template:
#;
(define (fn-for-dinner-order do)
  (cond [(and (string? do) (string=? do "chicken")) (...)]
        [(and (string? do) (string=? do "pasta")) (...)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "chicken"
;; - atomic distinct: "pasta"
;; - atomic distinct: false

;; =================
;; Functions:

;PROBLEM B:
;
;Design the function dinner-order-to-msg that consumes a dinner order 
;and produces a message for the flight attendants saying what the
;passenger ordered. 
;
;For example, calling dinner-order-to-msg for a chicken dinner would
;produce "The passenger ordered chicken."

;; DinnerOrder -> String
;; produce message with given dinner order

;; Stub:
#;
(define (dinner-order-to-msg do) "")

;; Tests:
(check-expect (dinner-order-to-msg "chicken") "The passenger ordered chicken.")
(check-expect (dinner-order-to-msg "pasta") "The passenger ordered pasta.")
(check-expect (dinner-order-to-msg false) "The passenger didn't make an order.")

;; <took template from DinnerOrder>
(define (dinner-order-to-msg do)
  (cond [(and (string? do) (string=? do "chicken")) "The passenger ordered chicken."]
        [(and (string? do) (string=? do "pasta")) "The passenger ordered pasta."]
        [else "The passenger didn't make an order."]))