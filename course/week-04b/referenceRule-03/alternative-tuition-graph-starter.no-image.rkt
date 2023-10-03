;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname alternative-tuition-graph-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; alternative-tuition-graph-starter.rkt

;Consider the following alternative type comment for Eva's school tuition 
;information program. Note that this is just a single type, with no reference, 
;but it captures all the same information as the two types solution in the 
;videos.
;
;(define-struct school (name tuition next))
;;; School is one of:
;;;  - false
;;;  - (make-school String Natural School)
;;; interp. an arbitrary number of schools, where for each school we have its
;;;         name and its tuition in USD
;
;(A) Confirm for yourself that this is a well-formed self-referential data 
;    definition.
;
;(B) Complete the data definition making sure to define all the same examples as 
;    for ListOfSchool in the videos.
;
;(C) Design the chart function that consumes School. Save yourself time by 
;    simply copying the tests over from the original version of chart.
;
;(D) Compare the two versions of chart. Which do you prefer? Why?

;; ==========
;; Constants:

(define BAR-COLOR (make-color 170 215 228 255))
(define BAR-WIDTH 30)

(define FONT-SIZE 20)
(define FONT-COLOR "black")

(define Y-SCALE (/ 1 200))

;; =================
;; Data Definitions:

(define-struct school (name tuition next))
;; School is one of:
;; - false
;; - (make-school String Natural School)
;; interp. an arbitrary number of schools, where fro each school we have its
;;         name and its tuition in USD

;; Examples:
(define S0 false)
(define S1 (make-school "UBC" 38457
                        (make-school "Harvard" 75430 (make-school "Stanford" 65032 false))))

;; Template:
#;
(define (fn-for-school s)
  (cond [(false? s) (...)]
        [else
         (... (school-name s)
              (school-tuition s)
              (fn-for-school (school-next s)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-school String Natural School)
;; - self-reference: (school-next s) is School


;; =====================
;; Function Definitions:

;; School -> Image
;; produce bar chart showing names and tuitions of the consumed schools

;; Stub:
#;
(define (chart s) (square 0 "solid" "white"))

;; Tests:
(check-expect (chart S0) (square 0 "solid" "white"))
(check-expect (chart (make-school "UBC" 38457 false))
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text "UBC" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 38457 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 38457 Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))
(check-expect (chart S1)
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S1) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name (school-next S1)) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next S1)) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next S1)) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name (school-next (school-next S1))) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next (school-next S1))) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next (school-next S1))) Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))

;; Template:
;; <used template from School>

(define (chart s)
  (cond [(false? s) (square 0 "solid" "white")]
        [else
         (beside/align "bottom" (overlay/align "center" "bottom"
               (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
               (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
               (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR))
              (chart (school-next s)))]))

;The first version is preferable because its simpler and more intuitive.
;It's also more efficient, performance and memory wise, for operations like      
;iterating through the list, searching, or sorting.