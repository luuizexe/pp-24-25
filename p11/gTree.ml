type 'a gtree = GT of 'a * 'a gtree list
type 'a t = 'a gtree

let leaftree x = GT (x, [])
let root (GT (x, _)) = x
let branches (GT (_, hijos)) = hijos

let rec size (GT (_, hijos)) =
  1 + List.fold_left (fun suma l -> suma + size l) 0 hijos

let rec height (GT (_, hijos)) =
  1 + List.fold_left (fun alt l -> max alt (height l)) 0 hijos

let preorder (GT (x, hijos)) =
  let rec aux l_aux = function
    | [] -> l_aux
    | GT (x, hijos) :: t -> x :: aux (aux l_aux t) hijos
  in
  x :: aux [] hijos

let postorder (GT (x, hijos)) =
  let rec aux l_aux = function
    | [] -> l_aux
    | GT (x, hijos) :: t -> aux (x :: aux l_aux hijos) t
  in
  List.rev (x :: aux [] hijos)

let breadth (GT (x, hijos)) =
  let rec aux acc = function
    | [] -> List.rev acc
    | GT (x, hijos) :: t -> aux (x :: acc) (t @ hijos)
  in
  aux [] [ GT (x, hijos) ]

let leaves a =
  let rec aux l_aux = function
    | GT (x, []) -> x :: l_aux
    | GT (_, hijos) -> List.fold_left aux l_aux hijos
  in
  List.rev (aux [] a)

let find_in_depth f a =
  let rec aux = function
    | [] -> raise Not_found
    | GT (x, hijos) :: t -> (
        if f x then x else try aux hijos with Not_found -> aux t)
  in
  aux [ a ]

let find_in_depth_opt f a =
  let rec aux = function
    | [] -> None
    | GT (x, hijos) :: t -> (
        if f x then Some x
        else
          match aux hijos with
          | Some x -> Some x
          | None -> aux t)
  in
  aux [ a ]

let breadth_find f a =
  let rec aux = function
    | [] -> raise Not_found
    | GT (x, hijos) :: t -> if f x then x else aux (t @ hijos)
  in
  aux [ a ]

let breadth_find_opt f a =
  let rec aux = function
    | [] -> None
    | GT (x, hijos) :: t -> if f x then Some x else aux (t @ hijos)
  in
  aux [ a ]

  let leaves_no GT(x,ht)= 
  let rec aux = function
  []-> 1
  h::t->leaves_no h + leaves_no t
in aux ht
let exists f a =
  let rec aux = function
    | [] -> false
    | GT (x, hijos) :: t -> if f x then true else aux hijos || aux t
  in
  aux [ a ]

let for_all f a =
  let rec aux = function
    | [] -> false
    | GT (x, hijos) :: t -> if f x then true else aux hijos && aux t
  in
  aux [ a ]

let map f (GT (x, hijos)) =
  let rec aux = function
    | [] -> []
    | GT (x, hijos) :: t -> GT (f x, aux hijos) :: aux t
  in
  GT (f x, aux hijos)

let rec mirror (GT (x, hijos)) = GT (x, List.rev (List.map mirror hijos))

let rec replace_when f (GT (x, hijos)) aux =
  if f x then aux else GT (x, List.map (fun l -> replace_when f l aux) hijos)

let rec cut_below f (GT (x, hijos)) =
  if f x then GT (x, []) else GT (x, List.map (cut_below f) hijos)

let rec from_bin t =
  if BinTree.is_empty t then raise (Failure "from_bin")
  else
    let r = BinTree.right_b t in
    let l = BinTree.left_b t in
    let hijos =
      if BinTree.is_empty l && BinTree.is_empty r then []
      else if BinTree.is_empty l then [ from_bin r ]
      else if BinTree.is_empty r then [ from_bin l ]
      else [ from_bin l; from_bin r ]
    in
    GT (BinTree.root t, hijos)

let rec from_stbin t =
  if StBinTree.is_leaf t then GT (StBinTree.root t, [])
  else
    let r = StBinTree.right_b t in
    let l = StBinTree.left_b t in
    let hijos = [ from_stbin l; from_stbin r ] in
    GT (StBinTree.root t, hijos)


    