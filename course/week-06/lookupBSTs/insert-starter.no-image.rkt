;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname insert-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; insert-starter.rkt

;PROBLEM:
;
;Design a function that consumes an Integer, String and BST, and adds a node
;that has the given key and value to the tree. The node should be inserted in 
;the proper place in the tree. The function can assume there is not already 
;an entry for that number in the tree. The function should produce the new BST.
;
;Do not worry about keeping the tree balanced. We will come back to this later.

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

;; Integer String BST -> BST
;; add a node that has the given key, key, and value, val, to the given binary search tree, t
;; ASSUME: there is not already an entry for that number in the tree

;; Stub:
#;
(define (insert-node key val t) false)

;; Tests:
(check-expect (insert-node 3 "smt" BST0)
  (make-node 3 "smt" false false))
(check-expect (insert-node 3 "smt" BST1)
  (make-node 1 "abc" false (make-node 3 "smt" false false)))
(check-expect (insert-node 3 "smt" BST4)
  (make-node 4 "dcj" (make-node 3 "smt" false false) (make-node 7 "ruf" false false)))
(check-expect (insert-node 5 "new" BST3)
  (make-node 3 "ilk" BST1 (make-node 4 "dcj" false (make-node 7 "ruf" (make-node 5 "new" false false) false))))
(check-expect (insert-node 2 "ano" BST42)
  (make-node 42 "ily" (make-node 27 "wit" (make-node 14 "olp" (make-node 2 "ano" false false) false) false) false))
(check-expect (insert-node 2 "ano" BST10)
  (make-node 10 "why" (make-node 3 "ilk" (make-node 1 "abc" false (make-node 2 "ano" false false)) BST4) BST42))

;; Template: <used template from BST and added Integer parameter key and String parameter val>
#;
(define (insert-node key val t)
  (cond [(false? t) (... key val)]
        [else
         (... key
              val
              (node-key t)
              (node-val t)
              (insert-node (... key) (... val) (node-l t))
              (insert-node (... key) (... val) (node-r t)))]))

(define (insert-node key val t)
  (cond [(false? t) (make-node key val false false)]
        [else
         (cond [(< key (node-key t))
                (make-node (node-key t) (node-val t) (insert-node key val (node-l t)) (node-r t))]
               [(> key (node-key t))
                (make-node (node-key t) (node-val t) (node-l t) (insert-node key val (node-r t)))])]))