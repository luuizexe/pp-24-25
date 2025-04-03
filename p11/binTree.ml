type 'a bintree = Empty | BT of 'a bintree * 'a * 'a bintree
type 'a t = 'a bintree

let empty = Empty
let is_empty x = x = Empty
let leaftree x = BT (Empty, x, Empty)

let root = function
  | Empty -> raise (Failure "root")
  | BT (_, x, _) -> x

let left_b = function
  | Empty -> raise (Failure "left_b")
  | BT (l, _, _) -> l

let right_b = function
  | Empty -> raise (Failure "right_b")
  | BT (_, _, r) -> r

let root_replacement t x =
  match t with
  | Empty -> raise (Failure "root_replacement")
  | BT (l, _, r) -> BT (l, x, r)

let left_replacement t l =
  match t with
  | Empty -> raise (Failure "left_replacement")
  | BT (_, x, r) -> BT (l, x, r)

let right_replacement t r =
  match t with
  | Empty -> raise (Failure "right_replacement")
  | BT (l, x, _) -> BT (l, x, r)

let rec size = function
  | Empty -> 0
  | BT (l, _, r) -> 1 + size l + size r

let rec height = function
  | Empty -> 0
  | BT (l, _, r) -> 1 + max (height l) (height r)

let rec preorder t =
  let rec aux l_aux = function
    | Empty -> l_aux
    | BT (l, x, r) -> x :: aux (aux l_aux r) l
  in
  aux [] t

let rec inorder t =
  let rec aux l_aux = function
    | Empty -> l_aux
    | BT (l, x, r) -> aux (x :: aux l_aux r) l
  in
  aux [] t

let rec postorder t =
  let rec aux l_aux = function
    | Empty -> l_aux
    | BT (l, x, r) -> aux (aux (x :: l_aux) r) l
  in
  aux [] t

let breadth a =
  let rec aux l_aux = function
    | [] -> (
        match l_aux with
        | [] -> []
        | _ -> aux [] (List.rev l_aux))
    | Empty :: t -> aux l_aux t
    | BT (l, x, r) :: t -> x :: aux (r :: l :: l_aux) t
  in
  aux [] [ a ]

let leaves t =
  let rec aux l_aux = function
    | Empty -> l_aux
    | BT (Empty, x, Empty) -> x :: l_aux
    | BT (l, _, r) -> aux (aux l_aux r) l
  in
  aux [] t

let rec find_in_depth f = function
  | Empty -> raise Not_found
  | BT (l, x, r) -> (
      if f x then x
      else try find_in_depth f l with Not_found -> find_in_depth f r)

let rec find_in_depth_opt f = function
  | Empty -> None
  | BT (l, x, r) -> (
      if f x then Some x
      else
        match find_in_depth_opt f l with
        | Some x -> Some x
        | None -> find_in_depth_opt f r)

let rec exists f = function
  | Empty -> false
  | BT (l, x, r) -> if f x then true else exists f l || exists f r

let rec for_all f = function
  | Empty -> false
  | BT (l, x, r) -> if f x then true else for_all f l && for_all f r

let rec map f = function
  | Empty -> Empty
  | BT (l, x, r) -> BT (map f l, f x, map f r)

let rec mirror = function
  | Empty -> Empty
  | BT (l, x, r) -> BT (mirror r, x, mirror l)

let rec replace_when f t aux =
  match t with
  | Empty -> Empty
  | BT (l, x, r) ->
      if f x then aux else BT (replace_when f l aux, x, replace_when f r aux)

let rec cut_above f = function
  | Empty -> Empty
  | BT (l, x, r) -> if f x then Empty else BT (cut_above f l, x, cut_above f r)

let rec cut_below f = function
  | Empty -> Empty
  | BT (l, x, r) ->
      if f x then BT (Empty, x, Empty) else BT (cut_below f l, x, cut_below f r)
