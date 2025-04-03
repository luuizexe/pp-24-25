let collatz n = if n mod 2 = 0 then n / 2 else (3 * n) + 1
let rec verify n = n = 1 || verify (collatz n)
let rec verify_to n = if n = 1 then true else verify n && verify_to (n - 1)

let rec orbit n =
  if n = 1 then "1" else string_of_int n ^ ", " ^ orbit (collatz n)

let rec length n = if n = 1 then 1 else 1 + length (collatz n)

let rec top n =
  if n = 1 then 1
  else
    let max = top (collatz n) in
    if n > max then n else max
