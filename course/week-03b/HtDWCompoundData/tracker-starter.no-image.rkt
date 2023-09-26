;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tracker-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;PROBLEM:
;
;Design a world program that displays the current (x, y) position
;of the mouse at that current position. So as the mouse moves the 
;numbers in the (x, y) display changes and its position changes.


;; A program that displays the current mouse position on the screen (x, y) coordinates

;; Constants:
(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define MTS (empty-scene WIDTH HEIGHT))
(define DISPLAY (rectangle 120 40 "outline" "black"))
(define DISPLAY_OFFSET 22)

(define FONT 20)
(define TEXT_COLOR "black")

;; Data Definitions:

(define-struct position (x y))
;; Position is (make-position Natural[0, WIDTH] Natural[0, HEIGHT])
;; interp. (make-position x y) is the mouse's position at a current time
;;         x is the mouse's x coordinate
;;         y is the mouse's y coordinate

;; Examples:
(define P0 (make-position 120 120))
(define P1 (make-position 349 50))

;; Template:
#;
(define (fn-for-position p)
  (... (position-x p)
       (position-y p)))

;; Template rules used:
;; - compound rule: 2 fields

;; Function Definitions:

;; Position -> Position
;; start the world with: (main (make-position 0 0))

(define (main p)
  (big-bang p                           ; Position
    (to-draw render-position)           ; Position -> Image
    (on-mouse handle-mouse-position)))  ; Position Natural[0, WIDTH] Natural[0, HEIGHT] MouseEvent -> Position


;; Position -> Image
;; produce display image with given position

;; Stub:
#;
(define (render-position) (make-position 0 0))

;; Tests:
(check-expect (render-position P0)
              (place-image (overlay
                (text (string-append (number->string (position-x P0)) ", " (number->string (position-x P0)))
                              FONT TEXT_COLOR) DISPLAY)
                           (position-x P0) (- (position-y P0) DISPLAY_OFFSET) MTS))
(check-expect (render-position P1)
              (place-image (overlay
                (text (string-append (number->string (position-x P1)) ", " (number->string (position-x P1)))
                              FONT TEXT_COLOR) DISPLAY)
                           (position-x P1) (- (position-y P1) DISPLAY_OFFSET) MTS))

;; Template:
;; <Used template from Position>
(define (render-position p)
  (place-image (overlay
                (text (string-append (number->string (position-x p)) ", " (number->string (position-x p)))
                              FONT TEXT_COLOR) DISPLAY)
                           (position-x p) (- (position-y p) DISPLAY_OFFSET) MTS))


;; Position Natural[0, WIDTH] Natural[0, HEIGHT] MouseEvent -> Position
;; create a new mouse position after any motion within the screen

;; Stub:
#;
(define (handle-mouse-position p x y me) (make-position 0 0))

;; Tests:
(check-expect (handle-mouse-position P0 729 820 "move") (make-position 729 820))
(check-expect (handle-mouse-position P0 729 820 "button-down") P0)
(check-expect (handle-mouse-position P1 1359 240 "move") (make-position 1359 240))

;; Template:
#;
(define (handle-mouse-position p x y me)
  (cond [(key=? me "move") (... x y (position-x p) (position-y p))]
        [else (... x y (position-x p) (position-y p))]))

(define (handle-mouse-position p x y me)
  (cond [(mouse=? me "move") (make-position x y)]
        [else p]))