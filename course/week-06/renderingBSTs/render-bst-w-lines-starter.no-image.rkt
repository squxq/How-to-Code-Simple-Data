;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname render-bst-w-lines-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))

;; render-bst-w-lines-starter.rkt

(require 2htdp/image)

;PROBLEM:
;
;Given the following data definition for a binary search tree,
;design a function that consumes a bst and produces a SIMPLE 
;rendering of that bst including lines between nodes and their 
;subnodes.
;
;To help you get started, we've added some sketches below of 
;one way you could include lines to a bst.

;; Constants

(define TEXT-SIZE  14)
(define TEXT-COLOR "BLACK")

(define KEY-VAL-SEPARATOR ":")

(define MTTREE (rectangle 20 1 "solid" "white"))

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

;(open image file)

;; Examples:
(define BST0 false)
(define BST1 (make-node 1 "abc" false false))
(define BST7 (make-node 7 "ruf" false false)) 
(define BST4 (make-node 4 "dcj" false (make-node 7 "ruf" false false)))
(define BST3 (make-node 3 "ilk" BST1 BST4))
(define BST42 
  (make-node 42 "ily"
             (make-node 27 "wit" (make-node 14 "olp" false false) false)
             (make-node 50 "dug" false false)))
(define BST10
  (make-node 10 "why" BST3 BST42))
(define BST100 
  (make-node 100 "large" BST10 false))

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

;; Functions:

;Here is a sketch of one way the lines could work. What 
;this sketch does is allows us to see the structure of
;the functions pretty clearly. We'll have one helper for
;the key value image, and one helper to draw the lines.
;Each of those produces a rectangular image of course.
;
;(open image file)
;
;And here is a sketch of the helper that draws the lines:
;(open image file)
;where lw means width of left subtree image and
;      rw means width of right subtree image

;; BST -> Image
;; produce a rendering of the given binary search tree, t

;; Stub:
#;
(define (render-bst t) empty-image)

;; Tests:
(check-expect (render-bst BST0) MTTREE)
(check-expect (render-bst BST1)
              (above (text "1:abc" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes MTTREE MTTREE)))
(check-expect (render-bst BST4)
              (above (text "4:dcj" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes MTTREE
                                      (render-bst BST7))))
(check-expect (render-bst BST3)
              (above (text "3:ilk" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes (render-bst BST1)
                                      (render-bst BST4))))
(check-expect (render-bst BST42)
              (above (text "42:ily" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes (render-bst (make-node 27 "wit" (make-node 14 "olp" false false) false))
                                      (render-bst (make-node 50 "dug" false false)))))
(check-expect (render-bst BST10)
              (above (text "10:why" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes (render-bst BST3)
                                      (render-bst BST42))))
(check-expect (render-bst BST100)
              (above (text "100:large" TEXT-SIZE TEXT-COLOR)
                     (render-subnodes (render-bst BST10)
                                      MTTREE)))

;; Template: <used template from BST>

(define (render-bst t)
  (cond [(false? t) MTTREE]
        [else
         (above (key-val-image (node-key t) (node-val t))
                (render-subnodes (render-bst (node-l t)) (render-bst (node-r t))))]))


;; Integer String -> Image
;; produce the key-value image given the key, key, and the value, val

;; Stub:
#;
(define (key-val-image key val) empty-image)

;; Tests:
(check-expect (key-val-image 1 "abc")
              (text "1:abc" TEXT-SIZE TEXT-COLOR))
(check-expect (key-val-image 4 "dcj")
              (text "4:dcj" TEXT-SIZE TEXT-COLOR))
(check-expect (key-val-image 3 "ilk")
              (text "3:ilk" TEXT-SIZE TEXT-COLOR))
(check-expect (key-val-image 42 "ily")
              (text "42:ily" TEXT-SIZE TEXT-COLOR))
(check-expect (key-val-image 10 "why")
              (text "10:why" TEXT-SIZE TEXT-COLOR))
(check-expect (key-val-image 100 "large")
              (text "100:large" TEXT-SIZE TEXT-COLOR))

;; Template:
#;
(define (key-val-image key val)
  (... key val))

(define (key-val-image key val)
  (text (string-append (number->string key) KEY-VAL-SEPARATOR val) TEXT-SIZE TEXT-COLOR))


;; Image Image -> Image
;; render given subnodes, sn1 and sn2

;; Stub:
#;
(define (render-subnodes sn1 sn2) empty-image)

;; Tests:
(check-expect (render-subnodes MTTREE MTTREE)
              (above (draw-lines MTTREE MTTREE) (beside MTTREE MTTREE)))
(check-expect (render-subnodes MTTREE (render-bst BST7))
              (above (draw-lines MTTREE (render-bst BST7)) (beside MTTREE (render-bst BST7))))
(check-expect (render-subnodes (render-bst BST1) (render-bst BST4))
              (above (draw-lines (render-bst BST1) (render-bst BST4))
                     (beside (render-bst BST1) (render-bst BST4))))
(check-expect (render-subnodes (render-bst (make-node 27 "wit" (make-node 14 "olp" false false) false))
                               (render-bst (make-node 50 "dug" false false)))
              (above (draw-lines (render-bst (make-node 27 "wit" (make-node 14 "olp" false false) false))
                                 (render-bst (make-node 50 "dug" false false)))
                     (beside (render-bst (make-node 27 "wit" (make-node 14 "olp" false false) false))
                             (render-bst (make-node 50 "dug" false false)))))
(check-expect (render-subnodes (render-bst BST3) (render-bst BST42))
              (above (draw-lines (render-bst BST3) (render-bst BST42))
                     (beside (render-bst BST3) (render-bst BST42))))
(check-expect (render-subnodes (render-bst BST10) MTTREE)
              (above (draw-lines (render-bst BST10) MTTREE) (beside (render-bst BST10) MTTREE)))

;; Template:
#;
(define (render-subnodes sn1 sn2)
  (... sn1 sn2))

(define (render-subnodes sn1 sn2)
  (above (draw-lines sn1 sn2) (beside sn1 sn2)))

;; Image Image -> Image
;; produce the correct arguments based on the two given images, sn1 and sn2, for render-lines

;; Stub:
#;
(define (draw-lines sn1 sn2) empty-image)

;; Tests:
(check-expect (draw-lines MTTREE MTTREE) (render-lines 0 0))
(check-expect (draw-lines MTTREE (render-bst BST7))
              (render-lines 0 (image-width (render-bst BST7))))
(check-expect (draw-lines (render-bst BST10) MTTREE)
              (render-lines (image-width (render-bst BST10)) 0))
(check-expect (draw-lines (render-bst BST1) (render-bst BST4))
              (render-lines (image-width (render-bst BST1)) (image-width (render-bst BST4))))

;; Template:
#;
(define (draw-lines sn1 sn2)
  (... sn1 sn2))

(define (draw-lines sn1 sn2)
  (cond [(and (image=? sn1 MTTREE) (image=? sn2 MTTREE)) (render-lines 0 0)]
        [(image=? sn1 MTTREE) (render-lines 0 (image-width sn2))]
        [(image=? sn2 MTTREE) (render-lines (image-width sn1) 0)]
        [else (render-lines (image-width sn1) (image-width sn2))]))


;; Natural Natural -> Image
;; render the lines connecting the parent node to its 2 child nodes with the given widths of the child nodes, n1 and n2

;; Stub:
#;
(define (render-lines n1 n2) empty-image)

;; Tests:
(check-expect (render-lines 0 0) empty-image)
(check-expect (render-lines 0 (image-width (render-bst BST7)))
              (add-line (rectangle (image-width (render-bst BST7)) (/ (image-width (render-bst BST7)) 4) "solid" "white")
                        (/ (image-width (render-bst BST7)) 2)  0
                        (image-width (render-bst BST7))  (/ (image-width (render-bst BST7)) 4)
                        "black"))
(check-expect (render-lines (image-width (render-bst BST10)) 0)
              (add-line (rectangle (image-width (render-bst BST10)) (/ (image-width (render-bst BST10)) 4) "solid" "white")
                        (/ (image-width (render-bst BST10)) 2)  0
                        0         (/ (image-width (render-bst BST10)) 4)
                        "black"))
(check-expect (render-lines (image-width (render-bst BST1)) (image-width (render-bst BST4)))
              (add-line (add-line (rectangle (+ (image-width (render-bst BST4)) (image-width (render-bst BST1)))
                                             (/ (+ (image-width (render-bst BST4)) (image-width (render-bst BST1))) 4) "solid" "white")
                                  (/ (+ (image-width (render-bst BST4)) (image-width (render-bst BST1))) 2) 0
                                  (/ (image-width (render-bst BST4)) 2) (/ (+ (image-width (render-bst BST4)) (image-width (render-bst BST1))) 4) "black")
                        (/ (+ (image-width (render-bst BST4)) (image-width (render-bst BST1))) 2)  0
                        (+ (image-width (render-bst BST4)) (/ (image-width (render-bst BST1)) 2))  (/ (+ (image-width (render-bst BST4)) (image-width (render-bst BST1))) 4)
                        "black"))

;; Template:
#;
(define (render-lines n1 n2)
  (... n1 n2))

(define (render-lines n1 n2)
  (cond [(and (= n1 0) (= n2 0)) empty-image]
        [(= n1 0) (add-line (rectangle n2 (/ n2 4) "solid" "white")
                            (/ n2 2) 0
                            n2 (/ n2 4)
                            "black")]
        [(= n2 0) (add-line (rectangle n1 (/ n1 4) "solid" "white")
                            (/ n1 2) 0
                            0 (/ n1 4)
                            "black")]
        [else (add-line (add-line (rectangle (+ n2 n1) (/ (+ n2 n1) 4) "solid" "white")
                                  (/ (+ n2 n1) 2) 0
                                  (/ n2 2) (/ (+ n2 n1) 4)
                                  "black")
                        (/ (+ n2 n1) 2) 0
                        (+ n2 (/ n1 2)) (/ (+ n2 n1) 4)
                        "black")]))