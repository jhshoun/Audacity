;nyquist plug-in
;version 1
;type analyze
;categories "http://lv2plug.in/ns/lv2core#AnalyserPlugin"
;name "E-Z Tracking ..."
;action "Insert Label Tracks..."
;info "Inserts track markers (labels) based on the specified time interval."

;; by John Shoun, PE (Durham, NC)
;; 2014,  no rights reserved
;; [original code]
;; by David R. Sky (http://www.garyallendj.com/davidsky/), June-October 2007.
;; Code for label placement based on silencemarker.ny by Alex S.Brown.

;control track-width "Duration of track (minutes)" real "" 5 1 15

; store the sample rate of the sound
(setq s1-srate *sound-srate*)
; int variable with length of the sound
(setq sermon-length (/ len *sound-srate*))
; init the track counter and the labels variable
(setq track-c 0)
(setq l nil)
; convert the track duration in seconds to a length in samples
(setq track-width (* track-width 60))
(setq track-length (* track-width s1-srate))
(setq track-position 0)

; function to add new items to the list of labels
; from silencemarker.ny by Alex S. Brown
(defun add-label (l-time l-text)
    (setq l (cons (list l-time l-text) l))
)

; main part of the program
; adds labels at interval until end of sound

; runs through a loop, adding to the list of markers (l)

    ; keep repeating, incrementing the counter and getting another sample
    ;each time through the loop.
    (do
        (
            (n 1 (+ n 1))
        ) 

        ; exit when past the end of sound
        ; and return the number of tracks processed (n)
        ((> track-position len) n)

        ; add the labels
        (progn
            ; mark the track
;            (add-label (* track-c track-width) "T")
            (add-label 
                (* track-c track-width) 
                (strcat 
                    "Track" 
                    (progn (setq *integer-format* "%02d") (format nil "~a" (+ 1 track-c)))
                )
            )       
            ; increment the track counter
            (setq track-c (+ track-c 1))
            (setq track-position (+ track-position track-length))
        )
    )
; return the label list
l
