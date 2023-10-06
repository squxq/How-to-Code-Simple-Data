;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Naturals-and-Helpers-Design-Quiz.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; SPD2-Design-Quiz-1.rkt


;; ======================================================================
;; Constants
(define COOKIES (circle 20 "solid" "brown")) ; open image file

;; ======================================================================
;; Data Definitions

;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number

;; Examples:
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

;; Template:
#;
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n   ; n is added because it's often useful                   
              (fn-for-natural (sub1 n)))]))

;; Template rules used:
;;  - one-of: two cases
;;  - atomic distinct: 0
;;  - compound: 2 fields
;;  - self-reference: (sub1 n) is Natural


;PROBLEM 1:
;
;Complete the design of a function called pyramid that takes a natural
;number n and an image, and constructs an n-tall, n-wide pyramid of
;copies of that image.
;
;For instance, a 3-wide pyramid of cookies would look like this:
;
;(open image file)

;; ======================================================================
;; Function Definitions

;; Natural Image -> Image
;; produce an n-wide pyramid of the given image

;; Stub:
#;
(define (pyramid n i) empty-image)

;; Tests:
(check-expect (pyramid 0 COOKIES) empty-image)
(check-expect (pyramid 1 COOKIES) COOKIES)
(check-expect (pyramid 3 COOKIES)
              (above COOKIES
                     (beside COOKIES COOKIES)
                     (beside COOKIES COOKIES COOKIES)))

;; Template: <used template from Natural>
#;
(define (fn-for-natural n img)
  (cond [(zero? n) (... img)]
        [else
         (... n img                
              (fn-for-natural (sub1 n) (... img)))]))

(define (pyramid n img)
  (cond [(zero? n) empty-image]
        [else (above (pyramid (sub1 n) img)
                     (row n img))]))


;; Natural Image -> Image
;; produce given natural number, n, images side by side
;; ASSUME Natural >= 1

;; Stub:
#;
(define (row n img) empty-image)

;; Tests:
(check-expect (row 4 COOKIES)
              (beside COOKIES COOKIES COOKIES COOKIES))
(check-expect (row 1 COOKIES)
              COOKIES)

;; Template: <used template from Natural>
#;
(define (fn-for-natural n img)
  (cond [(= n 1) (... img)]
        [else
         (... n img                
              (fn-for-natural (sub1 n) (... img)))]))

(define (row n img)
  (cond [(= n 1) img]
        [else (beside img (row (sub1 n) img))]))


;Problem 2:
;Consider a test tube filled with solid blobs and bubbles. Over time the
;solids sink to the bottom of the test tube, and as a consequence the bubbles
;percolate to the top.  Let's capture this idea in BSL.
;
;Complete the design of a function that takes a list of blobs and sinks each
;solid blob by one. It's okay to assume that a solid blob sinks past any
;neighbor just below it.
;
;To assist you, we supply the relevant data definitions.

;; ======================================================================
;; Data Definitions

;; Blob is one of:
;; - "solid"
;; - "bubble"
;; interp.  a gelatinous blob, either a solid or a bubble

;; Examples: <examples are redundant for enumerations>

;; Template:
#;
(define (fn-for-blob b)
  (cond [(string=? b "solid") (...)]
        [(string=? b "bubble") (...)]))

;; Template rules used:
;; - one-of: 2 cases
;; - atomic distinct: "solid"
;; - atomic distinct: "bubble"


;; ListOfBlob is one of:
;; - empty
;; - (cons Blob ListOfBlob)
;; interp. a sequence of blobs in a test tube, listed from top to bottom.

;; Examples:
(define LOB0 empty) ; empty test tube
(define LOB2 (cons "solid" (cons "bubble" empty))) ; solid blob above a bubble

;; Template:
#;
(define (fn-for-lob lob)
  (cond [(empty? lob) (...)]
        [else
         (... (fn-for-blob (first lob))
              (fn-for-lob (rest lob)))]))

;; Template rules used
;; - one-of: 2 cases
;; - atomic distinct: empty
;; - compound: 2 fields
;; - reference: (first lob) is Blob
;; - self-reference: (rest lob) is ListOfBlob

;; ======================================================================
;; Function Definitions

;; ListOfBlob -> ListOfBlob
;; produce a list of blobs that sinks the given solid blobs by one

;; Stub:
#;
(define (sink lob) empty)

;; Tests:
(check-expect (sink (cons "bubble" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "bubble" (cons "solid" empty))))
(check-expect (sink (cons "solid" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "solid" (cons "bubble" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "bubble" empty))))
(check-expect (sink (cons "solid" (cons "bubble" (cons "solid" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "bubble" (cons "solid" (cons "solid" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))
(check-expect (sink (cons "solid"
                          (cons "solid"
                                (cons "bubble" (cons "bubble" empty)))))
              (cons "bubble" (cons "solid" 
                                   (cons "solid" (cons "bubble" empty)))))

;; Template:
#;
(define (fn-for-lob lob)
  (fn-for-sink-blobs (fn-for-reverse-list lob)))

(define (sink lob)
  (reverse-list (sink-blobs (reverse-list lob))))


;; ListOfBlob -> ListOfBlob
;; reverse the order of the given list of blobs in a test tube

;; Stub:
#;
(define (reverse-list lob) lob)

;; Tests:
(check-expect (reverse-list empty) empty)
(check-expect (reverse-list (cons "bubble" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "bubble" empty))))
(check-expect (reverse-list LOB2)
              (cons "bubble" (cons "solid" empty)))
(check-expect (reverse-list (cons "solid" (cons "solid" (cons "bubble" empty))))
              (cons "bubble" (cons "solid" (cons "solid" empty))))

;; Template: <took template from ListOfBlob>

(define (reverse-list lob)
  (cond [(empty? lob) empty]
        [else
         (append (reverse-list (rest lob)) (list (first lob)))]))


;; ListOfBlob -> ListOfBlob
;; sink one of the solid blobs in the given list of blobs and return the new list
;; ASSUME: the give nlist of blobs is in the right order (reverse the original)

;; Stub:
#;
(define (sink-blobs lob) lob)

;; Tests:
(check-expect (sink-blobs empty) empty)
(check-expect (sink-blobs (cons "solid" (cons "bubble" empty)))
              (cons "solid" (cons "bubble" empty)))
(check-expect (sink-blobs (cons "bubble" (cons "solid" (cons "solid" empty))))
              (cons "solid" (cons "solid" (cons "bubble" empty))))
(check-expect (sink-blobs (cons "bubble" (cons "solid" (cons "bubble" empty))))
              (cons "solid" (cons "bubble" (cons "bubble" empty))))
(check-expect (sink-blobs (cons "bubble" (cons "bubble" (cons "solid" empty))))
              (cons "bubble" (cons "solid" (cons "bubble" empty))))
(check-expect (sink-blobs (cons "solid" (cons "bubble" (cons "solid" empty))))
              (cons "solid" (cons "solid" (cons "bubble" empty))))
(check-expect (sink-blobs (cons "solid" (cons "solid" (cons "bubble" empty))))
              (cons "solid" (cons "solid" (cons "bubble" empty))))
(check-expect (sink-blobs (cons "bubble"
                          (cons "bubble"
                                (cons "solid" (cons "solid" empty)))))
              (cons "bubble" (cons "solid" 
                                   (cons "solid" (cons "bubble" empty)))))

;; Template: <used template from ListOfBlob>

(define (sink-blobs lob)
  (cond [(empty? lob) empty]
        [else
         (if (and (not (empty? (rest lob))) (bubble-solid? (first lob) (first (rest lob))))
              (cons (first (rest lob)) (sink-blobs (cons (first lob) (rest (rest lob)))))
              (cons (first lob) (sink-blobs (rest lob))))]))


;; Blob Blob -> Boolean
;; produce true if the first given blob, b1, is a "bubble" and the other given blob, b2, is a "solid"

;; Stub:
#;
(define (bubble-solid? b1 b2) false)

;; Tests:
(check-expect (bubble-solid? "bubble" "bubble") false)
(check-expect (bubble-solid? "bubble" "solid") true)
(check-expect (bubble-solid? "solid" "bubble") false)
(check-expect (bubble-solid? "solid" "solid") false)

;; Template: <used template from blob>
#;
(define (fn-for-blob b1 b2)
  (cond [(and (string=? b1 "bubble") (string=? b2 "solid")) (...)]
        [else (...)]))

(define (bubble-solid? b1 b2)
  (and (string=? b1 "bubble") (string=? b2 "solid")))