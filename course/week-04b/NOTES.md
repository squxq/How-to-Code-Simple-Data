# 4b: Reference

## Module Overview

In this module, we take a small but very significant step in terms of the complexity of the information we can represent as data.

Learning Goal:

- Be able to predict and identify the correspondence between
references in a data definition and helper function calls in functions
that operate on the data.

## The Reference Rule Part 1

[tuition-graph-starter.no-image-01.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-01/tuition-graph-starter.no-image-01.rkt)

[tuition-graph-starter-01.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-01/tuition-graph-starter-01.rkt)

We are going to look at a more complex form of data than we have seen before. This data involves something called “reference”, and it comes up when the information we are trying to represent naturally has different related parts.

> Eva is trying to decide where to go to university. One important factor for her is
tuition costs. Eva is a visual thinker, and has taken Systematic Program Design,
so she decides to design a program that will help her visualize the costs at
different schools. She decides to start simply, knowing she can revise her design
later.
> 
> 
> The information she has so far is the names of some schools as well as their
> international student tuition costs. She would like to be able to represent that
> information in bar charts like this one:
> 
> (open image file)
> 
> (A) Design data definitions to represent the information Eva has.
> (B) Design a function that consumes information about schools and their
> tuition and produces a bar chart.
> (C) Design a function that consumes information about schools and produces
> the school with the lowest international student tuition.
> 

```racket
;; Constants

(define BAR-COLOR (make-color 170 215 228 255))
(define BAR-WIDTH 30)

(define FONT-SIZE 20)
(define FONT-COLOR "black")

(define Y-SCALE (/ 1 200))
```

The constants support a single point of control. They make it easier to change the program later. The existence of the constants matters a lot more than whether their actual values are right - we can change their values later.

What makes this problem different is we’re going to have two data definitions. There is going to be one compound data definition called “School” to represent information about an individual school. And there’s going to be an arbitrary size data definition called “ListOfSchool” which refers to the first data definition. There will be what’s called a reference relationship in the type comment. And a natural helper in the templates.

The structure of the information determines the structure of the data, which determines the structure of the templates that determine the structure of the functions.

```racket
;; Data Definitions

(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. (make-school name tuition) is a school with:
;;         name is the school's name
;;         tuition is the school's internation student tuition in USD

;; Examples:
(define S0 (make-school "UBC" 38457))
(define S1 (make-school "Harvard" 75430))
(define S2 (make-school "Stanford" 65032))

;; Template:
(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))

;; Template rules used:
;; - compound rule: (make-school String Natural)

;; ListOfSchool is one of:
;; - empty
;; - (cons School ListOfSchool)
;; interp. a lsit of schools

;; Examples:
(define LOS0 empty)
(define LOS1 (cons S1 (cons S2 (cons S3 empty))))

;; Template:
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los)) ; natural helper
              (fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound rule: (cons School ListOfSchool)
;; - reference rule: (first los) is School
;; - self-reference: (rest los) is ListOfSchool
```

## The Reference Rule Part 2

[tuition-graph-starter.no-image-02.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-02/tuition-graph-starter.no-image-02.rkt)

[tuition-graph-starter-02.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-02/tuition-graph-starter-02.rkt)

Doing the examples before the function:

- helps us figure out what we want the function to do;
- helps us remember the names of primitives we need;
- helps us get details, like order of arguments, right.

With the examples before the function we can figure all the above out in specific cases, rather than the general purpose behavior of the function. That’s easier.

What the recipe does is to get us to always do the easiest task next, chipping away all the overall function design problem, making what’s left easier and easier.

```racket
;; Function Definitions

;; ListOfSchool -> Image
;; produce bar chart showing names and tuitions of the consumed schools

;; Stub:
(define (chart los) (square 0 "solid" "white"))

;; Tests:
(check-expect (chart LOS0) (square 0 "solid" "white"))
(check-expect (chart (cons S0 empty))
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S0) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))
(check-expect (chart LOS1)
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S0) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S0) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S0) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S2) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S2) Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))
```

## The Reference Rule Part 3

[tuition-graph-starter.no-image-03.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/tuition-graph-starter.no-image-03.rkt)

[tuition-graph-starter-03.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/tuition-graph-starter-03.rkt)

The natural helper in the template says: “do something complicated in a helper function that consumes the referred-to type”.

```racket
;; Template:
;; <Used template from ListOfSchool>

(define (chart los)
  (cond [(empty? los) (square 0 "solid" "white")]
        [else
         (beside/align "bottom" (make-bar (first los))
              (chart (rest los)))]))

;; School -> Image
;; produce the bar for a single school in the bar chart
;; !!!
;; Stub:
(define (make-bar s) (square 0 "solid" "white"))
```

At this point “chart” is done - at least until we get a working version of the function “make-bar”.

What does complicated mean? The basic rule is if there is a need to call more than one function that operates on the referred-to type, make a helper.

```racket
;; School -> Image
;; produce the bar for a single school in the bar chart

;; Stub:
#;
(define (make-bar s) (square 0 "solid" "white"))

;; Tests:
(check-expect (make-bar S0) (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S0) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S0) Y-SCALE) "solid" BAR-COLOR)))
(check-expect (make-bar S1) (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S1) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR)))
(check-expect (make-bar S2) (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S2) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S2) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S2) Y-SCALE) "solid" BAR-COLOR)))

;; Template:
;; <Used template from School>

(define (make-bar s)
  (overlay/align "center" "bottom"
                 (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
                 (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR)))
```

What we have seen in this sample is something that is really critical to good software design, which is that the structure of the information flows all the way through to the structure of the functions in the program.

### Question 62: Problem 1

[problem-01.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/problem-01.no-image.rkt)

> Consider the following definitions for Student and ListOfStudent.
Suppose we would like to design a function that consumes a list of students
and produces a list of student cards, where each student card contains the name and ID of the student.
Assume a student card is simply a string of the form:

"<student name> <student id>"

For example:

(student-cards (cons (make-student "John" 7893 (cons (make-student "Eva" 3124) empty)))

should produce

(cons "John 7893" (cons "Eva 3124" empty))
> 

```racket
;; =================
;; Data Definitions:

(define-struct student (name id))
;; Student is (make-student String Natural)
;; interp. a student with name and student id

;; Examples:
(define S0 (make-student "Eva" 3124))
(define S1 (make-student "john" 7893))

;; Template:
#;
(define (fn-for-student s)
  (... (student-name s)
       (student-id s)))

;; Template rules used:
;; - compound: (make-student String Natural)

;; ListOfStudent is one of:
;; - empty
;; - (cons Student ListOfStudent)
;; interp. a list of students

;; Examples:
(define LOS0 empty)
(define LOS1 (cons S0 empty))
(define LOS2 (cons S0 (cons S1 empty)))

;; Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-student (first los))
              (fn-for-los (rest los)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Student ListOfStudent)
;; - reference: (first los) is Student
;; - self-reference: (rest los) is ListOfStudent

;; =====================
;; Function Definitions:

;; Stub:
#;
(define (student-cards los) empty)

;; Tests:
(check-expect (student-cards LOS0) empty)
(check-expect (student-cards LOS1)
              (cons (string-append (student-name S0) " " (number->string (student-id S0))) empty))
(check-expect (student-cards LOS2)
              (cons (string-append (student-name S0) " " (number->string (student-id S0)))
                    (cons (string-append (student-name S1) " " (number->string (student-id S1))) empty)))

;; Template:
;; <used template from ListOfStudent>

(define (student-cards los)
  (cond [(empty? los) empty]
        [else
         (cons (create-card (first los))
              (student-cards (rest los)))]))

;; Student -> String
;; produce a student card ("<student name> <student id>") given a single student

;; Stub:
#;
(define (create-card s) "")

;; Tests:
(check-expect (create-card S0)
              (string-append (student-name S0) " " (number->string (student-id S0))))
(check-expect (create-card S1)
              (string-append (student-name S1) " " (number->string (student-id S1))))

;; Template:
;; <used template from Student>

(define (create-card s)
  (string-append (student-name s) " " (number->string (student-id s))))
```

### Question 63: Alternative Tuition Graph

[alternative-tuition-graph-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/alternative-tuition-graph-starter.no-image.rkt)

> Consider the following alternative type comment for Eva's school tuition
information program. Note that this is just a single type, with no reference,
but it captures all the same information as the two types solution in the
videos.

(define-struct school (name tuition next))
;; School is one of:
;;  - false
;;  - (make-school String Natural School)
;; interp. an arbitrary number of schools, where for each school we have its
;;         name and its tuition in USD

(A) Confirm for yourself that this is a well-formed self-referential data
    definition.

(B) Complete the data definition making sure to define all the same examples as
    for ListOfSchool in the videos.

(C) Design the chart function that consumes School. Save yourself time by
    simply copying the tests over from the original version of chart.

(D) Compare the two versions of chart. Which do you prefer? Why?
> 

```racket
;; ==========
;; Constants:

(define BAR-COLOR (make-color 170 215 228 255))
(define BAR-WIDTH 30)

(define FONT-SIZE 20)
(define FONT-COLOR "black")

(define Y-SCALE (/ 1 200))

;; =================
;; Data Definitions:

(define-struct school (name tuition next))
;; School is one of:
;; - false
;; - (make-school String Natural School)
;; interp. an arbitrary number of schools, where fro each school we have its
;;         name and its tuition in USD

;; Examples:
(define S0 false)
(define S1 (make-school "UBC" 38457
                        (make-school "Harvard" 75430 (make-school "Stanford" 65032 false))))

;; Template:
#;
(define (fn-for-school s)
  (cond [(false? s) (...)]
        [else
         (... (school-name s)
              (school-tuition s)
              (fn-for-school (school-next s)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - compound: (make-school String Natural School)
;; - self-reference: (school-next s) is School

;; =====================
;; Function Definitions:

;; School -> Image
;; produce bar chart showing names and tuitions of the consumed schools

;; Stub:
#;
(define (chart s) (square 0 "solid" "white"))

;; Tests:
(check-expect (chart S0) (square 0 "solid" "white"))
(check-expect (chart (make-school "UBC" 38457 false))
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text "UBC" FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* 38457 Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* 38457 Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))
(check-expect (chart S1)
              (beside/align "bottom" (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name S1) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition S1) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name (school-next S1)) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next S1)) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next S1)) Y-SCALE) "solid" BAR-COLOR))
                      (overlay/align "center" "bottom"
                                     (rotate 90 (text (school-name (school-next (school-next S1))) FONT-SIZE FONT-COLOR))
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next (school-next S1))) Y-SCALE) "outline" "black")
                                     (rectangle BAR-WIDTH (* (school-tuition (school-next (school-next S1))) Y-SCALE) "solid" BAR-COLOR))
               (square 0 "solid" "white")))

;; Template:
;; <used template from School>

(define (chart s)
  (cond [(false? s) (square 0 "solid" "white")]
        [else
         (beside/align "bottom" (overlay/align "center" "bottom"
               (rotate 90 (text (school-name s) FONT-SIZE FONT-COLOR))
               (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "outline" "black")
               (rectangle BAR-WIDTH (* (school-tuition s) Y-SCALE) "solid" BAR-COLOR))
              (chart (school-next s)))]))

;The first version is preferable because its simpler and more intuitive.
;It's also more efficient, performance and memory wise, for operations like      
;iterating through the list, searching, or sorting.
```

### Question 64: Spinning Bears

[spinning-bears-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/spinning-bears-starter.no-image.rkt)

[spinning-bears-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/spinning-bears-starter.rkt)

[spinning-bears-starter.png](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/spinning-bears-starter.png)

> In this problem you will design another world program. In this program the changing
information will be more complex - your type definitions will involve arbitrary
sized data as well as the reference rule and compound data. But by doing your
design in two phases you will be able to manage this complexity. As a whole, this problem
will represent an excellent summary of the material covered so far in the course, and world
programs in particular.

This world is about spinning bears. The world will start with an empty screen. Clicking
anywhere on the screen will cause a bear to appear at that spot. The bear starts out upright,
but then rotates counterclockwise at a constant speed. Each time the mouse is clicked on the
screen, a new upright bear appears and starts spinning.

So each bear has its own x and y position, as well as its angle of rotation. And there are an
arbitrary amount of bears.

To start, design a world that has only one spinning bear. Initially, the world will start
with one bear spinning in the center at the screen. Clicking the mouse at a spot on the
world will replace the old bear with a new bear at the new spot. You can do this part
with only material up through compound.

Once this is working you should expand the program to include an arbitrary number of bears.

Here is an image of a bear for you to use: (open image file)
> 

![Spinning Bears](referenceRule-03/spinning-bears-starter.png)

```racket
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
```

### Question 65: Tuition Graph C

[tuition-graph-c-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/referenceRule-03/tuition-graph-c-starter.no-image.rkt)

> Remember the constants and data definitions we created in lectures 5h-j
to help Eva decide where to go to university:
> 

```racket
;; ==========
;; Constants:

(define FONT-SIZE 24)
(define FONT-COLOR "black")

(define Y-SCALE   1/200)
(define BAR-WIDTH 30)
(define BAR-COLOR "lightblue")

;; =================
;; Data definitions:

(define-struct school (name tuition))
;; School is (make-school String Natural)
;; interp. name is the school's name, tuition is international-students tuition in USD

;; Examples:
(define S1 (make-school "School1" 27797)) ;We encourage you to look up real schools
(define S2 (make-school "School2" 23300)) ;of interest to you -- or any similar data.
(define S3 (make-school "School3" 28500)) ;

;; Template:
#;
(define (fn-for-school s)
  (... (school-name s)
       (school-tuition s)))

;; Template rules used:
;;  - compound: (make-school String Natural)

;; ListOfSchool is one of:
;;  - empty
;;  - (cons School ListOfSchool)
;; interp. a list of schools

;; Examples:
(define LOS1 empty)
(define LOS2 (cons S1 (cons S2 (cons S3 empty))))

;;Template:
#;
(define (fn-for-los los)
  (cond [(empty? los) (...)]
        [else
         (... (fn-for-school (first los))
              (fn-for-los (rest los)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons School ListOfSchool)
;;  - reference: (first los) is School
;;  - self-reference: (rest los) is ListOfSchool

;; ListOfName is one of:
;;  - empty
;;  - (cons String ListOfName)
;; interp. a list of names

;; Examples:
(define LON1 empty)
(define LON2 (cons "School1" (cons "School2" empty)))
(define LON3 (cons "School1" (cons "School2" (cons "School3" empty))))

;; Template:
#;
(define (fn-for-lon lon)
  (cond [(empty? lon) (...)]
        [else
         (... (first lon)
              (fn-for-lon (rest lon)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic distinct: empty
;;  - compound: (cons String ListOfName)
;;  - self-reference: (rest lon) is ListOfName
```

> Complete problem (C) from the reference rule videos.

"Design a function that consumes information about schools and produces
the school with the lowest international student tuition."

The function should consume a ListOfSchool. Call it cheapest.

;; ASSUME the list includes at least one school or else
;;        the notion of cheapest doesn't make sense

Also note that the template for a function that consumes a non-empty
list is:

(define (fn-for-nelox nelox)
  (cond [(empty? (rest nelox)) (...  (first nelox))]
        [else
          (... (first nelox)
               (fn-for-nelox (rest nelox)))]))

And the template for a function that consumes two schools is:

(define (fn... s1 s2)
(... (school-name s1)
     (school-tuition s1)
     (school-name s2)
     (school-tuition s2)))
> 

```racket
;; =====================
;; Function Definitions:

;; ListOfSchool -> School
;; produce the school with the cheapest tuition from the given list of schools

;; Stub:
#;
(define (cheapest los) S1)

;; Tests:
(check-expect (cheapest (cons S1 empty)) S1)
(check-expect (cheapest (cons S1 (cons S2 empty))) S2)
(check-expect (cheapest LOS2) S2)

;; Template:
#;
(define (fn-for-nelox nelox)
  (cond [(empty? (rest nelox)) (...  (first nelox))] 
        [else
          (... (first nelox) 
               (fn-for-nelox (rest nelox)))]))

(define (cheapest los)
  (cond [(empty? (rest los)) (first los)] 
        [else (cheapest-school (first los) (cheapest (rest los)))]))

;; School School -> School
;; produce the cheapest school tuition out of two given schools

;; Stub:
#;
(define (cheapest-school s1 s2) S1)

;; Tests:
(check-expect (cheapest-school S1 S2) S2)
(check-expect (cheapest-school S2 S3) S2)
(check-expect (cheapest-school S1 S3) S1)

;; Template:
#;
(define (cheapest-school s1 s2)
(... (school-name s1)
     (school-tuition s1)
     (school-name s2)
     (school-tuition s2)))

(define (cheapest-school s1 s2)
  (if (< (school-tuition s1) (school-tuition s2)) s1 s2))
```

> Design a function that consumes a ListOfSchool and produces a list of the
school names. Call it get-names.

Do you need to define a new helper function?
> 

```racket
;; ListOfSchool -> ListOfName
;; produce a list of all school names in the given list of schools

;; Stub:
#;
(define (get-names los) LON1)

;; Tests:
(check-expect (get-names LOS1) empty)
(check-expect (get-names LOS2) LON3)

;; Template:
;; <used template from ListOfSchool>

(define (get-names los)
  (cond [(empty? los) empty]
        [else
         (cons (school-name (first los))
              (get-names (rest los)))]))

;Do you need to define a new helper function?
;Ans: No. I will only call one function that operates on the referred-to type.
```

## Video Contest

[snow-falling.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/videoContest/snow-falling.rkt)

[snow-falling.png](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-04b/course/week-04b/videoContest/snow-falling.png)

Objective: work through a problem with the design method from start to finish. Free to decide what to work on.

> You have to create a program that simulates a charming animation of snow falling on the screen.
The snowflakes appear to fall from the top of the screen to the bottom, creating a wintry effect.
> 

![Snow Falling](videoContest/snow-falling.png)

```racket
;; Snow Falling Simulation

;; =================
;; Constants:

(define WIDTH 1600)
(define HEIGHT (* WIDTH (/ 9 16)))

(define MTS (overlay (rectangle WIDTH HEIGHT "solid" "dark blue") (empty-scene WIDTH HEIGHT)))
(define SNOWFLAKE (pulled-regular-polygon 5 8 2 50 "solid" "white"))

(define Y0 -36)
(define R0 0)

;; =================
;; Data definitions:

(define-struct flake (x y r dy dr s))
;; Flake is (make-flake Integer[0, WIDTH] Integer[-30, HEIGHT] Integer (-360, 360) Integer[1, 10] Integer[-10, 0)U(0, 10] Integer[1, 4])
;; interp. (make-flake x y r dy dr s) is a snowflake with:
;;         x, is the snowflake's x coordinate - remains constant throughout its lifespan - random value
;;         y, is the snowflake's y coordinate - changes by dy every 1/28 seconds - starts at y = -30
;;         r, is the snowflake's rotation angle - changes according to dr - starts at r = 0
;;         dy, is the snowflake's changing rate of its y coordinate (vertical velocity) - random value
;;         dr, is the snowflake's changing rate of its rotation angle (angular velocity) - random value
;;         s, is the snowflake's scaling parameter for its image - random value

;; Examples:
(define F0 (make-flake (/ WIDTH 2) Y0 R0 5 7 2))
(define F1 (make-flake 549 Y0 R0 10 -7 2))
(define F2 (make-flake 1590 Y0 R0 1 -10 4))
(define F3 (make-flake 140 Y0 R0 7 10 1))

;; Template:
#;
(define (fn-for-flake f)
  (... (flake-x f)
       (flake-y f)
       (flake-r f)
       (flake-dy f)
       (flake-dr f)
       (flake-s f)))

;; Template rules used:
;; - compound: (make-flake Integer[0, WIDTH] Integer[-30, HEIGHT] Integer (-360, 360) Integer[1, 10] Integer[-10, 0)U(0, 10] Integer[1, 4])

;; Snowflakes is one of:
;; - empty
;; - (cons Flake Snowflakes)
;; interp. a list of all the snowflakes on the MTS

;; Examples:
(define SF0 empty)
(define SF1 (cons F0 empty))
(define SF2 (cons F0 (cons F1 empty)))
(define SF3 (cons F0 (cons F1 (cons F2 empty))))
(define SF4 (cons F0 (cons F1 (cons F2 (cons F3 empty)))))

;; Template:
#;
(define (fn-for-snowflakes sf)
  (cond [(empty? sf) (...)]
        [else
         (... (fn-for-flake (first sf))
              (fn-for-snowflakes (rest sf)))]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: empty
;; - compound: (cons Flake Snowflakes)
;; - reference: (first sf) is Flake
;; - self-reference: (rest sf) is Snowflake

;; =================
;; Functions:

;; Snowflakes -> Snowflakes
;; start the world with: (main empty)

(define (main sf)
  (big-bang sf                              ; Snowflakes
            (on-tick update-snowflakes)     ; Snowflakes -> Snowflakes
            (to-draw render-snowflakes)     ; Snowflakes -> Image
            (on-mouse reset-snowflakes)))   ; Snowflakes Integer Integer MouseEvent -> SnowFlakes

;; Snowflakes -> Snowflakes
;; produce the next positions for all the snowflakes on the MTS

;; Stub:
#;
(define (update-snowflakes sf) SF0)

;; Tests:
(check-random (update-snowflakes SF0)
              (cons (create-flake (random 20)) empty))
(check-random (update-snowflakes SF1)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (create-flake (random 20)) empty)))
(check-random (update-snowflakes SF2)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (create-flake (random 20)) empty))))
(check-random (update-snowflakes SF3)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2))
                                (cons (create-flake (random 20)) empty)))))
(check-random (update-snowflakes SF4)
              (cons (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0))
                    (cons (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1))
                          (cons (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2))
                                (cons (make-flake (flake-x F3) (+ (flake-y F3) (flake-dy F3)) (+ (flake-r F3) (flake-dr F3)) (flake-dy F3) (flake-dr F3) (flake-s F3))
                                      (cons (create-flake (random 20)) empty))))))

;; Template:
;; <used template from Snowflakes>

(define (update-snowflakes sf)
  (cond [(empty? sf)
         (cons (create-flake (random 20)) empty)]
        [else (if (>= (+ (flake-y (first sf)) (flake-dy (first sf))) HEIGHT)
                  (update-snowflakes (rest sf))
                  (cons (update-flake (first sf)) (update-snowflakes (rest sf))))]))

;; Snowflakes -> Image
;; render all the snowflakes on the MTS 

;; Stub:
#;
(define (render-snowflakes sf) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-snowflakes SF0) MTS)
(check-expect (render-snowflakes SF1)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0) MTS))
(check-expect (render-snowflakes SF2)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1) MTS)))
(check-expect (render-snowflakes SF3)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1)
                                        (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2) MTS))))
(check-expect (render-snowflakes SF4)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0)
                           (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1)
                                        (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2)
                                                     (place-image (scale (flake-s F3) (rotate (flake-r F3) SNOWFLAKE)) (flake-x F3) (flake-y F3) MTS)))))

;; Template:
;; <used template from Snowflakes>

(define (render-snowflakes sf)
  (cond [(empty? sf) MTS]
        [else
         (render-flake (first sf)
              (render-snowflakes (rest sf)))]))

;; Flake -> Flake
;; update the position(y) and rotation(r) with the given flake's values

;; Stub:
#;
(define (update-flake f) F0)

;; Tests:
(check-expect (update-flake F0)
              (make-flake (flake-x F0) (+ (flake-y F0) (flake-dy F0)) (+ (flake-r F0) (flake-dr F0)) (flake-dy F0) (flake-dr F0) (flake-s F0)))
(check-expect (update-flake F1)
              (make-flake (flake-x F1) (+ (flake-y F1) (flake-dy F1)) (+ (flake-r F1) (flake-dr F1)) (flake-dy F1) (flake-dr F1) (flake-s F1)))
(check-expect (update-flake F2)
              (make-flake (flake-x F2) (+ (flake-y F2) (flake-dy F2)) (+ (flake-r F2) (flake-dr F2)) (flake-dy F2) (flake-dr F2) (flake-s F2)))
(check-expect (update-flake F3)
              (make-flake (flake-x F3) (+ (flake-y F3) (flake-dy F3)) (+ (flake-r F3) (flake-dr F3)) (flake-dy F3) (flake-dr F3) (flake-s F3)))
(check-expect (update-flake (make-flake (/ WIDTH 2) 743 358 5 7 2))
              (make-flake (/ WIDTH 2) (+ 743 5) (remainder (+ 358 7) 360) 5 7 2))

;; Template:
;; <used template from Flake>

(define (update-flake f)
  (if (not (>= (+ (flake-r f) (flake-dr f)) 360))
      (make-flake (flake-x f) (+ (flake-y f) (flake-dy f))
                  (+ (flake-r f) (flake-dr f)) (flake-dy f) (flake-dr f) (flake-s f))
      (make-flake (flake-x f) (+ (flake-y f) (flake-dy f))
                  (remainder (+ (flake-r f) (flake-dr f)) 360) (flake-dy f) (flake-dr f) (flake-s f))))

;; Flake Image -> Image
;; produce image of given flake with its correct position(x and y coordinates) and rotation angle on given screen

;; Stub:
#;
(define (render-flake f s) (square 0 "solid" "white"))

;; Tests:
(check-expect (render-flake F0 MTS)
              (place-image (scale (flake-s F0) (rotate (flake-r F0) SNOWFLAKE)) (flake-x F0) (flake-y F0) MTS))
(check-expect (render-flake F1 MTS)
              (place-image (scale (flake-s F1) (rotate (flake-r F1) SNOWFLAKE)) (flake-x F1) (flake-y F1) MTS))
(check-expect (render-flake F2 MTS)
              (place-image (scale (flake-s F2) (rotate (flake-r F2) SNOWFLAKE)) (flake-x F2) (flake-y F2) MTS))
(check-expect (render-flake F3 MTS)
              (place-image (scale (flake-s F3) (rotate (flake-r F3) SNOWFLAKE)) (flake-x F3) (flake-y F3) MTS))

;; Template:
#;
(define (render-flake f s)
  (... s
       (flake-x f)
       (flake-y f)
       (flake-r f)
       (flake-dy f)
       (flake-dr f)
       (flake-s f)))

(define (render-flake f s)
  (place-image (scale (flake-s f) (rotate (flake-r f) SNOWFLAKE)) (flake-x f) (flake-y f) s))

;; Integer[0, 19] -> Flake
;; produce a new snowflake object given a random number less than 20 for its algular velocity

;; Stub:
#;
(define (create-flake dr0) F0)

;; Tests:
(check-random (create-flake 9)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- 9 10) (+ (random 5) 1)))
(check-random (create-flake 19)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ 19 1) (+ (random 5) 1)))
(check-random (create-flake 0)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- 0 10) (+ (random 5) 1)))
(check-random (create-flake 10)
              (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ 10 1) (+ (random 5) 1)))

;; Template:
#;
(define (create-flake dr0)
  (... dr0))

(define (create-flake dr0)
  (if (<= dr0 9)
      (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (- dr0 10) (+ (random 5) 1))
      (make-flake (random (+ WIDTH 1)) Y0 R0 (+ (random 9) 1) (+ dr0 1) (+ (random 5) 1))))

;; Snowflakes Integer Integer MouseEvent -> SnowFlakes
;; on "button-down" delete all the flakes from the snowflakes list

;; Stub:
#;
(define (reset-snowflakes sf x y me) SF0)

;; Tests:
(check-expect (reset-snowflakes SF0 742 124 "button-down") empty)
(check-expect (reset-snowflakes SF1 742 124 "button-down") empty)
(check-expect (reset-snowflakes SF1 742 124 "move") SF1)
(check-expect (reset-snowflakes SF2 742 124 "button-down") empty)
(check-expect (reset-snowflakes SF3 742 124 "button-down") empty)
(check-expect (reset-snowflakes SF4 742 124 "button-down") empty)
(check-expect (reset-snowflakes SF4 742 124 "move") SF4)

;; Template:
#;
(define (reset-snowflakes sf x y me)
  (cond [(mouse=? me "button-down") (... x y sf)]
        [else (... x y sf)]))

(define (reset-snowflakes sf x y me)
  (cond [(mouse=? me "button-down") empty]
        [else sf]))
```