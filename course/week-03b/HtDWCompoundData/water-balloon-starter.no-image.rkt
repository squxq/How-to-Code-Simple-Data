;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname water-balloon-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; water-balloon-starter.rkt

;PROBLEM:
;
;In this problem, we will design an animation of throwing a water balloon.  
;When the program starts the water balloon should appear on the left side 
;of the screen, half-way up.  Since the balloon was thrown, it should 
;fly across the screen, rotating in a clockwise fashion. Pressing the 
;space key should cause the program to start over with the water balloon
;back at the left side of the screen. 
;
;NOTE: Please include your domain analysis at the top in a comment box. 
;
;Use the following images to assist you with your domain analysis:
;
;
;1)
;(open image file)
;2)
;(open image file)
;3)
;(open image file)
;4)
;
;(open image file)
;    
;
;Here is an image of the water balloon:
;(define WATER-BALLOON (circle 20 "solid" "green")) ; open image file
;
;
;
;NOTE: The rotate function wants an angle in degrees as its first 
;argument. By that it means Number[0, 360). As time goes by your balloon 
;may end up spinning more than once, for example, you may get to a point 
;where it has spun 362 degrees, which rotate won't accept. 
;
;The solution to that is to use the modulo function as follows:
;
;(rotate (modulo ... 360) (text "hello" 30 "black"))
;
;where ... should be replaced by the number of degrees to rotate.
;
;NOTE: It is possible to design this program with simple atomic data, 
;but we would like you to use compound data.

;; Animation of throwing a water balloon

;; =================
;; Constants:

;; Screen:
(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

;; Image and Background:
;(define WATER-BALLOON (circle 20 "solid" "green")) ; open image file
(define MTS (empty-scene WIDTH HEIGHT))

(define X0 0)
(define Y0 (/ HEIGHT 2))
(define R0 0)

;; =================
;; Data definitions:

(define-struct balloon (x vx θ ω))
;; Balloon is (make-balloon Natural[0, WIDTH] Number Integer(-360, 0] Number)
;; interp. (make-balloon x vx θ ω) is a balloon with:
;;         x is the balloon's x coordinate on the screen
;;         vx is the balloon's horizontal velocity
;;         θ is the balloon's angular distance
;;         ω is the balloon's angular velocity

;; Examples:
(define B0 (make-balloon X0 5 R0 5))
(define B1 (make-balloon 458 3 -234 32))
(define B2 (make-balloon 1247 5.5 -123 8.9))

;; Template
#;
(define (fn-for-balloon b)
  (... (balloon-x b)       ; Natural[0, WIDTH]
       (balloon-vx b)      ; Number
       (balloon-θ b)       ; Integer(-360, 0]
       (balloon-ω b)))     ; Number

;; Template rules used:
;; - compound rule: 4 fields

;; =================
;; Functions:

;; Balloon -> Balloon
;; start the world with: (main (make-balloon 0 5 0 5))
;; 
(define (main b)
  (big-bang b                                   ; Balloon
            (on-tick   next-balloon)            ; Balloon -> Balloon
            (to-draw   render-balloon)          ; Balloon -> Image
            (on-key    handle-key-balloon)))    ; Balloon KeyEvent -> Balloon


;; Balloon -> Balloon
;; produce the next balloon position and rotation on the screen given its current data

;; Stub:
#;
(define (next-balloon b) B0)

;; Tests:
(check-expect (next-balloon B0)
              (make-balloon (+ (balloon-x B0) (balloon-vx B0)) (balloon-vx B0) (round (- (balloon-θ B0) (balloon-ω B0))) (balloon-ω B0)))
(check-expect (next-balloon B1)
              (make-balloon (+ (balloon-x B1) (balloon-vx B1)) (balloon-vx B1) (round (- (balloon-θ B1) (balloon-ω B1))) (balloon-ω B1)))
(check-expect (next-balloon B2)
              (make-balloon (+ (balloon-x B2) (balloon-vx B2)) (balloon-vx B2) (round (- (balloon-θ B2) (balloon-ω B2))) (balloon-ω B2)))

;; <Used template from Balloon>

(define (next-balloon b)
  (make-balloon (+ (balloon-x b) (balloon-vx b)) (balloon-vx b) (remainder (round (- (balloon-θ b) (balloon-ω b))) 360) (balloon-ω b)))


;; Balloon -> Image
;; render a balloon image to the screen given current balloon position and rotation

;; Stub:
#;
(define (render-balloon b) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-balloon B0)
              (place-image (rotate (balloon-θ B0) WATER-BALLOON) (balloon-x B0) Y0 MTS))
(check-expect (render-balloon B1)
              (place-image (rotate (balloon-θ B1) WATER-BALLOON) (balloon-x B1) Y0 MTS))
(check-expect (render-balloon B2)
              (place-image (rotate (balloon-θ B2) WATER-BALLOON) (balloon-x B2) Y0 MTS))

;; <Used template from Balloon>

(define (render-balloon b)
  (place-image (rotate (balloon-θ b) WATER-BALLOON) (balloon-x b) Y0 MTS))


;; Balloon KeyEvent -> Balloon
;; handle key press reseting the animation to its initial position when key pressed is " " (space) 

;; Stub:
#;
(define (handle-key-balloon b) B0)

;; Tests:
(check-expect (handle-key-balloon B0 " ") B0)
(check-expect (handle-key-balloon B1 " ") (make-balloon X0 (balloon-vx B1) R0 (balloon-ω B1)))
(check-expect (handle-key-balloon B1 "r") B1)
(check-expect (handle-key-balloon B2 " ") (make-balloon X0 (balloon-vx B2) R0 (balloon-ω B2)))

;; Template:
#;
(define (handle-key-balloon b ke)
  (cond [(key=? ke " ") (... (balloon-x b) (balloon-vx b) (balloon-θ b) (balloon-ω b))]
        [else (... (balloon-x b) (balloon-vx b) (balloon-θ b) (balloon-ω b))]))

(define (handle-key-balloon b ke)
  (cond [(key=? ke " ") (make-balloon X0 (balloon-vx b) R0 (balloon-ω b))]
        [else b]))