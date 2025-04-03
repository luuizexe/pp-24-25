let maximo = max_int;;
(*val maximo : int = 4611686018427387903*)
(*Nos indica el máximo entero representable en ocaml*)

let minimo = min_int;;
(*val minimo : int = -4611686018427387904*)
(*Nos indica el minimo entero representable en ocaml*)

minimo + maximo;;
(*La salida no es int = 0*)
(*int = -1*)

minimo + maximo + 1;;
(*int = 0*)

maximo + 1;;
(*La salida no es error de ejecución*)
(*int = -4611686018427387904*)

minimo = maximo + 1;;
(*bool = true*)

2 * minimo;;
(*int = 0*)

minimo - 1 = maximo;;
(*bool = true*)

2 * maximo;;
(*int = -2*)

let maximo = 1. /. 0.;;
(*La salida no es error de ejecución*)
(*val maximo : float = infinity*)

let minimo = -1.0 /. 0.;;
(*val minimo : float = neg_infinity*)

1. /. maximo;;
(*float = 0.*)

1. /. minimo;;
(*La salida no es float = 0.*)
(*float = -0.*)

1. /. maximo = 1. /. minimo;;
(*La salida no es bool = false*)
(*bool = true*)

0. /. 0.;;
(*La salida no es error de ejecución*)
(*float = nan*)

maximo +. maximo;;
(*float = infinity*)

maximo -. maximo;;
(*float = nan*)

-. maximo = minimo;;
(*bool = true*)

maximo +. minimo;;
(*float = nan*)

not (minimo < maximo);;
(*bool = false*)

let not = "no";;
(*val not : string = "no"*)

(*not (minimo < maximo);;*)
(*Error de tipo. not no es una función*)

Stdlib.not (minimo < maximo);;
(*bool = false*)

not ^ not;;
(*string = "nono"*)

let not = "si" in not ^ not;;
(*string = "sisi"*)

not;;
(*string = "no"*)

let x = 1;;
(*val x : int = 1*)

let x = 2 in x + x * x;;
(*int = 6*)

1 + let x = 2 in x + x * x;;
(*int = 7*)

x + let x = 2 in x * x;;
(*int = 5*)

let y = x + let x = 2 in x * x;;
(*val y : int = 5*)

let x = x + 1 in let x = 3 * x in x * x;;
(*int = 36*)

(function x -> 2 * x);;
(*int -> int = <fun>*)

(function x -> 2 * x) (2 + 1);;
(*int = 6*)

(function x -> 2 * x) 2 + 1;;
(*int = 5*)

(function y -> 2 * y) ((function y -> 2 * y) 3);;
(*int = 12*)

let doble = function z -> 2 * z;;
(*val = double : int -> int = <fun>*)

doble 2 + 1;;
(*int = 5*)

doble (doble 3);;
(*int = 12*)

(*doble doble 3;;*)
(*Error de tipo. Hay mas argumentos de lo requerido*)

abs (1 - 2);;
(*int = 1*)

abs 1;;
(*int = 1*)

(*abs -1;;*)
(*Error de tipo. Se espera un entero, pero sólo pilla el "-"*)

let abs = function x -> if x >= 0. then x else -. x;;
(*val abs : float -> float = <fun>*)

(*abs 1;;*)
(*Error de tipo. Se espera un entero, pero recibe un float*)

abs 1.5;;
(*float = 1.5*)

Stdlib.abs 1;;
(*int = 1*)

let suma = function (x,y) -> x + y;;
(*val suma = int * int -> = <fun>*)

2 * suma (2,3) - suma (1,1);;
(*int = 8*)

let suma' = function x -> (function y -> x + y);;
(*val suma' = int -> int -> int = <fun>*)

suma' 3;;
(*La salida no es error sintáctico, pq falta un parámetro*)
(*int -> int = <fun>. Ocaml si que puede devolver algo,en este caso una funcion con el parámetro escrito anteriormente, a pesar de que falta otro*)


(suma' 3) 2;;
(*int = 5*)

suma' 3 2;;
(*int = 5*)

suma (3,2) = suma' 3 2;;
(*bool = true*)

(*suma 3;;*)
(*Error sintáctico. Falta otro parámetro*)

let suma3 = suma' 3;;
(*val suma3 : int -> int = <fun>*)

suma3 10;;
(*int = 13*)

suma3 2 + 1;;
(*int = 6*)

suma3 (suma3 10);;
(*int = 16*)

(*suma3 suma3 10;;*)
(*Error de tipo. Debería recibir un int, pero recibe una función*)


