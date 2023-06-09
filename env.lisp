(in-package ang)

(defstruct env
  (parent nil :type (or null env))
  (bindings (make-hash-table :test 'equal) :type hash-table))

(defun env-get (env key)
  (let ((v (gethash key (env-bindings env))))
    (or v (with-slots (parent) env (and parent (env-get parent key))))))

(defun env-set (env key val)
  (setf (gethash key (env-bindings env)) val))

(defun (setf env-get) (val env key)
  (env-set env key val))
