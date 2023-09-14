;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname strings) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
"apple"
; outputs apple

(string-append "Ada" " " "Lovelace")
; outputs Ada Lovelace

"123" ; This is a string that happens to have the characters 1, 2, and 3 in it. 

123 ; And this is the number, 123.

(+ 1 123) ; In particular, I could take the number and add 1 to it.
; outputs 124

; (+ 1 "123") - I can't take the string and add 1 to it.
; outputs +: expects a number, given "123"

(string-length "apple")
; outputs 5

           "0123456789"
(substring "Caribou" 2 4)
; outputs "ri"

(substring "0123456789" 2 4)
; outputs "23"

(substring "Caribou" 0 3)
; outputs "Car"