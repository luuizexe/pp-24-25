val root_subtrees : 'a BinTree.t -> 'a BinTree.t list
(* lista de todos los subárboles raíz del árbol dado *)

val subtrees : 'a BinTree.t -> 'a BinTree.t list
(* lista de todos los subárboles del árbol dado *)

val complete_subtrees : 'a BinTree.t -> 'a BinTree.t list
(* lista de todos los subárboles completos del árbol dado *)

val terminal_subtrees : 'a BinTree.t -> 'a BinTree.t list
(* lista de todos los subárboles terminales del árbol dado *)

val inner_subtrees : 'a BinTree.t -> 'a BinTree.t list
(* lista de todos los subárboles interiores del árbol dado *)
