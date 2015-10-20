/* Welcome to Chogas world!!!
Chogas is very efficient type checker for 'join' operation
Simple form is explained in below
This version checks 'join operation between functions
========================================================================================
if cho=gas then (ref (if (cho < gas) then 'fun1' else 'fun2')) else (ref 'fun3')
========================================================================================
If you want to check another case, you should put type1, type2 and answer_type and share to us :)

All case would be successful!!!!!!*/

fun foo1_a (x:int) : int = 
    1
fun foo1_r (x:int) : int =
    1
fun foo1_l (x:int) : int =
    1

fun foo2_a (x:<int>) : int =
    1
fun foo2_r (x:<>) : int =
    1
fun foo2_l (x:<int>) : int =
    1

fun foo3_a (x:<<int,int>,<<int>,<int,int>>>) : int =
    1
fun foo3_r (x:<<int>,<<int>,<>>>) : int =
    1
fun foo3_l (x:<<int,int>,<<>,<int,int>>>) : int =
    1

fun foo4_a (x:<>) : <<>,<>> =
    <<1,2,<3,4>>,<<<5,6>,7>>>
fun foo4_r (x:<>) : <<>,<<<int,int>,int>>> =
    <<>,<<<1,2>,3>>>
fun foo4_l (x:<>) : <<int,int,<int,int>>,<>> =
    <<1,2,<3,4>>,<>>

fun foo5_a (x:<<int,int>,<<int>,<int,int>>>) : <<>,<>> =
    <<1,2,<3,4>>,<<<5,6>,7>>>
fun foo5_r (x:<<int>,<<int>,<>>>) : <<>,<<<int,int>,int>>> =
    <<>,<<<1,2>,3>>>
fun foo5_l (x:<<int,int>,<<>,<int,int>>>) : <<int,int,<int,int>>,<>> =
    <<1,2,<3,4>>,<>>

fun foo6_a (x:<int,<int,int>,<<int>,<int,int>>>) : <<int>,<>> =
    <<1,2,<3,4>>,<<<5,6>,7>>>
fun foo6_r (x:<int,<int>,<<int>>>) : <<int>,<<<int,int>,int>>> =
    <<1>,<<<1,2>,3>>>
fun foo6_l (x:<int,<int,int>,<<int>,<int,int>>>) : <<int,int,<int,int>>,<>> =
    <<1,2,<3,4>>,<>>

fun main (arg:int):int =
    let cho = 1 in
    let gas = 2 in
    let is = 3 in
    let op = 4 in
    (if cho=gas then (ref (if cho=gas then (foo1_r) else (foo1_l))) else (ref foo1_a); /* first stack */
    if cho=gas then (ref (if cho=gas then (foo2_r) else (foo2_l))) else (ref foo2_a); /* second stack */
    if cho=gas then (ref (if cho=gas then (foo3_r) else (foo3_l))) else (ref foo3_a); /* third stack */
    if cho=gas then (ref (if cho=gas then (foo4_r) else (foo4_l))) else (ref foo4_a); /* fourth stack */
    if cho=gas then (ref (if cho=gas then (foo5_r) else (foo5_l))) else (ref foo5_a); /* fifth stack */
    if cho=gas then (ref (if cho=gas then (foo6_r) else (foo6_l))) else (ref foo6_a); /* sixth stack */
	1)

