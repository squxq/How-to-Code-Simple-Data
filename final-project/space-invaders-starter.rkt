;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders-starter) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders

;; ==========
;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BORDER_WIDTH 10)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define MISSILE (ellipse 5 15 "solid" "red"))

(define TANK-WIDTH/2 (/ (image-width TANK) 2))
(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define INVADER-WIDTH/2 (/ (image-width INVADER) 2))
(define INVADER-HEIGHT/2 (/ (image-height INVADER) 2))
(define MISSILE-WIDTH/2 (/ (image-width MISSILE) 2))
(define MISSILE-HEIGHT/2 (/ (image-height MISSILE) 2))

(define SCOREBOARD-HEIGHT 50)
(define SCOREBOARD (rectangle WIDTH SCOREBOARD-HEIGHT "solid" "white"))
(define SCORE-FONT-SIZE 34)
(define SCORE-FONT-COLOR "black")

(define HITTING-POINTS 10)
(define MISSING-POINTS -1)

(define GAME-OVER-FONT-SIZE 44)
(define GAME-OVER-FONT-COLOR "red")
(define GAME-OVER-BACKGROUND (empty-scene WIDTH (+ HEIGHT SCOREBOARD-HEIGHT)))


;; =================
;; Data Definitions:

(define-struct tank (x dir))
;; Tank is (make-tank Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2] Integer[-1, 1]\[0])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir = -1, right if dir = 1

;; Examples:
(define T0 (make-tank (/ WIDTH 2) 1)) ; center going right
(define T1 (make-tank 50 1))          ; going right
(define T2 (make-tank 50 -1))         ; going left

;; Template:
#;
(define (fn-for-tank t)
  (... (tank-x t)     ; Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2]
       (tank-dir t))) ; Integer[-1, 1]\[0]

;; Template rules used:
;; - compound: 2 fields


(define-struct invader (x y dir))
;; Invader is (make-invader Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2] Integer[-2 * INVADER-HEIGHT/2, HEIGHT - INVADER-HEIGHT/2] Integer[-1, 1]\[0])
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader moves along x by INVADER-X-SPEED pixels per clock tick left if dir = -1, right if dir = 1
;;         the invader moves along y by INVADER-Y-SPEED pixels per clock tick

;; Examples:
(define I1 (make-invader 150 100 1))                          ; not landed, moving right
(define I2 (make-invader 150 (- HEIGHT INVADER-HEIGHT/2) -1)) ; landed, moving left
(define I3 (make-invader 150 150 1))                          ; not landed, moving left

;; Template:
#;
(define (fn-for-invader i)
  (... (invader-x i)     ; Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2]
       (invader-y i)     ; Integer[-2 * INVADER-HEIGHT/2, HEIGHT - INVADER-HEIGHT/2]
       (invader-dir i))) ; Integer[-1, 1]\[0]

;; Template rules used:
;; - compound: 3 fields


;; ListOfInvader is one of:
;; - empty
;; - (cons Invader ListOfInvader)
;; interp. a list of invaders

;; Examples:
(define LOI0 empty)
(define LOI1 (list I1))
(define LOI2 (list I1 I2))
(define LOI3 (list I1 I2 I3))

;; Template:
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi)) ; Invader
              (fn-for-loi (rest loi)))]))  ; ListOfInvader

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Invader ListOfInvader)
;; - reference: (first loi) is Invader
;; - self-reference: (rest loi) is ListOfInvader


(define-struct missile (x y))
;; Missile is (make-missile Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2] Integer[-2 * MISSILE-HEIGHT/2, HEIGHT - TANK-HEIGHT/2])
;; interp. the missile's location is (x, y) in screen coordinates

;; Examples:
(define M1 (make-missile 150 300))                               ;not hit I1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit I1, 10 is the HIT-RANGE
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1, 5 is less than HIT-RANGE

;; Template:
#;
(define (fn-for-missile m)           ; Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2]
  (... (missile-x m) (missile-y m))) ; Integer[-2 * MISSILE-HEIGHT/2, HEIGHT - TANK-HEIGHT/2]

;; Template rules used:
;; - compound: 2 fields


;; ListOfMissile is one of:
;; - empty
;; - (cons Missile ListOfMissile)
;; interp. a list of missiles

;; Examples:
(define LOM0 empty)
(define LOM1 (list M1))
(define LOM2 (list M1 M2))
(define LOM3 (list M1 M2 M3))

;; Template:
#;
(define (fn-for-lom lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom)) ; Missile
              (fn-for-lom (rest lom)))]))  ; ListOfMissile

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Missile ListOfMissile)
;; - reference: (first lom) is Missile
;; - self-reference: (rest lom) is ListOfMissile


(define-struct game (invaders missiles tank score))
;; Game is (make-game  ListOfInvader ListOfMissile Tank Natural[0, 9999])
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles, tank and score

;; Examples:
(define G0 (make-game empty empty T0 0))
(define G1 (make-game empty empty T1 0))
(define G2 (make-game (list I1) (list M1) T1 0))
(define G3 (make-game (list I1 I2) (list M1 M2) T1 0))
(define G4 (make-game (list I1 I2) (list M1 M2) T1 90))

;; To start the game:
(define G-MAIN (make-game empty empty (make-tank (/ WIDTH 2) 0) 0))

;; Template:
#;
(define (fn-for-game g)
  (... (fn-for-loi (game-invaders g))
       (fn-for-lom (game-missiles g))
       (fn-for-tank (game-tank g))
       (game-score g)))

;; Template rules used:
;; - compound: 4 fields


;; =====================
;; Function Definitions:

;; Game -> Game
;; start the world with: (main G-MAIN)

(define (main g)
  (big-bang g                             ; Game
    (on-tick update-game)                 ; Game -> Game
    (to-draw render-game)                 ; Game -> Image
    (on-key on-key-game)                  ; Game KeyEvent -> Game
    (stop-when stop-game game-over)))     ; Game -> Boolean


;; Game -> Game
;; produce next position of the game (invaders, missiles and tank)

;; Stub:
#;
(define (update-game g) G0)

;; Tests:
(check-expect (update-game G0)
              (make-game empty empty (update-tank T0 (tank-dir T0)) 0))
(check-expect (update-game G1)
              (make-game empty empty (update-tank T1 (tank-dir T1)) 0))
(check-expect (update-game G2)
              (make-game (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dir I1)))
                         (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))
                         (update-tank T1 (tank-dir T1)) 0))
(check-expect (update-game G3)
              (make-game (list (make-invader (+ (invader-x I2) (* INVADER-X-SPEED (invader-dir I2))) (+ (invader-y I2) INVADER-Y-SPEED) (invader-dir I2)))
                         (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))
                         (update-tank T1 (tank-dir T1)) 10))

;; Template: <used template from Game>

(define (update-game g)
  (update-game-layer g (update-missiles (game-missiles g))))


;; Game ListOfMissile -> Game
;; given a state of a game at a certain time, g, and an updated list of missiles, lom, produce an updated game

;; Stub:
#;
(define (update-game-layer g lom) g)

;; Tests:
(check-expect (update-game-layer G0 empty)
              (make-game (update-invaders (game-invaders G0)) empty (update-tank T0 (tank-dir T0))
                         (update-score-missiles (game-score G0) (game-missiles G0) empty)))
(check-expect (update-game-layer G1 empty)
              (make-game (update-invaders (game-invaders G1)) empty (update-tank T1 (tank-dir T1))
                         (update-score-missiles (game-score G1) (game-missiles G1) empty)))
(check-expect (update-game-layer G2 (game-missiles G2))
              (make-game (update-invaders (game-invaders G2)) (game-missiles G2) (update-tank T1 (tank-dir T1))
                         (update-score-missiles (game-score G2) (game-missiles G2) (game-missiles G2))))
(check-expect (update-game-layer G3 (list M1))
              (make-game (update-invaders (game-invaders G3)) (list M1) (update-tank T1 (tank-dir T1))
                         (update-score-missiles (game-score G3) (game-missiles G3) (list M1))))
(check-expect (update-game-layer G3 empty)
              (make-game (update-invaders (game-invaders G3)) empty (update-tank T1 (tank-dir T1))
                         (update-score-missiles (game-score G3) (game-missiles G3) empty)))

;; Template:
#;
(define (update-game-layer g lom)
  (... (fn-for-game g)
       (fn-for-lom lom)))

(define (update-game-layer g lom)
  (collisions (make-game (update-invaders (game-invaders g)) lom
                         (update-tank (game-tank g) (tank-dir (game-tank g)))
                         (update-score-missiles (game-score g) (game-missiles g) lom))))


;; Game -> Game
;; given a state of a game at a certain time, g, produce a game with filtered collisions and possible new invaders

;; Stub:
#;
(define (collisions g) g)

;; Tests: 
(check-expect (collisions G0) G0)
(check-expect (collisions G1) G1)
(check-expect (collisions G2) G2)
(check-expect (collisions G3)
              (make-game (list I2) (list M1) (game-tank G3) 10))

;; Template: <used template from Game>

(define (collisions g)
  (collisions-layer g (collisions-invaders (game-invaders g) (game-missiles g))))


;; Game ListOfInvader -> Game
;; given a state of a game at a certain time, g, and a new filtered list of invaders (have not been hit), loi, produce an updated game with no collisions

;; Stub:
#;
(define (collisions-layer g loi) g)

;; Tests:
(check-expect (collisions-layer G0 empty) G0)
(check-expect (collisions-layer G1 empty) G1)
(check-expect (collisions-layer G2 (game-invaders G2)) G2)
(check-expect (collisions-layer G3 (list I2))
              (make-game (list I2) (list M1) T1 10))

;; Template:
#;
(define (collisions-layer g loi)
  (... (fn-for-game g)
       (fn-for-loi loi)))

(define (collisions-layer g loi)
  (make-game (create-invader loi (random INVADE-RATE))
             (collisions-missiles (game-missiles g) (game-invaders g))
             (game-tank g) (update-score-invaders (game-score g) (game-invaders g) loi)))


;; ListOfInvader ListOfMissile -> ListOfInvader
;; filter the given list of invaders, loi, for any invader that has been hit by a missile in given list of missiles, lom
;;        "hit" means: comparing the horizontal and vertical distances between the invader and the first missile
;;                     to certain thresholds (half of the invader's width and an acceptable range on the y-axis)

;; Stub:
#;
(define (collisions-invaders loi lom) loi)

;; Tests:
(check-expect (collisions-invaders empty empty) empty)
(check-expect (collisions-invaders (list I1 I2) empty) (list I1 I2))
(check-expect (collisions-invaders empty (list M1)) empty)
(check-expect (collisions-invaders (list I1) (list M1)) (list I1))
(check-expect (collisions-invaders (list I1 I2) (list M1 M2)) (list I2))

;; Template: <used template from ListOfInvader>
#;
(define (collisions-invaders loi lom)
  (cond [(empty? loi) (... (fn-for-lom lom))]
        [else
         (... (fn-for-lom lom)
              (fn-for-invader (first loi))
              (collisions-invaders (rest loi) (... (fn-for-lom lom))))]))

(define (collisions-invaders loi lom)
  (cond [(empty? loi) empty]
        [else
         (if (not (invader-collides? (first loi) lom))
             (cons (first loi) (collisions-invaders (rest loi) lom))
             (collisions-invaders (rest loi) lom))]))


;; Invader ListOfMissile -> Boolean
;; check if given invader, i, collides with any of the elements in the given list of missiles, lom

;; Stub:
#;
(define (invader-collides? i lom) false)

;; Tests:
(check-expect (invader-collides? I1 empty) false)
(check-expect (invader-collides? I2 (list M1)) false)
(check-expect (invader-collides? I1 (list M1 M2)) true)

;; Template: <used template from ListOfMissile>
#;
(define (fn-for-lom i lom)
  (cond [(empty? lom) (... (fn-for-invader i))]
        [else
         (... (fn-for-invader i)
              (fn-for-missile (first lom))
              (fn-for-lom (... (fn-for-invader i)) (rest lom)))]))

(define (invader-collides? i lom)
  (cond [(empty? lom) false]
        [else
         (or (and (<= (abs (- (invader-x i) (missile-x (first lom)))) INVADER-WIDTH/2)
                  (<= (abs (- (missile-y (first lom)) (invader-y i))) HIT-RANGE))
             (invader-collides? i (rest lom)))]))


;; ListOfMissile ListOfInvader -> ListOfMissile
;; filter the given list of missiles, lom, for any missile that has hit an invader in the given list of invaders, loi
;;        "hit" means: comparing the horizontal and vertical distances between the missile and the first invader
;;                     to certain thresholds (half of the invader's width and an acceptable range on the y-axis)

;; Stub:
#;
(define (collisions-missiles lom loi) lom)

;; Tests:
(check-expect (collisions-missiles empty empty) empty)
(check-expect (collisions-missiles (list M1 M2) empty) (list M1 M2))
(check-expect (collisions-missiles empty (list I1)) empty)
(check-expect (collisions-missiles (list M1) (list I1)) (list M1))
(check-expect (collisions-missiles (list M1 M2) (list I1 I2)) (list M1))

;; Template: <used template from ListOfMissile>
#;
(define (collisions-missiles lom loi)
  (cond [(empty? lom) (... (fn-for-loi loi))]
        [else
         (... (fn-for-loi loi)
              (fn-for-missile (first lom))
              (collisions-missiles (rest lom) (... (fn-for-loi loi))))]))

(define (collisions-missiles lom loi)
  (cond [(empty? lom) empty]
        [else
         (if (not (missile-collides? (first lom) loi))
             (cons (first lom) (collisions-missiles (rest lom) loi))
             (collisions-missiles (rest lom) loi))]))


;; Missile ListOfInvader -> Boolean
;; check if given missile, m, collides with any of the elements in the given list of invaders, loi

;; Stub:
#;
(define (missile-collides? m loi) false)

;; Tests:
(check-expect (missile-collides? M1 empty) false)
(check-expect (missile-collides? M2 (list I1)) true)
(check-expect (missile-collides? M1 (list I1 I2)) false)

;; Template: <used template from ListOfInvader>
#;
(define (missile-collides? m loi)
  (cond [(empty? loi) (... (fn-for-missile m))]
        [else
         (... (fn-for-missile m)
              (fn-for-invader (first loi))
              (missile-collides? (... (fn-for-missile m)) (rest loi)))]))

(define (missile-collides? m loi)
  (cond [(empty? loi) false]
        [else
         (or (and (<= (abs (- (missile-x m) (invader-x (first loi)))) INVADER-WIDTH/2)
                  (<= (abs (- (invader-y (first loi)) (missile-y m))) HIT-RANGE))
             (missile-collides? m (rest loi)))]))


;; ListOfInvader -> ListOfInvader
;; produce next iteration of the position of all invaders in given list of invaders, loi

;; Stub:
#;
(define (update-invaders loi) loi)

;; Tests:
(check-expect (update-invaders empty) empty)
(check-expect (update-invaders (list I1))
              (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dir I1))))
(check-expect (update-invaders (list I1 I2))
              (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dir I1))
                    (make-invader (+ (invader-x I2) (* INVADER-X-SPEED (invader-dir I2)))
                                  (+ (invader-y I2) INVADER-Y-SPEED) (invader-dir I2))))

;; Template: <used template from ListOfInvader>

(define (update-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (update-invader (first loi))
               (update-invaders (rest loi)))]))


;; Invader -> Invader
;; produce the next position of a given invader, i

;; Stub:
#;
(define (update-invader i) i)

;; Tests:
(check-expect (update-invader I1)
              (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dir I1)))
(check-expect (update-invader I2)
              (make-invader (+ (invader-x I2) (* INVADER-X-SPEED (invader-dir I2))) (+ (invader-y I2) INVADER-Y-SPEED) (invader-dir I2)))
(check-expect (update-invader (make-invader (- WIDTH INVADER-WIDTH/2 1) 150 1))
              (make-invader (- (* 2 (- WIDTH INVADER-WIDTH/2)) (- WIDTH INVADER-WIDTH/2 1) (* INVADER-X-SPEED 1))
                            (+ 150 (* INVADER-Y-SPEED (abs 1)))
                            (* 1 -1)))
(check-expect (update-invader (make-invader (+ INVADER-WIDTH/2 1) 150 -1))
              (make-invader (- (* 2 INVADER-WIDTH/2) (+ INVADER-WIDTH/2 1) (* INVADER-X-SPEED -1))
                            (+ 150 (* INVADER-Y-SPEED (abs -1)))
                            (* -1 -1)))

;; Template: <used template from Invader>

(define (update-invader i)
  (update-invader-layer (invader-x i) (invader-dir i)
                        (+ (invader-x i) (* INVADER-X-SPEED (invader-dir i)))
                        (+ (invader-y i) INVADER-Y-SPEED)))


;; Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2] Integer[-1, 1] Natural Natural
;; produce the next position of an invader given:
;;         its current x position, x
;;         its current direction, dir
;;         its possible next x coordinate, next-x
;;         its possible next y coordinate, next-y

;; Stub:
#;
(define (update-invader-layer x dir next-x next-y) I1)

;; Tests:
(check-expect (update-invader-layer 150 1 152 160)
              (make-invader 152 160 1))
(check-expect (update-invader-layer (- WIDTH INVADER-WIDTH/2 1) 1 (+ WIDTH INVADER-WIDTH/2 1) 160)
              (out-of-border (- WIDTH INVADER-WIDTH/2 1) 1 160 (- WIDTH INVADER-WIDTH/2)))
(check-expect (update-invader-layer (+ INVADER-WIDTH/2 1) -1 (- INVADER-WIDTH/2 1) 160)
              (out-of-border (+ INVADER-WIDTH/2 1) -1 160 INVADER-WIDTH/2))

;; Template:
#;
(define (update-invader-layer x dir next-x next-y)
  (... x dir next-x next-y))

(define (update-invader-layer x dir next-x next-y)
  (cond [(and (>= next-x INVADER-WIDTH/2) (<= next-x (- WIDTH INVADER-WIDTH/2)))
         (make-invader next-x next-y dir)]
        [(< next-x INVADER-WIDTH/2)
         (out-of-border x dir next-y INVADER-WIDTH/2)]
        [(> next-x (- WIDTH INVADER-WIDTH/2))
         (out-of-border x dir next-y (- WIDTH INVADER-WIDTH/2))]))


;; Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2] Integer[-1, 1] Natural (INVADER-WIDTH/2 || WIDTH - INVADER-WIDTH/2)
;; produce the next position of an invader whose predicted position is out of bounds
;;         either less than INVADER-WIDTH/2
;;         or greater than WIDTH - INVADER-WIDTH/2

;; Stub:
#;
(define (out-of-border x dir next-y border) I1)

;; Tests:
(check-expect (out-of-border (- WIDTH INVADER-WIDTH/2 1) 1 160 (- WIDTH INVADER-WIDTH/2))
              (make-invader (- (* 2 (- WIDTH INVADER-WIDTH/2))
                               (- WIDTH INVADER-WIDTH/2 1) (* INVADER-X-SPEED 1)) 160 -1))
(check-expect (out-of-border (+ INVADER-WIDTH/2 1) -1 160 INVADER-WIDTH/2)
              (make-invader (- (* 2 INVADER-WIDTH/2)
                               (+ INVADER-WIDTH/2 1) (* INVADER-X-SPEED -1)) 160 1))

;; Template:
#;
(define (out-of-border x dir next-y border)
  (... x dir next-y border))

(define (out-of-border x dir next-y border)
  (make-invader (- (* 2 border) x (* INVADER-X-SPEED dir))
                next-y (* dir -1)))


;; ListOfMissile -> ListOfMissile
;; produce next iteration of the position of all missiles in given list of missiles, lom

;; Stub:
#;
(define (update-missiles lom) lom)

;; Tests:
(check-expect (update-missiles empty) empty)
(check-expect (update-missiles (list M1))
              (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))))
(check-expect (update-missiles (list M1 M2))
              (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
                    (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED))))
(check-expect (update-missiles (list M1 M2 (make-missile (/ WIDTH 2) -6)))
              (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
                    (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED))))

;; Template: <used template from ListOfMissile>

(define (update-missiles lom)
  (cond [(empty? lom) empty]
        [(< (- (missile-y (first lom)) MISSILE-SPEED) (- 0 (* MISSILE-HEIGHT/2 2)))
         (update-missiles (rest lom))]
        [else
         (cons (update-missile (first lom))
               (update-missiles (rest lom)))]))


;; Missile -> Missile
;; produce the next position of a given missile, m

;; Stub:
#;
(define (update-missile m) m)

;; Tests:
(check-expect (update-missile M1)
              (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))
(check-expect (update-missile M2)
              (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED)))

;; Template: <used template from Missile>

(define (update-missile m)
  (make-missile (missile-x m) (- (missile-y m) MISSILE-SPEED)))


;; Natural[0, 9999] ListOfInvader ListOfInvader -> Natural[0, 9999]
;; given a score, s, an old list of invaders, loi, and a new list of invaders, new-loi, produce the new score
;; ASSUME: the length of new-loi is always smaller or equal than the lenght of loi

;; Stub:
#;
(define (update-score-invaders s loi new-loi) s)

;; Tests:
(check-expect (update-score-invaders 0 (list I1) (list I1)) 0)
(check-expect (update-score-invaders 0 (list I1) empty) 10)
(check-expect (update-score-invaders 347 (list I1 I2) empty) 367)

;; Template:
#;
(define (update-score-invaders s loi new-loi)
  (... s
       (fn-for-loi loi)
       (fn-for-loi new-loi)))

(define (update-score-invaders s loi new-loi)
  (+ s (* (- (length loi) (length new-loi)) HITTING-POINTS)))


;; Natural[0, 9999] ListOfMissile ListOfMissile -> Natural[0, 9999]
;; given a score, s, an old list of missiles, lom, and a new list of missiles, new-lom, produce the new score
;; ASSUME: the length of new-lom is always smaller or equal than the lenght of lom

;; Stub:
#;
(define (update-score-missiles s loi new-loi) s)

;; Tests:
(check-expect (update-score-missiles 0 (list M1) (list M1)) 0)
(check-expect (update-score-missiles 0 (list M1) empty) 0)
(check-expect (update-score-missiles 347 (list M1 M2) empty) 345)

;; Template:
#;
(define (update-score-missiles s lom new-lom)
  (... s
       (fn-for-lom lom)
       (fn-for-lom new-lom)))

(define (update-score-missiles s lom new-lom)
  (if (>= (+ s (* (- (length lom) (length new-lom)) MISSING-POINTS)) 0)
      (+ s (* (- (length lom) (length new-lom)) MISSING-POINTS))
      0))


;; ListOfInvader Natural[0, INVADE-RATE) -> ListOfInvader
;; create invader and add it to given list of invaders, loi
;;        if the given random number is less than 3
;;        this is used to only create an invader 3/100 times every clock tick

;; Stub:
#;
(define (create-invader loi r) loi)

;; Tests:
(check-random (create-invader empty (random INVADE-RATE))
              (if (< (random INVADE-RATE) 3)
                  (cons (make-invader (+ (random (- WIDTH (* INVADER-WIDTH/2 2))) INVADER-WIDTH/2)
                                      (- 0 (* INVADER-HEIGHT/2 2)) (- (random 3) 1)) empty)
                  empty))
(check-random (create-invader (list I1 I2) (random INVADE-RATE))
              (if (< (random INVADE-RATE) 3)
                  (cons (make-invader (+ (random (- WIDTH (* INVADER-WIDTH/2 2))) INVADER-WIDTH/2)
                                      (- 0 (* INVADER-HEIGHT/2 2)) (- (random 3) 1)) (list I1 I2))
                  (list I1 I2)))

;; Template:
#;
(define (create-invader loi r)
  (... r
       (fn-for-loi loi)))

(define (create-invader loi r)
  (if (< r 3)
      (cons (make-invader (+ (random (- WIDTH (* INVADER-WIDTH/2 2))) INVADER-WIDTH/2)
                          (- 0 (* INVADER-HEIGHT/2 2)) (invader-direction (random 4))) loi)
      loi))


;; Natural[0, 3] -> (Integer =1 || =-1)
;; given a random natural number between 0 and 3, n, produce either 1 or -1

;; Stub:
#;
(define (invader-direction n) n)

;; Tests:
(check-expect (invader-direction 0) -1)
(check-expect (invader-direction 1) -1)
(check-expect (invader-direction 2) 1)
(check-expect (invader-direction 3) 1)

;; Template:
#;
(define (invader-direction n)
  (... n))

(define (invader-direction n)
  (if (>= n 2) 1 -1))


;; Game -> Image
;; render the invaders, the missiles and the tank on the screen

;; Stub:
#;
(define (render-game g) empty-image)

;; Tests:
(check-expect (render-game G0)
              (above (render-score (game-score G0))
                     (place-image TANK (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2) BACKGROUND)))
(check-expect (render-game G1)
              (above (render-score (game-score G1))
                     (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND)))
(check-expect (render-game G2)
              (above (render-score (game-score G2))
                     (place-image INVADER 150 100
                           (place-image MISSILE 150 300
                                        (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND)))))
(check-expect (render-game G3)
              (above (render-score (game-score G3))
                     (place-image INVADER 150 100
                           (place-image INVADER 150 (- HEIGHT INVADER-HEIGHT/2)
                                        (place-image MISSILE 150 300
                                                     (place-image MISSILE (invader-x I1) (+ (invader-y I1) 10)
                                                                  (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND)))))))

;; Template: <used template from Game>

(define (render-game g)
  (above (render-score (game-score g))
         (overlay (place-image TANK (tank-x (game-tank g)) (- HEIGHT TANK-HEIGHT/2)
                               (rectangle WIDTH HEIGHT "solid" "transparent"))
                  (render-invaders (game-invaders g)) (render-missiles (game-missiles g))
                  BACKGROUND)))


;; ListOfInvader -> Image
;; render a given list of invaders, loi, in the given screen coordinates

;; Stub:
#;
(define (render-invaders loi) empty-image)

;; Tests:
(check-expect (render-invaders empty) (rectangle WIDTH HEIGHT "solid" "transparent"))
(check-expect (render-invaders (list I1))
              (place-image INVADER 150 100 (rectangle WIDTH HEIGHT "solid" "transparent")))
(check-expect (render-invaders (list I1 I2))
              (place-image INVADER 150 100 (place-image INVADER 150 (- HEIGHT INVADER-HEIGHT/2) (rectangle WIDTH HEIGHT "solid" "transparent"))))

;; Template: <used template from ListOfInvader>

(define (render-invaders loi)
  (cond [(empty? loi) (rectangle WIDTH HEIGHT "solid" "transparent")]
        [else
         (place-image INVADER (invader-x (first loi)) (invader-y (first loi))
                      (render-invaders (rest loi)))]))


;; ListOfMissile -> Image
;; render a given list of missiles, lom, in the given screen coordinates

;; Stub:
#;
(define (render-missiles lom) empty-image)

;; Tests:
(check-expect (render-missiles empty) (rectangle WIDTH HEIGHT "solid" "transparent"))
(check-expect (render-missiles (list M1))
              (place-image MISSILE 150 300 (rectangle WIDTH HEIGHT "solid" "transparent")))
(check-expect (render-missiles (list M1 M2))
              (place-image MISSILE 150 300 (place-image MISSILE (invader-x I1) (+ (invader-y I1) 10) (rectangle WIDTH HEIGHT "solid" "transparent"))))

;; Template: <used template from ListOfMissile>

(define (render-missiles lom)
  (cond [(empty? lom) (rectangle WIDTH HEIGHT "solid" "transparent")]
        [else
         (place-image MISSILE (missile-x (first lom)) (missile-y (first lom))
                      (render-missiles (rest lom)))]))


;; Natural[0, 9999] -> Image
;; produce a scoreboard with the given score, s

;; Stub:
#;
(define (render-score s) empty-image)

;; Tests:
(check-expect (render-score 0)
              (overlay/align "center" "center" (text "0000" SCORE-FONT-SIZE SCORE-FONT-COLOR)
                       SCOREBOARD))
(check-expect (render-score 89)
              (overlay/align "center" "center" (text "0089" SCORE-FONT-SIZE SCORE-FONT-COLOR)
                       SCOREBOARD))
(check-expect (render-score 457)
              (overlay/align "center" "center" (text "0457" SCORE-FONT-SIZE SCORE-FONT-COLOR)
                       SCOREBOARD))
(check-expect (render-score 9999)
              (overlay/align "center" "center" (text "9999" SCORE-FONT-SIZE SCORE-FONT-COLOR)
                       SCOREBOARD))

;; Template:
#;
(define (render-score s)
  (... s))

(define (render-score s)
  (overlay (text (create-score (number->string s)) SCORE-FONT-SIZE SCORE-FONT-COLOR)
           SCOREBOARD))


;; String -> String
;; given a string of a score number, s, produce its correct display form always containing 4 characters
;; ASSUME: the given string will always consist of number characters: [0, 9]; and its length will always be within [1, 4]

;; Stub:
#;
(define (create-score s) "0000")

;; Tests:
(check-expect (create-score "0") "0000")
(check-expect (create-score "1") "0001")
(check-expect (create-score "84") "0084")
(check-expect (create-score "479") "0479")
(check-expect (create-score "9999") "9999")

;; Template:
#;
(define (create-score s)
  (... s))

(define (create-score s)
  (string-append (make-string (- 4 (string-length s)) #\0) s))


;; Game KeyEvent -> Game
;; produce a new missile when " " (space bar) is pressed
;;         a new x position for the game's tank when "arrow-left" or "arrow-right" are pressed
;;         the current state of the game when any other key is pressed

;; Stub:
#;
(define (on-key-game g ke) g)

;; Tests:
(check-expect (on-key-game G0 " ")
              (make-game empty (list (make-missile (tank-x (game-tank G0)) (- HEIGHT TANK-HEIGHT/2))) T0 0))
(check-expect (on-key-game G1 "left")
              (make-game empty empty (make-tank (+ (tank-x (game-tank G1)) -2) -1) 0))
(check-expect (on-key-game G2 " ")
              (make-game (list I1)
                         (cons (make-missile (tank-x (game-tank G2)) (- HEIGHT TANK-HEIGHT/2)) (list M1)) T1 0))
(check-expect (on-key-game G3 "right")
              (make-game (list I1 I2)
                         (list M1 M2)
                         (make-tank (+ (tank-x (game-tank G3)) 2) 1) 0))
(check-expect (on-key-game G2 "r") G2)

;; Template:
#;
(define (on-key-game g ke)
  (cond [(key=? " " ke) (... (fn-for-game g))]
        [(key=? "left" ke) (... (fn-for-game g))]
        [(key=? "right" ke) (... (fn-for-game g))]
        [else (... (fn-for-game g))]))

(define (on-key-game g ke)
  (cond [(key=? " " ke)
         (make-game (game-invaders g)
                    (shoot-missile (game-missiles g) (game-tank g))
                    (game-tank g)
                    (game-score g))]
        [(key=? "left" ke)
         (make-game (game-invaders g) (game-missiles g)
                    (update-tank (game-tank g) -1)
                    (game-score g))]
        [(key=? "right" ke)
         (make-game (game-invaders g) (game-missiles g)
                    (update-tank (game-tank g) 1)
                    (game-score g))]
        [else g]))


;; ListOfMissile Tank -> ListOfMissile
;; shoot a missile (create a new element Missile and add it to the given list, lom) at x coordinate of the given tank, t

;; Stub:
#;
(define (shoot-missile lom t) lom)

;; Tests:
(check-expect (shoot-missile empty T0)
              (cons (make-missile (tank-x T0) (- HEIGHT TANK-HEIGHT/2)) empty))
(check-expect (shoot-missile (list M1) T1)
              (cons (make-missile (tank-x T1) (- HEIGHT TANK-HEIGHT/2)) (list M1)))
(check-expect (shoot-missile (list M1 M2) T2)
              (cons (make-missile (tank-x T2) (- HEIGHT TANK-HEIGHT/2)) (list M1 M2)))

;; Template: <used template from Tank>
#;
(define (shoot-missile lom t)
  (... (tank-x t)
       (tank-dir t)
       (fn-for-lom lom)))

(define (shoot-missile lom t)
  (cons (make-missile (tank-x t) (- HEIGHT TANK-HEIGHT/2)) lom))


;; Tank Integer[-1, 1] -> Tank
;; given a tank, t, and a direction, dir, produce the next tank position according to the screen limits

;; Stub:
#;
(define (update-tank t dir) t)

;; Tests:
(check-expect (update-tank T0 1)
              (make-tank (+ (tank-x T0) (* TANK-SPEED 1)) 1))
(check-expect (update-tank T0 -1)
              (make-tank (+ (tank-x T0) (* TANK-SPEED -1)) -1))
(check-expect (update-tank T1 -1)
              (make-tank (+ (tank-x T1) (* TANK-SPEED -1)) -1))
(check-expect (update-tank T2 1)
              (make-tank (+ (tank-x T2) (* TANK-SPEED 1)) 1))
(check-expect (update-tank (make-tank (+ TANK-WIDTH/2 1) -1) -1)
              (make-tank TANK-WIDTH/2 0))
(check-expect (update-tank (make-tank (- (- WIDTH TANK-WIDTH/2) 1) 1) 1)
              (make-tank (- WIDTH TANK-WIDTH/2) 0))

;; Template:
#;
(define (update-tank t dir)
  (... t dir))

(define (update-tank t dir)
  (update-tank-layer (tank-x t) dir (+ (tank-x t) (* TANK-SPEED dir))))


;; Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2] Integer[-1, 1] Natural
;; produce the next tank position given, its current x position, x,
;;         its direction, dir,
;;         its possible next x-coordinate, next-x  

;; Stub:
#;
(define (update-tank-layer x dir next-x) T0)

;; Tests:
(check-expect (update-tank-layer 150 1 152)
              (make-tank 152 1))
(check-expect (update-tank-layer (- WIDTH TANK-WIDTH/2 1) 1 (+ (- WIDTH TANK-WIDTH/2 1) (* TANK-SPEED 1)))
              (make-tank (- WIDTH TANK-WIDTH/2) 0))
(check-expect (update-tank-layer (+ TANK-WIDTH/2 1) -1 (+ (+ TANK-WIDTH/2 1) (* TANK-SPEED -1)))
              (make-tank TANK-WIDTH/2 0))

;; Template:
#;
(define (update-tank-layer x dir next-x)
  (... x dir next-x))

(define (update-tank-layer x dir next-x)
  (cond [(and (>= next-x TANK-WIDTH/2) (<= next-x (- WIDTH TANK-WIDTH/2)))
         (make-tank next-x dir)]
        [(< next-x TANK-WIDTH/2)
         (make-tank TANK-WIDTH/2 0)]
        [(> next-x (- WIDTH TANK-WIDTH/2))
         (make-tank (- WIDTH TANK-WIDTH/2) 0)]))


;; Game -> Boolean
;; return true if a single invader's y-coordinate is HEIGHT - INVADER-HEIGHT/2

;; Stub:
#;
(define (stop-game g) false)

;; Tests:
(check-expect (stop-game G0) false)
(check-expect (stop-game G1) false)
(check-expect (stop-game G2) false)
(check-expect (stop-game G3) true)

;; Template: <used template from Game>

(define (stop-game g)
  (check-invaders-y (game-invaders g)))


;; ListOfInvader -> Boolean
;; given a list of integer, loi, and return false if all its invader's y coordinate is less than HEIGHT - INVADER-HEIGHT/2

;; Stub:
#;
(define (check-invaders-y loi) loi)

;; Tests:
(check-expect (check-invaders-y empty) false)
(check-expect (check-invaders-y (list I1)) false)
(check-expect (check-invaders-y (list I1 I2)) true)

;; Template: <used template from ListOfInvader>

(define (check-invaders-y loi)
  (cond [(empty? loi) false]
        [else
         (or (>= (invader-y (first loi)) (- HEIGHT INVADER-HEIGHT/2))
             (check-invaders-y (rest loi)))]))


;; Game -> Image
;; produce the game over screen given a state of a game, g

;; Stub:
#;
(define (game-over g) empty-image)

;; Tests:
(check-expect (game-over G0)
              (place-image (above (text "GAME OVER" GAME-OVER-FONT-SIZE GAME-OVER-FONT-COLOR) (text (string-append "SCORE: "
                                  (create-score (number->string (game-score G0)))) SCORE-FONT-SIZE SCORE-FONT-COLOR))
                           (/ WIDTH 2) (/ (+ HEIGHT SCOREBOARD-HEIGHT) 2) GAME-OVER-BACKGROUND))
(check-expect (game-over G4)
              (place-image (above (text "GAME OVER" GAME-OVER-FONT-SIZE GAME-OVER-FONT-COLOR) (text (string-append "SCORE: "
                                  (create-score (number->string (game-score G4)))) SCORE-FONT-SIZE SCORE-FONT-COLOR))
                           (/ WIDTH 2) (/ (+ HEIGHT SCOREBOARD-HEIGHT) 2) GAME-OVER-BACKGROUND))

;; Template: <used template from Game>

(define (game-over g)
  (place-image (above (text "GAME OVER" GAME-OVER-FONT-SIZE GAME-OVER-FONT-COLOR) (text (string-append "SCORE: "
                      (create-score (number->string (game-score g)))) SCORE-FONT-SIZE SCORE-FONT-COLOR))
               (/ WIDTH 2) (/ (+ HEIGHT SCOREBOARD-HEIGHT) 2) GAME-OVER-BACKGROUND))