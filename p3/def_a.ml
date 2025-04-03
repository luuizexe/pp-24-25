let pi = 2. *. asin 1.;;

let e = exp(1.);;

let max_int_f = float_of_int (max_int);;

let per x = 2. *. pi *. x;;

let area x = pi *. x *. x;;

let next_char x = char_of_int(1+int_of_char (x));;

let absf x = if x<0. then -.x else x;;

let odd x = x mod 2 <> 0;;

let next5mult x = ((x+4)/5)*5;;

let is_letter x = x > 'a' && x < 'z' || x > 'A' && x < 'Z';;

let string_of_bool x = if x then "verdadero" else "falso";;
