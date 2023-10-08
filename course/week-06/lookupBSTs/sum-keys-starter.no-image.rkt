;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname sum-keys-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; sum-keys-starter.rkt

;PROBLEM:
;
;Design a function that consumes a BST and produces the sum of all
;the keys in the BST.

;; Data definitions:

(define-struct node (key val l r))
;; A BST (Binary Search Tree) is one of:
;;  - false
;;  - (make-node Integer String BST BST)
;; interp. false means no BST, or empty BST
;;         key is the node key
;;         val is the node val
;;         l and r are left and right subtrees
;; INVARIANT: for a given node:
;;     key is > all keys in its l(eft)  child
;;     key is < all keys in its r(ight) child
;;     the same key never appears twice in the tree

;; Examples:
(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             false))
(define BST10 (make-node 10 "why" BST3 BST42))

;(open image file)

;; Template:
#;
(define (fn-for-bst t)
  (cond [(false? t) (...)]
        [else
         (... (node-key t)    ;Integer
              (node-val t)    ;String
              (fn-for-bst (node-l t))
              (fn-for-bst (node-r t)))]))

;; Template rules used:
;;  - one of: 2 cases
;;  - atomic-distinct: false
;;  - compound: (make-node Integer String BST BST)
;;  - self reference: (node-l t) has type BST
;;  - self reference: (node-r t) has type BST

;; Function Definitions:

;; BST -> Integer
;; produce the sum of all keys in the give nbinary search tree, t

;; Stub:
#;
(define (sum-all-keys t) 0)

;;  Tests:
(check-expect (sum-all-keys BST0) 0)
(check-expect (sum-all-keys BST1) 1)
(check-expect (sum-all-keys BST4) 11)
(check-expect (sum-all-keys BST3) 15)
(check-expect (sum-all-keys BST42) 83)
(check-expect (sum-all-keys BST10) 108)

;; Template: <used template from BST>

(define (sum-all-keys t)
  (cond [(false? t) 0]
        [else
         (+ (node-key t) (sum-all-keys (node-l t))
            (sum-all-keys (node-r t)))]))