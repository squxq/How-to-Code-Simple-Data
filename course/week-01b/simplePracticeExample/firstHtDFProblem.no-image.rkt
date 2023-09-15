;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname firstHtDFProblem.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Problem:
;
;Design a function that pluralizes a given word.
;(Pluralize means to convert the word to its plural form.)
;For simplicity you may assume that just adding s is enough to pluralize a word.

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