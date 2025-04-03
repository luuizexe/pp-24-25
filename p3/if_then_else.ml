(function true -> "first is greater" | false -> "second is greater")(x > y);;
(function true -> x | false -> -x)(x > 0);;
(function true -> x | false -> (function true -> y | false -> 0)(y>0))(x>0);;
(function true -> (function true -> x | false -> z)(x > z) | false -> (function true -> y | false -> z)(y>z))(x > y);;