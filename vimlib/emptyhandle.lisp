(import vimlib/enums enums)

(defun gen-handle ()
  { :open open-hand
    :read read-hand
    :write write-hand
    :close close-hand
    :cleanup clean-hand 
    :data { :text "" :openmode enums/*mode-closed* } })

(defun open-hand (handle mode))
(defun close-hand (handle mode))
(defun clean-hand (handle mode))
