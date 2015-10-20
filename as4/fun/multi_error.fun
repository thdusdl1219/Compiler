/*
Don't just give up at the first type error.
Try to recover so that other errors can be found.
The typical way to do this is to call ErrorMsg.error,
then return the integer type, or the Tuple[] type, or whatever. */

/* compile should be failed
Posting error at 
1. function foo (type mismatched with return types)
2. call foo(<>)
3. call foo2(<1>)
*/

fun good(arg:int) : <int> =
    <arg+3+4+5+6*1*2*3*4-1-2-3-4-1,1,2,3>

fun foo(arg: int) : <int> =
    <arg>

fun foo2(arg:<int,int,int>) : <> =
    1

fun main(arg:int) : int =
    let a = good(1234) in
    let b = foo(<>) in
    let c = foo2(<1>) in
        1
