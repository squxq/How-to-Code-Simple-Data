;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname spinning-bears-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; spinning-bears-starter.rkt

(require 2htdp/image)
(require 2htdp/universe)

;PROBLEM:
;
;In this problem you will design another world program. In this program the changing 
;information will be more complex - your type definitions will involve arbitrary 
;sized data as well as the reference rule and compound data. But by doing your 
;design in two phases you will be able to manage this complexity. As a whole, this problem 
;will represent an excellent summary of the material covered so far in the course, and world 
;programs in particular.
;
;This world is about spinning bears. The world will start with an empty screen. Clicking
;anywhere on the screen will cause a bear to appear at that spot. The bear starts out upright,
;but then rotates counterclockwise at a constant speed. Each time the mouse is clicked on the 
;screen, a new upright bear appears and starts spinning.
;
;So each bear has its own x and y position, as well as its angle of rotation. And there are an
;arbitrary amount of bears.
;
;To start, design a world that has only one spinning bear. Initially, the world will start
;with one bear spinning in the center at the screen. Clicking the mouse at a spot on the
;world will replace the old bear with a new bear at the new spot. You can do this part 
;with only material up through compound. 
;
;Once this is working you should expand the program to include an arbitrary number of bears.
;
;Here is an image of a bear for you to use: (open image file)

;; ==========
;; Constants:

(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define MTS (empty-scene WIDTH HEIGHT))
(define BEAR (circle 30 "solid" "blue")) ; (open image file)

;; =================
;; Data Definitions:

(define-struct bear (x y a da))
;; Bear is (make-bear Integer[0, WIDTH] Integer[0, HEIGHT] Integer[0, 360) Natural[1, 5])
;; interp. (make-bear x y a da) is a bear with:
;;         x, is the bear's x coordinate
;;         y, is the bear's y coordinate
;;         a, is the bear's rotation angle
;;         da, is the bear's rotation angle rate of change - random Natural[1, 5]

;; Examples:
(define B0 (make-bear (/ WIDTH 2) (/ HEIGHT 2) 0 2))
(define B1 (make-bear 938 573 184 3))
(define B2 (make-bear 234 70 341 4))

;; Template:
#;
(define (fn-for-bear b)
  (... (bear-x b)
       (bear-y b)
       (bear-a b)))

;; Template rules used:
;; - compound: (make-bear Integer[0, WIDTH] Integer[0, HEIGHT] Integer[0, 360) Natural[1, 5])


;; ListOfBear is one of:
;; - empty
;; - (cons Bear ListOfBear)
;; interp. a list of bears

;; Examples:
(define LOB0 empty)
(define LOB1 (cons B0 empty))
(define LOB2 (cons B0 (cons B1 empty)))
(define LOB3 (cons B0 (cons B1 (cons B2 empty))))

;; Template:
#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (fn-for-bear (first lob))
              (fn-for-lob (rest lob)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - copmpound: (cons Bear ListOfBear)
;; - reference: (first lob) is Bear
;; - self-reference: (last lob) is ListOfBear


;; =====================
;; Function Definitions:

;; ListOfBear -> ListOfBear
;; start the world with: (main empty)

(define (main lob)
  (big-bang lob                ; ListOfBear
    (on-tick rotate-bears)     ; ListOfBear -> ListOfBear
    (to-draw render-bears)     ; ListOfBear -> Image
    (on-mouse create-bear)))   ; ListOfBear Integer[0, WIDTH] Integer[0, HEIGHT] MouseEvent -> ListOfBear


;; ListOfBear -> ListOfBear
;; rotate each bear on the MTS by one degree (counterclockwise)

;; Stub:
#;
(define (rotate-bears lob) LOB0)

;; Tests:
(check-expect (rotate-bears LOB0) LOB0)
(check-expect (rotate-bears LOB1)
              (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) 2 2) empty))
(check-expect (rotate-bears LOB2)
              (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) 2 2)
                    (cons (make-bear 938 573 187 3) empty)))
(check-expect (rotate-bears LOB3)
              (cons (make-bear (/ WIDTH 2) (/ HEIGHT 2) 2 2)
                    (cons (make-bear 938 573 187 3)
                          (cons (make-bear 234 70 345 4) empty))))

;; Template:
;; <used template from ListOfBear>

(define (rotate-bears lob)
  (cond [(empty? lob) empty]
        [else
         (cons (rotate-bear (first lob))
              (rotate-bears (rest lob)))]))


;; Bear -> Bear
;; rotate given bear by one degree (counterclockwise)

;; Stub:
#;
(define (rotate-bear b) B0)

;; Tests:
(check-expect (rotate-bear B0) (make-bear (/ WIDTH 2) (/ HEIGHT 2) 2 2))
(check-expect (rotate-bear B1) (make-bear 938 573 187 3))
(check-expect (rotate-bear B2) (make-bear 234 70 345 4))
(check-expect (rotate-bear (make-bear (/ WIDTH 2) (/ HEIGHT 2) 359 5))
              (make-bear (/ WIDTH 2) (/ HEIGHT 2) 4 5))

;; Template:
;; <used template from Bear>

(define (rotate-bear b)
  (if (not (>= (+ (bear-a b) (bear-da b)) 360))
      (make-bear (bear-x b) (bear-y b) (+ (bear-a b) (bear-da b)) (bear-da b))
      (make-bear (bear-x b) (bear-y b) (remainder (+ (bear-a b) (bear-da b)) 360) (bear-da b))))


;; ListOfBear -> Image
;; render each bear on the MTS given its coordinates and rotation angle

;; Stub:
#;
(define (render-bears lob) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-bears LOB0) MTS)
(check-expect (render-bears LOB1)
              (place-image (rotate (bear-a B0) BEAR) (bear-x B0) (bear-y B0) MTS))
(check-expect (render-bears LOB2)
              (place-image (rotate (bear-a B1) BEAR) (bear-x B1) (bear-y B1)
                           (place-image (rotate (bear-a B0) BEAR) (bear-x B0) (bear-y B0) MTS)))
(check-expect (render-bears LOB3)
              (place-image (rotate (bear-a B2) BEAR) (bear-x B2) (bear-y B2)
                           (place-image (rotate (bear-a B1) BEAR) (bear-x B1) (bear-y B1)
                                        (place-image (rotate (bear-a B0) BEAR) (bear-x B0) (bear-y B0) MTS))))

;; Template:
;; <used template from ListOfBear>

(define (render-bears lob)
  (cond [(empty? lob) MTS]
        [else (render-bear (first lob)
              (render-bears (rest lob)))]))


;; Bear Image -> Image
;; produce image of given bear with its correct position (x and y coordinates) and rotation angle on the given screen

;; Stub:
#;
(define (render-bear b s) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-bear B0 MTS)
              (place-image (rotate (bear-a B0) BEAR) (bear-x B0) (bear-y B0) MTS))
(check-expect (render-bear B1 MTS)
              (place-image (rotate (bear-a B1) BEAR) (bear-x B1) (bear-y B1) MTS))
(check-expect (render-bear B2 MTS)
              (place-image (rotate (bear-a B2) BEAR) (bear-x B2) (bear-y B2) MTS))

;; Template:
;; <used template from Bear>

(define (render-bear b s)
  (place-image (rotate (bear-a b) BEAR) (bear-x b) (bear-y b) s))


;; ListOfBear Integer[0, WIDTH] Integer[0, HEIGHT] MouseEvent -> ListOfBear
;; when the mouse is clicked ("button-down") create a new upright(rotation angle is 0) bear at that position

;; Stub:
#;
(define (create-bear lob x y me) LOB0)

;; Tests:
(check-random (create-bear LOB0 473 835 "button-down")
              (cons (make-bear 473 835 0 (+ (random 5) 1)) empty))
(check-random (create-bear LOB0 473 835 "move") empty)
(check-random (create-bear LOB1 1529 753 "button-down")
              (cons (make-bear 1529 753 0 (+ (random 5) 1)) (cons B0 empty)))
(check-random (create-bear LOB2 941 50 "button-down")
              (cons (make-bear 941 50 0 (+ (random 5) 1)) (cons B0 (cons B1 empty))))
(check-random (create-bear LOB3 1241 879 "button-down")
              (cons (make-bear 1241 879 0 (+ (random 5) 1)) (cons B0 (cons B1 (cons B2 empty)))))

;; Template:
#;
(define (create-bear lob x y me)
  (cond [(mouse=? me "button-down") (... lob x y)]
        [else (... lob x y)]))

(define (create-bear lob x y me)
  (cond [(mouse=? me "button-down") (cons (make-bear x y 0 (+ (random 5) 1)) lob)]
        [else lob]))
