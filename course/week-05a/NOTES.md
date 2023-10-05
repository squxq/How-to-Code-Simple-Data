# 5a: Naturals

## Module Overview

Learning Goals:

- Be able to design functions that operate on natural numbers.
- Be able to design a simple alternative representation for natural numbers.

## Natural Numbers

How many natural numbers are there? There is an arbitrary number of natural numbers.

```racket
(add1 0)
;; outputs 1

(add1 (add1 0))
;; outputs 2

(sub1 2)
;; outputs 1

(sub1 (sub1 2))
;; outputs 0
```

“add1” produces a natural number, N, greater than the given number, n, by 1: N=n+1. So it works similarly to “cons”, which produces a list 1 longer.

“sub1” produces a natural number, N, smaller than the given number, n, by 1: N=n-1. As “add1”, “sub1” works a little bit like “rest”, because “rest” takes a list that’s at least 1 long and gives you a list that’s 1 shorter.

A starter template for the Natural type:

```racket
;; Natural is one of:
;;  - 0
;;  - (add1 Natural)
;; interp. a natural number
(define N0 0)         ;0
(define N1 (add1 N0)) ;1
(define N2 (add1 N1)) ;2

(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... (fn-for-natural (sub1 n)))]))

;; Template rules used:
;;  - one-of: two cases
;;  - atomic distinct: 0
;;  - compound: (add1 Natural)
;;  - self-reference: (sub1 n) is Natural
```

> Design a function that consumes Natural number n and produces the sum of all
the naturals in [0, n].
> 

```racket
;; Natural -> Natural
;; produce sum of Natural[0, n]

;; Stub:
#;
(define (sum n) 0)

;; Tests:
(check-expect (sum 0) 0)
(check-expect (sum 1) 1)
(check-expect (sum 3) (+ 3 2 1 0))

;; Template:
;; <used template from Natural>

(define (sum n)
  (cond [(zero? n) 0]
        [else
         (+ n
          (sum (sub1 n)))]))
```

> Design a function that consumes Natural number n and produces a list of all
the naturals of the form (cons n (cons n-1 ... empty)) not including 0.
> 

```racket
;; Natural -> ListOfNatural
;; produce (cons n (cons n-1 ...empty)), not including 0

;; Stub:
#;
(define (to-list n) empty)

;; Tests:
(check-expect (to-list 0) empty)
(check-expect (to-list 1) (cons 1 empty))
(check-expect (to-list 2) (cons 2 (cons 1 empty)))

;; Template:
(define (to-list n)
  (cond [(zero? n) empty]
        [else
         (cons n
          (to-list (sub1 n)))]))
```

We ended up adding n to the template both times. Without it, there’s no easy “contribution of the first” in the template. So let’s augment the original template.

```racket
(define (fn-for-natural n)
  (cond [(zero? n) (...)]
        [else
         (... n ; template rules dont put this in
                ; but it seems to be used a lot so
                ; we added it
              (fn-for-natural (sub1 n)))]))
```

### Question 66: Sum to n

[sum-to-n-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/sum-to-n-starter.no-image.rkt)

> Design a function that produces the sum of all the naturals from 0 to a given n.
> 

```racket
;; Stub:
#;
(define (sum-all n) 0)

;; Tests:
(check-expect (sum-all 0) 0)
(check-expect (sum-all 10) 55)
(check-expect (sum-all 100) 5050)

;; Template:
#;
(define (sum-all n)
  (cond [(zero? n) 0]
        [else
         (... n
              (sum-all (sub1 n)))]))

(define (sum-all n)
  (cond [(zero? n) 0]
        [else
         (+ n
              (sum-all (sub1 n)))]))
```

### Question 67: Decreasing Image

[decreasing-image-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/decreasing-image-starter.no-image.rkt)

[decreasing-image-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/decreasing-image-starter.rkt)

> Design a function called decreasing-image that consumes a Natural n and produces an image of all the numbers from n to 0 side by side.

So (decreasing-image 3) should produce (open image file)
> 

```racket
;; ==========
;; Constants:

(define FONT-SIZE 20)
(define FONT-COLOR "black")

;; =================
;; Data Definitions:

;; Natural -> Image
;; produce an image of all the numbers from n to 0 side by side

;; Stub:
#;
(define (decreasing-image n) (square 0 "solid" "white"))

;; Tests:
(check-expect (decreasing-image 0) (text "0" FONT-SIZE FONT-COLOR))
(check-expect (decreasing-image 3)
              (beside (text "3" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "2" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "1" FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
                      (text "0" FONT-SIZE FONT-COLOR)))

;; Template:
#;
(define (decreasing-image n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (decreasing-image (sub1 n)))]))

(define (decreasing-image n)
  (cond [(zero? n) (text "0" FONT-SIZE FONT-COLOR)]
        [else
         (beside (text (number->string n) FONT-SIZE FONT-COLOR) (square 5 "solid" "white")
              (decreasing-image (sub1 n)))]))
```

### Question 68: Odd from n

[odd-from-n-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/odd-from-n-starter.no-image.rkt)

> Design a function called odd-from-n that consumes a natural number n, and produces a list of all the odd numbers from n down to 1.

Note that there is a primitive function, odd?, that produces true if a natural number is odd.
> 

```racket
;; ListOfNatural is one of:
;; - empty
;; - (cons Natural ListOfNatural)
;; interp. a list of natural numbers

;; Examples:
(define LON0 empty)
(define LON1 (cons 1 empty))
(define LON2 (cons 3 (cons 1 empty)))
(define LON3 (cons 5 (cons 3 (cons 1 empty))))
(define LON4 (cons 11 (cons 9 (cons 7 (cons 5 (cons 3 (cons 1 empty)))))))

;; Template:

(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Natural ListOfNatural)
;; - self-reference: (rest lon) is ListOfNatural

;; Natural -> ListOfNatural
;; produce a list of all the odd numbers (n = 2k + 1) from n down to 1

;; Stub:
#;
(define (odd-from-n n) LON0)

;; Tests:
;; Solution with one function
(check-expect (odd-from-n 0) LON0)
(check-expect (odd-from-n 1) LON1)
(check-expect (odd-from-n 2) LON1)
(check-expect (odd-from-n 4) LON2)
(check-expect (odd-from-n 5) LON3)
(check-expect (odd-from-n 11) LON4)

;; Solution with two functions (more performant)
(check-expect (odd-from-n-perf 0) LON0)
(check-expect (odd-from-n-perf 1) LON1)
(check-expect (odd-from-n-perf 2) LON1)
(check-expect (odd-from-n-perf 4) LON2)
(check-expect (odd-from-n-perf 5) LON3)
(check-expect (odd-from-n-perf 11) LON4)

;; Template:
#;
(define (odd-from-n n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (odd-from-n (sub1 n)))]))

;; Solution with one function
(define (odd-from-n n)
  (cond [(zero? n) empty]
        [else
         (if (odd? n)
             (cons n (odd-from-n (sub1 n)))
             (odd-from-n (sub1 n)))]))

;; Solution with two functions (more performant)
(define (odd-from-n-perf n)
  (cond [(odd? n) (odd-from-n-perf-layer n)]
        [(and (even? n) (not (= n 0))) (odd-from-n-perf-layer (sub1 n))]
        [else empty]))

(define (odd-from-n-perf-layer n)
  (cond [(= n 1) (cons 1 empty)]
        [else
         (cons n
              (odd-from-n-perf-layer (- n 2)))]))
```

### Question 69: Concentric Circles

[concentric-circles-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/concentric-circles-starter.no-image.rkt)

[concentric-circles-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05a/course/week-05a/naturalNumbers/concentric-circles-starter.rkt)

> Design a function that consumes a natural number n and a color c, and produces n
concentric circles of the given color.

So (concentric-circles 5 "black") should produce (open image file)
> 

```racket
;; Natural Color -> Image
;; produce given natural number, n, concentric circles of given color, c

;; Stub:
#;
(define (concentric-circles n c) (circle 0 "outline" "white"))

;; Tests:
(check-expect (concentric-circles 0 "black") (circle 0 "outline" "black"))
(check-expect (concentric-circles 1 "black")
              (overlay (circle (* 1 10) "outline" "black") (circle 0 "outline" "black")))
(check-expect (concentric-circles 2 "black")
              (overlay (circle (* 2 10) "outline" "black") (circle (* 1 10) "outline" "black")
                       (circle 0 "outline" "black")))
(check-expect (concentric-circles 3 "black")
              (overlay (circle (* 3 10) "outline" "black") (circle (* 2 10) "outline" "black")
                       (circle (* 1 10) "outline" "black") (circle 0 "outline" "black")))

;; Template:
#;
(define (concentric-circles n)
  (cond [(zero? n) (...)]
        [else
         (... n
              (concentric-circles (sub1 n)))]))

(define (concentric-circles n c)
  (cond [(zero? n) (circle n "outline" c)]
        [else
         (overlay (circle (* n 10) "outline" c)
              (concentric-circles (sub1 n) c))]))
```

## A Parlor Trick

> Your friend has just given you a new pad, and it runs a prototype version of Racket.
> 
> 
> This is great, you can make it do anything. There's just one problem, this version of
> racket doesn't include numbers as primitive data. There just are no numbers in it!
> 
> But you need natural numbers to write your next program.
> 
> No problem you say, because you remember the well-formed self-referential data definition
> for Natural, as well as the idea that add1 is kind of like cons, and sub1 is kind of like
> rest. Your idea is to make add1 actually be cons, and sub1 actually be rest...
> 

Data Definition:

```racket
;; NATURAL is one of:
;; - empty
;; - (cons "!" NATURAL)
;; interp. a natural number, the number of "!" in the list is the number

;; Examples:
(define N0 empty)         ; 0
(define N1 (cons "!" N0)) ; 1
(define N2 (cons "!" N1)) ; 2
(define N3 (cons "!" N2)) ; 3
(define N4 (cons "!" N3)) ; 4
(define N5 (cons "!" N4)) ; 5
(define N6 (cons "!" N5)) ; 6
(define N7 (cons "!" N6)) ; 7
(define N8 (cons "!" N7)) ; 8
(define N9 (cons "!" N8)) ; 9

;; These are the primitives that operate on NATURAL:
(define (ZERO? n) (empty? n))     ; Any -> Boolean
(define (ADD1 n) (cons "!" n))    ; NATURAL -> NATURAL
(define (SUB1 n) (rest n))        ; NATURAL[>0] -> NATURAL

;; Template:
(define (fn-for-NATURAL n)
  (cond [(ZERO? n) (...)]
        [else
         (... n
              (fn-for-NATURAL (SUB1 n)))]))
```

Function Definitions:

```racket
;; NATURAL NATURAL -> NATURAL
;; produce a + b

;; Stub:
#;
(define (ADD a b) N0)

;; Tests:
(check-expect (ADD N2 N0) N2)
(check-expect (ADD N0 N3) N3)
(check-expect (ADD N3 N4) N7)

;; Template: <took template from NATURAL>

(define (ADD a b)
  (cond [(ZERO? b) a]
        [else
         (ADD (ADD1 a) (SUB1 b))]))

;; NATURAL NATURAL -> NATURAL
;; produce a - b

;; Stub:
#;
(define (SUB a b) N0)

;; Tests:
(check-expect (SUB N2 N0) N2)
(check-expect (SUB N7 N3) N4)

;; Template: <took template from NATURAL>

(define (SUB a b)
  (cond [(ZERO? b) a]
        [else
         (SUB (SUB1 a) (SUB1 b))]))
```

Multiplication and factorial functions:

```racket
;; NATURAL NATURAL -> NATURAL
;; produce a * b for given natural numbers

;; Stub:
#;
(define (TIMES a b) N0)

;; Tests:
(check-expect (TIMES N0 N2) N0)
(check-expect (TIMES N2 N0) N0)
(check-expect (TIMES N2 N4) N8)

;; Template: <took template from NATURAL>

(define (TIMES a b)
  (cond [(ZERO? b) empty]
        [else
         (ADD a
              (TIMES a (SUB1 b)))]))

;; NATURAL -> NATURAL
;; produce a!, given natural number a

;; Stub:
#;
(define (FACTORIAL a) N0)

;; Tests:
(check-expect (FACTORIAL N0) N1)
(check-expect (FACTORIAL N1) N1)
(check-expect (FACTORIAL N3) N6)

;; Template: <took template from NATURAL>

(define (FACTORIAL n)
  (cond [(ZERO? n) (cons "!" empty)]
        [else
         (TIMES n
              (FACTORIAL (SUB1 n)))]))
```