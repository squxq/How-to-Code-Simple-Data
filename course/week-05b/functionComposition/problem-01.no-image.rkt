;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)

;The questions in the next view videos will walk you through the design of a function called arrange-strings,    
;which consumes an arbitrary number of strings and lays them out vertically in alphabetical order.

;; Constants:

(define TEXT-SIZE 24)
(define TEXT-COLOR "black")

;; Data Definitions:

;; ListOfString is one of:
;; - empty
;; - (cons String ListOfString)
;; interp. a list of strings

;; Examples:
(define LOS0 empty)
(define LOS1 (cons "John" empty))
(define LOS2 (cons "John" (cons "Anne" empty)))
(define LOS3 (cons "John" (cons "Anne" (cons "Peter" empty))))

;; Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else (...
         (first los)
         (fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons String ListOfString)
;; - self-reference: (rest los) is ListOfString

;; Function Definitions:

;; ListOfString -> Image
;; produce all the given strings in alphabetical order vertically

;; Stub:
#;
(define (arrange-strings los) empty-image)

;; Tests:
(check-expect (arrange-strings LOS1)
              (text "John" TEXT-SIZE TEXT-COLOR))
(check-expect (arrange-strings LOS2)
              (above (text "Anne" TEXT-SIZE TEXT-COLOR) (text "John" TEXT-SIZE TEXT-COLOR)))
(check-expect (arrange-strings LOS3)
              (above (text "Anne" TEXT-SIZE TEXT-COLOR) (text "John" TEXT-SIZE TEXT-COLOR) (text "Peter" TEXT-SIZE TEXT-COLOR)))

;; Template: <used template from ListOfString>
#;
(define (fn-for-los los)
  (fn-for-render-strings (fn-for-order-strings los)))

(define (arrange-strings los)
  (render-strings (order-strings los)))


;; ListOfString -> ListOfString
;; order the given list of strings alphabetically (a-z)

;; Stub:
#;
(define (order-strings los) los)

;; Tests:
(check-expect (order-strings LOS1) LOS1)
(check-expect (order-strings LOS2) (cons "Anne" (cons "John" empty)))
(check-expect (order-strings LOS3) (cons "Anne" (cons "John" (cons "Peter" empty))))

;; Template: <used template from ListOfString>
#;
(define (fn-for-los los)
  (fn-for-insertion-sort los empty))

(define (order-strings los)
  (insertion-sort los empty))


;; ListOfString ListOfString -> ListOfString
;; order the given list of strings, unsorted, alphabetically (a-z) and place the results in the given list, sorted
;; ASSUME: the second given list of strings is always empty

;; Stub:
#;
(define (insertion-sort unsorted sorted) empty)

;; Tests:
(check-expect (insertion-sort empty empty) empty)
(check-expect (insertion-sort LOS2 empty) (cons "Anne" (cons "John" empty)))
(check-expect (insertion-sort LOS3 empty) (cons "Anne" (cons "John" (cons "Peter" empty))))

;; Template: <used template from ListOfString>
#;
(define (fn-for-los los1 los2)
  (cond [(empty? los1) (... los2)]
        [else (... los2
         (first los1)
         (fn-for-los (rest los1)))]))

(define (insertion-sort unsorted sorted)
  (cond [(empty? unsorted) sorted]
        [else (insertion-sort (rest unsorted)
         (insert (first unsorted) sorted))]))


;; String ListOfString -> ListOfString
;; insert given string, s, into given list of strings, los, maintaining the alphabetic order

;; Stub:
#;
(define (insert s los) los)

;; Tests:
(check-expect (insert "John" empty)
              (cons "John" empty))
(check-expect (insert "John" (cons "Anne" (cons "Peter" empty)))
              (cons "Anne" (cons "John" (cons "Peter" empty))))
(check-expect (insert "John" (cons "Anne" empty))
              (cons "Anne" (cons "John" empty)))
(check-expect (insert "John" (cons "Peter" empty))
              (cons "John" (cons "Peter" empty)))

;; Template: <used template from ListOfString>
#;
(define (fn-for-los s los)
  (cond [(empty? los) (... s)]
        [else (... s
         (first los)
         (fn-for-los s (rest los)))]))

(define (insert s los)
  (cond [(empty? los) (cons s empty)]
        [(string<=? s (first los)) (cons s los)]
        [else (cons (first los) (insert s (rest los)))]))


;; ListOfString -> Image
;; produce the given list of strings, los, vertically in an image

;; Stub:
#;
(define (render-strings los) los)

;; Tests:
(check-expect (render-strings LOS0) empty-image)
(check-expect (render-strings LOS1)
              (text "John" TEXT-SIZE TEXT-COLOR))
(check-expect (render-strings (cons "John" (cons "Peter" empty)))
              (above (text "John" TEXT-SIZE TEXT-COLOR) (text "Peter" TEXT-SIZE TEXT-COLOR)))
(check-expect (render-strings (cons "Anne" (cons "John" (cons "Peter" empty))))
              (above (text "Anne" TEXT-SIZE TEXT-COLOR) (text "John" TEXT-SIZE TEXT-COLOR) (text "Peter" TEXT-SIZE TEXT-COLOR)))

;; Template: <used template from ListOfString>

(define (render-strings los)
  (cond [(empty? los) empty-image]
        [else
         (above (text (first los) TEXT-SIZE TEXT-COLOR)
         (render-strings (rest los)))]))