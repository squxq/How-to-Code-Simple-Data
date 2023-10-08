;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname problem-01.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Food for thought:
;
;(open image file)
;
;    A) If all binary search trees looked like the one above, will we gain anything from using them instead of lists?
;
;    B) Can we do anything to those trees if we want to improve the performance of searching for a node?

;A) No difference between operating on a binary search tree like the one above or the ordinary list.

;B) This is because the root (1:a) is poorly chosen. Choosing the median node of a list (2:b / 3:c)
;   would result in a more efficient BST model that properly optimize the performance (runtime) of the function.