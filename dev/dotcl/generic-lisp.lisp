(in-package #:metatilities)

;;; ---------------------------------------------------------------------------
;;; specify that we're using the dotcl interface
;;; ---------------------------------------------------------------------------

(setf (default-interface) :dotcl)

;;; ---------------------------------------------------------------------------

(defmethod is-interface-available-p ((interface (eql :dotcl)))
  (values t))

;;; ---------------------------------------------------------------------------
;;; quitting
;;; ---------------------------------------------------------------------------

(defmethod quit-lisp* ((interface (eql :dotcl)))
  (dotcl:quit))

;;; ---------------------------------------------------------------------------
;;; memory management stuff
;;; ---------------------------------------------------------------------------

(defmethod total-bytes-allocated* ((interface (eql :dotcl)))
  ;; (gen0-count gen1-count gen2-count total-memory total-allocated-bytes)
  (values (fifth (dotcl:gc-stats))))

;;; ---------------------------------------------------------------------------

(defmethod gc-time* ((interface (eql :dotcl)))
  ;; Total time the GC has paused the program, in internal time units: the
  ;; sixth element of DOTCL:GC-STATS (NIL where the runtime cannot tell).
  (or (nth 5 (dotcl:gc-stats)) 0))

;;; ---------------------------------------------------------------------------

(defmethod collect-garbage* ((interface (eql :dotcl)))
  (dotcl:gc))
