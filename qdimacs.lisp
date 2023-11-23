(require :uiop)
(defpackage :qbf-qdimacs (:use :cl)
    (:export :parse))

(defun read-file (path) (uiop:read-file-lines path))
(defun starts-with (str c) (equalp (char str 0) c))
(defun c-zerop (c) (eq c #\0))

(defun collect-words (str) (uiop:split-string str :separator " "))
(defun collect-literals (str) (remove-if #'zerop (mapcar #'parse-integer (collect-words str))))
(defun collect-prefix-line (str) (mapcar #'(lambda (x) (list (char str 0) x)) (collect-literals (subseq str 2))))

(defun parse (path)
    (loop for line in (read-file path) 
        when (or (starts-with line #\a) (starts-with line #\e))
        collect (collect-prefix-line line)
        into prefix

        when (or (digit-char-p (char line 0)) (starts-with line #\-))
        collect (collect-literals line)
        into clauses

        finally (return (list (reduce #'append prefix) clauses))))

(format t "~a~%" (parse "./inputs/test.qdimacs"))