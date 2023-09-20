# 02: How to Design Data

## Module Overview

While systems tend to have more function designs than data designs, the design of the data turns out to drive the design of the functions. So data design is a critical part of program design.

### Learning Goals:

- Be able to use the How to Design Data Definitions (HtDD) recipe to design data definitions for atomic data.
- Be able to identify problem domain information that should be
represented as simple atomic data, intervals, enumerations, itemizations and mixed data itemizations.
- Be able to use the Data Driven Templates recipe to generate templates for functions operating on atomic data.
- Be able to use the How to Design Functions (HtDF) recipe to design functions operating on atomic data.

## Cond Expressions

[condExpressions.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/condExpressions/condExpressions.no-image.rkt)

The design of data turns out to be a point of leverage in designing programs because when I design data, I make decisions about all the functions that later operate on that data. This section covers “cond” expressions, which are an expression in Racket that are going to let us program conditional behavior where there are more than just two cases.

```racket
(define I1 (rectangle 10 20 "solid" "red"))
(define I2 (rectangle 20 20 "solid" "red"))
(define I3 (rectangle 20 10 "solid" "red"))

;; Image -> String
;; produce shape of image, one of "tall", "square" or "wide"
(check-expect (aspect-ratio I1) "tall")
(check-expect (aspect-ratio I2) "square")
(check-expect (aspect-ratio I3) "wide")

;(define (aspect-ratio img) "")  ;stub

;(define (aspect-ratio img)      ;template
;  (... img))

(define (aspect-ratio img)  
  (if (> (image-height img) (image-width img))
      "tall"
      (if (= (image-height img) (image-width img))
          "square"
          "wide")))
```

There is something, in the previous function that I’m not entirely happy about. There are three cases: the tall case, the square case, and the wide case. Those three cases are parallel/corresponding cases, but using the “if” statement, 2 cases are “inside the false answer” of the first.

There is this mechanism called “cond”, that’s what’s called a multi-armed conditional. That is something I can use when I want to make an expression that has different behavior depending on the answer to predicates and there are more than two different options.

```racket
(define (aspect-ratio img)
	(cond [(> (image-height img) (image-width img) "tall"]
				[(= (image-height img) (image-width img) "square"]
				[else "wide"]))

; both () and [] are equivalent, but by convention, we use [] around question/answer pairs in cond.
; this makes the cond easier to read.
```

Note: #; comments out the entire expression or definition that follows it

To form “cond” expression:

$$
(cond\ [<expression>\ <expression>]...)\\
Each\ question\ must\ evaluate\ to\ a\ boolean.\ Last\ question\ can\ be\ else.
$$

> Given the following definition:
> 
> 
> 
> (define (absval n)
>   (cond [(> n 0) n]
>         [(< n 0) (* -1 n)]
>         [else 0]))
> 
> Hand step the execution of:
> 
> (absval -3)
> 

To evaluate a “cond” expression:

- If there are no question/answer pairs, signal an error.
- If the first question is not a value, evaluate it and replace it with its value. That is, replace the entire “cond” with a new “cond” in which the first question has been replaced by its value.
- If the first question is true or else, replace the entire “cond” expression with the first answer.
- If the first question is false drop the first question/answer pair. That is, replace the “cond” with a new “cond” that does not have the first question/answer pair.
- Since the first question is not, true or false, signal an error.

```racket
; expression
(cond [(> 1 2) "bigger"]
	[(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 1
(cond [false "bigger"]
	[(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 2
(cond [(= 1 2) "equal"]
	[(< 1 2) "smaller"])

; step 3
(cond [false "equal"]
	[(< 1 2) "smaller"])

; step 4
(cond [(< 1 2) "smaller"])

; step 5
(cond [true "smaller"])

; step 6 - smaller
"smaller"
```

Rules for function calls, “if” and “cond” all work by trying to reduce the program to a simpler program that does not have that construct:

- Function call is replaced with body;.
- “if” is replaced with true or false question.
- “cond” is replaced with one answer.

### Question 28: Problem 1

[problem-01.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/condExpressions/problem-01.no-image.rkt)

> Given the following definition:
> 
> 
> 
> (define (absval n)
>   (cond [(> n 0) n]
>         [(< n 0) (* -1 n)]
>         [else 0]))
> 
> Hand step the execution of:
> 
> (absval -3)
> 

```racket
(define (absval n)
  (cond [(> n 0) n]
        [(< n 0) (* -1 n)]
        [else 0]))

(absval -3)

; step 1
(cond ((> -3 0) -3) ((< -3 0) (* -1 -3)) (else 0))

; step 2
(cond (#false -3) ((< -3 0) (* -1 -3)) (else 0))

; step 3
(cond ((< -3 0) (* -1 -3)) (else 0))

; step 4
(cond (#true (* -1 -3)) (else 0))

; step 5
(* -1 -3)

; step 6 - output
3
```

## Data Definitions

[dataDefinitions.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/dataDefinitions/dataDefinitions.no-image.rkt)

Suppose you are working on a program someone else wrote that simulates traffic. In the program, there are traffic lights and cars and streets and things like that. While reading the program you come across this function:

```racket
(define (next-color c)
  (cond [(= c 0) 2]
        [(= c 1) 0]
        [(= c 2) 1]))
```

What does it do? The name is a hint, it seems to produce the "next color". But it’s hard to be sure.

Surely if the programmer had followed the HtDF recipe this would be better, wouldn't it? Suppose instead the code looked like this.

```racket
;; Natural -> Natural
;; produce next color of traffic light
(check-expect (next-color 0) 2)
(check-expect (next-color 1) 0)
(check-expect (next-color 2) 1)

;(define (next-color c) 0)  ;stub

;(define (next-color c)     ;template
;  (... c))

(define (next-color c)
  (cond [(= c 0) 2]
        [(= c 1) 0]
        [(= c 2) 1]))
```

That's a little better. At least it is now clear that the function does produce the next color. And the tests make it clear that the function is really supposed to produce 2 when it is called with 0. But what are the 0, 1, and 2 about? And what about calling the function with 3? The signature says that is OK, but the cond in the body will signal an error in that case.

```racket
;; Data definitions:

;; TLColor is one of:
;;  - 0
;;  - 1
;;  - 2
;; interp. 0 means red, 1 yellow, 2 green               
#;
(define (fn-for-tlcolor c)
  (cond [(= c 0) (...)]
        [(= c 1) (...)]
        [(= c 2) (...)]))

;; Functions

;; TLColor -> TLColor
;; produce next color of traffic light
(check-expect (next-color 0) 2)
(check-expect (next-color 1) 0)
(check-expect (next-color 2) 1)

;(define (next-color c) 0)  ;stub

; Template from TLColor

(define (next-color c)
  (cond [(= c 0) 2]
        [(= c 1) 0]
        [(= c 2) 1]))
```

In any program, we have what we call the problem domain. In this case, the problem domain has to do with traffic and simulation of traffic, traffic lights, cars, etc. But inside the program, we don’t have red lights or green lights, we have data. When we design a program, we represent information in the problem domain using data in the program. Data in the program can be interpreted as information in the program's domain.

Data definitions will describe how we are representing information as data. The data definition starts with a type comment which defines a new type name and shows how to form data of that type. Interpretation explains how to interpret data of this type as information thereby establishing the information/data correspondence. There is also a template skeleton for one-argument functions that consume of this type.

```racket
;; A small part of a traffic simulation.

;; Data definitions:

;; TLColor is one of:
;;  - "red"
;;  - "yellow"
;;  - "green"
;; interp. "red" means red, "yellow" yellow, "green" green
#;
(define (fn-for-tlcolor c)
  (cond [(string=? c "red") (...)]
        [(string=? c "yellow") (...)]
        [(string=? c "green") (...)]))

;; Functions

;; TLColor -> TLColor
;; produce next color of traffic light
(check-expect (next-color "red") "green")
(check-expect (next-color "yellow") "red")
(check-expect (next-color "green") "yellow")

;(define (next-color c) "red")  ;stub

; Template from TLColor

(define (next-color c)
  (cond [(string=? c "red")    "green"]
        [(string=? c "yellow") "red"]
        [(string=? c "green")  "yellow"]))
```

Data definition describes:

- How to form data of a new type.
- How to represent information as data.
- How to interpret data as information.
- Template for operating on data.

Data definition simplifies function:

- Restricts data consumed.
- Restricts data produced.
- Helps generate examples.
- Provides template.

## Atomic Non-Distinct

[atomicNonDistinct.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/atomicNonDistinct/atomicNonDistinct.no-image.rkt)

> Imagine that you are designing a program that, among other things, has information about the names of cities in its problem domain.
> 
> 
> Design a data definition to represent the name of a city.
> 

The first key thing that we do when we design a data definition is to work out the form of the information we’re trying to represent. In this scenario, we are trying to represent city names, Vancouver and Boston. This information is atomic, which means I can’t take it apart into pieces that are meaningfully part of the same problem domain.

```racket
;INFORMATION:        DATA          
;
;Vancouver           "Vancouver"
;
;Boston              "Boston"
```

The first step of the recipe is to identify the inherent structure of the information.

Once that is done, a data definition consists of four or five elements:

1. A possible **structure definition** (not until compound data)
2. A **type comment** that defines a new type name and describes how to form data of that type.
3. An **interpretation** that describes the correspondence between information and data.
4. One or more **examples** of the data.
5. A **template** for a 1 argument function operating on data of this type.

```racket
;; CityName is String ; type comment
;; interp. the name of a city ; interpretation

; examples
(define CN1 "Boston")
(define CN2 "Vancouver")

; template
#;
(define (fn-for-city-name cn)
  (... cn))

;; Template rules used:
;; atomic non-distinct: String
```

## HtDF With Non-Primitive Data

[HtDFNonPrimitiveData.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/HtDFNonPrimitiveData/HtDFNonPrimitiveData.no-image.rkt)

Data defined by my own data definition is called non-primitive data. The goal is to design a function with non-primitive data. We will be doing this with the previous section data definition:

```racket
;; Data definitions:

;; CityName is String
;; interp. the name of a city
(define CN1 "Boston")
(define CN2 "Vancouver")
#;
(define (fn-for-city-name cn)
  (... cn))

;; Template rules used:              For the first part of the course
;;   atomic non-distinct: String     we want you to list the template
;;                                   rules used after each template.
;;
```

Following the HtDF recipe:

```racket
;; Functions:

;; CityName -> Boolean
;; produce true if given city is the best in the world

(define (best? cn) false) ; stub
```

For the examples/tests we need at least one test that produces true and one that produces false.

```racket
; tests
(check-expect (best? "Boston") false)
(check-expect (best? "Hogsmeade") true)
```

Templates tell me everything I have available to work with, not what I must work with. So oftentimes I’ll be deleting parts out of templates.

```racket
; took template from CityName
(define (best? cn)
  (string=? cn "Hogsmeade"))
```

### Question 29: Problem 1

[problem-01.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/HtDFNonPrimitiveData/problem-01.no-image.rkt)

[problem-01.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/HtDFNonPrimitiveData/problem-01.rkt)

> You are working on an extension to DrRacket.
The extension operates on the icons displayed in the DrRacket user interface.
This includes (open image file) and (open image file) and the other icons you see.
> 
> 
> Create a data definition for a non-primitive data type called Icon and a function definition to
> 
> determine what command each Icon is responsible for. Follow the HtDF and HtDD recipes.
> 

```racket
;; Data Definitions

;; Icon is Image
;; interp. the image of an icon
(define I1 [open image file])
(define I2 [open image file])

#;
(define (fn-for-icon icon)
  (... icon))

;; Template rules used:
;; atomic non-distinct: Image

;; Functions

;; Icon -> String
;; given one of the two possible icons produce its related command

;(define (icon-cmd icon) "debug") ;stub

;; tests
(check-expect (icon-cmd [open image file]) "stepper")
(check-expect (icon-cmd [open image file]) "run")

;; took template from Icon
(define (icon-cmd icon)
  (cond [(image=? icon [open image file]) "stepper"]
        [(image=? icon [open image file]) "run"]))
```

## HtDF X Structure of Data Orthogonality

Some of the power of working with a systematic design process is that there’s always the next step of the recipe, which tells me what I need to write and where I should be looking to figure out how to write it. We also produce uniformly structured code. Code that’s easy for other programmers to read and code that has an appropriate number of tests.

Because the design method itself is structured so that the how-to-design function is orthogonal, as we learn more forms of data, the function recipe continues to work unchanged.

The HtDF (and HtDW) recipes work with all forms of data. The recipe is mostly orthogonal (at right angle) to any form of data so I get the cross-product easily.

## Interval

[interval.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/interval/interval.no-image.rkt)

> Imagine that you are designing a program to manage ticket sales for a
theatre. (Also imagine that the theatre is perfectly rectangular in shape!)
> 
> 
> Design a data definition to represent a seat number in a row, where each
> row has 32 seats. (Just the seat number, not the row number.)
> 

Notes:

- [] brackets mean inclusive at that end of the interval.
- () parenthesis mean exclusive.
- Natural is integers starting at 1, so 1, 2, …
- Number includes all real numbers.

```racket
;; Note: Natural [1, 32) does not include 32

;; Data Definitions:

;; SeatNum is Natural[1, 32]
```

Anything that would help me understand exactly what the numbers 1, 32, and the numbers in between mean is that I would put in the interpretation.

```racket
;; interp. seat numbers in a row, 1 and 32 are aisle seats
```

I should always have at least one example, and more if they’re illustrative.

```racket
; examples
(define SN1 1) ;aisle
(define SN2 12) ;middle
(define SN3 32) ;aisle

#;
(define (fn-for-seat-num sn)
  (... sn))

;; Template rules used:
;; - atomic non-distinct: Natural[1, 32]
```

### Question: 30: Style Rules

[style-rules-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/interval/style-rules-starter.no-image.rkt)

> You're redesigning the SeatNum data definition from lecture, and you're not
sure if you've done it correctly. When you ask a TA for feedback, she tells
you that you haven't followed our style rules and she asks you to re-format
your data definition before she gives you feedback.

a) Why is it important to follow style rules?

b) Fix the data definition below so that it follows our style rules. Be sure to
consult the style rules page so that you make ALL the required changes, of which
there are quite a number.
> 

```racket
;Following style rules in programming is essential because it enhances code readability,
;eases collaboration among developers, and simplifies code maintenance. Consistent style
;improves code quality, facilitates effective code reviews, and allows for the automation
;of error detection and correction. It also ensures portability, supports career advancement,
;encourages adherence to best practices, aids in documentation, and promotes consistency
;across projects, making it a fundamental aspect of professional software development.

;; Data Defnitions:

;; SeatNum is Natural[1,32]
;; interp. the number of a seat in a row, 1 and 32 are aisle seats

;; Examples:
(define SN1 1)
(define SN2 15)
(define SN3 32)

;; Template:
#;
(define (fn-for-seat-num sn)
  (... sn))

;; Template rules used:
;; - atomic non-distinct: Natural[1,32]
```

## Enumeration

[enumeration.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/enumeration.no-image.rkt)

> As part of designing a system to keep track of student grades, you
are asked to design a data definition to represent the letter grade
in a course, which is one of A, B or C.
> 

The key thing about the information in this problem is that there are three distinct values: A, B, or C.

```racket
;; LetterGrade is on of:
;; - "A"
;; - "B"
;; - "C"
```

For enumerations,especially those with strings as data, the interpretations tend to be straightforward.

```racket
;; interp. the letter grade in the course
```

Because it’s an enumeration, there are only three values, so we know what the examples are before getting to the enumeration stage. Examples are redundant for enumerations.

```racket
;; <examples are redundant for enumeration>
```

The body of the template is a “cond” statement with one clause per subclass of “one of”, in this case: A, B, or C. For each question and answer expression, I’m going to form it by following the rule in the question or answer column of this table for the corresponding case.

“A” is an atomic distinct value, which means there is a single specific value.

```racket
(define (fn-for-letter-grade lg)
  (cond [(string=? lg "A") (...)] ;because "A" is atomic distinct we don't need lg after
        [(string=? lg "B") (...)] ;in this case of the "cond", lg will always be "A"
        [(string=? lg "C") (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct value: "A"
;; - atomic distinct value: "B"
;; - atomic distinct value: "C"
```

This is an enumeration because the domain information consists of two or more distinct values.

### Question: 31: Letter Grade Error

[letter-grade-error-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/letter-grade-error-starter.no-image.rkt)

> You're working with a revised version of the LetterGrade data definition that
you saw in lecture to design a function that produces true if a given LetterGrade
represents a passing grade in a course. You're working through HtDF and have
completed the signature, purpose, stub and examples, but you're getting an
error message.  Uncomment the code in the box below and revise it until
all the tests run (even though several tests still fail).
> 

```racket
;; Data Definitions:

;; LetterGrade is one of: 
;;  - "A"
;;  - "B"
;;  - "C"
;;  - "D"
;;  - "F"
;; interp. a grade in a course
;; <examples are redundant for enumerations>
#;
(define (fn-for-letter-grade lg)
  (cond [(string=? "A" lg) (...)]
        [(string=? "B" lg) (...)]
        [(string=? "C" lg) (...)]
        [(string=? "D" lg) (...)]
        [(string=? "F" lg) (...)]))

;; LetterGrade -> Boolean
;; produce true if the LetterGrade represents a passing grade

;; Stub:
#;
(define (pass? lg) true)

;; Tests:
(check-expect (pass? "A") true)
(check-expect (pass? "B") true)
(check-expect (pass? "C") true)
(check-expect (pass? "D") true)
(check-expect (pass? "F") false)

;; <took tamplate from LetterGrade>
(define (pass? lg)
  (cond [(string=? "A" lg) true]
        [(string=? "B" lg) true]
        [(string=? "C" lg) true]
        [(string=? "D" lg) true]
        [(string=? "F" lg) false]))
```

## Itemization

[itemization.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/itemization.no-image.rkt)

In this HtDD problem, the type comment is going to end up with a “one of”, but not all of the subclasses are going to be single distinct values. This is what’s called itemization.

> Consider designing the system for controlling a New Year's Eve
display. Design a data definition to represent the current state
of the countdown, which falls into one of three categories:
> 
> - not yet started
> - from 10 to 1 seconds before midnight
> - complete (Happy New Year!)

The previous problem, the letter grade problem, also had 3 categories, but here the categories are different. The first one is distinct, the second one is not since it can be a number from 10 all the way to 1. The third category is distinct.

Use an itemization when domain information is comprised of 2 or more subclasses, at least one of which is not a distinct data item.

```racket
;; Countdown is one of:
;; - false
;; - Natural[1, 10]
;; - "Complete!"
;; interp.
;;   false           means countdown has not yet started
;;   Natural[1, 10]  means countdown is running and how many seconds left
;;   "Complete!"     means countdown is over

;; examples
(define CD1 false)
(define CD2 10) ;just started running
(define CD3 3) ;almost over
(define CD4 "Complete!")
```

This is a mixed data itemization: Boolean, Natural, String. In a mixed data itemization template, the type-specific predicates (i.e. ≤) must be guarded against being called on the wrong type of data. It is permissible to use else for the last question for itemization’s and large enumerations. For the template:

```racket
;; Template v1
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(and (number? c) (<= 1 c) (<= c 10)) (... c)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: false
;; - atomic non-distinct: Natural[1, 10]
;; - atomic distinct: "Complete!"
```

The reason we are allowed to put else in the last question is because we assume the function is called with arguments that match its signature. In other programming languages this will be enforced automatically.

Because there can be different data types in the itemization, we end up having to put a guard to make sure that we don’t accidentally hand the string complete to this “less than or equal to”: (number? c). The template can be simplified tho:

```racket
;; Template v2
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(number? c) (... c)]
        [else (...)]))
```

If all the remaining cases are the same data type, the you don’t need the guards.

There are two rules for simplifying mixed data itemization templates:

- If a given subclass is the last subclass of its type, we can reduce the test to just the guard, i.e. (number? c).
- If all remaining subclasses are of the same type, then we can eliminate all of the guards.

### Question 32: TLight with Fail

[tlight-w-fail-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/tlight-w-fail-starter.no-image.rkt)

> Design a data definition for a traffic light that can either be disabled,
or be one of red, yellow, or green.
> 

```racket
;; Data Definitions:

;; TLight is one of:
;; - false
;; - "red"
;; - "yellow"
;; - "green"
;; interp. false means the light is disabled, otherwise the color of the light

;; Examples:
(define TL1 false)
(define TL2 "red")
(define TL3 "yellow")
(define TL4 "green")

;; Template
(define (fn-for-tlight tl)
  (cond [(false? tl) (...)]
        [(string=? tl "red") (...)]
        [(string=? tl "yellow") (...)]
        [(string=? tl "green") (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: false
;; - atomic distinct: "red"
;; - atomic distinct: "yellow"
;; - atomic distinct: "green"
```

## HtDF with Interval

[aisle-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/interval/aisle-starter.no-image.rkt)

Given the data definition SeatNum from the Interval section:

> Using the SeatNum data definition below design a function
that produces true if the given seat number is on the aisle.
> 

```racket
;; Data definitions:

;; SeatNum is Natural[1, 32]
;; Interp. Seat numbers in a row, 1 and 32 are aisle seats
(define SN1  1) ;aisle
(define SN2 12) ;middle
(define SN3 32) ;aisle
#;
(define (fn-for-seat-num sn)
  (... sn)) 

;; Template rules used:
;;  atomic non-distinct: Natural[1, 32]

;; Functions:

;; SeatNum -> Boolean
;; produce true if the given seat number is on the aisle

(define (aisle? sn) false) ;stub
```

I know that I have an interval with two closed endpoints, so I know that what I’m going to need are three tests. Two for the endpoints and one for the middle, which doesn’t need to be right in the middle; we just need to check the behavior for numbers in the interval that are not endpoints:

```racket
;; Examples
(check-expect (aisle? SN1) true)
(check-expect (aisle? SN2) false)
(check-expect (aisle? SN3) true)

;; <Took template from SeatNum>
(define (aisle? sn)
  (or (= sn 1) (= sn 32)))
```

### Question 33: Employees

[employees-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/interval/employees-starter.no-image.rkt)

> You work in the Human Resources department at a ski lodge.
Because the lodge is busier at certain times of year,
the number of employees fluctuates.
There are always more than 10, but the maximum is 50.

Design a data definition to represent the number of ski lodge employees.
Call it Employees.
> 
> 
> Design a function that will calculate the total payroll for the quarter.
> Each employee is paid $1,500 per quarter. Call it calculate-payroll.
> 

```racket
;; =================
;; Data definitions:

;; Employees is Natural[10, 50]
;; interp. number of ski lodge employees, 10 is the minimum and 50 is the maximum number of employees

; examples
(define E1 10) ;minimum number of employees in a less busier time of the year
(define E2 30) ;middle number of employees in a moderate time of the year
(define E3 50) ; maximum number of employees in a very busy time of the year

#;
(define (fn-for-employees e)
  (... e))

;; Template rules used:
;; - atomic non-distinct: Natural[10, 50]

;; =================
;; Functions:

;; Note: the function output is a Natural, because: Natural * Natural = Natural

;; Employees -> Natural
;; calculate the total payroll for all employees in a quarter, each of them is paid $1,500

#;
(define (calculate-payroll e) 0) ;stub

;; tests
(check-expect (calculate-payroll E1) 15000)
(check-expect (calculate-payroll E2) 45000)
(check-expect (calculate-payroll E3) 75000)

;; Took template from Employees:
(define (calculate-payroll e)
  (* e 1500))
```

## HtDF with Enumeration

[bump-up-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/bump-up-starter.no-image.rkt)

In these examples, we have a single data definition and a single function that goes with it. In normal programs, there tends to be many function that consume data defined by a single data defined by a single data definition. We do not normally design a separate data definition for each function.

Given the data definition LetterGrade from the Enumeration section:

> Using the LetterGrade data definition below design a function that
consumes a letter grade and produces the next highest letter grade.
Call your function bump-up.
> 

```racket
;; Data definitions:

;; LetterGrade is one of: 
;;  - "A"
;;  - "B"
;;  - "C"
;; interp. the letter grade in a course
;; <examples are redundant for enumerations>
#;
(define (fn-for-letter-grade lg)
  (cond [(string=? lg "A") (...)]
        [(string=? lg "B") (...)]
        [(string=? lg "C") (...)]))

;; Template rules used:
;;  one-of: 3 cases
;;  atomic distinct: "A"
;;  atomic distinct: "B"
;;  atomic distinct: "C"

;; Functions:

;; LetterGrade -> LetterGrade
;; produce the next highest letter grade (no change for "A")

(define (bump-up lg) "A") ;stub
```

I need to have at least as many tests as there are cases in the enumeration:

```racket
;; Tests:
(check-expect (bump-up "A") "A")
(check-expect (bump-up "B") "A")
(check-expect (bump-up "C") "B")

;; <use template from LetterGrade>
(define (bump-up lg)
  (cond [(string=? lg "A") "A"]
        [(string=? lg "B") "A"]
        [(string=? lg "C") "B"]))
```

We should check the well-formedness of templates before we comment them out because we want templates to be bug-free, so that when we copy them we don’t copy bugs.

### Question 34: Demolish

[demolish-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/demolish-starter.no-image.rkt)

> You are assigned to develop a system that will classify
buildings in downtown Vancouver based on how old they are.
According to city guidelines, there are three different classification levels:
new, old, and heritage.

Design a data definition to represent these classification levels.
Call it BuildingStatus.

The city wants to demolish all buildings classified as "old".
You are hired to design a function called demolish?
that determines whether a building should be torn down or not.
> 

```racket
;; =================
;; Data definitions:

;; BuildingStatus is one of:
;; - "new"
;; - "old"
;; - "heritage"
;; interp. classification levels of buildings based on how old they are
;; <examples are redundant for enumeration>

;; Template:
#;
(define (fn-for-building-status status)
  (cond [(string=? status "new") (...)]
        [(string=? status "old") (...)]
        [(string=? status "heritage") (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct value: "new"
;; - atomic distinct value: "old"
;; - atomic distinct value: "heritage"

;; =================
;; Functions:

;; BuildingStatus -> Boolean
;; produces true if given building status is "old", else false

#;
(define (demolish? status) false) ;stub

;; tests
(check-expect (demolish? "new") false)
(check-expect (demolish? "old") true)
(check-expect (demolish? "heritage") false)

;; Took template from BuildingStatus.
(define (demolish? status)
  (cond [(string=? status "new") false]
        [(string=? status "old") true]
        [(string=? status "heritage") false]))
```

### Question 35: Season

[season-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/season-starter.no-image.rkt)

> Consider the problem of designing a function called next-season 
that takes the given season and produces the season that follows.
> 

```racket
;; Data Definitions

;; Season is one of:
;; - "spring"
;; - "summer"
;; - "fall"
;; - "winter"
;; interp. the four seasons of the year

;; <examples are redundant for enumeration>

#;
(define (fn-for-season s)
  (cond [(string=? "spring" s) (...)]
        [(string=? "summer" s) (...)]
        [(string=? "fall" s) (...)]
        [(string=? "winter" s) (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: "spring"
;; - atomic distinct: "summer"
;; - atomic distinct: "fall"
;; - atomic distinct: "winter"

;; Function Definitions

;; Season -> Season
;; produce the next season after the given season

#;
(define (next-season s) "spring") ;stub

;; Tests:
(check-expect (next-season "spring") "summer")
(check-expect (next-season "summer") "fall")
(check-expect (next-season "fall") "winter")
(check-expect (next-season "winter") "spring")

;; <used template from Season>
(define (next-season s)
  (cond [(string=? "spring" s) "summer"]
        [(string=? "summer" s) "fall"]
        [(string=? "fall" s) "winter"]
        [(string=? "winter" s) "spring"]))
```

### Question 36: Bike Route

[bike-route-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/bike-route-starter.no-image.rkt)

> Suppose you are developing a route planning tool for bicycling in Vancouver.
There are four varieties of designated bike routes:

1) Separated Bikeway
2) Local Street Bikeway
3) Painted Bike Lane
4) Painted Shared-Use Lane

Use the HtDD recipe to design a data definition for varieties of bike routes (call it BikeRoute)
> 

```racket
;; Data Definitions:

;; BikeRoute is one of:
;; - "Separated Bikeway"
;; - "Local Street Bikeway"
;; - "Painted Bike Lane"
;; - "Painted Shared-Use Lane"
;; interp. varieties of bike routes

;; <Examples are redundant for enumerations.>

;; Template
#;
(define (fn-for-bike-route br)
  (cond [(string=? br "Separated Bikeway") (...)]
        [(string=? br "Local Street Bikeway") (...)]
        [(string=? br "Painted Bike Lane") (...)]
        [(string=? br "Painted Shared-Use Lane") (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: "Separated Bikeway"
;; - atomic distinct: "Local Street Bikeway"
;; - atomic distinct: "Painted Bike Lane"
;; - atomic distinct: "Painted Shared-Use Lane"
```

> Separated bikeways and painted bike lanes are exclusively designated for bicycles, while
local street bikeways and shared-use lanes must be shared with cars and/or pedestrians.

Design a function called 'exclusive?' that takes a bike route and indicates whether it
is exclusively designated for bicycles.
> 

```racket
;; Function Definitions:

;; BikeRoute -> Boolean
;; produce true if bike route is exclusive (only bicycles allowed); else false

;; Stub:
#;
(define (exclusive? br) false)

;; Tests:
(check-expect (exclusive? "Separated Bikeway") true)
(check-expect (exclusive? "Local Street Bikeway") false)
(check-expect (exclusive? "Painted Bike Lane") true)
(check-expect (exclusive? "Painted Shared-Use Lane") false)

;; <Used template from BikeRoute>
(define (exclusive? br)
  (cond [(string=? br "Separated Bikeway") true]
        [(string=? br "Local Street Bikeway") false]
        [(string=? br "Painted Bike Lane") true]
        [(string=? br "Painted Shared-Use Lane") false]))
```

### Question 37: Direction

[direction-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/direction-starter.no-image.rkt)

> Given the data definition below, design a function named left
that consumes a compass direction and produces the direction
that results from making a 90 degree left turn.
> 

```racket
;; =================
;; Data definitions:

;; Direction is one of:
;;  - "N"
;;  - "S"
;;  - "E"
;;  - "W"
;; interp. a compass direction that a player can be facing
;; <examples are redundant for enumerations>
#;
(define (fn-for-direction d)
  (cond [(string=? d "N") (...)]
        [(string=? d "S") (...)]
        [(string=? d "E") (...)]
        [(string=? d "W") (...)]))

;; Template rules used:
;; - one of: 4 cases
;; - atomic distinct: "N"
;; - atomic distinct: "S"
;; - atomic distinct: "E"
;; - atomic distinct: "W"

;; =================
;; Functions:

;; Direction -> Direction
;; produce the direction that results from making a 90 degree left turn, i.e. N -> W

;; Stub:
#;
(define (left d) "N")

;; Tests:
(check-expect (left "N") "W")
(check-expect (left "S") "E")
(check-expect (left "E") "N")
(check-expect (left "W") "S")

;; <took template from Direction>
(define (left d)
  (cond [(string=? d "N") "W"]
        [(string=? d "S") "E"]
        [(string=? d "E") "N"]
        [(string=? d "W") "S"]))
```

### Question 38: Dinner

[dinner-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/enumeration/dinner-starter.no-image.rkt)

> You are working on a system that will automate delivery for
YesItCanFly! airlines catering service.
There are three dinner options for each passenger, chicken, pasta
or no dinner at all.

Design a data definition to represent a dinner order. Call the type
DinnerOrder.
> 

```racket
;; =================
;; Data definitions:

;; DinnerOrder is one of:
;; - "chicken"
;; - "pasta"
;; - false
;; interp. the dinner order, false being no dinner order

;; <examples are redundant for enumerations>

;; Template:
#;
(define (fn-for-dinner-order do)
  (cond [(and (string? do) (string=? do "chicken")) (...)]
        [(and (string? do) (string=? do "pasta")) (...)]
        [else (...)]))

;; Template rules used:
;; - one of: 3 cases
;; - atomic distinct: "chicken"
;; - atomic distinct: "pasta"
;; - atomic distinct: false
```

> Design the function dinner-order-to-msg that consumes a dinner order
and produces a message for the flight attendants saying what the
passenger ordered.

For example, calling dinner-order-to-msg for a chicken dinner would
produce "The passenger ordered chicken."
> 

```racket
;; DinnerOrder -> String
;; produce message with given dinner order

;; Stub:
#;
(define (dinner-order-to-msg do) "")

;; Tests:
(check-expect (dinner-order-to-msg "chicken") "The passenger ordered chicken.")
(check-expect (dinner-order-to-msg "pasta") "The passenger ordered pasta.")
(check-expect (dinner-order-to-msg false) "The passenger didn't make an order.")

;; <took template from DinnerOrder>
(define (dinner-order-to-msg do)
  (cond [(and (string? do) (string=? do "chicken")) "The passenger ordered chicken."]
        [(and (string? do) (string=? do "pasta")) "The passenger ordered pasta."]
        [else "The passenger didn't make an order."]))
```

## HtDF with Itemization

[countdown-to-display-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/countdown-to-display-starter.no-image.rkt)

Given the data definition Countdown from the Itemization section:

> You are asked to contribute to the design for a very simple New Year's
Eve countdown display. You already have the data definition given below.
You need to design a function that consumes Countdown and produces an
image showing the current status of the countdown.
> 

```racket
;; Data definitions:

;; Countdown is one of:
;;  - false
;;  - Natural[1, 10]
;;  - "complete"
;; interp.
;;    false           means countdown has not yet started
;;    Natural[1, 10]  means countdown is running and how many seconds left
;;    "complete"      means countdown is over
(define CD1 false)
(define CD2 10)          ;just started running
(define CD3  1)          ;almost over
(define CD4 "complete")
#;
(define (fn-for-countdown c)
  (cond [(false? c) (...)]
        [(and (number? c) (<= 1 c) (<= c 10)) (... c)]
        [else (...)]))

;; Template rules used:
;;  - one of: 3 cases
;;  - atomic distinct: false
;;  - atomic non-distinct: Natural[1, 10]
;;  - atomic distinct: "complete"

;; Functions:

;; Countdown -> Image
;; produce image of current state of countdown

(define (countdown-to-image c) (square 0 "solid" "white")) ;stub

;; Tests
(check-expect (countdown-to-image false) (square 0 "solid" "white"))
(check-expect (countdown-to-image 5) (text (number->string 5) 24 "black"))
(check-expect (countdown-to-image "complete") (text "happy New Year!!!" 24 "red"))
```

Note that we are making lots of decisions about the function’s behavior while we are working on the examples. This is great, it means that it will be all worked out before we get to the potentially more difficult code the body step.

```racket
;; <used template from Countdown>
(define (countdown-to-image c)
  (cond [(false? c) (square 0 "solid" "white")]
        [(and (number? c) (<= 1 c) (<= c 10)) (text (number->string c) 24 "black")]
        [else (text "happy New Year!!!" 24 "red")]))
```

To rename the “countdown-to-image” function:

1. Click “Check Syntax”.
2. Hover definition or call to see relation between definitions and uses.
3. Hover a function (or constant) name, control-click (MAC), right-click (Windows) and choose “Rename”.

### Question 39: Rocket

[rocket-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/rocket-starter.no-image.rkt)

> You are designing a program to track a rocket's journey as it descends
100 kilometers to Earth. You are only interested in the descent from
100 kilometers to touchdown. Once the rocket has landed it is done.

Design a data definition to represent the rocket's remaining descent.
Call it RocketDescent.
> 
> 
> Design a function that will output the rocket's remaining descent distance
> in a short string that can be broadcast on Twitter.
> When the descent is over, the message should be "The rocket has landed!".
> Call your function rocket-descent-to-msg.
> 

```racket
;; =================
;; Data definitions:

;; RocketDescent is one of:
;; - false
;; - Number[1, 100]
;; interp. false if the rocket has landed, a real number from 1 to 100 for the remaining kms

;; Examples
(define RD1 false) ;the rocket has landed
(define RD2 5) ;the rocket is almost landing
(define RD3 65) ;the rocket is midway through the landing
(define RD4 100) ;the rocket has just start landing

;; Template:
#;
(define (fn-for-rocket-descent rd)
  (cond [(false? rd) (...)]
        [(number? rd) (... a)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - atomic non-distinct: Number[1, 100]

;; =================
;; Functions:

;; RocketDescent -> String
;; return the rocket's remaining descent distance if it has not landed yet, else produce "The rocket has landed!"

#;
(define (rocket-descent-to-msg rd) "") ;stub

;; Tests:
(check-expect (rocket-descent-to-msg false) "The rocket has landed!")
(check-expect (rocket-descent-to-msg 5) "The rocket's remaining descent distance is: 5.")
(check-expect (rocket-descent-to-msg 65) "The rocket's remaining descent distance is: 65.")
(check-expect (rocket-descent-to-msg 100) "The rocket's remaining descent distance is: 100.")

;; Took template from RocketDescent
(define (rocket-descent-to-msg rd)
  (cond [(false? rd) "The rocket has landed!"]
        [(number? rd) (string-append "The rocket's remaining descent distance is: " (number->string rd) ".")]))
```

### Question 40: Rocket Error

[rocket-error-starter.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/rocket-error-starter.rkt)

> Consider the following data definition from the Rocket practice problem.

We have designed a function has-landed?, but there are errors in the function
design. Uncomment the program below, and make the minimal changes possible to
a) make this program work properly and b) make the function design
consistent.
> 

 

```racket
;; =================
;; Data Definitions: 

(@htdd RocketDescent)
;; RocketDescent is one of:
;; - Number(0, 100]
;; - false
;; interp. false if rocket's descent has ended, otherwise number of kilometers
;;         left to Earth, restricted to (0, 100]

;; Examples
(define RD1 100)
(define RD2 40)
(define RD3 0.5)
(define RD4 false)

(@dd-template-rules one-of              ;2 cases
                    atomic-non-distinct ;Number(0, 100]
                    atomic-distinct)    ;false
;; Template:
#;
(define (fn-for-rocket-descent rd)
  (cond [(number? rd)
         (... rd)]
         [else  (...)])) 

;; =================
;; Functions:

(@htdf has-landed?)
(@signature RocketDescent -> Boolean)
;; produce true if rocket's descent has ended; false if it's still descending

;; Stub:
#;
(define (has-landed? r) true) ; stub

;; Tests:
(check-expect (has-landed? 100) false)
(check-expect (has-landed? 23) false)
(check-expect (has-landed? 0.25) false)
(check-expect (has-landed? false) true)

(@template RocketDescent)

(define (has-landed? rd)
  (cond [(number? rd)
         false]
        [else true]))
```

### Question 41: Reservation

[reservation-starter.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/itemization/reservation-starter.no-image.rkt)

> Consider the problem of designing a function called reservation
that produces an image with the given reservation.
> 

```racket
;; Data Definition

;; Reservation is one of:
;; - Natural[1, 100]
;; - "standby"
;; interp.
;;    Natural[1, 100] means a guaranteed seat for dinner where the number
;;                    corresponds to which reservation (not which seat).
;;    "standby"       means a standby spot, if all the reservations show
;;                    up this person will not be seated

;; Examples:
(define R1 1)
(define R2 70)
(define R3 100)
(define R4 "standby")

;; Template
#;
(define (fn-for-reservation r)
  (cond [(number? r) (... r)]
        [else (...)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic non-distinct: Natural[1,100]
;; - atomic distinct: "standby"

;; Function Definition

; Reservation -> Image
;; produces an image with the reservation number if there is a reservation, else returns an image that shows there is no reservation

;; Stub
#;
(define (reservation r) (square 0 "solid" "white"))

;; Tests
(check-expect (reservation R1) (text (string-append "Reservation Number: " (number->string R1) ".") 24 "brown"))
(check-expect (reservation R2) (text (string-append "Reservation Number: " (number->string R2) ".") 24 "brown"))
(check-expect (reservation R3) (text (string-append "Reservation Number: " (number->string R3) ".") 24 "brown"))
(check-expect (reservation R4) (text "This person has no Reservation." 24 "brown"))

;; <used template from Reservation>
(define (reservation r)
  (cond [(number? r) (text (string-append "Reservation Number: " (number->string r) ".") 24 "brown")]
        [else (text "This person has no Reservation." 24 "brown")]))
```

## Structure of Information Flows Through

The point where I can think about the organization of the first part of the course in terms of a cross product between the form of data and how to design function recipe, that points important.

Once we identify the inherent structure of the information, that gives us the structure of the data used to represent it, which gives us the structure of the template, which gives us the structure of the function, and we also get guidance about the tests for that function.

Identifying the structure of the information is a key step in program design. As data definitions get more sophisticated I will see that choosing the structure to use is a point of leverage in designing the overall program.

Designing data is a very high point of leverage for designing programs.

## Quiz

[HtDDDesignQuiz.no-image.rkt](https://github.com/squxq/How-to-Code-Simple-Data/blob/week-02/course/week-02/quiz/HtDDDesignQuiz.no-image.rkt)

This design quiz will have 3 phases:

- In step one you will design a solution to a given problem.
- In step two you will watch the assessment tutorial video (in the next tab).
- In step three you will do a self-assessment of your solution.

> Consider the above data definition for the age of a person.
> 
> 
> Design a function called teenager? that determines whether a person
> of a particular age is a teenager (i.e., between the ages of 13 and 19).
> 

```racket
;; Age is Natural
;; interp. the age of a person in years
(define A0 1)
(define A1 13)
(define A2 16)
(define A3 19)
(define A4 25)

#;
(define (fn-for-age a)
  (... a))

;; Template rules used:
;; - atomic non-distinct: Natural

;; ====================
;; Function Definitions:

;; Age -> Boolean
;; returns true if age is between 13 and 19 (is a teenager)

;; Stub
#;
(define (teenager? a) false)

;; Tests:
(check-expect (teenager? A0) false)
(check-expect (teenager? A1) true)
(check-expect (teenager? A2) true)
(check-expect (teenager? A3) true)
(check-expect (teenager? A4) false)

;; <Took template from Age.>
(define (teenager? a)
  (and (> a 12) (< a 20)))
```

> Design a data definition called MonthAge to represent a person's age
in months.
> 

```racket
;; ================
;; Data Definitions:

;; MonthAge is Natural
;; interp. the age of a person in months

;; Examples:
(define MA0 12)
(define MA1 156)
(define MA2 192)
(define MA3 228)
(define MA4 300)

;; Template:
#;
(define (fn-for-month-age ma)
  (... ma))

;; Template rules used:
;; - atomic non-distinct: Natural
```

> Design a function called months-old that takes a person's age in years
and yields that person's age in months.
> 

```racket
;; =====================
;; Function Definitions:

;; Age -> MonthAge
;; given an age in years, produces that person's age in months

;; Stub:
#;
(define (months-old a) 0)

;; Tests:
(check-expect (months-old A0) MA0)
(check-expect (months-old A1) MA1)
(check-expect (months-old A2) MA2)
(check-expect (months-old A3) MA3)
(check-expect (months-old A4) MA4)

;; <Took template from Age.>
(define (months-old a)
  (* a 12))
```

> Consider a video game where you need to represent the health of your
character. The only thing that matters about their health is:
> 
> - if they are dead (which is shockingly poor health)
> - if they are alive then they can have 0 or more extra lives
> 
> Design a data definition called Health to represent the health of your
> character.
> 
> Design a function called increase-health that allows you to increase the
> lives of a character.  The function should only increase the lives
> of the character if the character is not dead, otherwise the character
> remains dead.
> 

```racket
;; =================
;; Data Definitions:

;; Health is one of:
;; - false
;; - Natural
;; interp. false represents the character is dead, else the number of extra lives the character has

;; Examples
(define H0 false)
(define H1 0)
(define H2 13)

;; Template:
#;
(define (fn-for-health h)
  (cond [(false? h) (...)]
        [else (... h)]))

;; Template rules used:
;; - one of: 2 cases
;; - atomic distinct: false
;; - atomic non-distinct: Natural

;; =====================
;; Function Definitions:

;; Health -> Health
;; if the given health is not false increase it by 1, else the character remains dead (false)

;; Stub:
#;
(define (increase-health h) 0)

;; Tests:
(check-expect (increase-health H0) false)
(check-expect (increase-health H1) 1)
(check-expect (increase-health H2) 14)

;; <Took template from Health.>
(define (increase-health h)
  (cond [(false? h) false]
        [else (+ h 1)]))
```

For this quiz you will be asked to design a function using the HtDF recipe. Your solution will be assessed according to the following rubric:

1. Is the program safe?The program file should be set to use the Beginning Student Language and should have no require declarations in it at all.
2. Is the program "commit ready"? The file should be neat and tidy, no tests or code should be commented out other than stubs and templates and all scratch work should be removed. The indentation should conform
to course conventions and typing CMD-I (CTL-I on Windows) should not
move anything. (But note that limitations of the peer tool mean that
indentation can only be self-assessed.)
3. Is the design complete? All HtDD and HtDF design elements should be present, and each element should be well-formed.
4. Does the design have high internal quality? For Data
Definitions, the type comments should be correct, and the
interpretations should be clear. The examples should cover all cases,
and the template should be complete with the correct template rules
used. For function designs, the signature should be correct, the purpose should be clear and succinct, the examples should be sufficient to test and explain the function. The function name should be well chosen and
should describe what the function does, not how it does it. The stub
should match the signature. The template should be correct. The function body should be clear. When the program is run all the tests should
pass, and those tests should cover the entire program.
5. Does the design satisfy the problem requirements? The design
solutions should satisfy the problem statements. If there is any
ambiguity in the problem statements the solution should identify and
resolve that ambiguity.