;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Consider the following definitions for Student and ListOfStudent: 

;; =================
;; Data Definitions:

(define-struct student (name id))
;; Student is (make-student String Natural)
;; interp. a student with name and student id

;; Examples:
(define S0 (make-student "Eva" 3124))
(define S1 (make-student "john" 7893))

;; Template:
#;
(define (fn-for-student s)
  (... (student-name s)
       (student-id s)))

;; Template rules used:
;; - compound: (make-student String Natural)


;; ListOfStudent is one of:
;; - empty
;; - (cons Student ListOfStudent)
;; interp. a list of students

;; Examples:
(define LOS0 empty)
(define LOS1 (cons S0 empty))
(define LOS2 (cons S0 (cons S1 empty)))

;; Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-student (first los))
              (fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Student ListOfStudent)
;; - reference: (first los) is Student
;; - self-reference: (rest los) is ListOfStudent

;Suppose we would like to design a function that consumes a list of students
;and produces a list of student cards, where each student card contains the name and ID of the student.
;Assume a student card is simply a string of the form:
;
;"<student name> <student id>"
;
;For example:
;
;(student-cards (cons (make-student "John" 7893 (cons (make-student "Eva" 3124) empty)))
;
;should produce
;
;(cons "John 7893" (cons "Eva 3124" empty))

;; ListOfStudent -> ListOfStudent
;; produce a list of student cards ("<student name> <student id>") given a list of students

;; =====================
;; Function Definitions:

;; Stub:
#;
(define (student-cards los) empty)

;; Tests:
(check-expect (student-cards LOS0) empty)
(check-expect (student-cards LOS1)
              (cons (string-append (student-name S0) " " (number->string (student-id S0))) empty))
(check-expect (student-cards LOS2)
              (cons (string-append (student-name S0) " " (number->string (student-id S0)))
                    (cons (string-append (student-name S1) " " (number->string (student-id S1))) empty)))

;; Template:
;; <used template from ListOfStudent>

(define (student-cards los)
  (cond [(empty? los) empty]
        [else
         (cons (create-card (first los))
              (student-cards (rest los)))]))


;; Student -> String
;; produce a student card ("<student name> <student id>") given a single student

;; Stub:
#;
(define (create-card s) "")

;; Tests:
(check-expect (create-card S0)
              (string-append (student-name S0) " " (number->string (student-id S0))))
(check-expect (create-card S1)
              (string-append (student-name S1) " " (number->string (student-id S1))))

;; Template:
;; <used template from Student>

(define (create-card s)
  (string-append (student-name s) " " (number->string (student-id s))))