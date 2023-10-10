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

(define TANK-WIDTH/2 (/ (image-width TANK) 2))
(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define INVADER-WIDTH/2 (/ (image-width INVADER) 2))
(define INVADER-HEIGHT/2 (/ (image-height INVADER) 2))
(define MISSILE-WIDTH/2 (/ (image-width MISSILE) 2))
(define MISSILE-HEIGHT/2 (/ (image-height MISSILE) 2))

(define MISSILE (ellipse 5 15 "solid" "red"))


;; =================
;; Data Definitions:

(define-struct tank (x dir))
;; Tank is (make-tank Natural[TANK-WIDTH/2, WIDTH - TANK-WIDTH/2] Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT/2 in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

;; Examples:
(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

;; Template:
#;
(define (fn-for-tank t)
  (... (tank-x t)       ; [TANK-WIDTH/2, WIDTH - TANK-WIDTH/2]
       (tank-dir t)))   ; Integer

;; Template rules used:
;; - compound: 2 fields


(define-struct invader (x y dx))
;; Invader is (make-invader Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2] Natural[INVADER-HEIGHT/2, HEIGHT - INVADER-HEIGHT/2] Natural)
;; interp. the invader is at (x, y) in screen coordinates
;;         the invader moves along x by dx pixels per clock tick

;; Examples:
(define I1 (make-invader 150 100 12))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -10))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 10)) ;> landed, moving right

;; Template:
#;
(define (fn-for-invader i)
  (... (invader-x i)       ; Natural[INVADER-WIDTH/2, WIDTH - INVADER-WIDTH/2]
       (invader-y i)       ; Natural[INVADER-HEIGHT/2, HEIGHT - INVADER-HEIGHT/2]
       (invader-dx i)))    ; Natural

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
;; Missile is (make-missile Natural[MISSILE-WIDTH/2, WIDTH - MISSILE-WIDTH/2] Natural[MISSILE-HEIGHT/2, HEIGHT - MISSILE-HEIGHT/2])
;; interp. the missile's location is x y in screen coordinates

;; Examples:
(define M1 (make-missile 150 300))                               ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

;; Template:
#;
(define (fn-for-missile m)            ; Natural[MISSILE-WIDTH/2, WIDTH - MISSILE-WIDTH/2]
  (... (missile-x m) (missile-y m)))  ; Natural[MISSILE-HEIGHT/2, HEIGHT - MISSILE-HEIGHT/2]

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


(define-struct game (invaders missiles tank))
;; Game is (make-game  ListOfInvader ListOfMissile Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Examples:
(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))

;; Template:
#;
(define (fn-for-game g)
  (... (fn-for-loinvader (game-invaders g))
       (fn-for-lom (game-missiles g))
       (fn-for-tank (game-tank g))))

;; Template rules used:
;; - compound: 3 fields

;; =====================
;; Function Definitions:

;; Game -> Game
;; start the world with: (main G0)

(define (main g)
  (big-bang g                   ; Game
    (on-tick update-game)       ; Game -> Game
    (to-draw render-game)       ; Game -> Image
    (on-key shoot-missile)))    ; Game KeyEvent -> Game


;; Game -> Game
;; produce next position of the game (invaders and missiles)

;; Stub:
#;
(define (update-game s) G0)

;; Tests:
(check-expect (update-game G0) G0)
(check-expect (update-game G1) G1)
(check-expect (update-game G2)
              (make-game (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dx I1)))
                         (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED)))
                         T1))
(check-expect (update-game G3)
              (make-game (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dx I1))
                               (make-invader (+ (invader-x I2) INVADER-X-SPEED) (+ (invader-y I2) INVADER-Y-SPEED) (invader-dx I2)))
                         (list (make-missile (missile-x M1) (- (missile-y M1) MISSILE-SPEED))
                               (make-missile (missile-x M2) (- (missile-y M2) MISSILE-SPEED)))
                         T1))

;; Template: <used template from Game>

(define (update-game s)
  (make-game (update-invaders (game-invaders s))
       (update-missiles (game-missiles s))
       (game-tank s)))


;; (listof Invader) -> (listof Invader)
;; produce next iteration of the position of all invaders in given list of invaders, loi

;; Stub:
#;
(define (update-invaders loi) loi)

;; Tests:
(check-expect (update-invaders empty) empty)
(check-expect (update-invaders (list I1))
              (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dx I1))))
(check-expect (update-invaders (list I1 I2))
              (list (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dx I1))
                               (make-invader (+ (invader-x I2) INVADER-X-SPEED) (+ (invader-y I2) INVADER-Y-SPEED) (invader-dx I2))))

;; Template:
#;
(define (update-invaders loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi))
              (update-invaders (rest loi)))]))

(define (update-invaders loi)
  (cond [(empty? loi) empty]
        [else
         (cons (update-invader (first loi))
              (update-invaders (rest loi)))]))


;; Invader -> Invader
;; produce the next position of a given invader, invader

;; Stub:
#;
(define (update-invader invader) invader)

;; Tests:
(check-expect (update-invader I1)
              (make-invader (+ (invader-x I1) INVADER-X-SPEED) (+ (invader-y I1) INVADER-Y-SPEED) (invader-dx I1)))
(check-expect (update-invader I2)
              (make-invader (+ (invader-x I2) INVADER-X-SPEED) (+ (invader-y I2) INVADER-Y-SPEED) (invader-dx I2)))

;; Template: <used template from Invader>

(define (update-invader invader)
  (make-invader (+ (invader-x invader) INVADER-X-SPEED)
                (+ (invader-y invader) INVADER-Y-SPEED)
                (invader-dx invader)))


;; (listof Missile) -> (listof Missile)
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

;; Template:
#;
(define (update-missiles lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (update-missiles (rest lom)))]))

(define (update-missiles lom)
  (cond [(empty? lom) empty]
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


;; Game -> Image
;; render the invaders, the missiles and the tank on the screen

;; Stub:
#;
(define (render-game s) empty-image)

;; Tests:
(check-expect (render-game G0)
              (place-image TANK (/ WIDTH 2) (- HEIGHT TANK-HEIGHT/2) BACKGROUND))
(check-expect (render-game G1)
              (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND))
(check-expect (render-game G2)
              (place-image INVADER 150 100
                           (place-image MISSILE 150 300
                                        (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND))))
(check-expect (render-game G3)
              (place-image INVADER 150 100
              (place-image INVADER 150 HEIGHT
                           (place-image MISSILE 150 300
                           (place-image MISSILE (invader-x I1) (+ (invader-y I1) 10)
                                        (place-image TANK 50 (- HEIGHT TANK-HEIGHT/2) BACKGROUND))))))

;; Template: <used template from Game>

(define (render-game s)
  (overlay (render-invaders (game-invaders s)) (render-missiles (game-missiles s))
           (place-image TANK (tank-x (game-tank s)) (- HEIGHT TANK-HEIGHT/2) BACKGROUND)))


;; (listof Invader) -> Image
;; render a given list of invaders, loi, in the given screen coordinates

;; Stub:
#;
(define (render-invaders loi) empty-image)

;; Tests:
(check-expect (render-invaders empty) (rectangle WIDTH HEIGHT "solid" "transparent"))
(check-expect (render-invaders (list I1))
              (place-image INVADER 150 100 (rectangle WIDTH HEIGHT "solid" "transparent")))
(check-expect (render-invaders (list I1 I2))
              (place-image INVADER 150 100 (place-image INVADER 150 HEIGHT (rectangle WIDTH HEIGHT "solid" "transparent"))))

;; Template:
#;
(define (render-invaders loi)
  (cond [(empty? loi) (...)]
        [else
         (... (fn-for-invader (first loi))
              (render-invaders (rest loi)))]))

(define (render-invaders loi)
  (cond [(empty? loi) (rectangle WIDTH HEIGHT "solid" "transparent")]
        [else
         (place-image INVADER (invader-x (first loi)) (invader-y (first loi))
              (render-invaders (rest loi)))]))


;; (listof Missile) -> Image
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

;; Template:
#;
(define (render-missiles lom)
  (cond [(empty? lom) (...)]
        [else
         (... (fn-for-missile (first lom))
              (render-missiles (rest lom)))]))

(define (render-missiles lom)
  (cond [(empty? lom) (rectangle WIDTH HEIGHT "solid" "transparent")]
        [else
         (place-image MISSILE (missile-x (first lom)) (missile-y (first lom))
              (render-missiles (rest lom)))]))


;; Game KeyEvent -> Game
;; on "space" (space bar) pressed, create a new missile with (x, y) coordinates on the screen

;; Stub:
#;
(define (shoot-missile s ke) G0)

;; Tests:
(check-expect (shoot-missile G0 " ") ; "space" key is pressed
              (make-game empty (list (make-missile (tank-x (game-tank G0)) (- HEIGHT TANK-HEIGHT/2))) T0))
(check-expect (shoot-missile G0 "r") G0) ; any other key is pressed
(check-expect (shoot-missile G1 " ")
              (make-game empty (list (make-missile (tank-x (game-tank G1)) (- HEIGHT TANK-HEIGHT/2))) T1))
(check-expect (shoot-missile G2 " ")
              (make-game (list I1)
                         (cons (make-missile (tank-x (game-tank G2)) (- HEIGHT TANK-HEIGHT/2)) (list M1)) T1))
(check-expect (shoot-missile G3 " ")
              (make-game (list I1 I2)
                         (cons (make-missile (tank-x (game-tank G3)) (- HEIGHT TANK-HEIGHT/2)) (list M1 M2)) T1))

;; Template:
#;
(define (shoot-missile s ke)
  (cond [(key=? " " ke) (... (fn-for-game s))]
        [else (... (fn-for-game s))]))

(define (shoot-missile s ke)
  (cond [(key=? " " ke) (make-game (game-invaders s)
          (cons (make-missile (tank-x (game-tank s)) (- HEIGHT TANK-HEIGHT/2)) (game-missiles s)) (game-tank s))]
        [else s]))