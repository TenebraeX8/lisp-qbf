(require :uiop)
(defpackage :qbf-normalize
(:use :cl)
(:export :normalize))

(in-package :qbf-normalize)

(defun read-file (path) (uiop:read-file-lines path))

(defun c-zerop (c) (eq c #\0))

(defun starts-with (str c) (equalp (char str 0) c))

(defun associate-mapping (mapping lit) (push (list lit (length mapping)) mapping))
(defun resolve-mapping (mapping lit)(second (assoc lit mapping)))
(defun collect-words (str) (uiop:split-string str :separator " "))
(defun collect-literals (str) (remove-if #'zerop (mapcar #'parse-integer (collect-words str))))

(defun normalize (path)
    (loop for line in (read-file path) 
        with mapping := (list (list 0 0))

        when (starts-with line #\c) 
        do (format t "~a~%" line)

        when (or (starts-with line #\a) (starts-with line #\e))
        do 
        (format t "~a" (char line 0))
        (loop for lit in (collect-literals (subseq line 2)) do 
            (setq mapping (associate-mapping mapping lit))
            (format t " ~a" (resolve-mapping mapping lit)))
        (format t " 0~%")

        when (or (digit-char-p (char line 0)) (starts-with line #\-))
        do 
        (loop for lit in (collect-literals line)
            when (< lit 0) do (format t "-~a " (resolve-mapping mapping (abs lit)))
            else           do (format t "~a " (resolve-mapping mapping lit)))
        (format t "0~%")))

(normalize "./inputs/test.qdimacs")