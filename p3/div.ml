let rec div x y =
    if x < y then (x,0)
    else let (q,r) = div (x-y) y in
      (1+q,r)
  ;;