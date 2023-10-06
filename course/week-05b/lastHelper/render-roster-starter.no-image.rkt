;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname render-roster-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; render-roster-starter.rkt

;Problem:
;
;You are running a dodgeball tournament and are given a list of all
;of the players in a particular game as well as their team numbers.  
;You need to build a game roster like the one shown below. We've given
;you some constants and data definitions for Player, ListOfPlayer 
;and ListOfString to work with. 
;
;While you're working on these problems, make sure to keep your 
;helper rules in mind and use helper functions when necessary.
;
;(open image file)

(require 2htdp/image)

;; Constants
;; ---------

(define CELL-WIDTH 200)
(define CELL-HEIGHT 30)

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")

;; Data Definitions
;; ----------------

(define-struct player (name team))
;; Player is (make-player String Natural[1,2])
;; interp. a dodgeball player. 
;;   (make-player s t) represents the player named s 
;;   who plays on team t

;; Examples:
(define P0 (make-player "Samael" 1))
(define P1 (make-player "Georgia" 2))

;; Template:
#;
(define (fn-for-player p)
  (... (player-name p)
       (player-team p)))


;; ListOfPlayer is one of:
;; - empty
;; - (cons Player ListOfPlayer)
;; interp.  A list of players.

;; Examples:
(define LOP0 empty)                     ;; no players
(define LOP2 (cons P0 (cons P1 empty))) ;; two players

;; Template:
#;
(define (fn-for-lop lop)
  (cond [(empty? lop) (...)]
        [else
         (... (fn-for-player (first lop))
              (fn-for-lop (rest lop)))]))


;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings

;; Examples:
(define LOS0 empty)
(define LOS2 (cons "Samael" (cons "Georgia" empty)))

;; Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (first los)
              (fn-for-los (rest los)))]))

;; Functions
;; ---------

;PROBLEM 1: 
;
;Design a function called select-players that consumes a list 
;of players and a team t (Natural[1,2]) and produces a list of 
;players that are on team t.

;; ListOfPlayer Natural[1,2] -> ListOfString
;; select from the given list of players the ones that are on given team t and produce their names on a list

;; Stub:
#;
(define (select-players lop t) lop)

;; Tests:
(check-expect (select-players LOP0 1) LOP0)
(check-expect (select-players LOP2 2) (cons (player-name P1) empty))
(check-expect (select-players (cons P0 (cons P1 (cons (make-player "John" 1) empty))) 1)
              (cons (player-name P0) (cons "John" empty)))

;; Template: <took template from ListOfPlayer>
#;
(define (fn-for-lop lop t)
  (cond [(empty? lop) (... t)]
        [else
         (... t
              (fn-for-player (first lop))
              (fn-for-lop (... t) (rest lop)))]))

(define (select-players lop t)
  (cond [(empty? lop) empty]
        [else
         (if (= t (player-team (first lop)))
              (cons (player-name (first lop)) (select-players (rest lop) t))
              (select-players (rest lop) t))]))



;PROBLEM 2:  
;
;Complete the design of render-roster. We've started you off with 
;the signature, purpose, stub and examples. You'll need to use
;the function that you designed in Problem 1.
;
;Note that we've also given you a full function design for render-los
;and its helper, render-cell. You will need to use these functions
;when solving this problem.

;; ListOfPlayer -> Image
;; Render a game roster from the given list of players

;; Stub:
#;
(define (render-roster lop) empty-image)

;; Tests:
(check-expect (render-roster empty)
              (beside/align 
               "top"
               (overlay
                (text "Team 1" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Team 2" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))
                
(check-expect (render-roster LOP2)
              (beside/align 
               "top"
               (above
                (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Samael" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))
               (above
                (overlay
                 (text "Team 2" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (overlay
                 (text "Georgia" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))))

;; Template: <took template from ListOfPlayer>

(define (render-roster lop)
  (beside/align "top" (above (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (render-los (select-players lop 1)))
                (above (overlay
                 (text "Team 2" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                (render-los (select-players lop 2)))))


;; ListOfString -> Image
;; Render a list of strings as a column of cells.

;; Stub
#;
(define (render-los lon) empty-image)

;; Tests:
(check-expect (render-los empty) empty-image)
(check-expect (render-los (cons "Samael" empty))
              (above 
               (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
                     empty-image))
(check-expect (render-los (cons "Samael" (cons "Brigid" empty)))
              (above
                (overlay
                (text "Samael" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))
               (overlay
                (text "Brigid" TEXT-SIZE TEXT-COLOR)
                (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR))))

;; Template: <took template from ListOfString>

(define (render-los los)
  (cond [(empty? los) empty-image]
        [else
         (above (render-cell (first los))
                (render-los (rest los)))]))


;; String -> Image
;; Render a cell of the game table

;; Stub:
#;
(define (render-cell s) empty-image)

;; Tests:
(check-expect (render-cell "Team 1") 
              (overlay
                 (text "Team 1" TEXT-SIZE TEXT-COLOR)
                 (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))

;; Template:
#;
(define (render-cell s)
  (... s))

(define (render-cell s)
  (overlay
   (text s TEXT-SIZE TEXT-COLOR)
   (rectangle CELL-WIDTH CELL-HEIGHT "outline" TEXT-COLOR)))