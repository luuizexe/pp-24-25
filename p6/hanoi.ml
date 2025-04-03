let otro ori des = 6 - ori - des

let move (ori, des) =
  if ori = 1 then if des = 2 then "1 -> 2    3\n" else "1 ---2--> 3\n"
  else if ori = 2 then if des = 1 then "1 <- 2    3\n" else "1    2 -> 3\n"
  else if des = 1 then "1 <--2--- 3\n"
  else "1    2 <- 3\n"

let rec crono f x =
  let t = Sys.time () in
  f x;
  Sys.time () -. t

let rec hanoi n ori des =
  (* n número de discos, 1 <= ori <= 3, 1 <= dest <= 3, ori <> des *)
  if n = 0 then ""
  else
    let otro = otro ori des in
    hanoi (n - 1) ori otro ^ move (ori, des) ^ hanoi (n - 1) otro des

let hanoi n ori des = if n = 0 || ori = des then "\n" else hanoi n ori des

let print_hanoi n ori des =
  if n < 0 || ori < 1 || ori > 3 || des < 1 || des > 3 then
    print_endline " ** ERROR ** \n"
  else print_endline (" =========== \n" ^ hanoi n ori des ^ " =========== \n")

(*
  n       hanoi n 3 1 (s)        2*hanoi (n-1) 3 1 (s)
  ----------------------------------------------------
  20      0.202670               -
  21      0.360391               0.405340
  22      0.713529               0.720782
  23      1.371239               1.427058
  24      2.680278               2.742478
  25      5.434414               5.360556

  Como observamos en la tabla, conforme aumentamos el numero de discos de hanoi(n), 
  el tiempo de ejecucion de hanoi(n+1) se aproxima bastante al doble de hanoi(n).
  Por lo tanto, podemos confirmar que la complejidad es O(2^n).
*)

let rec nth_hanoi_move n nd ori des =
  if ori = des || nd <= 0 || nd >= Sys.int_size then (-1, -1)
  else if nd = 1 && n = 1 then
    (*Si el numero de discos y el movimiento es 1, devolvemos el unico movimiento posible:*)
    (ori, des)
  else
    let mitad = int_of_float (2. ** float_of_int (nd - 1)) - 1 in
    let aux = otro ori des in
    if n <= mitad then
      nth_hanoi_move n (nd - 1) ori aux (*Buscamos en la primera mitad*)
    else if n = mitad + 1 then (ori, des)
      (*Estamos justo en la mitad: encontramos el movimiento*)
    else nth_hanoi_move (n - mitad - 1) (nd - 1) aux des
(*Buscamos en la segunda mitad*)
(*
  nd      nth_hanoi_move 10 nd 3 1 (s)    nth_hanoi_move 20 nd 3 1 (s)
  --------------------------------------------------------------------
  10      0.89999999999812452e-05         0.89999999999812452e-05               -
  20      1.10000000000011001e-05         1.10000000000011001e-05
  30      1.29999999999852456e-05         1.29999999999852456e-05
  40      1.40000000000140012e-05         1.40000000000140012e-05u
  50      1.69999999999892459e-05         1.69999999999892459e-05
  60      2.10000000000487574e-05         2.10000000000487574e-05

  Como observamos en la tabla, conforme aumentamos el numero de discos, aumenta a su vez el
  tiempo de ejecucion. Sin embargo, el tiempo no se ve afectado si aumentamos el movimiento
  a encontrar. Por lo tanto, podemos confirmar que la complejidad es de O(nd).
*)
