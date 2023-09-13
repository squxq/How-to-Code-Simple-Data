;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname images) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

(circle 10 "solid" "red") 
; creates a red solid (filled) circle with radius 5

(rectangle 30 60 "outline" "blue")
; creates a blue outlined rectangle with dimensions 30x60

(text "hello" 24 "orange")
; creates an orange text in font 24 that says: "hello"

(above (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles each one of top of another

(beside (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles side by side from left to right

(overlay (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles stacked on top of each other