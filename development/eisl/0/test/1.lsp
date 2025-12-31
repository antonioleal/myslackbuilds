#!/usr/bin/eisl -s


(defglobal x 0)

(progn
  (setq x 5)
  (+ x 1))

(progn
  (format (standard-output) "4 plus 1 equals ")
  (format (standard-output) "~D~%" (+ 4 1))
)
