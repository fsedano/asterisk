(set! server_access_list '("localhost\\.localdomain" "localhost"))
(set! server_log_file "/var/log/festival.log")
;; set italian voice (comment the following 2 lines to use british_american)

;;; Command for Asterisk begin


(define (tts_textasterisk string mode)
"(tts_textasterisk STRING MODE)
Apply tts to STRING. This function is specifically designed for
use in server mode so a single function call may synthesize the string.
This function name may be added to the server safe functions."
(let ((wholeutt (utt.synth (eval (list 'Utterance 'Text string)))))
(utt.wave.resample wholeutt 8000)
(utt.wave.rescale wholeutt 5)
(utt.send.wave.client wholeutt)))