;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname cowabunga-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;PROBLEM:
;
;As we learned in the cat world programs, cats have a mind of their own. When they 
;reach the edge they just keep walking out of the window.
;
;Cows on the other hand are docile creatures. They stay inside the fence, walking
;back and forth nicely.
;
;Design a world program with the following behaviour:
;   - A cow walks back and forth across the screen.
;   - When it gets to an edge it changes direction and goes back the other way
;   - When you start the program it should be possible to control how fast a
;     walker your cow is.
;   - Pressing space makes it change direction right away.
;   
;To help you here are two pictures of the right and left sides of a lovely cow that 
;was raised for us at Brown University.
;
;(open image file)     (open image file)
;
;Once your program works here is something you can try for fun. If you rotate the
;images of the cow slightly, and you vary the image you use as the cow moves, you
;can make it appear as if the cow is waddling as it walks across the screen.
;
;Also, to make it look better, arrange for the cow to change direction when its
;nose hits the edge of the window, not the center of its body.

;; A cow that walks back and forth in the screen limits

;; ======================
;; Constants

(define WIDTH 600)
(define HEIGHT (* WIDTH (/ 2 3)))

(define CTR-Y (/ HEIGHT 2))

(define MTS (empty-scene WIDTH HEIGHT))

(define RIGHT_COW (rectangle 20 10 "solid" "black")) ; open image file
(define RIGHT_COW_POSITIVE (rotate 1 RIGHT_COW))
(define RIGHT_COW_NEGATIVE (rotate -1 RIGHT_COW))

(define LEFT_COW (rectangle 10 20 "solid" "black")) ; open image file
(define LEFT_COW_POSITIVE (rotate 1 LEFT_COW))
(define LEFT_COW_NEGATIVE (rotate -1 LEFT_COW))

(define HALF_COW 50)

;; ======================
;; Data Definitions

(define-struct cow (x dx))
;; Cow is (make-cow Natural[HALF_COW, WIDTH - HALF_COW] Integer != 0)
;; interp. (make-cow x dx) is a cow with x coordinate and dx velocity:
;;         x is the center x coordinate of the cow in pixels
;;         dx is the cow's velocity, change of pixels per tick
;;         dx can be positive which means the cow moves from left to right
;;         dx can also be negative which means the cow moves from right to left

;; Examples:
(define C0 (make-cow HALF_COW 3))       ; a cow at position 0 that moves left to right
(define C1 (make-cow 200 10))    ; a cow at position 200 that moves left to right
(define C2 (make-cow 100 -4))    ; a cow at position 100 that moves right to left
(define C3 (make-cow (- WIDTH HALF_COW) -10)) ; a cow at position WIDTH that moves right to left

;; Template:
(define (fn-for-cow c)
  (... (cow-x c)         ; Natural[HALF_COW, WIDTH - HALF_COW]
       (cow-dx c)))      ; Integer != 0

;; Template rules used:
;; - compound rule: 2 fields

;; ======================
;; Function Definitions:

;; Cow -> Cow
;; Start the world with (main (make-cow HALF_COW 3)) = (main (make-cow 50 3))
;;`
(define (main c)
  (big-bang c                  ; Cow
    (on-tick next-cow)         ; Cow -> Cow
    (to-draw render-cow)       ; Cow -> Image
    (on-key handle-key-cow)))  ; Cow KeyEvent -> Cow


;; Number -> Number
;; change sign of given number

;; Stub:
#;
(define (change-sign n) 0)

;; Tests:
(check-expect (change-sign 5) -5)
(check-expect (change-sign -123) 123)

;; Template:
#;
(define (change-sign n)
  (... n))

(define (change-sign n)
  (* n -1))


;; Cow -> Cow
;; add to the cow x coordinate dx pixels, in order to move it

;; Stub:
#;
(define (next-cow c) (make-cow 0 3))

;; Tests:
;; when HALF_COW < x + dx < WIDHT - HALF_COW
(check-expect (next-cow C0) (make-cow (+ HALF_COW 3) 3))
(check-expect (next-cow C1) (make-cow 210 10))
(check-expect (next-cow C2) (make-cow 96 -4))
(check-expect (next-cow C3) (make-cow (- (- WIDTH HALF_COW) 10) -10))

;; when there is need to change the direction
(check-expect (next-cow (make-cow 548 3)) (make-cow 549 -3))
(check-expect (next-cow (make-cow 549 3)) (make-cow 548 -3))
(check-expect (next-cow (make-cow 51 -3)) (make-cow 52 3))

;; <Used template from Cow>
(define (next-cow c)
  (cond [(and (> (+ (cow-x c) (cow-dx c)) HALF_COW)
              (< (+ (cow-x c) (cow-dx c)) (- WIDTH HALF_COW)))
         (make-cow (+ (cow-x c) (cow-dx c)) (cow-dx c))]
        [(> (+ (cow-x c) (cow-dx c)) (- WIDTH HALF_COW))
         (make-cow (- (* 2 (- WIDTH HALF_COW)) (cow-x c) (cow-dx c)) (change-sign (cow-dx c)))]
        [else
         (make-cow (- (* 2 HALF_COW) (cow-x c) (cow-dx c)) (change-sign (cow-dx c)))]))


;; Cow -> Image
;; produce the correct image of the cow given its direction:
;;         if dx > 0 it moves from left to right
;;         else if dx < 0 it moves from right to left
;; rotate the image correctly:
;;         if x = 2k, k being an Integer, the cow rotates to a positive angle (1deg)
;;         if x = 2k + 1, k being an Integer, the cow rotates to a negative angle (-1deg)

;; Stub:
#;
(define (render-cow c) (square 0 "solid" "white"))

;; Tests:
;; changing the image
(check-expect (render-cow C0) (place-image RIGHT_COW_POSITIVE (cow-x C0) CTR-Y MTS))
(check-expect (render-cow C1) (place-image RIGHT_COW_POSITIVE (cow-x C1) CTR-Y MTS))
(check-expect (render-cow C2) (place-image LEFT_COW_POSITIVE (cow-x C2) CTR-Y MTS))
(check-expect (render-cow C3) (place-image LEFT_COW_POSITIVE (cow-x C3) CTR-Y MTS))

;; rotating the image
(check-expect (render-cow (make-cow 121 3)) (place-image RIGHT_COW_NEGATIVE 121 CTR-Y MTS))
(check-expect (render-cow (make-cow 121 -10)) (place-image LEFT_COW_NEGATIVE 121 CTR-Y MTS))

;; <Took template from Cow>
(define (render-cow c)
  (if (> (cow-dx c) 0)
       (if (even? (cow-x c))
           (place-image RIGHT_COW_POSITIVE (cow-x c) CTR-Y MTS)
           (place-image RIGHT_COW_NEGATIVE (cow-x c) CTR-Y MTS))
       (if (even? (cow-x c))
           (place-image LEFT_COW_POSITIVE (cow-x c) CTR-Y MTS)
           (place-image LEFT_COW_NEGATIVE (cow-x c) CTR-Y MTS))))


;; Cow KeyEvent -> Cow
;; change the cow direction when the spacebar

;; Stub:
#;
(define (handle-key-cow c) (make-cow 0 3))

;; Tests:
(check-expect (handle-key-cow C0 " ") (make-cow HALF_COW -3))
(check-expect (handle-key-cow C0 "a") C0)
(check-expect (handle-key-cow C1 " ") (make-cow 200 -10))
(check-expect (handle-key-cow C2 " ") (make-cow 100 4))
(check-expect (handle-key-cow C3 " ") (make-cow (- WIDTH HALF_COW) 10))

;; Template:
#;
(define (handle-key-cow c ke)
  (cond [(key=? ke " ") (... (cow-x c) (cow-dx c))]
        [else 
         (... (cow-x c) (cow-dx c))]))

(define (handle-key-cow c ke)
  (cond [(key=? ke " ") (make-cow (cow-x c) (change-sign (cow-dx c)))]
        [else c]))