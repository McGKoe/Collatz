#!/usr/bin/sbcl --script


(defstruct cell ;structure holds the happy number and its norm
        num
        seqlength
)

(defun makeCell (n seq) ; creates and returns a new cell
	(let ((temp (make-cell)))
		(setf (cell-num temp) n)
		(setf (cell-seqlength temp) seq)

		(return-from makeCell temp)
	)
)

; determines length of collatz sequence recursively
(defun collatz (n)
	(progn
	  (cond
	    ((= n 1) (return-from collatz 0))
	    ((= (mod n 2) 0) (return-from collatz (+ 1 (collatz (/ n 2)))))
	    ((= (mod n 2) 1) (return-from collatz (+ 1 (collatz (+ 1 (* n 3))))))))

)




(progn
(defparameter *setofcells* ()) ;; declares an empty set

(defvar num1)
(defvar num2)


;;take command line input
(setf num1 (parse-integer (nth 1 sb-ext:*posix-argv*)) )

;take second command line input
(setf num2 (parse-integer (nth 2 sb-ext:*posix-argv*)) )

(if (< num2 num1)
	(progn
		(defvar hold)
		(setf hold num1)
		(setf num1 num2)
		(setf num2 hold)

	)

)


;;declare and set first number to find collatz
(defvar begin)

(setf begin num1)

(defvar seq)
(setf seq 0)

;; find scollayz sequence for each number between num1 and num2
(loop for i from num1 below (+ 1 num2) do

	(setf seq 0)

	(setf begin i)


	;;collatz sequence length of begin
	(setf seq (collatz begin))



	;;adds next cell to array
	(setf *setofcells* (adjoin (makeCell i seq) *setofcells*))

)

(terpri)

(defparameter *final* ())

;sort array by collatz sequence length
(setf *final* (sort  *setofcells* #'> :key #'cell-seqlength))

;remove duplicates
(setf *final* (delete-duplicates *final* :key #'cell-seqlength))



(defparameter *final2* ())

(princ "Sorted based on sequencce length: ")
(terpri)


(loop for item in *final*
	for i from 1 to 10
	do (format t "~d 		~d~%" (cell-num item) (cell-seqlength item))

	;;adds first ten of final to final2
	(setf *final2* (adjoin item *final2*))	
)

;sort final2 array by size of number
(setf *final2* (sort  *final2* #'> :key #'cell-num))


(princ "Sorted based on integer size: ")
(terpri)

(loop for item in *final2*
	for i from 1 to 10
	do (format t "~d 		~d~%" (cell-num item) (cell-seqlength item))
)


)


