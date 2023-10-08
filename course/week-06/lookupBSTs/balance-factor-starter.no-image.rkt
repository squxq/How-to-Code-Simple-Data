;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname balance-factor-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; balance-factor-starter.rkt

;PROBLEM:
;
;As discussed in lecture, for optimal lookup time we want a BST to be balanced. 
;The oldest approach to this is called AVL self-balancing trees and was invented in 1962. 
;The remainder of this problem set is based on AVL trees.
;
;An individual node is balanced when the height of its left and right branches differ 
;by no more than 1. A tree is balanced when all its nodes are balanced.
;
;a) Design the function balance-factor that consumes a node and produces its balance factor,
;which is defined as the height of its left child minus the height of its right child.
;
;b) Use your function in part a) to design the function balanced?, which consumes a BST and 
;produces true if the tree is balanced.
;
;Once you have the function, use it to compare what happens with the following two sequences
;of insertions:
;
;
;(insert 4 "a" 
;        (insert 5 "a"
;                (insert 6 "a" 
;                        (insert 7 "a" 
;                                (insert 8 "a" false)))))
;        
;        
;(insert 4 "a" 
;        (insert 5 "a"
;                (insert 8 "a" 
;                        (insert 7 "a" 
;                                (insert 6 "a" false))))) 

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

;; BST -> Natural
;; produce the height (maximum depth of any leaf node from the root node)
;;         of given binary search tree, t

;; Stub:
#;
(define (height t) 0)

;; Tests:
(check-expect (height BST0) 0)
(check-expect (height BST1) 1)
(check-expect (height BST4) 2)
(check-expect (height BST3) 3)
(check-expect (height BST42) 3)
(check-expect (height BST10) 4)

;; Template: <used template from BST>

(define (height t)
  (cond [(false? t) 0]
        [else
         (+ (max (height (node-l t)) (height (node-r t))) 1)]))


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


;; (make-node Integer String BST BST) -> Integer
;; produce the balance factor (height of its left child minus the height of its right child)
;;         of the given node, n

;; Stub:
#;
(define (balance-factor n) 0)

;; Tests:
(check-expect (balance-factor BST1) 0)
(check-expect (balance-factor BST4) -1)
(check-expect (balance-factor BST3) -1)
(check-expect (balance-factor BST42) 2)
(check-expect (balance-factor BST10) 0)

;; Template:
#;
(define (balance-factor n)
  (... (node-key n)
       (node-val n)
       (node-l n)
       (node-r n)))

(define (balance-factor n)
  (- (height (node-l n)) (height (node-r n))))


;; BST -> Boolean
;; produce true if the tree is balanced (if all of its nodes are balanced)
;;         an individual node is balanced when the height of its left and right branch differ by no more than 1
;;         otherwise produce false

;; Stub:
#;
(define (balanced? t) false)

;; Tests:
(check-expect (balanced? BST0) true)
(check-expect (balanced? BST1) true)
(check-expect (balanced? BST4) true)
(check-expect (balanced? BST3) true)
(check-expect (balanced? BST42) false)
(check-expect (balanced? BST10) false)

;; Template: <used template from BST>

(define (balanced? t)
  (cond [(false? t) true]
        [else
         (and (<= (abs (balance-factor t)) 1) (balanced? (node-l t)) (balanced? (node-r t)))]))

;Once you have the function, use it to compare what happens with the following two sequences
;of insertions:
;
;
;(insert 4 "a" 
;        (insert 5 "a"
;                (insert 6 "a" 
;                        (insert 7 "a" 
;                                (insert 8 "a" false)))))
;        
;        
;(insert 4 "a" 
;        (insert 5 "a"
;                (insert 8 "a" 
;                        (insert 7 "a" 
;                                (insert 6 "a" false))))) 

;; Insertion 0:
(define I0 (insert-node 4 "a" 
        (insert-node 5 "a"
                (insert-node 6 "a" 
                        (insert-node 7 "a" 
                                (insert-node 8 "a" false))))))
I0
;; outputs (make-node 8 "a" (make-node 7 "a" (make-node 6 "a" (make-node 5 "a" (make-node 4 "a" #false #false) #false) #false) #false) #false)
(height I0)
;; ouputs 5
(balanced? I0)
;; outputs false

;; Insertion 1:
(define I1 (insert-node 4 "a" 
        (insert-node 5 "a"
                (insert-node 8 "a" 
                        (insert-node 7 "a" 
                                (insert-node 6 "a" false))))))
I1
;; ouputs (make-node 6 "a" (make-node 5 "a" (make-node 4 "a" #false #false) #false) (make-node 7 "a" #false (make-node 8 "a" #false #false)))
(height I1)
;; outputs 3
(balanced? I1)
;; outputs false