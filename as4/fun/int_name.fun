/*
You should even permit (fun g(int:<int>): <int> = int).
That is, the name space of types (which in basic Fun has only "int" in it)
is orthogonal to the name space of values.
*/
/* return success */

fun g(int:<int>):<int> =
    int

fun main(arg:int) : int =
    (g(<1,2,3,4,5,6>); 1)
