/* Wrong type of function */

/* Error: Same function names */
fun sum (x:int):int = x + x
fun sum (y:int):int = sum(y)

fun main (x: int): int = sum(2)

