;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tuition-graph-starter.no-image-01) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; tuition-graph-starter.rkt  (just the problem statements)

;PROBLEM:
;
;Eva is trying to decide where to go to university. One important factor for her is 
;tuition costs. Eva is a visual thinker, and has taken Systematic Program Design, 
;so she decides to design a program that will help her visualize the costs at 
;different schools. She decides to start simply, knowing she can revise her design
;later.
;
;The information she has so far is the names of some schools as well as their 
;international student tuition costs. She would like to be able to represent that
;information in bar charts like this one:
;
;
;        (open image file)
;        
;(A) Design data definitions to represent the information Eva has.
;(B) Design a function that consumes information about schools and their
;    tuition and produces a bar chart.
;(C) Design a function that consumes information about schools and produces
;    the school with the lowest international student tuition.

;; Constants

(define BAR-COLOR (make-color 170 215 228 255))
(define BAR-WIDTH 30)

(define FONT-SIZE 20)
(define FONT-COLOR "black")

(define Y-SCALE (/ 1 200))


;; Data Definitions

(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. (make-school name tuition) is a school with:
;;         name is the school's name
;;         tuition is the school's internation student tuition in USD

;; Examples:
(define S0 (make-school "UBC" 38457))
(define S1 (make-school "Harvard" 75430))
(define S2 (make-school "Stanford" 65032))

;; Template:
(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))

;; Template rules used:
;; - compound rule: (make-school String Natural)


;; ListOfSchool is one of:
;; - empty
;; - (cons School ListOfSchool)
;; interp. a lsit of schools

;; Examples:
(define LOS0 empty)
(define LOS1 (cons S0 (cons S1 (cons S2 empty))))

;; Template:
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los)) ; natural helper
              (fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons School ListOfSchool)
;; - reference rule: (first los) is School
;; - self-reference: (rest los) is ListOfSchool
