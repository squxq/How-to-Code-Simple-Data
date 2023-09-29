;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname simple-text-editor-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; simple-text-editor-starter.rkt

; In this problem, you will be designing a simple one-line text editor.
; 
; The constants and data definitions are provided for you, so make sure 
; to take a look through them after completing your own Domain Analysis. 
; 
; Your text editor should have the following functionality:
; - when you type, characters should be inserted on the left side of the cursor 
; - when you press the left and right arrow keys, the cursor should move accordingly  
; - when you press backspace (or delete on a mac), the last character on the left of 
;   the cursors should be deleted


(require 2htdp/image)
(require 2htdp/universe)

;; A simple editor

;; Constants
;; =========

(define WIDTH 1600)
(define HEIGHT 20)
(define MTS (empty-scene WIDTH HEIGHT))

(define CURSOR (rectangle 2 14 "solid" "red"))

(define TEXT-SIZE 14)
(define TEXT-COLOUR "black")

(define ALLOWED-CHARACTERS
  (list
   "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
   "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
   "0" "1" "2" "3" "4" "5" "6" "7" "8" "9"
   " " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/" ":" ";" "<" "=" ">" "?" "@" "[" "\\" "]" "^" "_" "`" "{" "|" "}" "~"
   ))

;; Data Definitions
;; ================

(define-struct editor (pre post))
;; Editor is (make-editor String String)
;; interp. pre is the text before the cursor, post is the text after

;; Examples:
(define E0 (make-editor "" ""))
(define E1 (make-editor "a" ""))
(define E2 (make-editor "" "b"))

;; Template:
#;
(define (fn-for-editor e)
  (... (editor-pre e)       ; String
       (editor-post e)))    ; String

;; Template rules used:
;; - compound rule: 2 fields


;; Function Definitions
;; ====================

;; Editor -> Editor
;; start the world with: (main (make-editor "" ""))

(define (main e)
  (big-bang e                       ; Editor
    (to-draw render-editor)         ; Editor -> Image
    (on-key handle-key-editor)))    ; Editor KeyEvent -> Editor


;; Editor -> Image
;; render editor on the screen

;; Stub:
#;
(define (render-editor e) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-editor E0)
              (overlay/align "left" "middle"
                             (beside (rectangle 2 HEIGHT "solid" "transparent")
                                     (text (editor-pre E0) TEXT-SIZE TEXT-COLOUR) CURSOR (text (editor-post E0) TEXT-SIZE TEXT-COLOUR)
                                     (rectangle 2 HEIGHT "solid" "transparent")) MTS))
(check-expect (render-editor E1)
              (overlay/align "left" "middle"
                             (beside (rectangle 2 HEIGHT "solid" "transparent")
                                     (text (editor-pre E1) TEXT-SIZE TEXT-COLOUR) CURSOR (text (editor-post E1) TEXT-SIZE TEXT-COLOUR)
                                     (rectangle 2 HEIGHT "solid" "transparent")) MTS))
(check-expect (render-editor E2)
              (overlay/align "left" "middle"
                             (beside (rectangle 2 HEIGHT "solid" "transparent")
                                     (text (editor-pre E2) TEXT-SIZE TEXT-COLOUR) CURSOR (text (editor-post E2) TEXT-SIZE TEXT-COLOUR)
                                     (rectangle 2 HEIGHT "solid" "transparent")) MTS))

;; <Used template from Editor>

(define (render-editor e)
  (overlay/align "left" "middle"
                 (beside (rectangle 2 HEIGHT "solid" "transparent")
                         (text (editor-pre e) TEXT-SIZE TEXT-COLOUR) CURSOR (text (editor-post e) TEXT-SIZE TEXT-COLOUR)
                         (rectangle 2 HEIGHT "solid" "transparent")) MTS))


;; Editor KeyEvent -> Editor
;; handle key presses on the editor:
;;        any letter or number should be inserted on the left side of the cursor
;;        left and arrow keys move the cursor accordingly
;;        backspace (or delete on a mac) the last character on the left of the cursor is deleted

;; Stub: 
#;
(define (handle-key-editor e ke) E0)

;; Tests:
(check-expect (handle-key-editor E0 "a") (make-editor "a" ""))
(check-expect (handle-key-editor (make-editor "a" "") "left") (make-editor "" "a"))
(check-expect (handle-key-editor (make-editor "" "a") "right") (make-editor "a" ""))
(check-expect (handle-key-editor (make-editor "a" "") "\b") (make-editor "" ""))
(check-expect (handle-key-editor E0 "\u007F") (make-editor "" ""))

(check-expect (handle-key-editor E1 "r") (make-editor "ar" ""))
(check-expect (handle-key-editor (make-editor "ar" "") "left") (make-editor "a" "r"))
(check-expect (handle-key-editor (make-editor "a" "r") "right") (make-editor "ar" ""))
(check-expect (handle-key-editor (make-editor "ar" "") "\b") (make-editor "a" ""))
(check-expect (handle-key-editor (make-editor "ar" "") "right") (make-editor "ar" ""))

(check-expect (handle-key-editor E2 "2") (make-editor "2" "b"))
(check-expect (handle-key-editor (make-editor "2" "b") "left") (make-editor "" "2b"))
(check-expect (handle-key-editor (make-editor "" "2b") "right") (make-editor "2" "b"))
(check-expect (handle-key-editor (make-editor "2" "b") "\b") (make-editor "" "b"))
(check-expect (handle-key-editor (make-editor "" "2b") "left") (make-editor "" "2b"))

;; Template:
#;
(define (handle-key-editor e ke)
  (cond [(key=? ke "left") (... (editor-pre e) (editor-post e))]
        [(key=? ke "right") (... (editor-pre e) (editor-post e))]
        [(key=? ke "\u007F") (... (editor-pre e) (editor-post e))]
        [else (... (editor-pre e) (editor-post e))]))

(define (handle-key-editor e ke)
  (cond [(and (key=? ke "left") (> (string-length (editor-pre e)) 0))
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (string-append (substring (editor-pre e) (- (string-length (editor-pre e)) 1) (string-length (editor-pre e))) (editor-post e)))]
        [(and (key=? ke "right") (> (string-length (editor-post e)) 0))
         (make-editor (string-append (editor-pre e) (substring (editor-post e) 0 1))
                      (substring (editor-post e) 1 (string-length (editor-post e))))]
        [(and (key=? ke "\b") (> (string-length (editor-pre e)) 0))
         (make-editor (substring (editor-pre e) 0 (- (string-length (editor-pre e)) 1))
                      (editor-post e))]
        [(member ke ALLOWED-CHARACTERS)
         (make-editor (string-append (editor-pre e) ke) (editor-post e))]
        [else e]))