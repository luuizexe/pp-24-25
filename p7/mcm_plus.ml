(*Funcion optimizada del MCD de la practica anterior*)
let rec mcd x y =
  if y = 0 then x else if x < y then mcd y x else mcd (x mod y) y

let mcm' x y =
  (*Si alguno de los dos es menor a 0, devolvemos -1*)
  if x <= 0 || y <= 0 then raise (Invalid_argument "mcm': argumento inválido")
  else
    let aux = mcd x y in
    if aux = 0 then 0 (*Si el MCD es 0, el MCM tambien*)
    else
      (*Por si es muy grande, dividimos x entre su MCD con y*)
      let res = x / aux in
      if res > max_int / y then
        raise (Invalid_argument "mcm': mcm excede max_int")
      else abs (res * y)
