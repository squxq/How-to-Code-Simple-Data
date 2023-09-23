;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname countdown-animation-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; countdown-animation starter.rkt

;PROBLEM:
;
;Design an animation of a simple countdown. 
;
;Your program should display a simple countdown, that starts at ten, and
;decreases by one each clock tick until it reaches zero, and stays there.
;
;To make your countdown progress at a reasonable speed, you can use the 
;rate option to on-tick. If you say, for example, 
;(on-tick advance-countdown 1) then big-bang will wait 1 second between 
;calls to advance-countdown.
;
;Remember to follow the HtDW recipe! Be sure to do a proper domain 
;analysis before starting to work on the code file.
;
;Once you are finished the simple version of the program, you can improve
;it by reseting the countdown to ten when you press the spacebar.

;; A countdown that starts at ten then decreases by 1 each second until it reaches 0 and stays there

;; =====================
;; Constants

(define WIDTH 150)
(define HEIGHT (* WIDTH (/ 3 2)))

(define CTR-X (/ WIDTH 2))
(define CTR-Y (/ HEIGHT 2))

(define MTS (empty-scene WIDTH HEIGHT))

(define FONT 48)

;; =====================
;; Data Definitions

;; Time is Natural[0, 10]
;; interp. seconds before countdown is over (reaches 0 seconds)
;;       - [4, 10]: the color of the time image is black
;;       - [1, 3]: the color of the time image is red
;;       - 0: the color of the time image is green 

;; Examples
(define T0 0)  ; end of the countdown and green color
(define T1 1)  ; end of the red color
(define T2 3)  ; start of the red color
(define T3 4)  ; middle of the countdown and end of the black color
(define T4 10) ; start of the countdown and start of the black color

;; Template
#;
(define (fn-for-time t)
  (... t))

;; Template rules used:
;;  - atomic non-distinct: Natural[0, 10]

;; =====================
;; Function Definitions

;; Time -> Time
;; start the world with (main T4) = (main 10)
;;
(define (main t)
  (big-bang t                   ; Time
    (on-tick next-time 1)       ; Time -> Time
    (to-draw render-time)       ; Time -> Image
    (on-key handle-key-time)))  ; Time KeyEvent -> Time


;; Time -> Time
;; produce the next time natural number, subtracting 1 from given time if it is not 0

;; Stub:
#;
(define (next-time t) 0)

;; Tests:
(check-expect (next-time T4) (- T4 1)) ; start of the countdown
(check-expect (next-time T3) (- T3 1)) ; middle of the countdown
(check-expect (next-time T0) T0) ; end of the countdown

;; <Took the template from Time.>
(define (next-time t)
  (if (not (= t 0))
      (- t 1)
      t))


;; Time -> Image
;; produce time image with given time and place it on MTS at (CTR-X, CTR-y)
;;       - [4, 10]: the color of the time image is black
;;       - [1, 3]: the color of the time image is red
;;       - 0: the color of the time image is green 

;; Stub:
#;
(define (render-time t) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-time T4)
              (place-image (text (number->string T4) FONT "black") CTR-X CTR-Y MTS))
(check-expect (render-time T3)
              (place-image (text (number->string T3) FONT "black") CTR-X CTR-Y MTS))
(check-expect (render-time T2)
              (place-image (text (number->string T2) FONT "red") CTR-X CTR-Y MTS))
(check-expect (render-time T1)
              (place-image (text (number->string T1) FONT "red") CTR-X CTR-Y MTS))
(check-expect (render-time T0)
              (place-image (text (number->string T0) FONT "green") CTR-X CTR-Y MTS))

;; <Took template from Time.>
(define (render-time t)
  (cond [(and (> t 3) (< t 11))
         (place-image (text (number->string t) FONT "black") CTR-X CTR-Y MTS)]
        [(and (> t 0) (< t 4))
         (place-image (text (number->string t) FONT "red") CTR-X CTR-Y MTS)]
        [else
         (place-image (text (number->string t) FONT "green") CTR-X CTR-Y MTS)]))


;; Time KeyEvent -> Time
;; reset countdown to time 10 when space key is pressed

;; Stub:
#;
(define (handle-key-time t ke) 10)

;; Tests:
(check-expect (handle-key-time T4 " ") T4)
(check-expect (handle-key-time T3 " ") T4)
(check-expect (handle-key-time T3 "r") T3)
(check-expect (handle-key-time T0 " ") T4)
(check-expect (handle-key-time T0 "r") T0)

;; <Used template from Time.>
(define (handle-key-time t ke)
  (cond [(key=? ke " ") T4]
        [else t]))