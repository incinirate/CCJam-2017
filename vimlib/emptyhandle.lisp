(import extra/assert (assert!))
(import vimlib/enums enums)

(defun gen-handle ()
  { :open open-hand
    :read read-hand
    :write write-hand
    :close close-hand
    :cleanup clean-hand 
    :data { :text "-- Hello world\n\nlocal i = 2\nfunction hello()\n  print(\"Hello!\")" :openmode enums/*mode-closed* :ptr 0 } })

;;\nend\n\n--[[cool\nmultiline\ncomment]]\n\nprint([[It works!\nAll of it!]])\n

(defun open-hand (handle mode)
  "Opens HANDLE for MODE (*mode-read* or *mode-write*)"
  (.<! handle :data :ptr 0)
  (when (= mode enums/*mode-write*)
    (.<! handle :data :text "")))
(defun close-hand (handle)
  "Exits the currently active mode for HANDLE"
  nil)
(defun clean-hand (handle)
  "Call this when no more work is to be done with HANDLE"
  nil)

(defun read-hand (handle amount)
  "Reads AMOUNT lines from HANDLE"
  (with (lines (string/split 
                  (.> handle :data :text) "\n"
                  (+ amount (.> handle :data :ptr))))
    (with (result (take (drop lines (.> handle :data :ptr)) amount))
      (^~ handle (<> (on! :ptr) (on :data)) (cut + <> amount))
      result)))

(defun write-hand (handle data)
  "Writes DATA to HANDLE"
  (assert! (= (.> handle :data :openmode) enums/*mode-write*)
    "Handle not opened in write mode")

  (.<! handle :data :text (.. (.> handle :data :text) data)))
