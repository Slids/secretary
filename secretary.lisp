(defpackage #:secretary
  (:use #:cl
        #:cl-permutation))

(in-package #:secretary)


(defun found-best-secretary (num-candidates final-candidate-checked)
  (when (< num-candidates final-candidate-checked)
    (return-from found-best-secretary nil))
  (when (= final-candidate-checked 0)
    (return-from found-best-secretary
      (= (random num-candidates) (1- num-candidates))))
  (let* ((permutation (random-perm num-candidates))
         (final-checked-rank
           (loop :for i :from 1 :to  final-candidate-checked
                 :maximizing (perm-eval permutation i) :into max
                 :finally (return max))))
    (when (= final-checked-rank num-candidates)
      (return-from found-best-secretary nil))
    (let ((chosen-candidate-value
            (loop :for i :from (1+ final-candidate-checked) :to num-candidates
                  :for choice = (perm-eval permutation i)
                  :until (> choice final-checked-rank)
                  :finally (return choice))))
      (and chosen-candidate-value
           (= chosen-candidate-value num-candidates)))))

(defun run-n-trials-m-candidates-choice-k (n m k)
  (let ((times-successful 0))
    (dotimes (i n)
      (when (found-best-secretary m k)
        (incf times-successful)))
    times-successful))

(defun create-plot (number-of-candidates number-of-trials)
  (loop :for best-after-choice :from 0 :to (1- number-of-candidates)
        :for times-successful = (run-n-trials-m-candidates-choice-k
                                 number-of-trials
                                 number-of-candidates
                                 best-after-choice)
        do
           (format t "~d, ~d~%" best-after-choice times-successful)))
