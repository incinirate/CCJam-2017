(with ((start finish) (string/find "hey there bud" "t%S+"))
  (print! ($ "From ~{start} to ~{finish}")))