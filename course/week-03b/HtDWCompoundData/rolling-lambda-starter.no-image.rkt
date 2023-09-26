;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname rolling-lambda-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; rolling-lambda-starter.rkt

;PROBLEM:
;
;Design a world program as follows:
;
;The world starts off with a lambda on the left hand side of the screen. As 
;time passes, the lambda will roll towards the right hand side of the screen. 
;Clicking the mouse changes the direction the lambda is rolling (ie from 
;left -> right to right -> left). If the lambda hits the side of the window 
;it should also change direction.
;
;Starting display (rolling to the right):
;
;(open image file)
;
;After a few seconds (rolling to the right):
;      (open image file)
;After a few more seconds (rolling to the right):
;               (open image file)
;A few seconds after clicking the mouse (rolling to the left):
;
;     (open image file)
;
;NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;analysis before starting to work on the code file.
;
;NOTE 2: DO THIS PROBLEM IN STAGES.
;
;FIRST
;
;Just make the lambda slide back and forth across the screen without rolling.
;      
;SECOND
;  
;Make the lambda spin as it slides, but don't worry about making the spinning
;be just exactly right to make it look like its rolling. Just have it 
;spinning and sliding back and forth across the screen.
;
;FINALLY
;
;Work out the math you need to in order to make the lambda look like it is
;actually rolling.  Remember that the circumference of a circle is 2*pi*radius,
;so that for each degree of rotation the circle needs to move:
;
;   2*pi*radius
;   -----------
;       360
;
;Also note that the rotate function requires an angle in degrees as its 
;first argument. [By that it means Number[0, 360). As time goes by the lambda
;may end up spinning more than once, for example, you may get to a point 
;where it has spun 362 degrees, which rotate won't accept. One solution to 
;that is to  use the modulo function as follows:
;
;(rotate (modulo ... 360) LAMBDA)
;
;where ... can be an expression that produces any positive number of degrees 
;and remainder will produce a number in [0, 360).
;
;Remember that you can lookup the documentation of modulo if you need to know 
;more about it.


;; A lambda that rolls back and fourth across the screen

;; ======================
;; Constants:
(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define LAMBDA (circle 20 "solid" "blue")) ; open image file
(define MTS (empty-scene WIDTH HEIGHT))

(define RADIUS 38)            ; Lambda's radius
(define Y (- HEIGHT RADIUS))  ; Lambda's Y coordinate

;; Lambda's Available WIDTH: Natural[RADIUS, (- WIDTH RADIUS)]

;; ======================
;; Data Definitions:
(define-struct lambda_ (x r dx dr))
;; Lambda is (make-lambda_ Natural[RADIUS, WIDTH - RADIUS] Integer Integer Integer)
;; interp. (make-lambda_ x r dx dr) is a lambda object that rolls on the screen:
;;         x is the lambda's x coordinate
;;         r is the lambda's rotation angle
;;         dx is the lambda's x coordinate rate of change
;;         dr is the lambda's rotation angle rate of change

;; Examples:
(define L0 (make-lambda_ RADIUS 0 3 3))
(define L1 (make-lambda_ (+ RADIUS 2) 238 -10 -2))
(define L2 (make-lambda_ (- WIDTH 3) 742 12 5))

;; Template:
#;
(define (fn-for-lambda_ l)
  (... (lambda_-x l)       ; Natural[RADIUS, WIDTH - RADIUS]
       (lambda_-r l)       ; Integer
       (lambda_-dx l)      ; Integer
       (lambda_-dr l)))    ; Integer

;; Template rules used:
;; - compound data: 4 fields

;; ======================
;; Function Definitions:

;; Lambda -> Lambda
;; start the world with: (main (create-lambda 38 3))

(define (main l)
  (big-bang l                         ; Lambda
    (on-tick next-lambda)             ; Lambda -> Lambda
    (to-draw render-lambda)           ; Lambda -> Image
    (on-mouse handle-mouse-lambda)))  ; Lambda Integer Integer MouseEvent -> Lambda


;; Lambda -> Lambda
;; produce the next lambda with correct x coordinate and rotation angle

;; Stub:
#;
(define (next-lambda l) L0)

;; Tests:
;; RADIUS < x + dx < WIDTH - RADIUS
(check-expect (next-lambda L0)
              (make-lambda_ (+ (lambda_-x L0) (lambda_-dx L0)) (+ (lambda_-r L0) (lambda_-dr L0))
                            (lambda_-dx L0) (lambda_-dr L0)))
;; x + dx < RADIUS || x + dx > WIDTH - RADIUS
(check-expect (next-lambda L1) (make-lambda_ (- (* 2 RADIUS) (lambda_-x L1) (lambda_-dx L1)) (lambda_-r L1) (opposite-sign (lambda_-dx L1)) (opposite-sign (lambda_-dr L1))))
(check-expect (next-lambda L2) (make-lambda_ (- (* 2 (- WIDTH RADIUS)) (lambda_-x L2) (lambda_-dx L2)) (lambda_-r L2) (opposite-sign (lambda_-dx L2)) (opposite-sign (lambda_-dr L2))))

;; Template:
;; <Used template from Lambda>

(define (next-lambda l)
  (cond [(and (> (+ (lambda_-x l) (lambda_-dx l)) RADIUS)
              (< (+ (lambda_-x l) (lambda_-dx l)) (- WIDTH RADIUS)))
         (make-lambda_ (+ (lambda_-x l) (lambda_-dx l)) (+ (lambda_-r l) (lambda_-dr l))
                (lambda_-dx l) (lambda_-dr l))]
        [(> (+ (lambda_-x l) (lambda_-dx l)) (- WIDTH RADIUS))
         (make-lambda_ (- (* 2 (- WIDTH RADIUS)) (lambda_-x l) (lambda_-dx l)) (lambda_-r l) (opposite-sign (lambda_-dx l)) (opposite-sign (lambda_-dr l)))]
        [else (make-lambda_ (- (* 2 RADIUS) (lambda_-x l) (lambda_-dx l)) (lambda_-r l) (opposite-sign (lambda_-dx l)) (opposite-sign (lambda_-dr l)))]))


;; Lambda -> Image
;; produce the corresponding image for the given lambda

;; Stub:
#;
(define (render-lambda l) LAMBDA)

;; Tests:
(check-expect (render-lambda L0)
              (place-image (rotate (opposite-sign (remainder (lambda_-r L0) 360)) LAMBDA) (lambda_-x L0) Y MTS))
(check-expect (render-lambda L1)
              (place-image (rotate (opposite-sign (remainder (lambda_-r L1) 360)) LAMBDA) (lambda_-x L1) Y MTS))
(check-expect (render-lambda L2)
              (place-image (rotate (opposite-sign (remainder (lambda_-r L2) 360)) LAMBDA) (lambda_-x L2) Y MTS))

;; Template:
;; <Used template from Lambda>

(define (render-lambda l)
  (place-image (rotate (opposite-sign (remainder (lambda_-r l) 360)) LAMBDA) (lambda_-x l) Y MTS))


;; Lambda Integer Integer MouseEvent -> Lambda
;; change the direction of the lambda after "button-down"

;; Stub:
#;
(define (handle-mouse-lambda l x y me) L0)

;; Tests:
(check-expect (handle-mouse-lambda L0 0 0 "button-down")  ; me = "button-down" 
              (make-lambda_ (lambda_-x L0) (lambda_-r L0) (opposite-sign (lambda_-dx L0)) (opposite-sign (lambda_-dr L0))))
(check-expect (handle-mouse-lambda L1 0 0 "button-down")  ; me = "button-down" 
              (make-lambda_ (lambda_-x L1) (lambda_-r L1) (opposite-sign (lambda_-dx L1)) (opposite-sign (lambda_-dr L1))))
(check-expect (handle-mouse-lambda L2 0 0 "button-down")  ; me = "button-down" 
              (make-lambda_ (lambda_-x L2) (lambda_-r L2) (opposite-sign (lambda_-dx L2)) (opposite-sign (lambda_-dr L2))))
(check-expect (handle-mouse-lambda L0 0 0 "move") L0)     ; me != "button-down"

;; Template:
#;
(define (handle-mouse-lambda l x y me)
  (cond [(mouse=? me "button-down") (... (lambda_-x l) (lambda_-r l) (lambda_-dx l) (lambda_-dr l) x y)]
        [else
         (... (lambda_-x l) (lambda_-r l) (lambda_-dx l) (lambda_-dr l) x y)]))

(define (handle-mouse-lambda l x y me)
  (cond [(mouse=? me "button-down")
         (make-lambda_ (lambda_-x l) (lambda_-r l) (opposite-sign (lambda_-dx l)) (opposite-sign (lambda_-dr l)))]
        [else l]))


;; Number -> Number
;; produce the opposite sign number of the given number

;; Stub:
#;
(define (opposite-sign n) 0)

;; Tests:
(check-expect (opposite-sign 1237) -1237)  ; n > 0
(check-expect (opposite-sign 0) 0)         ; n = 0
(check-expect (opposite-sign -423) 423)    ; n < 0

;; Template:
#;
(define (opposite-sign n)
  (... n))

(define (opposite-sign n)
  (* n -1))


;; Natural[RADIUS, WIDTH - RADIUS] Integer -> Lambda
;; produce a lambda with given initial position and velocity

;; Stub:
#;
(define (create-lambda x dx) L0)

;; Template:
#;
(define (create-lambda x dx)
  (... x dx))

(define (create-lambda x dx)
  (make-lambda_ x 0 dx (round (/ (* dx 360) (* 2 pi RADIUS)))))