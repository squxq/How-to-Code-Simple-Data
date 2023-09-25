;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname growing-grass-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; growing-grass-starter.rkt

;PROBLEM:
;
;Design a world program as follows:
;
;The world starts off with a piece of grass waiting to grow. As time passes, 
;the grass grows upwards. Pressing any key cuts the current strand of 
;grass to 0, allowing a new piece to grow to the right of it.
;
;Starting display:
;
;(open image file)
;
;After a few seconds:
;
;(open image file)
;
;After a few more seconds:
;
;(open image file)
;
;Immediately after pressing any key:
;
;(open image file)
;
;A few more seconds after pressing any key:
;
;(open image file)
;
;NOTE 1: Remember to follow the HtDW recipe! Be sure to do a proper domain 
;analysis before starting to work on the code file.

;; A yard with grass that is constantly growing and needs to be cut

;; =====================
;; Constants:

(define WIDTH 800)
(define HEIGHT (/ WIDTH 2))

(define GRASS_SIZE (/ HEIGHT 20))

(define BG (rectangle WIDTH HEIGHT "solid" "Deep Sky Blue"))

(define MTS (overlay BG (empty-scene WIDTH HEIGHT)))

;; =====================
;; Data Definitions:

(define-struct grass (x s))
;; Grass is (make-grass Natural[0, WIDTH] Natural[0, HEIGHT])
;; interp. (make-grass (x s)) is a grass strand:
;;         x is the grass current x position which changes when cut
;;         s is the grass size up
;;         both x and s are multiples of GRASS_SIZE

;; Examples:
(define G0 (make-grass (* GRASS_SIZE 0) (* GRASS_SIZE 0)))
(define G1 (make-grass (* GRASS_SIZE 2) (* GRASS_SIZE 10)))

;; Template:
#;
(define (fn-for-grass g)
  (... (grass-x g)       ; Natural[0, WIDTH]
       (grass-s g)))     ; Natural[0, HEIGHT]

;; Template rules used:
;; - compound rule: 2 fields

;; =====================
;; Function Definitions:

;; Grass -> Grass
;; start the world with: (main (make-grass 0 0))
;;
(define (main g)
  (big-bang g               ; Grass
    (on-tick next-grass (/ 1 8))    ; Grass -> Grass
    (to-draw render-grass)  ; Grass -> Image
    (on-key handle-key-grass)))   ; Grass KeyEvent -> Grass


;; Grass -> Grass
;; produce the next grass expansion up

;; Stub:
#;
(define (next-grass g) G0)

;; Tests:
(check-expect (next-grass G0)
              (make-grass (grass-x G0) (+ (grass-s G0) GRASS_SIZE)))
(check-expect (next-grass G1)
              (make-grass (grass-x G1) (+ (grass-s G1) GRASS_SIZE)))

;; Template:
;; <Used template from Grass>
(define (next-grass g)
  (make-grass (grass-x g) (+ (grass-s g) GRASS_SIZE)))


;; Grass -> Image
;; produce the given grass strand image

;; Stub:
#;
(define (render-grass g) GRASS)

;; Tests:
(check-expect (render-grass G0)
              (place-image (rectangle GRASS_SIZE (grass-s G0) "solid" "green")
                           (grass-x G0) HEIGHT MTS))

;; Template:
;; <Used template from Grass>
(define (render-grass g)
  (place-image (rectangle GRASS_SIZE (grass-s g) "solid" "green")
                           (grass-x g) HEIGHT MTS))


;; Grass KeyEvent -> Grass
;; when any key is pressed cut the grass, grass-s = 0 and increse the grass x position

;; Stub:
#;
(define (handle-key-grass g ke) G0)

;; Tests:
(check-expect (handle-key-grass G0 " ") (make-grass (+ GRASS_SIZE (grass-x G0)) 0))
(check-expect (handle-key-grass G0 "r") (make-grass (+ GRASS_SIZE (grass-x G0)) 0))
(check-expect (handle-key-grass G1 " ") (make-grass (+ GRASS_SIZE (grass-x G1)) 0))

;; Template:
#;
(define (handle-key-grass g ke)
  (cond [(key=? ke " ") (... (grass-x g) (grass-s g))]
        [else 
         (... (grass-x g) (grass-s g))]))

(define (handle-key-grass g ke)
  (make-grass (+ GRASS_SIZE (grass-x g)) 0))