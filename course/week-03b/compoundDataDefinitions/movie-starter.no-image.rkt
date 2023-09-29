;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname movie-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; movie-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;Design a data definition to represent a movie, including  
;title, budget, and year released.
;
;To help you to create some examples, find some interesting movie facts below: 
;"Titanic" - budget: 200000000 released: 1997
;"Avatar" - budget: 237000000 released: 2009
;"The Avengers" - budget: 220000000 released: 2012
;
;However, feel free to resarch more on your own!

(define-struct movie (title budget release))
;; Movie is (make-movie String Number Natural)
;; interp. (make-movie title budget release) is a movie with:
;;         title is the movie's title
;;         budget is the movie's budget
;;         release is the movie's release date

;; Examples:
(define M0 (make-movie "Titanic" 200000000 1997))
(define M1 (make-movie "Avatar" 237000000 2009))
(define M2 (make-movie "The Avengers" 220000000 2012))

;; Template
(define (fn-for-movie m)
  (... (movie-title m)     ; String
       (movie-budget m)    ; Number
       (movie-release m))) ; Natural

;; Template rules used:
;; - compound rule: 3 fields

;; =================
;; Functions:

;PROBLEM B:
;
;You have a list of movies you want to watch, but you like to watch your 
;rentals in chronological order. Design a function that consumes two movies 
;and produces the title of the most recently released movie.
;
;Note that the rule for templating a function that consumes two compound data 
;parameters is for the template to include all the selectors for both 
;parameters.

;; Movie Movie -> String
;; produce the title of the movie that was released more recently

;; Stub:
#;
(define (most-recent-movie m0 m1) "")

;; Tests
(check-expect (most-recent-movie M0 M1) (movie-title M1))
(check-expect (most-recent-movie M1 M2) (movie-title M2))
(check-expect (most-recent-movie M2 M0) (movie-title M2))

;; <Took template from Movie>
(define (most-recent-movie m0 m1)
  (cond [(> (movie-release m0) (movie-release m1)) (movie-title m0)]
        [(< (movie-release m0) (movie-release m1)) (movie-title m1)]))