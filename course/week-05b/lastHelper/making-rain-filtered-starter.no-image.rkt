;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname making-rain-filtered-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; making-rain-filtered-starter.rkt

;PROBLEM:
;
;Design a simple interactive animation of rain falling down a screen. Wherever we click,
;a rain drop should be created and as time goes by it should fall. Over time the drops
;will reach the bottom of the screen and "fall off". You should filter these excess
;drops out of the world state - otherwise your program is continuing to tick and
;and draw them long after they are invisible.
;
;In your design pay particular attention to the helper rules. In our solution we use
;these rules to split out helpers:
;  - function composition
;  - reference
;  - knowledge domain shift
;  
;  
;NOTE: This is a fairly long problem.  While you should be getting more comfortable with 
;world problems there is still a fair amount of work to do here. Our solution has 9
;functions including main. If you find it is taking you too long then jump ahead to the
;next homework problem and finish this later.

;; Make it rain where we want it to.

;; =================
;; Constants:

(define WIDTH  300)
(define HEIGHT 300)

(define SPEED 1)

(define DROP (ellipse 4 8 "solid" "blue"))

(define MTS (rectangle WIDTH HEIGHT "solid" "light blue"))

;; =================
;; Data definitions:

(define-struct drop (x y))
;; Drop is (make-drop Integer Integer)
;; interp. A raindrop on the screen, with x and y coordinates.

;; Examples:
(define D1 (make-drop 10 30))

;; Template:
#;
(define (fn-for-drop d)
  (... (drop-x d) 
       (drop-y d)))

;; Template Rules used:
;; - compound: 2 fields


;; ListOfDrop is one of:
;;  - empty
;;  - (cons Drop ListOfDrop)
;; interp. a list of drops

;; Examples:
(define LOD1 empty)
(define LOD2 (cons (make-drop 10 20) (cons (make-drop 3 6) empty)))

;; Template:
#;
(define (fn-for-lod lod)
  (cond [(empty? lod) (...)]
        [else
         (... (fn-for-drop (first lod))
              (fn-for-lod (rest lod)))]))

;; Template Rules used:
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Drop ListOfDrop)
;; - reference: (first lod) is Drop
;; - self reference: (rest lod) is ListOfDrop

;; =================
;; Functions:

;; ListOfDrop -> ListOfDrop
;; start rain program by evaluating (main empty)
(define (main lod)
  (big-bang lod
    (on-mouse handle-mouse)   ; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
    (on-tick  next-drops)     ; ListOfDrop -> ListOfDrop
    (to-draw  render-drops))) ; ListOfDrop -> Image


;; ListOfDrop Integer Integer MouseEvent -> ListOfDrop
;; if mevt is "button-down" add a new drop at that position

;; CROSS PRODUCT OF TYPE COMMENTS TABLE
;;
;;                                       MouseEvent
;;                             "button-down"        else                
;;                                           |
;; l   empty                                 |     
;; o                              create     -      lod
;; d   (cons Drop ListOfDrop)                | 
;;                                           |

;; Stub:
#;
(define (handle-mouse lod x y mevt) empty)

;; Tests:
(check-expect (handle-mouse LOD1 250 50 "button-down")
              (cons (make-drop 250 50) empty))
(check-expect (handle-mouse LOD1 250 50 "move") empty)
(check-expect (handle-mouse LOD2 145 248 "button-down")
              (cons (make-drop 145 248) LOD2))
(check-expect (handle-mouse LOD2 145 248 "button-up") LOD2)

;; Template:
#;
(define (handle-mouse lod x y mevt)
  (cond [(mouse=? mevt "button-down") (... lod x y)]
        [else (... lod)]))

(define (handle-mouse lod x y mevt)
  (cond [(mouse=? mevt "button-down") (cons (make-drop x y) lod)]
        [else lod]))


;; ListOfDrop -> ListOfDrop
;; produce filtered and ticked list of drops

;; Stub:
#;
(define (next-drops lod) empty)

;; Tests:
(check-expect (next-drops LOD2)
              (cons (make-drop 10 21) (cons (make-drop 3 7) empty)))
(check-expect (next-drops (cons (make-drop 56 300) empty)) empty)
(check-expect (next-drops (cons (make-drop 56 300) (cons (make-drop 75 09) empty)))
              (cons (make-drop 75 10) empty))

;; Template:
#;
(define (fn-for-lod lod)
  (fn-for-update-drops (fn-for-filter-drops lod)))

(define (next-drops lod)
  (update-drops (filter-drops lod)))


;; ListOfDrop -> ListOfDrop
;; filter all the drops with y coordinate = HEIGHT (remove the ones about to become invisible)

;; Stub:
#;
(define (filter-drops lod) lod)

;; Tests:
(check-expect (filter-drops empty) empty)
(check-expect (filter-drops LOD2) LOD2)
(check-expect (filter-drops (cons (make-drop 56 300) empty)) empty)
(check-expect (filter-drops (cons (make-drop 56 300) (cons (make-drop 75 09) empty)))
              (cons (make-drop 75 09) empty))

;; Template: <used template from ListOfDrop>

(define (filter-drops lod)
  (cond [(empty? lod) empty]
        [else
         (if (onscreen? (first lod))
             (cons (first lod) (filter-drops (rest lod)))
             (filter-drops (rest lod)))]))


;; Drop -> Boolean
;; produce true if the drop's y-coordinate != HEIGHT (is onscreen)

;; Stub:
#;
(define (onscreen? d) true)

;; Tests:
(check-expect (onscreen? (make-drop 56 300)) false)
(check-expect (onscreen? (make-drop 75 09)) true)

;; Template: <used template from Drop>

(define (onscreen? d)
  (not (= (drop-y d) HEIGHT)))


;; ListOfDrop -> ListOfDrop
;; produce the next iteration for all the given list of drops
;; ASSUME: the given list of drops is already filtered (drop-y != HEIGHT)

;; Stub:
#;
(define (update-drops lod) lod)

;; Tests:
(check-expect (update-drops LOD1) empty)
(check-expect (update-drops LOD2)
              (cons (make-drop 10 21) (cons (make-drop 3 7) empty)))

;; Template: <used template from ListOfDrop>

(define (update-drops lod)
  (cond [(empty? lod) empty]
        [else
         (cons (update-drop (first lod))
              (update-drops (rest lod)))]))


;; Drop -> Drop
;; update the y-coordinate of the given drop
;; ASSUME: the given drop y-coordinate != HEIGHT

;; Stub:
#;
(define (update-drop d) d)

;; Tests:
(check-expect (update-drop (make-drop 100 122))
              (make-drop 100 123))
(check-expect (update-drop (make-drop 231 95))
              (make-drop 231 96))

;; Template: <used template from Drop>

(define (update-drop d)
  (make-drop (drop-x d) (+ (drop-y d) SPEED)))


;; ListOfDrop -> Image
;; Render the drops onto MTS

;; Stub:
#;
(define (render-drops lod) MTS)

;; Tests:
(check-expect (render-drops LOD1) MTS)
(check-expect (render-drops (cons (make-drop 283 98) empty))
              (place-image DROP 283 98 MTS))
(check-expect (render-drops LOD2)
              (place-image DROP 10 20 (place-image DROP 3 6 MTS)))

;; Template: <used template from ListOfDrop>

(define (render-drops lod)
  (cond [(empty? lod) MTS]
        [else
         (place-image DROP (drop-x (first lod)) (drop-y (first lod))
              (render-drops (rest lod)))]))


;; Drop Image -> Image
;; place given drop in given image (MTS)

;; Stub:
#;
(define (place-drop d img) empty-image)

;; Tests:
(check-expect (place-drop D1 MTS)
              (place-image DROP (drop-x D1) (drop-y D1) MTS))
(check-expect (place-drop (make-drop 271 99) (place-image DROP (drop-x D1) (drop-y D1) MTS))
              (place-image DROP 271 99 (place-image DROP (drop-x D1) (drop-y D1) MTS)))

;; Template: <used template from Drop>
#;
(define (fn-for-drop d img)
  (... (drop-x d) 
       (drop-y d)
       img))

(define (place-drop d img)
  (place-image DROP (drop-x d) (drop-y d) img))