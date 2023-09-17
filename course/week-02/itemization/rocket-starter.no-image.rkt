;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rocket-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; rocket-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;You are designing a program to track a rocket's journey as it descends 
;100 kilometers to Earth. You are only interested in the descent from 
;100 kilometers to touchdown. Once the rocket has landed it is done.
;
;Design a data definition to represent the rocket's remaining descent. 
;Call it RocketDescent.

;; RocketDescent is one of:
;; - false
;; - Number[1, 100]
;; interp. false if the rocket has landed, a real number from 1 to 100 for the remaining kms

;; Examples
(define RD1 false) ;the rocket has landed
(define RD2 5) ;the rocket is almost landing
(define RD3 65) ;the rocket is midway through the landing
(define RD4 100) ;the rocket has just start landing

;; Template:
#;
(define (fn-for-rocket-descent rd)
  (cond [(false? rd) (...)]
        [(number? rd) (... a)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - atomic non-distinct: Number[1, 100]

;; =================
;; Functions:

;PROBLEM B:
;
;Design a function that will output the rocket's remaining descent distance 
;in a short string that can be broadcast on Twitter. 
;When the descent is over, the message should be "The rocket has landed!".
;Call your function rocket-descent-to-msg.

;; RocketDescent -> String
;; return the rocket's remaining descent distance if it has not landed yet, else produce "The rocket has landed!"

#;
(define (rocket-descent-to-msg rd) "") ;stub

;; Tests:
(check-expect (rocket-descent-to-msg false) "The rocket has landed!")
(check-expect (rocket-descent-to-msg 5) "The rocket's remaining descent distance is: 5.")
(check-expect (rocket-descent-to-msg 65) "The rocket's remaining descent distance is: 65.")
(check-expect (rocket-descent-to-msg 100) "The rocket's remaining descent distance is: 100.")

;; Took template from RocketDescent
(define (rocket-descent-to-msg rd)
  (cond [(false? rd) "The rocket has landed!"]
        [(number? rd) (string-append "The rocket's remaining descent distance is: " (number->string rd) ".")]))