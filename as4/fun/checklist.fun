fun main (arg:int):int = 1
fun myFun(arg:int):int = 0
fun abc(myFun:int):int = 0
fun f(x:int):<int> = 
	let x=3 in 
		let x=<x> in 
			x
fun g(int:<int>): <int> = <1>
fun h(int:<int, int>): <int, (int->int)> = <1,myFun>

fun test(int:int): <int, int, int>-><int> =
	if 1 then g else h

fun test2(int:int): <> =
	if 1 then <1, myFun> else <>
