let length l =
  let cont = ref 0 in
  let aux = ref l in
  while !aux <> [] do
    cont := !cont + 1;
    aux := List.tl !aux
  done;
  !cont

let last l =
  if l = [] then failwith "last"
  else
    let t = ref (List.tl l) in
    let h = ref (List.hd l) in
    while !t <> [] do
      h := List.hd !t;
      t := List.tl !t
    done;
    !h

let nth l pos =
  if pos < 0 then raise (Invalid_argument "nth") (*pos tiene que ser positiva*)
  else
    let cont = ref 0 in
    let l_aux = ref l in
    while !cont < pos && !l_aux <> [] do
      l_aux := List.tl !l_aux;
      cont := !cont + 1
    done;
    if !l_aux = [] then failwith "nth" (*No se ha encontrado el elemento*)
    else List.hd !l_aux

let rev l =
  match l with
  | [] -> []
  | _ ->
      let l_rev = ref [] in
      let l_aux = ref l in
      while !l_aux <> [] do
        l_rev := List.hd !l_aux :: !l_rev;
        l_aux := List.tl !l_aux
      done;
      !l_rev

let append l1 l2 =
  let l1_aux = ref l1 in
  let l2_aux = ref l2 in
  let l_rev = ref [] in
  while !l1_aux <> [] do
    l_rev := List.hd !l1_aux :: !l_rev;
    l1_aux := List.tl !l1_aux
  done;
  while !l_rev <> [] do
    l2_aux := List.hd !l_rev :: !l2_aux;
    l_rev := List.tl !l_rev
  done;
  !l2_aux

let concat l =
  let l_concat = ref [] in
  let l_aux = ref l in
  while !l_aux <> [] do
    let h = ref (List.hd !l_aux) in
    while !h <> [] do
      l_concat := List.hd !h :: !l_concat;
      h := List.tl !h
    done;
    l_aux := List.tl !l_aux
  done;
  let l_rev = ref [] in
  while !l_concat <> [] do
    l_rev := List.hd !l_concat :: !l_rev;
    l_concat := List.tl !l_concat
  done;
  !l_rev

let for_all f l =
  let l_aux = ref l in
  let aux = ref true in
  while !l_aux <> [] && !aux do
    if f (List.hd !l_aux) then l_aux := List.tl !l_aux else aux := false
  done;
  !aux

let exists f l =
  let l_aux = ref l in
  let aux = ref false in
  while !l_aux <> [] && not !aux do
    if f (List.hd !l_aux) then aux := true else l_aux := List.tl !l_aux
  done;
  !aux

let find_opt f l =
  let l_aux = ref l in
  let aux = ref None in
  while !l_aux <> [] && !aux = None do
    let h = List.hd !l_aux in
    if f h then aux := Some h else l_aux := List.tl !l_aux
  done;
  !aux

let iter f l =
  let l_aux = ref l in
  while !l_aux <> [] do
    f (List.hd !l_aux);
    l_aux := List.tl !l_aux
  done

let fold_left f acc l =
  let l_aux = ref l in
  let acc_aux = ref acc in
  while !l_aux <> [] do
    acc_aux := f !acc_aux (List.hd !l_aux);
    l_aux := List.tl !l_aux
  done;
  !acc_aux
