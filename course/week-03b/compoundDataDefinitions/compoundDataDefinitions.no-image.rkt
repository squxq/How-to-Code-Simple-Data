;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname compoundDataDefinitions.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;Design a data definition to represent hockey players, including both 
;their first and last names.

(define-struct player (fn ln))
;; Player is (make-player String String)
;; interp. (make-player fn ln) is a hockey player with
;;         fn is the first name
;;         ln is the last name

;; Examples
(define P1 (make-player "Bobby" "Orr"))
(define P2 (make-player "Wayne" "Gretzky"))

;; Template
(define (fn-for-player p)
  (... (player-fn p)    ; String
       (player-ln p)))  ; String

;; Template rules used:
;; - compound rule: 2 fields