let collatz n = if n mod 2 = 0 then n / 2 else (3 * n) + 1

let rec length'n'top x =
  if x = 1 then (1, 1)
  else
    let n, max = length'n'top (collatz x) in
    let aux = if x > max then x else max in
    (n + 1, aux)
(*Vamos comprobando el maximo de la sucesion, a la vez que aumentamos en una unidad el contador de elementos*)
