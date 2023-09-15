;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname simplePracticeExample.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;PROBLEM:
;
;DESIGN a function called yell that consumes strings like "hello" 
;and adds "!" to produce strings like "hello!".
;
;Remember, when we say DESIGN, we mean follow the recipe.
;
;Leave behind commented out versions of the stub and template.

; step 1 - signature, purpose, stub
;; String -> String
;; append "!" to given string
;(define (yell word) "word!")

; step 2 - define examples/tests
(check-expect (yell "hello") "hello!")
(check-expect (yell "yay") "yay!")

; step 3 - template and inventory
;(define (yell word)
;  (... word))

; step 4 - code the function body
(define (yell word)
  (string-append word "!"))

; step 5 - test and debug until correct