let from0to n =
  if n < 0 then raise (Failure "from0to: n no puede ser negativo")
  else
    let rec aux n_aux l_aux =
      if n_aux > n then l_aux else n_aux :: aux (n_aux + 1) l_aux
    in
    aux 0 []

let to0from n =
  if n < 0 then raise (Failure "from0to: n no puede ser negativo")
  else
    let rec aux n_aux l_aux =
      if n_aux < 0 then l_aux else aux (n_aux - 1) (n_aux :: l_aux)
    in
    aux n []

let pair x l =
  let rec aux = function
    | [] -> []
    | h :: t -> (x, h) :: aux t
  in
  aux l

let remove_first x l =
  let rec aux = function
    | [] -> []
    | h :: t -> if x = h then t else h :: aux t
  in
  aux l

let remove_all x l =
  let rec aux = function
    | [] -> []
    | h :: t -> if x = h then aux t else h :: aux t
  in
  aux l

let ldif l1 l2 =
  let rec aux l_aux = function
    | [] -> List.rev l_aux
    | h :: t -> if List.mem h l2 then aux l_aux t else aux (h :: l_aux) t
  in
  aux [] l1
