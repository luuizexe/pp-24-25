let rec fib n = if n <= 2 then 1 else fib (n - 1) + fib (n - 2)

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
