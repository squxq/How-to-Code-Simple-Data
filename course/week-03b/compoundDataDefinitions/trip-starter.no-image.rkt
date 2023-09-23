;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname trip-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; trip-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;Design a data definition to help travelers plan their next trip. 
;A trip should specify an origin, destination, mode of transport and 
;duration (in days).

(define-struct trip (origin destination transport duration))
;; Trip is (make-trip String String String Natural)
;; interp. (make-trip origin destination transport duration)
;;         origin is the trip's origin
;;         destination is the trip's destination
;;         transport is the trip's mode of transport
;;         duration is the trip's duration in days

;; Examples:
(define T0 (make-trip "Boston" "Vancouver" "plane" 6))
(define T1 (make-trip "Yellowstone National Park" "Crater Lake National Park" "car" 14))

;; Template:
(define (fn-for-trip t)
  (... (trip-origin t)      ; String
       (trip-destination t) ; String
       (trip-transport t)   ; String
       (trip-duration t)))  ; Natural

;; Template rules used:
;; - compound rule: 4 cases

;; =================
;; Functions:

;PROBLEM B:
;
;You have just found out that you have to use all your days off work 
;on your next vacation before they expire at the end of the year. 
;Comparing two options for a trip, you want to take the one that 
;lasts the longest. Design a function that compares two trips and 
;returns the trip with the longest duration.
;
;Note that the rule for templating a function that consumes two 
;compound data parameters is for the template to include all 
;the selectors for both parameters.

;; Trip Trip -> Trip
;; return the trip with the longest duration

;; Stub:
#;
(define (longest-trip t0 t1) T0)

;; Tests:
(check-expect (longest-trip T0 T1) T1)
(check-expect (longest-trip T1 T0) T1)
(check-expect (longest-trip T0 T0) T0)

;; Template
#;
(define (longest-trip t0 t1)
  (... (trip-origin t0)
       (trip-destination t0)
       (trip-transport t0)
       (trip-duration t0)
       (trip-origin t1)
       (trip-destination t1)
       (trip-transport t1)
       (trip-duration t1)))

(define (longest-trip t0 t1)
  (cond [(> (trip-duration t0) (trip-duration t1)) t0]
        [(< (trip-duration t0) (trip-duration t1)) t1]
        [else t0]))