let rec mcd_pasos x y =
  if y = 0 then (x, 1)
  else if x < y then mcd_pasos y x
  else
    let mcd, n = mcd_pasos (x mod y) y in
    (mcd, n + 1)
(*Llamamos sucesivamente a la funcion y contamos el numero de interacciones*)
