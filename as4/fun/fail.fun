fun main(x:int):int =  
	let 
		x= ref(5)
	in (x:=3:=5;!x)

fun test(x:<>):int ref =
	let 
		x = ref(5)
	in x

fun kk(x:int):int = -3
