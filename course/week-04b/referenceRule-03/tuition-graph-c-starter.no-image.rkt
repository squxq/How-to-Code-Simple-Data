;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tuition-graph-c-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;; tuition-graph-c-starter.rkt

;Remember the constants and data definitions we created in lectures 5h-j 
;to help Eva decide where to go to university:

;; ==========
;; Constants:

(define FONT-SIZE 24)
(define FONT-COLOR "black")

(define Y-SCALE   1/200)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")

;; =================
;; Data definitions:

(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. name is the school's name, tuition is international-students tuition in USD

;; Examples:
(define S1 (make-school "School1" 27797)) ;We encourage you to look up real schools
(define S2 (make-school "School2" 23300)) ;of interest to you -- or any similar data.
(define S3 (make-school "School3" 28500)) ;

;; Template:
#;
(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))

;; Template rules used:
;;  - compound: (make-school String Natural)


;; ListOfSchool is one of:
;;  - empty
;;  - (cons School ListOfSchool)
;; interp. a list of schools

;; Examples:
(define LOS1 empty)
(define LOS2 (cons S1 (cons S2 (cons S3 empty))))

;;Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-los (rest los)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons School ListOfSchool)
;;  - reference: (first los) is School
;;  - self-reference: (rest los) is ListOfSchool


;; ListOfName is one of:
;;  - empty
;;  - (cons String ListOfName)
;; interp. a list of names

;; Examples:
(define LON1 empty)
(define LON2 (cons "School1" (cons "School2" empty)))
(define LON3 (cons "School1" (cons "School2" (cons "School3" empty))))

;; Template:
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons String ListOfName)
;;  - self-reference: (rest lon) is ListOfName

;; =====================
;; Function Definitions:

;PROBLEM A:
;
;Complete problem (C) from the reference rule videos.
;
;"Design a function that consumes information about schools and produces 
;the school with the lowest international student tuition."
;
;The function should consume a ListOfSchool. Call it cheapest.
;
;;; ASSUME the list includes at least one school or else
;;;        the notion of cheapest doesn't make sense
;
;Also note that the template for a function that consumes a non-empty 
;list is:
;
;(define (fn-for-nelox nelox)
;  (cond [(empty? (rest nelox)) (...  (first nelox))] 
;        [else
;          (... (first nelox) 
;               (fn-for-nelox (rest nelox)))]))
;
;And the template for a function that consumes two schools is: 
;
;(define (fn... s1 s2)
;(... (school-name s1)
;     (school-tuition s1)
;     (school-name s2)
;     (school-tuition s2)))

;; ListOfSchool -> School
;; produce the school with the cheapest tuition from the given list of schools

;; Stub:
#;
(define (cheapest los) S1)

;; Tests:
(check-expect (cheapest (cons S1 empty)) S1)
(check-expect (cheapest (cons S1 (cons S2 empty))) S2)
(check-expect (cheapest LOS2) S2)

;; Template:
#;
(define (fn-for-nelox nelox)
  (cond [(empty? (rest nelox)) (...  (first nelox))] 
        [else
          (... (first nelox) 
               (fn-for-nelox (rest nelox)))]))

(define (cheapest los)
  (cond [(empty? (rest los)) (first los)] 
        [else (cheapest-school (first los) (cheapest (rest los)))]))


;; School School -> School
;; produce the cheapest school tuition out of two given schools

;; Stub:
#;
(define (cheapest-school s1 s2) S1)

;; Tests:
(check-expect (cheapest-school S1 S2) S2)
(check-expect (cheapest-school S2 S3) S2)
(check-expect (cheapest-school S1 S3) S1)

;; Template:
#;
(define (cheapest-school s1 s2)
(... (school-name s1)
     (school-tuition s1)
     (school-name s2)
     (school-tuition s2)))

(define (cheapest-school s1 s2)
  (if (< (school-tuition s1) (school-tuition s2)) s1 s2))

;PROBLEM B:
;
;Design a function that consumes a ListOfSchool and produces a list of the 
;school names. Call it get-names.
;
; Do you need to define a new helper function?

;; ListOfSchool -> ListOfName
;; produce a list of all school names in the given list of schools

;; Stub:
#;
(define (get-names los) LON1)

;; Tests:
(check-expect (get-names LOS1) empty)
(check-expect (get-names LOS2) LON3)

;; Template:
;; <used template from ListOfSchool>

(define (get-names los)
  (cond [(empty? los) empty]
        [else
         (cons (school-name (first los))
              (get-names (rest los)))]))

;Do you need to define a new helper function?
;Ans: No. I will only call one function that operates on the referred-to type.