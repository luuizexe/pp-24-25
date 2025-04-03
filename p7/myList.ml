let hd = function
  | [] -> raise (Failure "hd: Lista vacia")
  | h :: t -> h

let tl = function
  | [] -> raise (Failure "tl: Lista vacia")
  | h :: t -> t

let last l =
  let rec aux = function
    | [] -> raise (Failure "last: Lista vacia")
    | [ x ] -> x
    | _ :: t -> aux t
  in
  aux l

let rec length = function
  | [] -> 0
  | h :: t -> 1 + length t

let length' l =
  let rec aux count = function
    | [] -> count
    | h :: t -> aux (count + 1) t
  in
  aux 0 l

let compare_lengths l1 l2 =
  let rec aux l_aux1 l_aux2 =
    match (l_aux1, l_aux2) with
    | [], [] -> 0
    | [], _ -> -1
    | _, [] -> 1
    | _ :: t1, _ :: t2 -> aux t1 t2
  in
  aux l1 l2

let rec append l1 l2 =
  match l1 with
  | [] -> l2
  | h1 :: t1 -> h1 :: append t1 l2

let rec rev_append l1 l2 =
  let rec aux l_aux = function
    | [] -> l_aux
    | h :: t -> aux (h :: l_aux) t
  in
  aux l2 l1

let rev l =
  let rec aux l_aux = function
    | [] -> l_aux
    | h :: t -> aux (h :: l_aux) t
  in
  aux [] l

let rec concat = function
  | [] -> []
  | h :: t -> append h (concat t)

let flatten = concat

let init len f =
  if len < 0 then raise (Invalid_argument "init: lenght is negative")
  else
    let rec aux n l_aux = if n < 0 then l_aux else aux (n - 1) (f n :: l_aux) in
    aux (len - 1) []

let rec nth l n =
  if n < 0 then raise (Invalid_argument "nth: n is negative")
  else
    let rec aux cont = function
      | [] -> raise (Failure "nth: List is too short or n not found")
      | h :: t -> if n = cont then h else aux (cont + 1) t
    in
    aux 0 l

let rec map f l =
  match l with
  | [] -> []
  | h :: t -> f h :: map f t

let rec rev_map f l =
  let rec aux l_aux = function
    | [] -> l_aux
    | h :: t -> aux (f h :: l_aux) t
  in
  aux [] l

let rec map2 f l1 l2 =
  match (l1, l2) with
  | [], [] -> []
  | [], _ | _, [] ->
      raise (Invalid_argument "map2: Lists have different lengths")
  | h1 :: t1, h2 :: t2 -> f h1 h2 :: map2 f t1 t2

let rec combine l1 l2 =
  match (l1, l2) with
  | [], [] -> []
  | [], _ | _, [] ->
      raise (Invalid_argument "combine: Lists have different lengths")
  | h1 :: t1, h2 :: t2 -> (h1, h2) :: combine t1 t2

let rec split = function
  | [] -> ([], [])
  | (h1, h2) :: t ->
      let t1, t2 = split t in
      (h1 :: t1, h2 :: t2)

let find f l =
  let rec aux f_aux l_aux =
    match (f_aux, l_aux) with
    | _, [] -> raise Not_found
    | _, h :: t -> if f h then h else aux f_aux t
  in
  aux f l

let rec filter f l =
  match l with
  | [] -> l
  | h :: t -> if f h then h :: filter f t else filter f t

let filter' f l =
  let rec aux l_aux = function
    | [] -> l_aux
    | h :: t -> if f h then h :: aux l_aux t else aux l_aux t
  in
  aux [] l

let rec partition f l =
  match l with
  | [] -> ([], [])
  | h :: t ->
      let si, no = partition f t in
      if f h then (h :: si, no) else (si, h :: no)

let partition' f l =
  let rec aux l_aux = function
    | [] -> l_aux
    | h :: t ->
        let si, no = aux l_aux t in
        if f h then (h :: si, no) else (si, h :: no)
  in
  aux ([], []) l

let for_all f l =
  let rec aux = function
    | [] -> true
    | h :: t -> if f h then true && aux t else false
  in
  aux l

let exists f l =
  let rec aux = function
    | [] -> false
    | h :: t -> if f h then true else false || aux t
  in
  aux l

let mem n l =
  let rec aux = function
    | [] -> false
    | h :: t -> if h = n then true else aux t
  in
  aux l

let fold_left f x l =
  let rec aux x_aux = function
    | [] -> x_aux
    | h :: t -> aux (f x_aux h) t
  in
  aux x l

let rec fold_right f l x =
  match l with
  | [] -> x
  | h :: t -> f h (fold_right f t x)
