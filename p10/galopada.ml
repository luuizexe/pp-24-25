let rec hayRep l =
  match l with
  | [] -> false
  | h :: t -> if List.mem h t then true else hayRep t

let rec peonesNoValidos n peones =
  if hayRep peones then true
  else
    match peones with
    | [] -> false
    | (h1, h2) :: t ->
        h1 <= 0 || h1 > n || h2 <= 0 || h2 > n || peonesNoValidos n t

let siguiente_pos pos n =
  if snd pos >= n then (fst pos + 1, 1) else (fst pos, snd pos + 1)

let movimientos_caballo (x, y) n =
  (* Genera todas las posiciones posibles a las que puede moverse un caballo *)
  let posibles =
    [
      (x + 2, y + 1);
      (x + 2, y - 1);
      (x - 2, y + 1);
      (x - 2, y - 1);
      (x + 1, y + 2);
      (x + 1, y - 2);
      (x - 1, y + 2);
      (x - 1, y - 2);
    ]
  in
  (* Filtrar movimientos que estén dentro del tablero *)
  List.filter (fun (a, b) -> a > 0 && a <= n && b > 0 && b <= n) posibles

let galopada n peones =
  (* Verificación inicial de argumentos *)
  if n < 1 || peonesNoValidos n peones then raise (Invalid_argument "galopada")
  else
    let rec aux pos l_aux restantes =
      match restantes with
      | [] ->
          Some (List.rev l_aux)
          (* Si no quedan peones, devolver el camino completo *)
      | h :: t ->
          let movimientos = movimientos_caballo pos n in
          let siguiente = siguiente_pos pos n in
          if siguiente = (n + 1, 1) then None
          else if List.mem h movimientos then
            match aux h (h :: l_aux) t with
            | Some result -> Some result
            | None -> aux siguiente l_aux restantes
          else aux siguiente l_aux restantes
    in
    match aux (1, 1) [] peones with
    | Some result -> result
    | None -> raise Not_found
