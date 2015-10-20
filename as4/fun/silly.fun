/*
You should allow such silliness as
(fun f(x:int):<int>=let x=3 in let x=<x> in x).
That is, a "let" binding is permitted to hide
an outer binding of the same name in a surrounding context.
*/
/* return success */

fun f(x:int):<int> =
    let x=3 in
    let x = <x> in
    let x = <x,x> in
    let x = <x,x,x> in
    let x = <x,x,x,x> in
    let x = <x,x,x,x,x> in
    let x = <3,x,x,x,x,x,x> in
    x

fun main(arg:int) : int =
    (f(10);3)
