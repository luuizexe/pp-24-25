let rec sumto = function 0 -> 0 | x -> x + sumto(x-1);;  

let rec exp2 = function 0 -> 1 | x -> 2 * exp2 (x-1);;

let rec num_cifras = function x -> 
	if x > (-10) && x < 10 
		then 1 
	else 
		1 + num_cifras(x/10);;

let rec sum_cifras = function 0 -> 0 | x -> abs(x mod 10) + sum_cifras (x/10);;
