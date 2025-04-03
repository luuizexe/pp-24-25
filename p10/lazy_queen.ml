let costeh (_, j1) (_, j2) = abs (j2 - j1) (* anchos horizontes *)
let costev (i1, _) (i2, _) = abs (i2 - i1) (* caída libre *)
let coste1 (i1, j1) (i2, j2) = min (abs (i2 - i1)) (abs (j2 - j1))

(* las cuestas se hacen pesadas *)
let coste2 (i1, j1) (i2, j2) = max (abs (i2 - i1)) (abs (j2 - j1))

(* las cuestas no cuestan tanto *)
let coste3 (i1, j1) (i2, j2) = abs (i2 - i1) + abs (j2 - j1)

(* bastante realista *)
let coste4 (i1, j1) (i2, j2) = abs (abs (i2 - i1) - abs (j2 - j1))

(* mejor en diagonal *)
let coste5 (i1, j1) (i2, j2) = max 0 (i2 - i1) + max 0 (j2 - j1)
(* evita caer y tirar a la derecha *)

let coste6 (i1, j1) (i2, j2) =
  (* ¿es la diagonal racional? *)
  if i1 = i2 then abs (j2 - j1)
  else if j1 = j2 then abs (i2 - i1)
  else 3 * abs (j2 - j1) / 2

(* Función auxiliar que implementa el algoritmo de Dijkstra para encontrar el camino de coste mínimo *)
let lazy_queen coste q_pos peones =
  let rec aux peones visited l_aux =
    match peones with
    | [] -> l_aux (* No hay más peones para comer, devolvemos el camino *)
    | _ ->
        let find_min_cost_peon peons =
          List.fold_left
            (fun (min_cost, best_peon) peon ->
              if List.mem peon visited then (min_cost, best_peon)
              else
                let cost = coste (List.hd l_aux) peon in
                if cost < min_cost then (cost, peon) else (min_cost, best_peon))
            (max_int, q_pos) peons
        in
        let _, best_peon = find_min_cost_peon peones in
        if best_peon = q_pos then
          raise Not_found (* Si no hay peón alcanzable *)
        else
          let resto = List.filter (fun p -> p <> best_peon) peones in
          aux resto (best_peon :: visited) (best_peon :: l_aux)
  in
  aux peones [] [ q_pos ]
