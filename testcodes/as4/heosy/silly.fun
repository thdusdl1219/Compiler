/* Wrong type of function */

/* Permit: Silly functions */
fun f(x:int):<int> = let x=3 in let x=<x> in x
fun g(int:<int>):<int> = int

/* Permit: A name of parameter is same as the name of a global function */
fun h(f: int): int = f - 1

/* Error: main does not has type of (int->int) */
fun main (x: int): int = 3

