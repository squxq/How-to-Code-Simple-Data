;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname employees-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; employees-starter.rkt

;; =================
;; Data definitions:

;PROBLEM A:
;
;You work in the Human Resources department at a ski lodge. 
;Because the lodge is busier at certain times of year, 
;the number of employees fluctuates. 
;There are always more than 10, but the maximum is 50.
;
;Design a data definition to represent the number of ski lodge employees. 
;Call it Employees.

;; Employees is Natural[10, 50]
;; interp. number of ski lodge employees, 10 is the minimum and 50 is the maximum number of employees

; examples
(define E1 10) ;minimum number of employees in a less busier time of the year
(define E2 30) ;middle number of employees in a moderate time of the year
(define E3 50) ; maximum number of employees in a very busy time of the year

#;
(define (fn-for-employees e)
  (... e))

;; Template rules used:
;; - atomic non-distinct: Natural[10, 50]

;; =================
;; Functions:

;PROBLEM B:
;
;Now design a function that will calculate the total payroll for the quarter.
;Each employee is paid $1,500 per quarter. Call it calculate-payroll.

;; Note: the function output is a Natural, because: Natural * Natural = Natural

;; Employees -> Natural
;; calculate the total payroll for all employees in a quarter, each of them is paid $1,500

#;
(define (calculate-payroll e) 0) ;stub

;; tests
(check-expect (calculate-payroll E1) 15000)
(check-expect (calculate-payroll E2) 45000)
(check-expect (calculate-payroll E3) 75000)

;; Took template from Employees:
(define (calculate-payroll e)
  (* e 1500))