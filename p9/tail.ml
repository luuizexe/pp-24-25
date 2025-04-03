let concat l =
  let rec aux acc = function
    | [] -> List.rev acc
    | h :: t -> aux (h @ acc) t
  in
  aux [] l

let front l =
  let rec aux acc = function
    | [] -> raise (Failure "front")
    | [ _ ] -> List.rev acc
    | h :: t -> aux (h :: acc) t
  in
  aux [] l

let compress l =
  let rec aux acc = function
    | h1 :: (h2 :: _ as t) -> if h1 = h2 then aux acc t else aux (h1 :: acc) t
    | [ h ] -> List.rev (h :: acc)
    | [] -> List.rev acc
  in
  aux [] l

let ofo l =
  let rec aux acc = function
    | [] -> List.rev acc
    | h :: t -> if List.mem h acc then aux acc t else aux (h :: acc) t
  in
  aux [] l

let fold_right' f l x =
  let rec aux acc l =
    match l with
    | [] -> acc
    | h :: t -> aux (f h acc) t
  in
  aux x (List.rev l)

let sublists l =
  let rec aux acc = function
    | [] -> acc
    | h :: t ->
        let sublista = List.map (fun sub -> h :: sub) acc in
        aux (acc @ sublista) t
  in
  aux [ [] ] l
