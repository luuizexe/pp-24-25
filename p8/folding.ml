let i_prod = function
  | [] -> raise (Failure "i_prod: La lista esta vacia")
  | h :: t -> List.fold_left ( * ) 1 t

let f_prod = function
  | [] -> raise (Failure "i_prod: La lista esta vacia")
  | h :: t -> List.fold_left ( *. ) 1. t

let lmin = function
  | [] -> raise (Failure "lmin: La lista esta vacia")
  | h :: t -> List.fold_left min h t

let min_max = function
  | [] -> raise (Failure "min_max: La lista esta vacia")
  | h :: t -> (List.fold_left min h t, List.fold_left max h t)

let rev l = List.fold_left (fun a b -> b :: a) [] l
let rev_append l1 l2 = List.fold_left (fun a b -> b :: a) l2 l1
let rev_map f l = List.fold_left (fun a b -> f b :: a) [] l
let concat l = List.fold_left (fun a b -> a ^ b) "" l
