let rec binstr_of_int x =
  if x = 0 then "0"
  else if x = 1 then "1"
  else binstr_of_int (x / 2) ^ string_of_int (x mod 2)

let rec int_of_binstr x =
  let n = String.length x in
  if n > Sys.int_size then
    (*Volvemos a llamarla, limitando el tamaño a 63(int_ize)*)
    int_of_binstr (String.sub x (n - Sys.int_size) Sys.int_size)
  else if n = 0 then 0
  else if x.[0] = '0' then
    (*Si el elemento es 0, lo ignoramos y pasamos al siguiente*)
    int_of_binstr (String.sub x 1 (n - 1))
  else
    (*Si el elemento es 1, elevamos 2 al respectivo tamaño del string y llamamos
      a la funcion con el resto del string*)
    int_of_float (2. ** float_of_int (n - 1))
    + int_of_binstr (String.sub x 1 (n - 1))

let rec int_of_binstr' x =
  (*Lo que hacemos es eliminar los espacios del string antes de pasarselo
    a la funcion que transforma a decimal*)
  let rec eliminar_espacios x =
    if String.contains x ' ' then
      (*Le pasamos el mismo string, pero quitando ese espacio*)
      eliminar_espacios
        (String.sub x 0 (String.index x ' ')
        ^ String.sub x
            (String.index x ' ' + 1)
            (String.length x - String.index x ' ' - 1))
    else x
  in
  let x = eliminar_espacios x in
  let n = String.length x in
  if n > Sys.int_size then
    (*Volvemos a llamarla, limitando el tamaño a 63(int_ize)*)
    int_of_binstr (String.sub x (n - Sys.int_size) Sys.int_size)
  else if n = 0 then 0
  else if x.[0] = '0' then
    (*Si el elemento es 0, lo ignoramos y pasamos al siguiente*)
    int_of_binstr (String.sub x 1 (n - 1))
  else
    (*Si el elemento es 1, elevamos 2 al respectivo tamaño del string y llamamos
      a la funcion con el resto del string*)
    int_of_float (2. ** float_of_int (n - 1))
    + int_of_binstr (String.sub x 1 (n - 1))
