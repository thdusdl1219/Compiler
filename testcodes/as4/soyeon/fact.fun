fun fact(n:int) : int =
  if n=0 then 1 else n * fact(n-1)
fun main(arg:int) : int =
  let res = fact(5)
  in (printint(res); res)
