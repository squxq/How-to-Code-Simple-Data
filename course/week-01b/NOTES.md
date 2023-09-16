# 1b: How to Design Functions

## Module Overview

### Learning Goals:

- Be able to use the How to Design Functions (HtDF) recipe to design functions that operate on primitive data.
- Be able to read a complete function design and identify its different elements.
- Be able to evaluate the different elements for clarity, simplicity and consistency with each other.
- Be able to evaluate the entire design for how well it solves the given problem.

Design methods often make simple problems harder to solve. This pays back later by making really hard problems much easier to solve.

## Full Speed HtDF Recipe

[fullSpeedHtDFRecipe.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/fullSpeedHtDFRecipe/fullSpeedHtDFRecipe.no-image.rkt)

The HtDF, how to design functions, recipe systematizes the design of a function, so it tells me what to do first, second, and third, all the way through the design of a function, so we end up with a high-quality function. 

What a design recipe does is it makes hard problems easier. It lets us take a big, hard problem, break it down, and work through it in a systematic fashion. The price we pay for that is that it makes easy problems cumbersome.

The HtDF recipe consists of the following steps:

1. [Signature, purpose and stub.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S1)
2. [Define examples, wrap each in check-expect.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S2)
3. [Template and inventory.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S3)
4. [Code the function body.](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S4)
5. [Test and debug until correct](https://courses.edx.org/courses/course-v1:UBCx+HtC1x+2T2017/77860a93562d40bda45e452ea064998b/#S5)

```racket
; step 1
; Number -> Number ; signature
; produce 2 times the given number ; purpose
; (define (double n) 0) ; stub

; step 2  
(check-expect (double 3) 6)
(check-expect (double 4.2) (* 2 4.2))
; if the examples run it tells me that they are well-formed

; step 3
; (define (double n)
;   (... n))

; step 4 - with a copy of the template
(define (double n)
  (* 2 n))

; step 5
; run the code and check for test errors
```

## Slow Motion HtDF Recipe

[slowMotionHtDFRecipe.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/slowMotionHtDFRecipe/slowMotionHtDFRecipe.rkt)

The first step of the recipe is to write the signature. The job of the signature is to tell me what type of data a function consumes and what type of data it produces. To form a signature:

$$
Type...\ -> Type\\
For\ now,\ primitive\ types\ are:\\
Number,\ Integer,\ Natural,\ String,\ Image,\ Boolean
$$

In this case:

```racket
; step 1 - signature, purpose and stub
;; Number -> Number ; signature
```

Now, the purpose. The job of the purpose is to give me a succinct (1 line) description of what the function produces given what it consumes.

```racket
;; produce 2 times the given number ; purpose
```

The signature and the purpose are permanently commented out so we start each line with ;;(SPACE) to distinguish them from other comments.

The stub is like a piece of scaffolding that we’re going to put in place for a short period of time. So it only lasts a short while, but it will do an important piece of work.

Stub is a function that:

- Has correct function name;
- Has correct number of parameters;
- Produces dummy result of correct type.

```racket
(define (double n) 0) ; stub
```

The second step involves creating examples and tests because they’re going to serve both roles. Sometimes it’s easier to design a general function if I start with some very specific examples of what it’s going to do.

Examples/tests:

- Examples help us understand what function must do.
- Multiple examples to illustrate behavior.
- Wrapping in “check-expect” means they will also serve as unit tests for the completed function.

```racket
; step 2 - define examples (also known as [unit] tests), wrap each in check-expect
(check-expect (double 3) 6)
(check-expect (double 4.2) 8.4)
; Number -> real numbers, integers, natural, etc.
; These two examples serve to really illustrate that I don't just mean integers.
; run the code and check if both tests run, although they will fail that goal is to see if they are well-formed
```

To make sure that the examples, the “check-expects” are well-formed, is where the stub is going to help. By running a program with “check-expects” in it, Dr. Racket checks to see if each one matches the stub’s result. The point here is to see if all the tests run.

Every step of the recipe helps with the steps after it.

The next step of the recipe is the template, sometimes called inventory. The role of the template is to give us the outline of the function. The body of the template is the outline of the function. For now, the body of the template is (… x), where x is the parameter to the function.

```racket
; step 3 - template and inventory
(define (double n)
	(... n))
```

In the next step, coding the function body, I’m going to use what I’ve written before to help me know how to finish the function body. One thing that might be useful sometimes is to elaborate the examples.

```racket
; step 4 - code the function body
(define (double n)
	(* 2 n))
```

The last step is to run the tests, by running the program.

```racket
; step 5 - test and debug until correct
; simply run the program and fix possible issues (errors and warnings)
```

## A Simple Practice Example

[simplePracticeExample.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/simplePracticeExample/simplePracticeExample.no-image.rkt)

Purpose statements are often cumbersome the first time I write them, so it is a good idea to try and rewrite them. Labeling stub and template is always a good practice.

### Question 18: A First HtDF Problem

[firstHtDFProblem.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/simplePracticeExample/firstHtDFProblem.no-image.rkt)

> Design a function that pluralizes a given word. (Pluralize means to convert the word to its plural form.) For simplicity, you may assume that just adding s is enough to pluralize a word.
> 

```racket
; step 1 - signature, purpose and stub
;; String -> String ; signature
;; pluralize given word (only adding s) ; purpose
;(define (pluralize word) "word") ; stub

; step 2 define examples/tests
(check-expect (pluralize "toast") "toasts")
(check-expect (pluralize "school") "schools")

; step 3 - template and inventory
;(define (pluralize word)
;  (... word))

; step 4 - code the function body
(define (pluralize word)
  (string-append word "s"))

; step 5
; run the code and check for test errors
```

Here is a more challenging version of the problem where there are taken into account more plural noun rules:

```racket
; More challenging version
;; String -> String
;; pluralize given word (all pluran noun rules)
;(define (plural word) "word")

(check-expect (plural "cat") "cats")
(check-expect (plural "house") "houses")
; add -s to the end

(check-expect (plural "iris") "irises")
(check-expect (plural "truss") "trusses")
(check-expect (plural "marsh") "marshes")
(check-expect (plural "lunch") "lunches")
(check-expect (plural "tax") "taxes")
(check-expect (plural "blitz") "blitzes")
; if the singular noun ends in -s, -ss, -sh, -ch, -x, -z, add -es - if statement

(check-expect (plural "roof") "roofs")
(check-expect (plural "belief") "beliefs")
(check-expect (plural "chef") "chefs")
(check-expect (plural "chief") "chiefs")
; if the noun ends with -f or -ef, add an -s

(check-expect (plural "city") "cities")
(check-expect (plural "puppy") "puppies")
; if the singular noun ends in -y and the letter before -y is a consonant, change the ending to -ies - if statement

(check-expect (plural "ray") "rays")
(check-expect (plural "boy") "boys")
; if the singular noun ends in -y and the letter before -y is a vowel, add -s

(check-expect (plural "cactus") "cacti")
(check-expect (plural "focus") "foci")
; if the singular noun ends in -us the plural ending is frequently -i - if statement

(check-expect (plural "analysis") "analyses")
(check-expect (plural "allipsis") "allipses")
; if the singular noun ends in -is, the plural ending is -es - if statement

(check-expect (plural "phenomenon") "phenomena")
(check-expect (plural "criterion") "criteria")
; if the singular noun ends in -on, the plural ending is usually -a - if statement

; step 3 - template and inventory
;(define (plural word)
;  (... word))

; step 4 - code the function body
(define esArr (list "s" "ss" "sh" "ch" "x" "z"))
(define vowels (list "a" "e" "i" "o" "u"))

(define (plural word)
  (cond
    ; Check for words ending in "us" except for "us" itself
    ((string=? (substring word (- (string-length word) 2) (string-length word)) "us")
     (string-append (substring word 0 (- (string-length word) 2)) "i"))
    
    ; Check for words ending in "is" except for "iris"
    ((and (string=? (substring word (- (string-length word) 2) (string-length word)) "is")
          (not (string=? word "iris")))
     (string-append (substring word 0 (- (string-length word) 2)) "es"))
    
    ; Check for words ending in certain suffixes
    ((or (member (substring word (- (string-length word) 1) (string-length word)) esArr)
         (member (substring word (- (string-length word) 2) (string-length word)) esArr))
     (string-append word "es"))
    
    ; Check for words ending in "y" after a consonant
    ((and (not (member (substring word (- (string-length word) 2) (- (string-length word) 1)) vowels))
          (string=? (substring word (- (string-length word) 1) (string-length word)) "y"))
     (string-append (substring word 0 (- (string-length word) 1)) "ies"))
    
    ; Check for words ending in "on"
    ((string=? (substring word (- (string-length word) 2) (string-length word)) "on")
     (string-append (substring word 0 (- (string-length word) 2)) "a"))
    
    ; Default case: just add "s" to the word
    (else (string-append word "s"))))

; step 5
; run the code and check for test errors
```

## When Tests are Incorrect

[whenTestsIncorrect.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/whenTestsIncorrect/whenTestsIncorrect.no-image.rkt)

The purpose needs to tell me something more specific than the signature about exactly what we do with the given number and exactly what the number we produce means.

```racket
;; Number -> Number
;; given the length of one side of the square, produce the area of the square

; this is not a good purpose, because it repeats the signature
;; given number produce number

;(define (area s) 0) ; stub
; a good dummy value to produce is 0

(check-expect (area 3) 3) ; for now, pretend you didn't notice this mistake
(check-expect (area 3.2) (* 3.2 3.2))

;(define (area s) ; template
; 	(... s))

(define (area s)
	(* s s))
```

When running this program a failing test comes up: Actual value 9 differs from 3, the expected value. By clicking it, it directs us to the corresponding test where I can spot that the test is wrong: the area of a square with side 3, is 9 not 3 as mentioned in the test.

```racket
(check-expect (area 3) 9)
```

If a test fails (a “check-expect” fails), it could be that:

- The function definition is wrong.
- The test is wrong.
- They are both wrong.

Note: always check the test before fixing the function definition. If a test is wrong and I make the function conform to it, then the function will be wrong.

## Varying Recipe Order

[varyingRecipeOrder.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/varyingRecipeOrder/varyingRecipeOrder.no-image.rkt)

The “How to Design Functions” recipe is not intended to be what’s called a waterfall process. There is some flexibility following the steps of the process.

```racket
;; Image -> Number ; not the most specific signature
;; produce image's width * height (area)

;(define (image-area img) 0) ; stub

(check-expect (image-area (rectangle 2 3 "solid" "red")) (* 2 3))

;(define (image-area img) ; template
; 	(... img))

(define (image-area img)
	(* (image-width img) (image-height img)))
```

Images are always sized in pixels and pixels are always a natural number. If the image’s width and height are always going to be a natural number and I multiply those two, the function returns a Natural, not a Number. When writing the signature for a function, you always want to use the most specific types that are correct (Natural is more specific than Number).

```racket
; this would turn out to be a better signature simply because it's more specific
;; Image -> Natural
```

## Poorly Formed Problems

[poorlyFormedProblems.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/poorlyFormedProblems.no-image.rkt)

Design is the process of going from a poorly formed problem to a well-structured solution. When designing functions which produce a boolean, the purpose specifies how to interpret the output.

```racket
;; Image -> Boolean
;; produce true if the image is tall

; functions that produce a boolean have a name that ends in a question mark

;(define (tall? img) false) ; stub

(check-expect (tall? (rectangle 2 3 "solid" "red")) true)
```

How many tests does this function need? For now, I will assume that it only needs the above test. That won’t turn out to be right, but I’ll see what happens.

```racket
;(define (tall? img)
; 	(... img))

(define (tall? img)
	(if (> (image-height img) (image-width img))
		true
		false)) ; highlighted
```

The test passed but is the function properly tested? One clue that I haven’t, Dr Racket is giving us in the way it’s colored the keyword false.

The highlighting means that after running all the “check-expects” in this file, this part of the program was never evaluated. The tests do not have complete code coverage. Code coverage means: giving all my tests, how much of the code is being evaluated. At a minimum, my tests should have complete code coverage. After all the tests are run there should be no unexecuted code.

```racket
(check-expect (tall? (rectangle 3 2 "solid" "red")) false)
```

What if the image width and height are the same? This is a thing that happens in function and program design all the time. Partway through the design process there’s a boundary condition, or corner case, that I haven’t quite thought of.

Thinking of a new case, or a new subtlety part way through the design is common. When it happens:

- Write an example (test) right away.
- Update all affected parts of design, often this involves purpose and/or function definition.
- It sometimes involves existing tests or even the signature.

```racket
(check-expect (tall? (rectangle 3 3 "solid" "red")) false)

; new purpose
;; produce true if the image is tall (height is greater than width)
```

A minor detail:

$$
(if\ <anything>\ true\ false)\ \ \ \ \ <=>\ \ \ \ \ <anything>
$$

So by definition:

```racket
; it's possible to rewrite the function definition as:
(define (tall? img)
	(> (image-height img) (image-width img)))
```

### Question 19: Summon

[summon-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/summon-starter.no-image.rkt)

> Design a function that generates a summoning charm. For example:

   (summon "Firebolt") should produce "accio Firebolt"
   (summon "portkey")  should produce "accio portkey"
   (summon "broom")    should produce "accio broom"
> 
> 
> See [http://harrypotter.wikia.com/wiki/Summoning_Charm](http://harrypotter.wikia.com/wiki/Summoning_Charm) for background on
> summoning charms.
> 
> Remember, when we say DESIGN, we mean follow the recipe.
> 
> Follow the HtDF recipe and leave behind commented-out versions of the stub and template.
> 

```racket
;; String -> String
;; if string is not empty append "accio " to given string, else return empty string

; stub
;(define (summon word) "")

; tests
(check-expect (summon "Firebolt") "accio Firebolt")
(check-expect (summon "portkey") "accio portkey")
(check-expect (summon "broom") "accio broom")

; template
;(define (summon word)
;  (... word))

; function definition
;(define (summon word)
;  (string-append "accio " word))

; what if string is empty?

; tests
(check-expect (summon "") "")

; re-designing function
(define (summon word)
  (if (> (string-length word) 0)
      (string-append "accio " word)
      ""))
```

### Question 20: Less than Five

[less-than-five-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/less-than-five-starter.no-image.rkt)

> DESIGN function that consumes a string and determines whether its length is
less than 5.  Follow the HtDF recipe and leave behind commented-out versions
of the stub and template.
> 

```racket
;; String -> Boolean
;; return true if given string length is less than five

; stub
;(define (less5? s) "")

; tests
(check-expect (less5? "home") true) ; word length less than 5
(check-expect (less5? "toast") false) ; word length equal to 5
(check-expect (less5? "gregarious") false) ; word length greater than 5

; template
;(define (less5? s)
;  (... s))

; function definition
(define (less5? s)
  (< (string-length s) 5))
```

### Question 21: Boxify

[boxify-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/boxify-starter.no-image.rkt)

[boxify-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/boxify-starter.rkt)

> Use the How to Design Functions (HtDF) recipe to design a function that consumes an image,
and appears to put a box around it. Note that you can do this by creating an "outline"
rectangle that is bigger than the image, and then using overlay to put it on top of the image.
For example:

(boxify (ellipse 60 30 "solid" "red")) should produce (open image file):
(overlay (ellipse 60 30 "solid" "red") (rectangle 62 32 "outline" "black"))
> 
> 
> 
> Remember, when we say DESIGN, we mean follow the recipe.
> 
> Leave behind commented out versions of the stub and template.
> 

```racket
;; Image -> Image
;; create a outline rectangle bigger than the given image

; stub
;(define (boxify img) (rectangle 20 10 "ouline" "black"))

; tests
(check-expect (boxify (ellipse 60 30 "solid" "red")) (overlay (ellipse 60 30 "solid" "red") (rectangle 62 32 "outline" "black"))) ; open image file

(define TRIANGLE (triangle 40 "solid" "red"))
(check-expect (boxify (triangle 40 "solid" "red")) (overlay TRIANGLE (rectangle (+ (image-width TRIANGLE) 2) (+ (image-height TRIANGLE) 2) "outline" "black"))) ; open image file

; template
;(define (boxify img)
;  (... img))

; function definition
(define (boxify img)
  (overlay img (rectangle (+ (image-width img) 2) (+ (image-height img) 2) "outline" "black")))
```

### Question 22: Pluralize Stubs

[pluralize-stubs-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/pluralize-stubs-starter.no-image.rkt)

> You are working on designing a function and have completed your signature and purpose.

Write three stubs with different bodies that are consistent with the signature and purpose below.
Put the three stubs in a comment box.

;; String -> String
;; pluralizes str by appending "s" to the end
> 

```racket
; stubs
;(define (pluralize str) "")
;(define (pluralize str) "houses")
;(define (pluralize str) "gardens")

; tests
(check-expect (pluralize "house") "houses")
(check-expect (pluralize "garden") "gardens")
; for strings that are not empty
(check-expect (pluralize "") "")

; template
;(define (pluralize str)
;  (... str))

; function definition
(define (pluralize str)
  (if (> (string-length str) 0)
      (string-append str "s")
      ""))
```

### Question 23: Blue Triangle

[blue-triangle-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/blue-triangle-starter.no-image.rkt)

> Design a function that consumes a number and produces a blue solid triangle of that size.

You should use The How to Design Functions (HtDF) recipe, and your complete design should include
signature, purpose, commented out stub, examples/tests, commented out template and the completed function.
> 

```racket
;; Natural -> Image ; its a Natural because pixels are Natural Numbers
;; return a blue solid triangle with side size of given natural number (pixels)

; stub
;(define (generateTriangle num) (triangle 40 "solid" "blue"))

; tests
(check-expect (generateTriangle 20) (triangle 20 "solid" "blue"))
(check-expect (generateTriangle 0) "Must provide a Natural number.")
(check-expect (generateTriangle -10) "Must provide a Natural number.")

; template
;(define (generateTriangle num)
;  (... num))

; function definition
(define (generateTriangle num)
  (if (> num 0)
      (triangle num "solid" "blue")
      "Must provide a Natural number."))
```

### Question 24: Double Error

[double-error-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/double-error-starter.no-image.rkt)

> There may be more than one problem with this function design. Uncomment
the function design below, and make the minimal changes required to
resolve the error that occurs when you run it.
> 

```racket
;;; Number -> Number
;;; doubles n ; bad purpose
;(check-expect (double 0) 0)
;(check-expect (double 4) 8)
;(check-expect (double 3.3) (* 2 3.3))
;(check-expect (double -1) -2)
;
;#;
;(define (double n) 0) ; stub
;
;; no template
;
;(define (double n)
;  (* (2 n)))
;; outputs function call: expected a function after the open parenthesis, but found a number

;; Number -> Number
;; multiplies given number by 2 ; better purpose

(check-expect (double 0) 0)
(check-expect (double 4) 8)
(check-expect (double 3.3) (* 2 3.3))
(check-expect (double -1) -2)

#;
(define (double n) 0) ; stub

; template
;(define (double n)
;  (... n))

(define (double n)
  (* 2 n))
```

### Question 25: Make Box

[make-box-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/make-box-starter.no-image.rkt)

> You might want to create boxes of different colors.

Use the How to Design Functions (HtDF) recipe to design a function that consumes a color, and creates a
solid 10x10 square of that colour.  Follow the HtDF recipe and leave behind commented-out versions of
the stub and template.
> 

```racket
; Strings, symbols, and color structs are allowed as colors.
; (image-color? x) -> boolean, x: any/c

;; Color <String, Symbol, Color Structs> -> Image
;; Return a solid 10x10 Square of given color

; stub
;(define (generateSquare color) (square 10 "solid" "red"))

; tests
(check-expect (generateSquare "red") (square 10 "solid" "red"))
(check-expect (generateSquare "Red") (square 10 "solid" "Red"))
; colors are not case sensitive, so both "red" and "Red" are allowed
(check-expect (generateSquare "light orange") (square 10 "solid" "light orange"))
(check-expect (generateSquare "lightorange") (square 10 "solid" "lightorange"))
; Spaces are not considered, so "light orange" is the same as "lightorange"
; the complete list of colors is the same as the colors allowed in color-database<%>
(check-expect (generateSquare "transparent") (square 10 "solid" "transparent"))
; and the color "transparent"
(check-expect (generateSquare "light brown") (square 10 "solid" "light brown"))
; and the additional variants of the colors: Brown, Cyan, Goldenrod, Gray, Green, Orange, Pink, Purple, Red, Turquoise, and Yellow, like "light brown"

;(struct color (red green blue alpha)
;  #:extra-constructor-name make-color)
;  red : (integer-in 0 255)
;  green : (integer-in 0 255)
;  blue : (integer-in 0 255)
;  alpha : (integer-in 0 255)

(check-expect (generateSquare (make-color 255 0 255)) (square 10 "solid" (make-color 255 0 255)))
; colors as color struct using the constructor make-color

(check-expect (generateSquare "hello") "Please provide a valid color.")
(check-expect (generateSquare "") "Please provide a valid color.")
; for Strings that are not valid colors

; template
;(define (generateSquare color)
;  (... color))

; function definition
(define (generateSquare color)
  (if (image-color? color)
      (square 10 "solid" color)
      "Please provide a valid color."))
```

### Question 26: Ensure Question

[ensure-question-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/ensure-question-starter.no-image.rkt)

> Use the How to Design Functions (HtDF) recipe to design a function that consumes a string, and adds "?"
to the end unless the string already ends in "?".

For this question, assume the string has length > 0. Follow the HtDF recipe and leave behind commented
out versions of the stub and template.
> 

```racket
;; String -> String
;; if the given string does not end in "?" append "?"

; important information
; assume the string has length > 0

; stub
;(define (questionMark str) "")

; tests
(check-expect (questionMark "hello") "hello?")
; in case the string does not end in "?"
(check-expect (questionMark "how are you?") "how are you?")
; in case the string already ends in "?"

; template
;(define (questionMark str)
;  (... str))

; function definition
(define (questionMark str)
  (if (not (string=? (substring str (- (string-length str) 1) (string-length str)) "?"))
      (string-append str "?")
      str))
```

### Question 27: Cartesian

[cartesian-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/cartesian-starter.no-image.rkt)

[cartesian-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/poorlyFormedProblems/cartesian-starter.rkt)

> In interactive games it is often useful to be able to determine the distance between two points on
the screen. We can describe those points using Cartesian coordinates as four numbers: x1, y1 and x2, y2.
The formula for the distance between those points is (open image file):
> 
> 
> d=√((x2 – x1)2 + (y2 – y1)2)
> 
> Use the How to Design Functions (HtDF) recipe to design a function called distance that consumes
> four numbers representing two points and produces the distance between the two points.
> 
> Use (distance 3 0 0 4), which should produce 5 as your first example/test. Once your function works with
> that test, try (distance 1 0 0 1) which should produce (sqrt 2). Read the error message carefully and use
> the help desk to figure out how to use check-within for this case.
> 
> Remember, when we say DESIGN, we mean follow the recipe.
> 
> Leave behind commented out versions of the stub and template.
> 
> NOTE:
> 
> The signature for such a function is:
> 
> ;; Number Number Number Number -> Number
> 
> The template for such a function is:
> 
> ; (define (distance x1 y1 x2 y2)
> ;   (... x1 y1 x2 y2))
> 

```racket
;; Number Number Number Number -> Number
;; return the distance of 2 points: (x1, y1) and (x2, y2) with the given coordinates x1 y1 x2 y2 (in this given order)

; stub
;(define (distance x1 y1 x2 y2) 0)

; tests
(check-expect (distance 3 0 0 4) 5)
(check-within (distance 1 0 0 1) (sqrt 2) #i1e-10)

; template
;(define (distance x1 y1 x2 y2)
;  (... x1 y1 x2 y2))

; function definition
(define (distance x1 y1 x2 y2)
  (sqrt (+ (expt (- x2 x1) 2) (expt (- y2 y1) 2))))
```

## Quiz

[quiz.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-01b/course/week-01b/quiz/quiz.no-image.rkt)

This design quiz will have 3 phases:

- In step one you will design a solution to a given problem.
- In step two you will watch the assessment tutorial video (in the next tab).
- In step three you will do a self-assessment of your solution.

> Design a function that consumes two images and produces true if the first is larger than the second.
> 

```racket
;; Image Image -> Boolean
;; return true if the first given image area is greater than the second

; stub
;(define (firstLarger? img1 img2) true)

; tests
(check-expect (firstLarger? (square 10 "solid" "red") (square 20 "solid" "red")) false) ; first is smaller than second
(check-expect (firstLarger? (square 10 "solid" "red") (square 10 "solid" "red")) false) ; first is as big as the second
(check-expect (firstLarger? (square 20 "solid" "red") (square 10 "solid" "red")) true) ; first is bigger than second

(check-expect (firstLarger? "not an image" "not an image") "Please provide two valid images.")
; at least one of the arguments is not an image

; template
;(define (firstLarger? img1 img2)
;  (... img1 img2))

; function definition
(define (firstLarger? img1 img2)
  (if (and (image? img1) (image? img2))
      (> (* (image-width img1) (image-height img1)) (* (image-width img2) (image-height img2)))
      "Please provide two valid images."))
```

Your design will be assessed using the following rubric:

- Is the program "commit ready"?

- The file should be neat and tidy, no tests or code should be commented out other than stubs and templates and all scratch work should be removed. The indentation should conform to course conventions and typing CMD-I (CTL-I on Windows) should not move anything. (But note that limitations of the peer tool mean that indentation can only be self-assessed.)
- Is the design complete? All HtDF design elements should be present, and each element should be well-formed.
- Does the design have high internal quality? The signature should be correct, the purpose should be clear and succinct, the examples should be sufficient to test and explain the function. The function name should be well chosen and should describe what the function does, not how it does it. The stub should match the signature. The template should be correct. The function body should be clear. When the program is run all the tests should pass, and those tests should cover the entire program.
- Does the design satisfy the problem requirements? The function design should satisfy the problem statement. If there is any ambiguity in the problem statement the function design should identify and resolve that ambiguity.