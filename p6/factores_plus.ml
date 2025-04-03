let rec primoDiv x =
  let rec div n =
    if n > int_of_float (sqrt (float_of_int x)) then x
    else if x mod n = 0 then n
    else div (if (n - 1) mod 6 = 0 then n + 4 else n + 2)
  in
  if x mod 2 = 0 then 2 else if x mod 3 = 0 then 3 else div 5

let rec factoriza x =
  if x = min_int then "(-1) * 2^62"
  else if x = 0 then "0"
  else if x = 1 then "1"
  else if x = -1 then "(-1)"
  else if x < 0 then "(-1) * " ^ factoriza (-x)
  else
    (*Contamos cuantas veces podemos dividir un numero por cada primo que lo divide
      para saber el exponente*)
    let rec exponentes x divisor cont =
      if x mod divisor = 0 then exponentes (x / divisor) divisor (cont + 1)
      else if cont = 0 then exponentes x (primoDiv x) 0
      else (divisor, cont, x)
    in
    let divisor, cont, primoSig = exponentes x (primoDiv x) 0 in
    let factores =
      (*Si el contador es 1, no se eleva a nada*)
      if cont = 1 then string_of_int divisor
        (*Si no, se eleva el primo a su contador*)
      else string_of_int divisor ^ "^" ^ string_of_int cont
    in
    if primoSig = 1 then factores (*Es primo y no mostramos el " * 1" final*)
    else factores ^ " * " ^ factoriza primoSig
