type 'a st_bintree = Leaf of 'a | SBT of 'a st_bintree * 'a * 'a st_bintree
type 'a t = 'a st_bintree

let leaftree x = Leaf x

let is_leaf = function
  | Leaf _ -> true
  | _ -> false

let comb x l r = SBT (l, x, r)

let root = function
  | Leaf x -> x
  | SBT (_, x, _) -> x

let left_b = function
  | Leaf _ -> raise (Failure "left_b")
  | SBT (l, _, _) -> l

let right_b = function
  | Leaf _ -> raise (Failure "right_b")
  | SBT (_, _, r) -> r

let root_replacement t x =
  match t with
  | Leaf _ -> raise (Failure "root_replacement")
  | SBT (l, _, r) -> SBT (l, x, r)

let left_replacement t l =
  match t with
  | Leaf _ -> raise (Failure "left_replacement")
  | SBT (_, x, r) -> SBT (l, x, r)

let right_replacement t r =
  match t with
  | Leaf _ -> raise (Failure "right_replacement")
  | SBT (l, x, _) -> SBT (l, x, r)

let rec size = function
  | Leaf _ -> 1
  | SBT (l, _, r) -> 1 + size l + size r

let rec height = function
  | Leaf _ -> 1
  | SBT (l, _, r) -> 1 + max (height l) (height r)

let rec preorder t =
  let rec aux l_aux = function
    | Leaf x -> x :: l_aux
    | SBT (l, x, r) -> x :: aux (aux l_aux r) l
  in
  aux [] t

let rec inorder t =
  let rec aux l_aux = function
    | Leaf x -> x :: l_aux
    | SBT (l, x, r) -> aux (x :: aux l_aux r) l
  in
  aux [] t

let rec postorder t =
  let rec aux l_aux = function
    | Leaf x -> x :: l_aux
    | SBT (l, x, r) -> aux (aux (x :: l_aux) r) l
  in
  aux [] t

let breadth a =
  let rec aux l_aux = function
    | [] -> (
        match l_aux with
        | [] -> []
        | _ -> aux [] (List.rev l_aux))
    | Leaf x :: t -> x :: aux l_aux t
    | SBT (l, x, r) :: t -> x :: aux (r :: l :: l_aux) t
  in
  aux [] [ a ]

let leaves t =
  let rec aux l_aux = function
    | Leaf x -> x :: l_aux
    | SBT (l, _, r) -> aux (aux l_aux r) l
  in
  aux [] t

let rec find_in_depth f = function
  | Leaf x -> if f x then x else raise Not_found
  | SBT (l, x, r) -> (
      if f x then x
      else try find_in_depth f l with Not_found -> find_in_depth f r)

let rec find_in_depth_opt f = function
  | Leaf x -> if f x then Some x else None
  | SBT (l, x, r) -> (
      if f x then Some x
      else
        match find_in_depth_opt f l with
        | Some x -> Some x
        | None -> find_in_depth_opt f r)

let rec exists f = function
  | Leaf x -> f x
  | SBT (l, x, r) -> if f x then true else exists f l || exists f r

let rec for_all f = function
  | Leaf x -> f x
  | SBT (l, x, r) -> if f x then true else for_all f l && for_all f r

let rec map f = function
  | Leaf x -> Leaf (f x)
  | SBT (l, x, r) -> SBT (map f l, f x, map f r)

let rec mirror = function
  | Leaf x -> Leaf x
  | SBT (l, x, r) -> SBT (mirror r, x, mirror l)

let rec replace_when f t aux =
  match t with
  | Leaf x -> if f x then aux else Leaf x
  | SBT (l, x, r) ->
      if f x then aux else SBT (replace_when f l aux, x, replace_when f r aux)

let rec cut_below f = function
  | Leaf x -> Leaf x
  | SBT (l, x, r) ->
      if f x then Leaf x else SBT (cut_below f l, x, cut_below f r)

let rec to_bin = function
  | Leaf x -> BinTree.leaftree x
  | SBT (l, x, r) ->
      BinTree.left_replacement
        (BinTree.right_replacement (BinTree.leaftree x) (to_bin r))
        (to_bin l)

let rec from_bin t =
  if BinTree.is_empty t then raise (Failure "from_bin")
  else
    let r = BinTree.right_b t in
    let l = BinTree.left_b t in
    if BinTree.is_empty l && BinTree.is_empty r then Leaf (BinTree.root t)
    else SBT (from_bin l, BinTree.root t, from_bin r)
