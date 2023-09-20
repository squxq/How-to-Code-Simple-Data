;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-02.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;You are asked to write a data definition for a regular polygon.
;You are told there are three distinct regular polygons that you need to represent: triangles, squares and pentagons.
;All polygons have the same size.
;
;Your friend proposes two different forms for the data definition, and writes down two different type comments:
;
;;; RegularPolygon is one of:
;;; - "triangle"
;;; - "square"
;;; - "pentagon"
;;; interp. different regular polygons
;
;
;
;;; RegularPolygon is Integer[3, 5]
;;; interp. a regular polygon, the number is the number of sides it has

;; Using Enumeration in this scenario would be the most correct because the form of the information to be represented
;; consists of a fixed number of distinct items

;; Data Definitions:

;; RegularPolygon is one of:
;; - "triangle"
;; - "square"
;; - "pentagon"
;; interp. different regular polygons

;; <Examples are redundant for enumeration.>

;; Template
#;
(define (fn-for-regular-polygon rp)
  (cond [(string=? rp "triangle") (...)]
        [(string=? rp "square") (...)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "triangle"
;; - atomit distinct: "square"
;; - atomic distinct: "pentagon"

;; Function Definitions:

;PROBLEM:
;
;Consider the problem of designing a function called polygon-sides 
;that takes the given regular polygon and produces its number of sides.

;; RegularPolygon -> Natural
;; produces number of sides of given regular polygon

;; Stub:
#;
(define (polygon-sides rp) 0)

;; Examples
(check-expect (polygon-sides "triangle") 3)
(check-expect (polygon-sides "square") 4)
(check-expect (polygon-sides "pentagon") 5)

;; <Used template from RegularPolygon.>
(define (polygon-sides rp)
  (cond [(string=? rp "triangle") 3]
        [(string=? rp "square") 4]
        [else 5]))