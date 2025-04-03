(*Funcion para obtener el primo divisor de un numero*)
let rec primoDiv x =
  let rec div n =
    if n > int_of_float (sqrt (float_of_int x)) then x (*Es primo*)
    else if x mod n = 0 then n (*Primo divisor*)
    else div (if (n - 1) mod 6 = 0 then n + 4 else n + 2)
    (*Llamamos a la funcion con el siguiente primo*)
  in
  if x mod 2 = 0 then 2 else if x mod 3 = 0 then 3 else div 5

let rec factoriza x =
  if x = min_int then "(-1) * 2 * " ^ factoriza (-(min_int / 2))
    (*Como es muy grande, lo dividimos entre dos
      y añadimos 2 al string de salida*)
  else if x = 0 then "0"
  else if x = 1 then "1"
  else if x = -1 then "(-1)"
  else if x < 0 then "(-1) * " ^ factoriza (-x)
  else
    let factor = primoDiv x in
    if factor = x then string_of_int x (*Si es primo, lo devolvemos*)
    else string_of_int factor ^ " * " ^ factoriza (x / factor)
