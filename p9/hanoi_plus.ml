type move = LtoC | LtoR | CtoL | CtoR | RtoL | RtoC

let is_stable (a, b, c) =
  let n = List.length a + List.length b + List.length c in
  let suma = n * (n + 1) / 2 in
  let suma_discos i j k = List.fold_left ( + ) 0 (a @ b @ c) in
  let rec ver_orden = function
    | [] | [ _ ] -> true
    | h :: t -> h < List.hd t
  in
  ver_orden a && ver_orden b && ver_orden c && suma = suma_discos a b c

let all_states n =
  let rec aux n_aux l =
    if n_aux = 0 then l
    else
      let l_aux =
        List.fold_left
          (fun l (p1, p2, p3) ->
            (p1 @ [ n_aux ], p2, p3)
            :: (p1, p2 @ [ n_aux ], p3)
            :: (p1, p2, p3 @ [ n_aux ])
            :: l)
          [] l
      in
      aux (n_aux - 1) l_aux
  in
  aux n [ ([], [], []) ]

let mov_valido = function
  | [], _ -> false
  | _, [] -> true
  | h1 :: t1, h2 :: t2 -> h1 < h2

let move (a, b, c) mov =
  if is_stable (a, b, c) then
    match mov with
    | LtoC ->
        if mov_valido (a, b) then (List.tl a, List.hd a :: b, c)
        else raise (invalid_arg "move")
    | LtoR ->
        if mov_valido (a, c) then (List.tl a, b, List.hd a :: c)
        else raise (invalid_arg "move")
    | CtoL ->
        if mov_valido (b, a) then (List.hd b :: a, List.tl b, c)
        else raise (invalid_arg "move")
    | CtoR ->
        if mov_valido (b, c) then (a, List.tl b, List.hd b :: c)
        else raise (invalid_arg "move")
    | RtoL ->
        if mov_valido (c, a) then (List.hd c :: a, b, List.tl c)
        else raise (invalid_arg "move")
    | RtoC ->
        if mov_valido (c, b) then (a, List.hd c :: b, List.tl c)
        else raise (invalid_arg "move")
  else raise (invalid_arg "move")

let rec move_sequence l mov =
  match mov with
  | [] -> l
  | h :: t ->
      let l_aux = move l h in
      move_sequence l_aux t
