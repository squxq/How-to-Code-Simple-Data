;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname spinning-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; spinning-starter.rkt

;PROBLEM:
;
;Design a world program as follows:
;
;The world starts off with a small square at the center of the screen. As time 
;passes, the square stays fixed at the center, but increases in size and rotates 
;at a constant speed.Pressing the spacebar resets the world so that the square 
;is small and unrotated.
;
;Starting display:
;(open image file)
;After a few seconds:
;(open image file)
;After a few more seconds:
;(open image file)
;Immediately after pressing the spacebar:
;(open image file)
;NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;analysis before starting to work on the code file.
;
;NOTE 2: The rotate function requires an angle in degrees as its first 
;argument. By that it means Number[0, 360). As time goes by the box may end up 
;spinning more than once, for example, you may get to a point where it has spun 
;362 degrees, which rotate won't accept. One solution to that is to use the 
;remainder function as follows:
;
;(rotate (remainder ... 360) (text "hello" 30 "black"))
;
;where ... can be an expression that produces any positive number of degrees 
;and remainder will produce a number in [0, 360).
;
;Remember that you can lookup the documentation of rotate if you need to know 
;more about it.
;
;NOTE 3: There is a way to do this without using compound data. But you should 
;design the compound data based solution.

;; A square that rotates while it increases it size overtime

;; ======================
;; Constants:

(define WIDTH 1000)
(define HEIGHT WIDTH)

(define X (/ WIDTH 2)) ; if WIDTH = 2k, k being an Integer
(define Y (/ HEIGHT 2)) ; if HEIGHT = 2k, k being an Integer

(define SQUARE_COLOR "red")

(define MTS (empty-scene WIDTH HEIGHT))

;; ======================
;; Data Definitions:

(define-struct square_ (os or s r ds dr))
;; Square is (make-square_ Natural Number[0, 360] Natural Number[0, 360] Natural Number)
;; interp. (make-square_ s r) is a square with:
;;         os, the square's original side length
;;         or, the square's original rotation angle
;;         s, the square's initial side length
;;         r, the square's initial rotation angle
;;         ds, the square's speed rate of change
;;         dr, the square's rotation rate of change

;; Examples:
(define S0 (make-square_ 10 0 10 0 3 3))       ; square just created
(define S1 (make-square_ 10 0 381 237 3 3))    ; previous square after some time
(define S2 (make-square_ 15 120 15 120 10 2))  ; square just created
(define S3 (make-square_ 15 120 743 032 10 2)) ; previous square after some time
(define S4 (make-square_ 15 120 327 438 10 2)) ; square with more than 360deg rotation

;; Template:
#;
(define (fn-for-square_ s)
  (... (square_-os s)      ; Natural
       (square_-or s)      ; Number[0, 360]
       (square_-s s)       ; Natural
       (square_-r s)       ; Number[0, 360]
       (square_-ds s)      ; Natural
       (square_-dr s)))    ; Number

;; Template rules used:
;; - compound rule: 6 fields

;; ======================
;; Function Definitions:

;; Natural Number[0, 360] Natural Number -> Square
;; return a Square with given data

;; Stub:
#;
(define (create-square s r ds dr) (make-square_ 10 0 10 0 3 3))

;; Tests:
(check-expect (create-square 10 0 3 3) S0)
(check-expect (create-square 15 120 10 2) S2)

;; Template:
#;
(define (create-square s r ds dr)
  (... s r ds dr))

(define (create-square s r ds dr)
  (make-square_ s r s r ds dr))


;; Square -> Square
;; Start the world with: (main (create-square 10 0 3 3))
;;
(define (main s)
  (big-bang s                    ; Square
    (on-tick next-square)        ; Square -> Square
    (to-draw render-square)      ; Square -> Image
    (on-key handle-key-square))) ; Square KeyEvent -> Square


;; Square -> Square
;; produce the next square size, s, and rotation, r, based on square's rates of change, ds and dr

;; Stub:
#;
(define (next-square s) S0)

;; Tests:
(check-expect (next-square S0)
              (make-square_ (square_-os S0) (square_-or S0)
                           (+ (square_-s S0) (square_-ds S0))
                           (+ (square_-r S0) (square_-dr S0))
                           (square_-ds S0) (square_-dr S0)))
(check-expect (next-square S1)
              (make-square_ (square_-os S1) (square_-or S1)
                           (+ (square_-s S1) (square_-ds S1))
                           (+ (square_-r S1) (square_-dr S1))
                           (square_-ds S1) (square_-dr S1)))
(check-expect (next-square S2)
              (make-square_ (square_-os S2) (square_-or S2)
                           (+ (square_-s S2) (square_-ds S2))
                           (+ (square_-r S2) (square_-dr S2))
                           (square_-ds S2) (square_-dr S2)))
(check-expect (next-square S3)
              (make-square_ (square_-os S3) (square_-or S3)
                           (+ (square_-s S3) (square_-ds S3))
                           (+ (square_-r S3) (square_-dr S3))
                           (square_-ds S3) (square_-dr S3)))
(check-expect (next-square S4)
              (make-square_ (square_-os S4) (square_-or S4)
                           (+ (square_-s S4) (square_-ds S4))
                           (remainder (+ (square_-r S4) (square_-dr S4)) 360)
                           (square_-ds S4) (square_-dr S4)))

;; Template:
;; <Used template from Square>
(define (next-square s)
  (if (<= (+ (square_-r s) (square_-dr s)) 360)
      (make-square_ (square_-os s) (square_-or s)
                           (+ (square_-s s) (square_-ds s))
                           (+ (square_-r s) (square_-dr s))
                           (square_-ds s) (square_-dr s))
      (make-square_ (square_-os s) (square_-or s)
                           (+ (square_-s s) (square_-ds s))
                           (remainder (+ (square_-r s) (square_-dr s)) 360)
                           (square_-ds s) (square_-dr s))))


;; Square -> Image
;; produce the respective square image, with the square's size, s, and rotation, r

;; Stub:
#;
(define (render-square s) (square 0 "solid" "red"))

;; Tests:
(check-expect (render-square S0)
              (place-image (rotate (square_-r S0)
                                   (square (square_-s S0) "solid" SQUARE_COLOR)) X Y MTS))
(check-expect (render-square S1)
              (place-image (rotate (square_-r S1)
                                   (square (square_-s S1) "solid" SQUARE_COLOR)) X Y MTS))
(check-expect (render-square S2)
              (place-image (rotate (square_-r S2)
                                   (square (square_-s S2) "solid" SQUARE_COLOR)) X Y MTS))
(check-expect (render-square S3)
              (place-image (rotate (square_-r S3) 
                                   (square (square_-s S3) "solid" SQUARE_COLOR)) X Y MTS))

;; Template:
;; <Used template from Square>
(define (render-square s)
  (place-image (rotate (square_-r s)
                       (square (square_-s s) "solid" SQUARE_COLOR)) X Y MTS))

;; Square KeyEvent -> Square
;; if the space bar is pressed

;; Stub:
#;
(define (handle-key-square s ke) S0)

;; Tests:
(check-expect (handle-key-square S1 " ") S0)
(check-expect (handle-key-square S1 "r") S1)
(check-expect (handle-key-square S3 " ") S2)
(check-expect (handle-key-square S3 "r") S3)

;; Template:
#;
(define (handle-key-square s ke)
  (cond [(key=? ke " ") (square_-os s) (square_-or s) (square_-s s)
                        (square_-r s) (square_-ds s) (square_-dr s)]
        [else (square_-os s) (square_-or s) (square_-s s)
              (square_-r s) (square_-ds s) (square_-dr s)]))

(define (handle-key-square s ke)
  (cond [(key=? ke " ") (create-square (square_-os s) (square_-or s) (square_-ds s) (square_-dr s))]
        [else s]))