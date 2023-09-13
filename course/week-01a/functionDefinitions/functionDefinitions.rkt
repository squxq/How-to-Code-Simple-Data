;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname functionDefinitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

; all the (circle 40 "solid" ...) is unchanging
(above (circle 40 "solid" "red") ; only "red" is changing 
       (circle 40 "solid" "yellow") ; only "yellow" is changing
       (circle 40 "solid" "green")) ; only "green" is changing

(define (bulb c)
        (circle 40 "solid" c))

(bulb "red")
; outputs a red circle

(bulb "yellow")
; outputs a yellow circle

(bulb "green")
; outputs a green circle

; expression
(bulb (string-append "re" "d"))

; step 1 - function call
(bulb "red")

; step 2 - replace function call function body
(circle 40 "solid" "red")

; step 3 - primitive call
; outputs a solid red circle with radius 20