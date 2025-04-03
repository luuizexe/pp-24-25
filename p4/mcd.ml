let rec mcd x y = if y = 0 then x else if x < y then mcd y x else mcd (x - y) y

let rec mcd' x y =
  if y = 0 then x else if x < y then mcd' y x else mcd' (x mod y) y
