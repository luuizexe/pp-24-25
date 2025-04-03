(*Version optimizada de fibonacci:*)
let fib n =
  (*Guaramos en fi el resultado de sumarse con fa(que es el fi anterior) y aumentamos el contador j*)
  let rec aux j fi fa = if j = n then fi else aux (j + 1) (fi + fa) fi in
  aux 0 0 1

let rec fib_to i n =
  let x = fib i in
  if x < n then
    (*mostramos el numero y llamamos al siguiente de la serie*)
    let () = print_endline (string_of_int x) in
    fib_to (i + 1) n
  else print_newline ()

let () =
  (*Si el tamaño de la entrada es distinto de 2, mostramos error*)
  if Array.length Sys.argv <> 2 then
    print_endline "fibto: Invalid number of arguments"
  else fib_to 1 (int_of_string Sys.argv.(1))
