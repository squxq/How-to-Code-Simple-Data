# 5b: Helpers

## Module Overview

Learning Goals:

Be able to design functions that use helper functions for each of the following reasons:

- at references to other non-primitive data definitions (this will be in the template)
- to form a function composition
- to handle a knowledge domain shift
- to operate on arbitrary sized data

## Introduction

The key to solving complex design problems is to break them down into smaller pieces to be tractable. The recipes already do that: the data recipe breaks data design down into individual steps; the function recipe does the same and so does the world recipe. We are going to look at more examples of how we break types and functions down into multiple types and multiple functions.

## Function Composition

[functionComposition.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/functionComposition/functionComposition.no-image.rkt)

> In this problem imagine you have a bunch of pictures that you would like to
store as data and present in different ways. We'll do a simple version of that
here, and set the stage for a more elaborate version later.
> 
> 
> (A) Design a data definition to represent an arbitrary number of images.
> 
> (B) Design a function called arrange-images that consumes an arbitrary number
> of images and lays them out left-to-right in increasing order of size.
> 

First, we have to design a data definition to represent an arbitrary number of images. And then we’ll design a function to arrange those images in a nice way.

```racket
;; Data Definitions:

;; ListOfImage is one of:
;; - empty
;; - (cons Image ListOfImage)
;; interp. a list of images

;; Examples:
(define LOI0 empty)
(define LOI1 (cons (square 10 "solid" "blue") empty))
(define LOI2 (cons (rectangle 10 20 "solid" "blue")
                   (cons (rectangle 20 30 "solid" "green"))))

;; Template:
#;
(define (fn-for-loi loi)
  (cond [(empty? loi) (...)]
        [else
         (... (first loi)
              (fn-for-loi (rest loi)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Image ListOfImage)
;; - self-reference: (rest loi)
```

Function Definition:

```racket
;; Function Definitions

;; ListOfImage -> Image
;; lay out images left to right in increasing order of size, which means:
;; sort images in increasing order of size and then lay them out left to right

;; Stub:
#;
(define (arrange-images loi) BLANK)

;; Tests:
(check-expect (arrange-images empty) BLANK)
(check-expect (arrange-images LOI1)
                              (beside (square 10 "solid" "blue") BLANK))
(check-expect (arrange-images LOI2)
                              (beside (rectangle 10 20 "solid" "blue")
                                      (rectangle 20 30 "solid" "green") BLANK))
```

First, entire list must be sorted, then images must be laid out.

```racket
;; Template:
#;
(define (fn-for-loi loi)
  (fn-for-loi-comp-1 (fn-for-loi-comp-2 loi)))

(define (arrange-images loi)
  (layout-images (sort-images loi)))

;; ListOfImage -> Image
;; place images beside each other in order of list
;; !!!
;; Stub:
(define (layout-images loi) BLANK)

;; ListOfImage -> ListOfImage
;; sort images in increasing order of size
;; !!!
;; Stub:
(define (sort-images loi) loi)
```

Making the stub produce its argument will make the stub a little more useful in at least some early tests of “arrange-images”.

Tests for “arrange-images” do not need to fully exercise “layout-images” and “sort-images”, but they do need to exercise the combination of the two functions. They don’t have to exhaustively test the individual functions. The tests for “layout-images” will test “layout-images” and the tests for “sort-images” will test “sort-images”. The tests for “arrange-images” have to make sure that “arrange-images” is called “layout-images” and “sort-images”.

```racket
;; Tests:
;(check-expect (arrange-images empty) BLANK)
;; there is no need to test the base case

;; these tests are not good enout because they don't check that the list is both sorted and laid out
(check-expect (arrange-images LOI1)
                              (beside (square 10 "solid" "blue") BLANK))
(check-expect (arrange-images LOI2)
                              (beside (rectangle 10 20 "solid" "blue")
                                      (rectangle 20 30 "solid" "green") BLANK))
(check-expect (arrange-images (cons (rectangle 20 30 "solid" "green")
                                    (cons (rectangle 10 20 "solid" "blue") empty)))
                              (beside (rectangle 10 20 "solid" "blue")
                                      (rectangle 20 30 "solid" "green") BLANK))
```

We should use a function composition when a single function must perform two or more complete operations on the entire consumed data.

### Question 70: Problem 1

> The questions in the next view videos will walk you through the design of a function called arrange-strings, which consumes an arbitrary number of strings and lays them out vertically in alphabetical order.
> 

```racket
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
```

## Laying Out a List of Images

[layingOutImages.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/layingOutImages/layingOutImages.no-image.rkt)

```racket
;; ListOfImage -> Image
;; place images beside each other in order of list

;; Stub:
#;
(define (layout-images loi) BLANK)

;; Tests:
(check-expect (layout-images LOI0) BLANK)
(check-expect (layout-images LOI1) (beside (square 10 "solid" "blue") BLANK))
(check-expect (layout-images LOI2) (beside (rectangle 10 20 "solid" "blue")
                      (rectangle 20 30 "solid" "green") BLANK))

;; Template: <used template from ListOfImage>

(define (layout-images loi)
  (cond [(empty? loi) BLANK]
        [else
         (beside (first loi)
              (layout-images (rest loi)))]))
```

## Operating on a List

[operatingList.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/operatingList/operatingList.no-image.rkt)

If I’m coding a function and I reach a point where I need to operate on a list - not just the first element of the list, but the whole list, or at least potentially the whole list - then I need a helper function to do that.

```racket
;; ListOfImage -> ListOfImage
;; sort images in increasing order of size (area)

;; Stub:
#;
(define (sort-images loi) loi)

;; Tests:
(check-expect (sort-images empty) empty)
(check-expect (sort-images LOI1) LOI1)
(check-expect (sort-images LOI2) LOI2)
(check-expect (sort-images (cons (rectangle 20 30 "solid" "green")
                                 (cons (rectangle 10 20 "solid" "blue") empty))) LOI2)
(check-expect (sort-images (cons (rectangle 40 60 "solid" "red") (cons (rectangle 20 30 "solid" "green")
                                 (cons (rectangle 10 20 "solid" "blue") empty))))
              (cons (rectangle 10 20 "solid" "blue") (cons (rectangle 20 30 "solid" "green")
                                 (cons (rectangle 40 60 "solid" "red") empty))))
```

If I need to operate on arbitrary size data, I have to use a function to do it, because I don’t know how far into the data I have to go as part of the operation.

```racket
;; Template: <used template from ListOfImage>

(define (sort-images loi)
  (cond [(empty? loi) empty]
        [else
         (insert (first loi)
              (sort-images (rest loi)))])) ; result of natural recursion will be sorted

;; Image ListOfImage -> ListOfImage
;; insert given image in proper place in given list of image (in increasing order of size)
;; !!!
;; Stub:
(define (img lst) lst)
```

Sometimes the signature can’t say everything that matters about the consumed data. In those cases, we can write an assumption as part of the function design.

```racket
;; Image ListOfImage -> ListOfImage
;; insert given image in proper place in given list of image (in increasing order of size)
;; ASSUME: lst is already sorted
;; !!!
;; Stub:
(define (insert img lst) lst)
```

## Domain Knowledge Shift

[domainKnowledgeShift.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/domainKnowledgeShift/domainKnowledgeShift.no-image.rkt)

When the body of a function must shift to a new knowledge domain it should call a helper function to do the work in the new domain.

```racket
;; Stub:
#;
(define (insert img loi) loi)

;; Tests:
(check-expect (insert I1 empty) (cons I1 empty))                                         ; beginning 
(check-expect (insert I1 (cons I2 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; beginning
(check-expect (insert I2 (cons I1 (cons I3 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; middle
(check-expect (insert I3 (cons I1 (cons I2 empty))) (cons I1 (cons I2 (cons I3 empty)))) ; end
```

When designing functions that consume additional atomic parameters, the name of that parameter gets added after every (…) in the template.

```racket
;; Template: <used template from ListOfImage>
#;
(define (insert img loi)
  (cond [(empty? loi) (... img)]
        [else
         (... img (first loi)
              (insert (... img) (rest loi)))]))

(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (<isbigger?> img (first loi))
              (insert (... img) (rest loi)))]))
```

The function “insert” is about inserting into a sorted list while <isbigger?> is about comparing the sizes of 2 images. This is a knowledge domain shift.

```racket
(define (insert img loi)
  (cond [(empty? loi) (cons img empty)]
        [else
         (if (larger? img (first loi))
             (cons (first loi) (insert img (rest loi)))
             (cons img loi))]))

;; Image Image -> Boolean
;; produce true if given img1 is larger than given img2 (by area)
;; !!!
;; Stub:
(define (larger? img1 img2) true)
```

Some named constants make the tests more compact. We made sure to make tests/examples of all insert cases. Function body involved knowledge domain shift from inserting into a list to comparing the size of images. This caused us to use a helper.

## The Last Helper

[lastHelper.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/lastHelper/lastHelper.no-image.rkt)

larger? must:

- consume 2 images
- operate on width and height of both images

Its easy to make mistakes like:

- using the same image twice
- using width twice instead of width and height

```racket
;; Image Image -> Boolean
;; produce true if given img1 is larger than given img2 (by area)
;; !!!
;; Stub:
#;
(define (larger? img1 img2) true)

;; Tests:
(check-expect (larger? I1 I2) false)
(check-expect (larger? I1 I3) false)
(check-expect (larger? I2 I1) true)
(check-expect (larger? I3 I1) true)
(check-expect (larger? I2 I3) false)
(check-expect (larger? I3 I2) true)
(check-expect (larger? (rectangle 3 4 "solid" "red") (rectangle 2 6 "solid" "red")) false)

;; Template:
#;
(define (larger? img1 img2)
  (... img1 img2))

(define (larger? img1 img2)
  (> (* (image-width img1) (image-height img1))
     (* (image-width img2) (image-height img2))))
```

Some helper rules:

- Function composition rule;
- Rule on operating on arbitrary size data;
- Knowledge domain shift.

### Question 71: Render Roster

[render-roster-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/lastHelper/render-roster-starter.no-image.rkt)

[render-roster-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/lastHelper/render-roster-starter.rkt)

> You are running a dodgeball tournament and are given a list of all
of the players in a particular game as well as their team numbers.
> 
> 
> You need to build a game roster like the one shown below. We've given
> you some constants and data definitions for Player, ListOfPlayer
> and ListOfString to work with.
> 
> While you're working on these problems, make sure to keep your
> helper rules in mind and use helper functions when necessary.
> 
> (open image file)
> 

```racket
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
```

> Design a function called select-players that consumes a list
of players and a team t (Natural[1,2]) and produces a list of
players that are on team t.
> 

```racket
;; Functions
;; ---------

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
```

> Complete the design of render-roster. We've started you off with
the signature, purpose, stub and examples. You'll need to use
the function that you designed in Problem 1.

Note that we've also given you a full function design for render-los
and its helper, render-cell. You will need to use these functions
when solving this problem.
> 

```racket
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
```

### Question 72: Making Rain Filtered

[making-rain-filtered-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/lastHelper/making-rain-filtered-starter.no-image.rkt)

[making-rain-filtered-starter.png](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/lastHelper/making-rain-filtered-starter.png)

> Design a simple interactive animation of rain falling down a screen. Wherever we click,
a rain drop should be created and as time goes by it should fall. Over time the drops
will reach the bottom of the screen and "fall off". You should filter these excess
drops out of the world state - otherwise your program is continuing to tick and
and draw them long after they are invisible.

In your design pay particular attention to the helper rules. In our solution we use
these rules to split out helpers:
  - function composition
  - reference
  - knowledge domain shift
> 
> 
> NOTE: This is a fairly long problem.  While you should be getting more comfortable with
> world problems there is still a fair amount of work to do here. Our solution has 9
> functions including main. If you find it is taking you too long then jump ahead to the
> next homework problem and finish this later.
> 

![Making Rain Filtered](lastHelper/making-rain-filtered-starter.png)

```racket
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
```

## Quiz

[Naturals-and-Helpers-Design-Quiz.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/quiz/Naturals-and-Helpers-Design-Quiz.no-image.rkt)

[Naturals-and-Helpers-Design-Quiz.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-05b/course/week-05b/quiz/Naturals-and-Helpers-Design-Quiz.rkt)

This design quiz will have 3 phases:

- First you will design a solution to a given problem.
- Second, you will watch an assessment tutorial video.
- Finally, you will submit a self-assessment of your completed function design.

> Complete the design of a function called pyramid that takes a natural
number n and an image, and constructs an n-tall, n-wide pyramid of
copies of that image.

For instance, a 3-wide pyramid of cookies would look like this:

(open image file)
> 

```racket
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
```

> Consider a test tube filled with solid blobs and bubbles. Over time the
solids sink to the bottom of the test tube, and as a consequence the bubbles
percolate to the top.  Let's capture this idea in BSL.

Complete the design of a function that takes a list of blobs and sinks each
solid blob by one. It's okay to assume that a solid blob sinks past any
neighbor just below it.

To assist you, we supply the relevant data definitions.
> 

```racket
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
```

You will assess your solution to the design quiz according to the following rubric:

1. Is the program "commit ready"?The file should be neat and tidy,
no tests or code should be commented out other than stubs and templates
and all scratch work should be removed.
2. Is the design complete? All design elements should be present,
including those from HtDF, as well as a cross-product table, and each
element should be well-formed.
3. Does the design have high internal quality? All HtDF elements should have high internal quality, the signatures should
be correct, the purposes should be clear and succinct, examples should
be well-formed, correct, and cover the entire program, the function
bodies should be clear. For this design quiz, we are focusing
specifically on the internal quality of the helper functions. The design should include a helper function whenever there is a reference to a
non-primitive type, a function operating on arbitrary-sized data, a
knowledge domain shift, or a function composition.
4. Does the design satisfy the problem requirements? The design
solutions should satisfy the problem statements. If there is any
ambiguity in the problem statements the solution should identify and
resolve that ambiguity.