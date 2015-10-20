/*
You should even permit (fun g(int:<int>): <int> = int).
That is, the name space of types (which in basic Fun has only "int" in it)
is orthogonal to the name space of values.
*/
/* return fail */

fun f(x:int):<int> =
    let x=3 in
    let x = <x> in
    let x = <x,x> in
    let x = <x,x,x> in
    let x = <x,x,x,x> in
    let x = <x,x,x,x,x> in
    let x = <x,x,x,x,x,x,x> in
    x

fun main(arg:int) : int =
    (f(10);3)
