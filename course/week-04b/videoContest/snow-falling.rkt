;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname snow-falling) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;You have to create a program that simulates a charming animation of snow falling on the screen.
;The snowflakes appear to fall from the top of the screen to the bottom, creating a wintry effect.  

;; Snow Falling Simulation

;; =================
;; Constants:

(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define MTS (overlay (rectangle WIDTH HEIGHT "solid" "dark blue") (empty-scene WIDTH HEIGHT)))
(define SNOWFLAKE (pulled-regular-polygon 5 8 2 50 "solid" "white"))

(define Y0 -36)
(define R0 0)

;; =================
;; Data definitions:

(define-struct flake (x y r dy dr s))
;; Flake is (make-flake Integer[0, WIDTH] Integer[-30, HEIGHT] Integer (-360, 360) Integer[1, 10] Integer[-10, 0)U(0, 10] Integer[1, 4])
;; interp. (make-flake x y r dy dr s) is a snowflake with:
;;         x, is the snowflake's x coordinate - remains constant throughout its lifespan - random value
;;         y, is the snowflake's y coordinate - changes by dy every 1/28 seconds - starts at y = -30
;;         r, is the snowflake's rotation angle - changes according to dr - starts at r = 0
;;         dy, is the snowflake's changing rate of its y coordinate (vertical velocity) - random value
;;         dr, is the snowflake's changing rate of its rotation angle (angular velocity) - random value
;;         s, is the snowflake's scaling parameter for its image - random value

;; Examples:
(define F0 (make-flake (/ WIDTH 2) Y0 R0 5 7 2))
(define F1 (make-flake 549 Y0 R0 10 -7 2))
(define F2 (make-flake 1590 Y0 R0 1 -10 4))
(define F3 (make-flake 140 Y0 R0 7 10 1))

;; Template:
#;
(define (fn-for-flake f)
  (... (flake-x f)
       (flake-y f)
       (flake-r f)
       (flake-dy f)
       (flake-dr f)
       (flake-s f)))

;; Template rules used:
;; - compound: (make-flake Integer[0, WIDTH] Integer[-30, HEIGHT] Integer (-360, 360) Integer[1, 10] Integer[-10, 0)U(0, 10] Integer[1, 4])


;; Snowflakes is one of:
;; - empty
;; - (cons Flake Snowflakes)
;; interp. a list of all the snowflakes on the MTS

;; Examples:
(define SF0 empty)
(define SF1 (cons F0 empty))
(define SF2 (cons F0 (cons F1 empty)))
(define SF3 (cons F0 (cons F1 (cons F2 empty))))
(define SF4 (cons F0 (cons F1 (cons F2 (cons F3 empty)))))

;; Template:
#;
(define (fn-for-snowflakes sf)
  (cond [(empty? sf) (...)]
        [else
         (... (fn-for-flake (first sf))
              (fn-for-snowflakes (rest sf)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Flake Snowflakes)
;; - reference: (first sf) is Flake
;; - self-reference: (rest sf) is Snowflake

;; =================
;; Functions:

;; Snowflakes -> Snowflakes
;; start the world with: (main empty)

(define (main sf)
  (big-bang sf                             ; Snowflakes
            (on-tick update-snowflakes)    ; Snowflakes -> Snowflakes
            (to-draw render-snowflakes)))  ; Snowflakes -> Image


;; Snowflakes -> Snowflakes
;; produce the next positions for all the snowflakes on the MTS

;; Stub:
#;
(define (update-snowflakes sf) SF0)

;; Tests:
(check-random (update-snowflakes SF0)
              (cons (create-flake (random 20)) empty))
(check-random (update-snowflakes SF1)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (create-flake (random 20)) empty)))
(check-random (update-snowflakes SF2)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (create-flake (random 20)) empty))))
(check-random (update-snowflakes SF3)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2))
                                (cons (create-flake (random 20)) empty)))))
(check-random (update-snowflakes SF4)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2))
                                (cons (make-flake (flake-x F3) (+ (flake-y F3) (flake-dy F3)) (+ (flake-r F3) (flake-dr F3)) (flake-dy F3) (flake-dr F3) (flake-s F3))
                                      (cons (create-flake (random 20)) empty))))))

;; Template:
;; <used template from Snowflakes>

(define (update-snowflakes sf)
  (cond [(empty? sf)
         (cons (create-flake (random 20)) empty)]
        [else (if (>= (+ (flake-y (first sf)) (flake-dy (first sf))) HEIGHT)
                  (update-snowflakes (rest sf))
                  (cons (update-flake (first sf)) (update-snowflakes (rest sf))))]))


;; Snowflakes -> Image
;; render all the snowflakes on the MTS 

;; Stub:
#;
(define (render-snowflakes sf) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-snowflakes SF0) MTS)
(check-expect (render-snowflakes SF1)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0) MTS))
(check-expect (render-snowflakes SF2)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1) MTS)))
(check-expect (render-snowflakes SF3)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1)
                                        (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2) MTS))))
(check-expect (render-snowflakes SF4)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1)
                                        (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2)
                                                     (place-image (scale (flake-s F3) (rotate (flake-r F3) SNOWFLAKE)) (flake-x F3) (flake-y F3) MTS)))))

;; Template:
;; <used template from Snowflakes>

(define (render-snowflakes sf)
  (cond [(empty? sf) MTS]
        [else
         (render-flake (first sf)
              (render-snowflakes (rest sf)))]))


;; Flake -> Flake
;; update the position(y) and rotation(r) with the given flake's values

;; Stub:
#;
(define (update-flake f) F0)

;; Tests:
(check-expect (update-flake F0)
              (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0)))
(check-expect (update-flake F1)
              (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1)))
(check-expect (update-flake F2)
              (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2)))
(check-expect (update-flake F3)
              (make-flake (flake-x F3) (+ (flake-y F3) (flake-dy F3)) (+ (flake-r F3) (flake-dr F3)) (flake-dy F3) (flake-dr F3) (flake-s F3)))
(check-expect (update-flake (make-flake (/ WIDTH 2) 743 358 5 7 2))
              (make-flake (/ WIDTH 2) (+ 743 5) (remainder (+ 358 7) 360) 5 7 2))

;; Template:
;; <used template from Flake>

(define (update-flake f)
  (if (not (>= (+ (flake-r f) (flake-dr f)) 360))
      (make-flake (flake-x f) (+ (flake-y f) (flake-dy f))
                  (+ (flake-r f) (flake-dr f)) (flake-dy f) (flake-dr f) (flake-s f))
      (make-flake (flake-x f) (+ (flake-y f) (flake-dy f))
                  (remainder (+ (flake-r f) (flake-dr f)) 360) (flake-dy f) (flake-dr f) (flake-s f))))


;; Flake Image -> Image
;; produce image of given flake with its correct position(x and y coordinates) and rotation angle on given screen

;; Stub:
#;
(define (render-flake f s) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-flake F0 MTS)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0) MTS))
(check-expect (render-flake F1 MTS)
              (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1) MTS))
(check-expect (render-flake F2 MTS)
              (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2) MTS))
(check-expect (render-flake F3 MTS)
              (place-image (scale (flake-s F3) (rotate (flake-r F3) SNOWFLAKE)) (flake-x F3) (flake-y F3) MTS))

;; Template:
#;
(define (render-flake f s)
  (... s
       (flake-x f)
       (flake-y f)
       (flake-r f)
       (flake-dy f)
       (flake-dr f)
       (flake-s f)))

(define (render-flake f s)
  (place-image (scale (flake-s f) (rotate (flake-r f) SNOWFLAKE)) (flake-x f) (flake-y f) s))


;; Integer[0, 19] -> Flake
;; produce a new snowflake object given a random number less than 20 for its algular velocity

;; Stub:
#;
(define (create-flake dr0) F0)

;; Tests:
(check-random (create-flake 9)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- 9 10) (+ (random 5) 1)))
(check-random (create-flake 19)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ 19 1) (+ (random 5) 1)))
(check-random (create-flake 0)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- 0 10) (+ (random 5) 1)))
(check-random (create-flake 10)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ 10 1) (+ (random 5) 1)))

;; Template:
#;
(define (create-flake dr0)
  (... dr0))

(define (create-flake dr0)
  (if (<= dr0 9)
      (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- dr0 10) (+ (random 5) 1))
      (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ dr0 1) (+ (random 5) 1))))
