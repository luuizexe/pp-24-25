let root_subtrees t =
  if BinTree.is_empty t then []
  else
    let rec aux l_aux t =
      let l = BinTree.left_b t in
      let r = BinTree.right_b t in
      if BinTree.is_empty l && BinTree.is_empty r then l_aux
      else if BinTree.is_empty l then aux (r :: l_aux) t
      else if BinTree.is_empty r then aux (l :: l_aux) t
      else aux (l :: r :: l_aux) t
    in
    aux [] t

let complete_subtrees t =
  let rec aux l_aux t =
    if BinTree.is_empty t then l_aux
    else
      let l = BinTree.left_b t in
      let r = BinTree.right_b t in
      aux (aux (t :: l_aux) l) r
  in
  aux [] t
