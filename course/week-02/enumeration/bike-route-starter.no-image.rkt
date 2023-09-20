;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bike-route-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; bike-route-starter.rkt

;PROBLEM a:
;
;Suppose you are developing a route planning tool for bicycling in Vancouver.
;There are four varieties of designated bike routes:
;
;1) Separated Bikeway
;2) Local Street Bikeway
;3) Painted Bike Lane
;4) Painted Shared-Use Lane
;
;Use the HtDD recipe to design a data definition for varieties of bike routes (call it BikeRoute)

;; Data Definitions:

;; BikeRoute is one of:
;; - "Separated Bikeway"
;; - "Local Street Bikeway"
;; - "Painted Bike Lane"
;; - "Painted Shared-Use Lane"
;; interp. varieties of bike routes

;; <Examples are redundant for enumerations.>

;; Template
#;
(define (fn-for-bike-route br)
  (cond [(string=? br "Separated Bikeway") (...)]
        [(string=? br "Local Street Bikeway") (...)]
        [(string=? br "Painted Bike Lane") (...)]
        [(string=? br "Painted Shared-Use Lane") (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: "Separated Bikeway"
;; - atomic distinct: "Local Street Bikeway"
;; - atomic distinct: "Painted Bike Lane"
;; - atomic distinct: "Painted Shared-Use Lane"

;PROBLEM b:
;
;Separated bikeways and painted bike lanes are exclusively designated for bicycles, while
;local street bikeways and shared-use lanes must be shared with cars and/or pedestrians.
;
;Design a function called 'exclusive?' that takes a bike route and indicates whether it 
;is exclusively designated for bicycles.

;; Function Definitions:

;; BikeRoute -> Boolean
;; produce true if bike route is exclusive (only bicycles allowed); else false

;; Stub:
#;
(define (exclusive? br) false)

;; Tests:
(check-expect (exclusive? "Separated Bikeway") true)
(check-expect (exclusive? "Local Street Bikeway") false)
(check-expect (exclusive? "Painted Bike Lane") true)
(check-expect (exclusive? "Painted Shared-Use Lane") false)

;; <Used template from BikeRoute>
(define (exclusive? br)
  (cond [(string=? br "Separated Bikeway") true]
        [(string=? br "Local Street Bikeway") false]
        [(string=? br "Painted Bike Lane") true]
        [(string=? br "Painted Shared-Use Lane") false]))