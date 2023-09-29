;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname student-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; student-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;Design a data definition to help a teacher organize their next field trip. 
;On the trip, lunch must be provided for all students. For each student, track 
;their name, their grade (from 1 to 12), and whether or not they have allergies.

(define-struct student (name grade allergies))
;; Student is (make-student String Natural[1, 12] Boolean)
;; interp. (make-student name grade allergies) is a student with:
;;         name is the student's name
;;         grande is the student's name
;;         allergies is true if the student has allergies, else false

;; Examples:
(define S0 (make-student "James" 4 true))
(define S1 (make-student "Maria" 3 false))
(define S2 (make-student "Stewart" 6 true))
(define S3 (make-student "John" 8 true))
(define S4 (make-student "Jane" 12 false))

;; Temaplate:
(define (fn-for-student s)
  (... (student-name s)        ; String
       (student-grade s)       ; Natural[1, 12]
       (student-allergies s))) ; Boolean

;; Template rules used:
;; - compound rule: 3 fields

;; =================
;; Functions:

;PROBLEM B:
;
;To plan for the field trip, if students are in grade 6 or below, the teacher 
;is responsible for keeping track of their allergies. If a student has allergies, 
;and is in a qualifying grade, their name should be added to a special list. 
;Design a function to produce true if a student name should be added to this list.

;; Student -> Boolean
;; produce true if a student has allergies and is in grade 6 or below

;; Stub:
#;
(define (allergies? s) false)

;; Tests:
(check-expect (allergies? S0) true)
(check-expect (allergies? S1) false)
(check-expect (allergies? S2) true)
(check-expect (allergies? S3) false)
(check-expect (allergies? S4) false)

;; <Took template from Student>
(define (allergies? s)
  (and (< (student-grade s) 7) (student-allergies s)))