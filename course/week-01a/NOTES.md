# 1a: Beginning Student Language

## Module Overview

Learning Goals:

- Be able to write expressions that operate on primitive data including numbers, strings, images and booleans.
- Be able to write constant and function definitions.
- Be able to write out the step-by-step of evaluation of simple expressions including function calls.
- Be able to use the stepper to automatically step through the evaluation of an expression.
- Be able to use the Dr. Racket help desk to discover new primitives.

## Expressions

[expressions.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/expressions/expressions.rkt)

The top part of Racket here is called the Definitions Area, and the bottom part is called the Interaction Area. And the way Racket works is we give it expressions, and it evaluates the expression to produce the value. 

```racket
(+ 3 4) ; expression
; outputs 7 -> value
```

To form an expression:

$$
(<primitive> <expression>...)
$$

Note that some primitives can only take in a certain number of expressions. We can make expressions that are even more complicated than that or use other primitive operators.

```racket
(+ 3 (* 2 3))
; outputs 9
```

And there's another rule that says expressions can be actual values. So numbers themselves can be expressions. 

```racket
(/ 12 (* 2 3))
; outputs 2

(sqr 3)
; outputs 9

(sqrt 16)
; outputs 4
```

We've seen several primitives that operate on numbers, primitives like plus, and times, and divide, and minus, and square, and square root.

### Question 1: Pythag

[pythag-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/expressions/pythag-starter.no-image.rkt)

> Assume that the two short sides of a right triangle have length 3 and 4.
> 
> 
> What is the length of the long side? Recall that the Pythagorean Theorem tells us that:
> 
> Write a BSL expression that produces the value of? for this triangle where the other two sides have lengths 3 and 4.
> 

```racket
(sqrt (+ (sqr 3) (sqr 4)))
; outputs 5
```

An irrational number cannot be written as a/b, where a and b are integers; that means its decimal representation is infinitely long (and not repeating like the decimal of 1/3).

```racket
(sqrt 2)
; outputs #i1.4142135623730951
```

The #i means: “This number is close to this, but not exactly this”.

### Question 2: Arithmetic Expression

[arithmetic-expression-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/expressions/arithmetic-expression-starter.no-image.rkt)

> Write the BSL expression that represents the arithmetic expression (7 - 2) * 4 which equals 20.
Do not just write 20! Instead, write BSL expression that clearly mirrors  (7 - 2) * 4.
> 

```racket
(* (- 7 2) 4)
; outputs 20
```

### Question 3: More Arithmetic Expression

[more-arithmetic-expression-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/expressions/more-arithmetic-expression-starter.no-image.rkt)

> Write two expressions that multiply the numbers 3, 5, and 7.
The first should take advantage of the fact that * can accept more than 2 arguments.
The second should build up the result by first multiplying 3 times 5 and then multiplying the result of that by 7.
> 

```racket
(* 3 5 7)
; outputs 105

(* (* 3 5) 7)
; outputs 105
```

### Question 4: Even More Arithmetic Expression

[even-more-arithmetic-expression-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/expressions/even-more-arithmetic-expression-starter.no-image.rkt)

> Write the BSL expression that represents the arithmetic expression:
> 
> 
> (6 + 3) * (9 - 7)
> which equals 18.  Do not just write 18! Instead, write a BSL expression that clearly
> mirrors the arithmetic expression.
> 

```racket
(* (+ 6 3) (- 9 7))
; outputs 18
```

## Evaluation

[evaluation.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/evaluation/evaluation.rkt)

An expression, like this one, because it starts with an open parenthesis and the name of a primitive operation, is called a primitive call, or a call to a primitive.

```racket
(+ 2 (* 3 4) (- (+ 1 2) 3))
; outputs 14
; + is an operator, all the expressions that follow the operator are the operands
```

The step-by-step process takes that expression and produces the value 14. The first thing that happens in Racket is to evaluate this entire expression. It seems it’s a primitive call because it starts with an open parenthesis and a primitive operator. The rule for evaluating a primitive call is that all operands must first be reduced to values.

```racket
; expression
(+ 2 (* 3 4) (- (+ 1 2) 3))

; step 1
(+ 2 12      (- (+ 1 2) 3))
; step 2
(+ 2 12      (- 3       3))
; step 3
(+ 2 12                  0)
; step 4 - output
14
```

The intuition to take away from this is that evaluation of an expression in general proceeds from left to right and from inside to outside.

The repeated application of the first evaluation rule, the primitive call rule, can evaluate numerical expressions of arbitrary complexity and leads to a left to right, inside to outside evaluation order.

### Question 5: Evaluation Prims

[evaluation-prims-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/evaluation/evaluation-prims-starter.no-image.rkt)

> Write out the step-by-step evaluation for the following expression:
> 
> 
> (+ (* 2 3) (/ 8 2))
> 

```racket
; expression
(+ (* 2 3) (/ 8 2))

; step 1
(+ 6       (/ 8 2))
; step 2
(+ 6             4)
; step 3 - output
10
```

> Write out the step-by-step evaluation for the following expression:
> 
> 
> (* (string-length "foo") 2)
> 

```racket
; expression
(* (string-length "foo") 2)

; step 1
(* 3                     2)
; step 2 - output
6
```

## Strings and Images

[strings.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/strings.rkt)

[images.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/images.rkt)

To form a string, for example: “Our team is number 1@!”, we do:

$$
"<any\ characters\ except\ for\ double\ quote>"
$$

```racket
"apple"
; outputs "apple"
```

One thing we could do with strings is put them together. So let's say I have two strings, Ada, which is someone's first name, and Lovelace, which is someone's last name, I can put them together like that:

```racket
(string-append "Ada" " " "Lovelace")
; outputs "Ada Lovelace"
```

And there I get Ada Lovelace. She's very famous as a computer scientist. In the 1840s and the 1840s, she wrote the first computer program ever written. It was written for a machine that, at the time, only existed on paper. The machine itself didn't run until quite recently, but she wrote the program in the 1840s.

```racket
"123" ; This is a string that happens to have the characters 1, 2, and 3 in it. 

123 ; And this is the number, 123.

(+ 1 123) ; In particular, I could take the number and add 1 to it.
; outputs 124

; (+ 1 "123") - I can't take the string and add 1 to it.
; outputs +: expects a number, given "123
```

There are other string primitives, for example, string-length is a primitive which tells us how long a string is. There's another operation called substring, which is going to let me take out parts of the string.

```racket
(string-length "apple")
; outputs 5

           "0123456789" ; Racket uses zero-based indexing.
(substring "Caribou" 2 4)
; outputs "ri"

(substring "0123456789" 2 4)
; outputs "23"

(substring "Caribou" 0 3)
; outputs "Car"
```

DrRacket has lots of different kinds of image functions. For me to use them I have to type, at the top of any file:

```racket
(require 2htdp/image)
```

There's lots and lots of primitives that operate on images, throughout the course I will have the opportunity to use many of them. Here are some basic image primitives:

```racket
(circle 10 "solid" "red") 
; creates a red solid (filled) circle with radius 5

(rectangle 30 60 "outline" "blue")
; creates a blue outlined rectangle with dimensions 30x60

(text "hello" 24 "orange")
; creates an orange text in font 24 that says: "hello"

(above (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles each one of top of another

(beside (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles side by side from left to right

(overlay (circle 10 "solid" "red")
       (circle 20 "solid" "yellow")
       (circle 30 "solid" "green"))
; creates 3 circles stacked on top of each other
```

### Question 6: Tile

[tile-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/tile-starter.no-image.rkt)

[tile-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/tile-starter.rkt)

> Use the DrRacket square, beside and above functions to create an image like this one (open image file):
> 
> 
> If you prefer to be more creative feel free to do so. You can use other DrRacket image
> 
> functions to make a more interesting or more attractive image.
> 

```racket
(above (beside (square 60 "solid" "blue") (square 60 "solid" "yellow"))
       (beside (square 60 "solid" "yellow") (square 60 "solid" "blue")))

(above (beside (overlay/align "right" "bottom"
                              (square 20 "solid" "blue")
                              (square 40 "solid" "yellow")
                              (square 60 "solid" "blue")) (overlay/align "left" "bottom"
                              (square 20 "solid" "yellow")
                              (square 40 "solid" "blue")
                              (square 60 "solid" "yellow"))) 
       (beside (overlay/align "right" "top"
                              (square 20 "solid" "yellow")
                              (square 40 "solid" "blue")
                              (square 60 "solid" "yellow")) (overlay/align "left" "top"
                              (square 20 "solid" "blue")
                              (square 40 "solid" "yellow")
                              (square 60 "solid" "blue"))))

(above (beside (overlay/xy (square 40 "solid" "yellow") 20 20 (square 40 "solid" "blue"))
               (overlay/xy (square 40 "solid" "blue") -20 20 (square 40 "solid" "yellow")))
       (beside (overlay/xy (square 40 "solid" "yellow") -20 20 (square 40 "solid" "blue"))
               (overlay/xy (square 40 "solid" "blue") 20 20 (square 40 "solid" "yellow"))))

(above (beside (above (beside (crop 30 30 30 30 (circle 30 "solid" "blue"))
               (crop 0 30 30 30 (circle 30 "solid" "yellow")))
       (beside (crop 30 0 30 30 (circle 30 "solid" "yellow"))
               (crop 0 0 30 30 (circle 30 "solid" "blue"))))
               (above (beside (crop 30 30 30 30 (circle 30 "solid" "blue"))
               (crop 0 30 30 30 (circle 30 "solid" "yellow")))
       (beside (crop 30 0 30 30 (circle 30 "solid" "yellow"))
               (crop 0 0 30 30 (circle 30 "solid" "blue")))))
       (beside (above (beside (crop 30 30 30 30 (circle 30 "solid" "blue"))
               (crop 0 30 30 30 (circle 30 "solid" "yellow")))
       (beside (crop 30 0 30 30 (circle 30 "solid" "yellow"))
               (crop 0 0 30 30 (circle 30 "solid" "blue"))))
               (above (beside (crop 30 30 30 30 (circle 30 "solid" "blue"))
               (crop 0 30 30 30 (circle 30 "solid" "yellow")))
       (beside (crop 30 0 30 30 (circle 30 "solid" "yellow"))
               (crop 0 0 30 30 (circle 30 "solid" "blue"))))))
```

### Question 7: Glue

[glue-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/glue-starter.no-image.rkt)

> Write an expression that sticks the strings "Super" "Glue" together into a single string
"Super Glue" with a space between the two words.
> 

```racket
(string-append "Super" " " "Glue")
; outputs "Super Glue"
```

### Question 8: CFlag

[cflag-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/cflag-starter.no-image.rkt)

[cflag-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/strings%26images/cflag-starter.rkt)

> The background for the Canadian Flag (without the maple leaf) is this (open the image file):
> 
> 
> Write an expression to produce that background. (If you want to get the
> details right, officially the overall flag has proportions 1:2, and the
> band widths are in the ratio 1:2:1.)
> 

```racket
(define (canRect w h color)
  (rectangle w h "solid" color))

; problem solution
(beside (canRect 10 20 "red") (canRect 20 20 "white") (canRect 10 20 "red"))

; 1st try on a maple leaf
(beside (canRect 10 20 "red") (overlay (star 10 "solid" "red") (canRect 20 20 "white")) (canRect 10 20 "red"))

; complete canadian flag
(beside (canRect 100 200 "red") 
        (overlay (scale 1/8 (bitmap/url "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Maple_Leaf.svg/1200px-Maple_Leaf.svg.png")) 
                 (canRect 200 200 "white")) (canRect 100 200 "red"))
```

### Question 9: Triangle

[triangle-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/strings%26images/triangle-starter.no-image.rkt)

[triangle-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/strings%26images/triangle-starter.rkt)

> Write an expression that uses triangle, overlay, and rotate to produce an image similar to this (open image file):
> 
> 
> You can consult the DrRacket help desk for information on how to use triangle and overlay.
> Don't worry about the exact size of the triangles.
> 

```racket
; triangles for visual reference
(triangle 40 "solid" "green")
(triangle 40 "solid" "yellow")
; outputs 2 equilateral triangles with size 40 solid green and yellow

(overlay (triangle 40 "solid" "green") (rotate 180 (triangle 40 "solid" "yellow")))
; outputs 2 overlayed triangles like the previous ones, this time, the yellow one is rotated 180deg
```

### Question 10: Overlay

[overlay-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/strings%26images/overlay-starter.no-image.rkt)

[overlay-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/strings%26images/overlay-starter.rkt)

> Write an expression that uses star and overlay to produce an image similar to this (open image file):
> 
> 
> You can consult the DrRacket help desk for information on how to use star and overlay.
> Don't worry about the exact size of the stars.
> 

```racket
; stars for visual reference
(star 10 "solid" "blue")
(star 25 "solid" "yellow")
(star 40 "solid" "blue")
; outputs 3 solid (filled) stars, 2 blue and 1 yellow

(overlay (star 10 "solid" "blue") (star 25 "solid" "yellow") (star 40 "solid" "blue"))
; outputs the previous 3 stars on top of each other (overlayed)
```

### Question 11: Debug Rectangle

[debug-rectangle-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/strings%26images/debug-rectangle-starter.no-image.rkt)

> Uncomment the code below and fix the error(s):
> 
> 
> (rectangle 10 solid red)
> 

```racket
(rectangle 10 solid red)
; outputs solid: this variable is not defined

(rectangle 10 "solid" red)
; outputs red: this variable is not defined

(rectangle 10 "solid" "red")
; outputs rectangle: expects 4 arguments, but found only 3

(rectangle 10 20 "solid" "red")
; outputs the red rectangle
```

## Constant Definitions

[constantDefinitions.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/constantDefinitions/constantDefinitions.no-image.rkt)

Constant definitions are more than just a convenience. They help make programs that are easy for other people to read and change, and those two properties - readability and changeability are two of the most important properties a program can have. 

```racket
(define WIDTH 400)
(define HEIGHT 600)

; expression
(* WIDTH HEIGHT)

; step 1
(* 400 HEIGHT)
; step 2
(* 400 600)
; step 3 - outputs 
240000
```

We often put the names of constants in upper case. Defining a constant doesn’t produce a value. To form a constant definition:

$$
(define\ <name>\ <expression>)\\
name = sequence\ of\ characters\ including: \\ a..z\ \ A..Z\ \ 0..9\ \ !\ \ @\ \ ^\ \ *\ \ _\ \ +\ \ -\ \ =\ \ ?\ \ <\ \ >\ 
$$

Evaluation rules for constant definitions:

- To evaluate a constant definition: evaluate the expression and record the resulting value as the value of the constant with the given name;
- To evaluate a defined constant name: the value is the recorded value.

```racket
(define IMG_CAT "alt: img_cat") ; images are values and all values are expressions
; alt: img_cat

; rotate is for images only
; (define RCAT (rotate -10 IMG_CAT))
; (define LCAT (rotate 10 IMG_CAT))

(define RCAT "alt: img_cat_rotated_right")
(define LCAT "alt: img_cat_rotated_left")

RCAT
; outputs the IMG_CAT rotated 10deg to the right

LCAT
; outputs the IMG_CAT rotated 10deg to the left
```

It is only possible to define a constant name one time.

## Function Definitions

[functionDefinitions.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/functionDefinitions/functionDefinitions.rkt)

Functions are the mechanisms in the BSL that are going to produce a different value each time they run. Is easy to be bothered by the amount of redundancy in the following expression:

```racket
; all the (circle 40 "solid" ...) is unchanging
(above (circle 40 "solid" "red") ; only "red" is changing 
       (circle 40 "solid" "yellow") ; only "yellow" is changing
       (circle 40 "solid" "green")) ; only "green" is changing
```

Creating a function definition comes down to:

$$
(define\ (<function\ name>\ <argument\ (parameter)>...) <expression\ (body)>)\\
parameters\ (from\ math\ functions)\ stand\ for\ varying\ value\\
$$

To form a function call expression:

$$
(<function\ name>\ <expression(operand)>...)\\
the\ number\ of\ expressions\ correspond\ to\ the\ number\ of\ parameters
$$

A function can be used repeatedly with any value each time.

```racket
(define (bulb c)
				(circle 40 "solid" c))

(bulb "red")
; outputs a red circle

(bulb "yellow")
; outputs a yellow circle

(bulb "green")
; outputs a green circle
```

In the end, this expression is more concise than the original expression. It reduces duplication and gives the code more meaning.

To evaluate function definitions:

- To evaluate function definitions: simply record definition;
- To evaluate function call: first, reduce operands to values (called arguments). Then replace the function call with the body of the function in which every occurrence of the parameter(s) is replaced by the corresponding argument.

```racket
; expression
(bulb (string-append "re" "d"))

; step 1 - function call
(bulb "red")

; step 2 - replace function call function body
(circle 40 "solid" "red")

; step 3 - primitive call
; outputs a solid red circle with radius 20
```

Just as an aside, to understand how powerful functions are, one of the most important theoretical results in computer science says that if I have a language that just has functions, just functions, no strings, no numbers, I could actually write any program that can be written in any language.

### Question 12: Function Writing

[function-writing-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/functionDefinitions/function-writing-starter.no-image.rkt)

> Write a function that consumes two numbers and produces the larger of the two.
> 

```racket
(define (larger a b)
  (if (> a b)
      a
      (if (< a b)
          b
          "Both numbers are equal")))

(larger 9 4)
; outputs 9, 9 > 4

(larger 4 9)
; outputs 9, 4 < 9

(larger 4 4)
; outputs "Both numbers are equal"
```

## Booleans and If Expressions

[booleans.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/booleans%26ifExpressions/booleans.rkt)

[ifExpressions.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/booleans%26ifExpressions/ifExpressions.no-image.rkt)

In computer programs, true-false questions turn out to be fundamental. A boolean represents the answer to true-false questions. There are two boolean values:

```racket
true ; outputs true

false ; outputs false
```

The primitives that produce a true-false value are often called predicates. Therefore, the greater-than and greater-than-or-equal-to primitives are predicates.

```racket
(define WIDTH 100)
(define HEIGHT 100)

(> WIDTH HEIGHT) ; > is a predicate
; outputs false - WIDTH = HEIGHT

(>= WIDTH HEIGHT) ; >= is a predicate
; outputs true

(= 1 2)
; outputs false - 1 < 2

(= 1 1)
; outputs true

(> 3 9)
; outputs false - 3 < 9

(string=? "foo" "bar")
; outputs false - those two strings are not equal

(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 10 "solid" "blue"))

(< (image-width I1)
	 (image-width I2))
; outputs true - the width of I1 = 10 and the width of I2 = 20, 10 < 20
```

To form an if expression:

$$
(if\ <expression> - question\\
<expression> - true\ answer\\
<expression>) - false\ answer\\
The\ question\ expression\ must\ produce\ a\ boolean\ value.
$$

```racket
(if (< (image-width I1) (image-height I1)) ; here I1 and I2 can be changed
    "tall"
    "wide") ; when the "tall" expression is outputed "wide" gets highlighted and vice-versa
; if the constant used is I1, it outputs "tall" - 10 < 20
; if the constant used is I2, it outputs "wide" - 20 > 10
```

To evaluate an if expression:

- If the question expression is not a value evaluate it, and replace with value.
- If the question is true replace entire if expression with true answer expression.
- If the question is false replace entire if expression with false answer expression.
- If the question is a value other than true or false, produce an error.

```racket
; expression
(if (< (image-width I2)
       (image-height I2))
    (image-width I2)
    (image-height I2))

; step 1
(if (< 20 ; (image-width "alt: solid blue rectangle with dimensions 20x10")
       (image-height I2))
    (image-width I2)
	  (image-height I2))

; step 2
(if (< 20
       (image-height I2))
    (image-width I2)
	  (image-height I2))

; step 3
(if (< 20
       10; (image-height "alt: solid blue rectangle with dimensions 20x10")
       )
    (image-width I2)
	  (image-height I2))

; step 4
(if (< 20
       10)
    (image-width I2)
	  (image-height I2))

; step 5
(if false
    (image-width I2)
	  (image-height I2))

; step 6
(image-height I2)

; step 7
10 ; (image-height "alt: solid blue rectangle with dimensions 20x10".)

; step 8
10
```

Notes: 

- ctrl-D or cmd-D hides the definitions area.
- ctrl-E or cmd-E hides the interactions area.

```racket
(> (image-height I1) (image-height I2))
; outputs true

(> (image-width I1) (image-width I2))
; outputs true
```

In the case of me wanting to know if I1 was both taller and skinnier than I2 we would use another primitive called “and”:

```racket
(and (> (image-height I1) (image-height I2)) 
     (< (image-width I1) (image-width I2)))
; outputs true
```

To form “and” expression:

$$
(and\ <expression>\ <expression>...)\\
All\ <expressions>\ must\ produce\ boolean.
$$

To evaluate “and” expression, evaluate <expression> one at a time:

- If an <expression> produces false immediately produce false.
- If all <expression> produce true, then produce true.

There are also the primitives “or” and “not”.

### Question 13: Compare Images

[compare-images-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/booleans%26ifExpressions/compare-images-starter.no-image.rkt)

> Based on the two constants provided, write three expressions to determine whether:
> 
> 
> 1) IMAGE1 is taller than IMAGE2
> 2) IMAGE1 is narrower than IMAGE2
> 3) IMAGE1 has both the same width AND height as IMAGE2
> 

```racket
(define IMAGE1 (rectangle 10 15 "solid" "red"))
(define IMAGE2 (rectangle 15 10 "solid" "red"))

IMAGE1
IMAGE2
; outputs the images for visual reference

; expression 1)
(if (> (image-height IMAGE1) (image-height IMAGE2))
    "IMAGE1 is taller than IMAGE2"
    "IMAGE1 is not taller than IMAGE2")

; expression 2)
(if (< (image-width IMAGE1) (image-width IMAGE2))
    "IMAGE1 is narrower than IMAGE2"
    "IMAGE1 is not narrower than IMAGE2")

; expression 3)
(if (and (= (image-width IMAGE1) (image-width IMAGE2)) (= (image-width IMAGE1) (image-width IMAGE2)))
    "IMAGE1 has both the same width AND height as IMAGE2"
    "IMAGE1 does not have both the same width AND height as IMAGE2")
```

## Using the Stepper

[stepper.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/stepper/stepper.rkt)

The Stepper is a functionality built into Dr. Racket that can help you understand the step-by-step evaluation of complex expressions. It’s essentially a debugger. I can access the stepper by clicking, in the top right corner, on a button that says: Step >|. Below is the code used to test the Dr. Racket Stepper:

```racket
(+ (* 3 2) 1)
; outputs 7

(define (max-dim img)
  (if (> (image-width img) (image-height img))
      (image-width img)
      (image-height img)))

(max-dim (rectangle 10 20 "solid" "blue"))
; outputs 20
```

### Question 14: Foo Evaluation

[foo-evaluation-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/stepper/foo-evaluation-starter.no-image.rkt)

> Given the following function definition:
> 
> 
> (define (foo s)
>   (if (string=? (substring s 0 1) "a")
>       (string-append s "a")
>       s))
> 
> Write out the step-by-step evaluation of the expression:
> 
> (foo (substring "abcde" 0 3))
> 
> Be sure to show every intermediate evaluation step.
> 

```racket
(define (foo s)
  (if (string=? (substring s 0 1) "a")
      (string-append s "a")
      s))

; expression
(foo (substring "abcde" 0 3))

; step 1
(foo "abc")

; step 2
(if (string=? (substring "abc" 0 1) "a")
    (string-append "abc" "a")
    "abc")

; step 3
(if (string=? "a" "a")
    (string-append "abc" "a")
    "abc")

; step 4
(if true (string-append "abc" "a") "abc")

; step 5
(string-append "abc" "a")

; step 6 - output
"abca"
```

### Question 15: More Foo Evaluation

[more-foo-evaluation-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/stepper/more-foo-evaluation-starter.no-image.rkt)

> Given the following function definition:
> 
> 
> (define (foo n)
>   (* n n))
> 
> Write out the step-by-step evaluation of the expression:
> 
> (foo (+ 3 4))
> 
> Be sure to show every intermediate evaluation step.
> 

```racket
(define (foo n)
  (* n n))

; expression
(foo (+ 3 4))

; step 1
(foo 7)

; step 2
(* 7 7)

; step 3 - output
49
```

### Question 16: Even More Foo Evaluation

[even-more-foo-evaluation-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/stepper/even-more-foo-evaluation-starter.no-image.rkt)

> Given the following function definition:
> 
> 
> (define (farfle s)
>   (string-append s s))
> 
> Write out the step-by-step evaluation of the expression:
> 
> (farfle (substring "abcdef" 0 2))
> 
> Be sure to show every intermediate evaluation step.
> 

```racket
(define (farfle s)
  (string-append s s))

; expression
(farfle (substring "abcdef" 0 2))

; step 1
(farfle "ab")

; step 2
(string-append "ab" "ab")

; step 3 - output
"abab"
```

### Question 17: Booble Evaluation

[bobble-evaluation-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/master/course/week-01a/stepper/bobble-evaluation-starter.no-image.rkt)

> Given the following function definition:
> 
> 
> (define (bobble s)
>   (if (<= (string-length s) 6)
>       (string-append s "ible")
>       s))
> 
> Write out the step-by-step evaluation of the expression:
> 
> (bobble (substring "fungus" 0 4))
> 
> Be sure to show every intermediate evaluation step (including the original expression
> and the final result, our answer has 7 steps).
> 

```racket
(define (booble s)
  (if (<= (string-length s) 6)
      (string-append s "ible")
      s))

; expression
(booble (substring "fungus" 0 4))

; step 1
(booble "fung")

; step 2
(if (<= (string-length "fung") 6)
    (string-append "fung" "ible")
    "fung")

; step 3
(if (<= 4 6) (string-append "fung" "ible") "fung")

; step 4
(if true (string-append "fung" "ible") "fung")

; step 5
(string-append "fung" "ible")

; step 6 - output
"fungible"
```

## Discovering Primitives

[discoveringPrimitives.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01a/course/week-01a/discoveringPrimitives/discoveringPrimitives.rkt)

There are two general techniques for discovering new primitives. The first one is to make a lucky guess. What happens after I’ve been programming for a while with a language, I start to get a pretty good sense of what the naming conventions are.

```racket
(triangle 40 "solid" "purple")
; outputs a filled purple equilateral triangle with sides being 40
```

In the example above, if I am not sure what any of the arguments mean, let’s say the number 40, right-click on Windows, or control-click on Mac, then select: Search in Help Desk for “triangle” (in this case). This brings up the Dr. Racket documentation for “triangle”.

The other technique is called “search and scroll”, where I look up the documentation for a related function and then scroll around looking for the thing I want.

```racket
(/ 3 4)
; outputs 0.75 but I would like to round the number

; after searching the documentation
(round (/ 3 4))
; outputs 1
```