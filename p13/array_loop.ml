let append a1 a2 =
  let tam1 = Array.length a1 in
  let tam2 = Array.length a2 in
  if tam1 + tam2 > Sys.max_array_length then raise (Invalid_argument "append")
  else
    Array.init (tam1 + tam2) (fun i ->
        if i < tam1 then a1.(i) else a2.(i - tam1))

let sub a pos tam =
  if pos < 0 || tam < 0 || pos + tam > Array.length a then
    raise (Invalid_argument "sub")
  else Array.init tam (fun i -> a.(pos + i))

let copy a =
  let tam = Array.length a in
  Array.init tam (fun i -> a.(i))

let fill a pos tam x =
  if pos < 0 || tam < 0 || pos + tam > Array.length a then
    raise (Invalid_argument "fill")
  else
    for i = pos to pos + tam - 1 do
      a.(i) <- x
    done

let blit a1 pos1 a2 pos2 tam =
  if
    pos1 < 0 || pos2 < 0 || tam < 0
    || pos1 + tam > Array.length a1
    || pos2 + tam > Array.length a2
  then raise (Invalid_argument "blit")
  else
    for i = 0 to tam - 1 do
      a2.(pos2 + i) <- a1.(pos1 + i)
    done

let to_list a =
  let tam = Array.length a in
  let l = ref [] in
  for i = tam - 1 to 0 do
    l := a.(i) :: !l
  done;
  !l

let iter f a =
  let len = Array.length a in
  for i = 0 to len - 1 do
    f a.(i)
  done

let fold_left f acc a =
  let acc_aux = ref acc in
  for i = 0 to Array.length a - 1 do
    acc_aux := f !acc_aux a.(i)
  done;
  !acc_aux

let for_all f a =
  let aux = ref true in
  let cont = ref 0 in
  while !cont < Array.length a && !aux do
    if not (f a.(!cont)) then aux := false else cont := !cont + 1
  done;
  !aux

let exists f a =
  let aux = ref false in
  let cont = ref 0 in
  while !cont < Array.length a && not !aux do
    if f a.(!cont) then aux := true else cont := !cont + 1
  done;
  !aux

let find_opt f a =
  let aux = ref None in
  let cont = ref 0 in
  while !cont < Array.length a && !aux = None do
    if f a.(!cont) then aux := Some a.(!cont) else cont := !cont + 1
  done;
  !aux
