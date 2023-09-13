;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname tile-starter.no-image) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
;; tile-starter.rkt

;PROBLEM:

;Use the DrRacket square, beside and above functions to create an image like this one (open image file):

;If you prefer to be more creative feel free to do so. You can use other DrRacket image
;functions to make a more interesting or more attractive image.

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

