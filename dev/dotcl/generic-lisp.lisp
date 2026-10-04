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
  ;; Total time the .NET GC has paused the program, in internal time units.
  (values (round (* (dotnet:invoke (dotnet:static "System.GC" "GetTotalPauseDuration")
                                   "TotalSeconds")
                    internal-time-units-per-second))))

;;; ---------------------------------------------------------------------------

(defmethod collect-garbage* ((interface (eql :dotcl)))
  (dotcl:gc))
