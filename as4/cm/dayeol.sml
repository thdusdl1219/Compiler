(*
Still working...!
This test was made by Dayeol Lee (dayeol@postech.ac.kr)
**** HOW TO TEST! ****
1. Move "dayeol.sml" and "dayeol.cm" to your working "as4" directory
2. Run sml console
3. Make
	> CM.make "dayeol.cm";
4. Test
	> Dayeol.testAll();

5. If everything's OK, there should be no "fail" messages.. Good Luck

마지막 testError() 함수는 에러 테스트 하는 함수로, fail이 나올 수도 있으며, Error가 안나면 그게 이상한 것입니다.

중요!! tc_exp를 test 하기 위해서는 반드시 typecheck.sml에 아래와 같은 라인을 추가해주세요

val tc_exp: Absyn.tp Symbol.table -> ErrorMsg.pos2 -> Absyn.exp -> Absyn.tp

예시:

signature TYPECHECK =
sig
  val tc : Absyn.prog -> unit
  (* if there are errors, these are reported through ErrorMsg.error *)

  val sub: Absyn.tp * Absyn.tp -> bool
  val join: (string->unit) -> Absyn.tp * Absyn.tp -> Absyn.tp
  val tc_exp: Absyn.tp Symbol.table -> ErrorMsg.pos2 -> Absyn.exp -> Absyn.tp
end

...(후략) ...

*)

structure T = TypeCheck
structure A = Absyn

structure Dayeol = 
struct
 
 
  fun list2string nil = ""
   | list2string [t] = t
   | list2string (h::t) = h ^ "," ^ list2string t
  
  fun tp2string A.Inttp = "int"
   | tp2string (A.Tupletp tps) = "<" ^ (list2string (map tp2string tps)) ^ ">"
   | tp2string (A.Arrowtp (tp1, tp2)) = tp2string tp1 ^ " -> " ^ tp2string tp2
   | tp2string (A.Reftp tp) = tp2string tp ^ " ref"

  fun assert (result, expect, fail) =
		if result = expect 
		then (print "ok\n";()) 
		else (print "fail\n"; fail := !fail + 1 ;())

	fun complain str =
		print (str^"\n")

	fun testSub () =
		let val fail = ref 0 in
			T.tc_exp;
			assert( T.sub (A.Inttp, A.Inttp), true, fail);
			assert( T.sub (A.Inttp, A.Tupletp []), false, fail);
			assert( T.sub (A.Tupletp [], A.Tupletp []), true, fail);
			assert( T.sub (A.Tupletp [A.Inttp], A.Tupletp []), true, fail);
			assert( T.sub (A.Tupletp [A.Inttp], A.Tupletp [A.Inttp, A.Inttp]), false, fail);
			assert( T.sub (
				A.Tupletp [A.Inttp, A.Tupletp [A.Inttp] ], 
				A.Tupletp [A.Inttp, A.Tupletp [] ]), 
				true, fail);
			assert( T.sub (
				A.Tupletp [A.Tupletp [ A.Tupletp [A.Inttp, A.Inttp] ], A.Tupletp [A.Inttp] ], 
				A.Tupletp [A.Tupletp [ A.Tupletp [A.Inttp, A.Inttp, A.Inttp] ], A.Tupletp [] ]), 
				false, fail);
			assert( T.sub (
				A.Arrowtp (A.Inttp, A.Inttp), 
				A.Arrowtp (A.Inttp, A.Inttp)), 
				true, fail );
			assert( T.sub (
				A.Arrowtp (A.Inttp, A.Inttp), 
				A.Arrowtp (A.Tupletp [A.Inttp], A.Inttp)), 
				false, fail);
			assert( T.sub (
				A.Arrowtp (A.Tupletp [A.Inttp, A.Inttp], A.Inttp), 
				A.Arrowtp (A.Tupletp [A.Inttp], A.Inttp)), 
				false, fail);
			assert( T.sub (
				A.Arrowtp (A.Tupletp [], A.Tupletp [A.Inttp]), 
				A.Arrowtp (A.Tupletp [A.Inttp], A.Tupletp [])), 
				true, fail);
			assert( T.sub (
				A.Arrowtp (A.Tupletp [A.Inttp], A.Tupletp [A.Inttp, A.Inttp]), 
				A.Arrowtp (A.Tupletp [A.Inttp], A.Tupletp [A.Inttp])), 
				true, fail);
			assert( T.sub (
				A.Arrowtp (A.Tupletp [], A.Tupletp [A.Inttp, A.Inttp]), 
				A.Arrowtp (A.Tupletp [A.Inttp], A.Tupletp [A.Inttp])), 
				true, fail);
			assert(T.sub(
				A.Reftp (A.Inttp),
				A.Reftp (A.Inttp)),
				true, fail);
			assert(T.sub(
				A.Reftp (A.Tupletp [A.Inttp]),
				A.Reftp (A.Tupletp [])),
				false, fail);
			assert(T.sub(
				A.Reftp (A.Arrowtp (A.Tupletp [A.Inttp], A.Tupletp [A.Inttp])),
				A.Reftp (A.Arrowtp (A.Tupletp [], A.Tupletp [A.Inttp, A.Inttp]))),
				false, fail);
			assert(T.sub(
				A.Reftp (A.Arrowtp (A.Tupletp [], A.Tupletp [A.Inttp, A.Inttp])),
				A.Reftp (A.Arrowtp (A.Tupletp [], A.Tupletp [A.Inttp, A.Inttp]))),
				true, fail);
        print("============================testsub end\n");
			!fail
		end  

	fun testExp () =
		let val fail = ref 0 in
			assert(
				T.tc_exp Symbol.empty (0,0)
				(A.Tuple [ A.Tuple [ A.Tuple [A.Int 1, A.Int 2] ], A.Tuple [A.Int 3], A.Tuple [ A.Tuple [A.Int 4] ], A.Int 5]),
				(A.Tupletp [ A.Tupletp [ A.Tupletp [A.Inttp , A.Inttp ] ], A.Tupletp [A.Inttp ], A.Tupletp [ A.Tupletp [A.Inttp ] ], A.Inttp ]),
				fail
				);
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) (A.Int 1)), A.Inttp, fail );
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) 
				(A.Op( A.Add, [A.Int 2, A.Int 1]))
				), A.Inttp, fail );
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) 
				(A.Op( A.Mul, [A.Int 2, A.Int 1]))
				), A.Inttp, fail );
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) 
				(A.Op( A.Eq, [A.Int 2, A.Int 1]))
				), A.Inttp, fail );
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) 
				(A.Op( A.LT, [A.Int 2, A.Int 1]))
				), A.Inttp, fail );
			assert ( (TypeCheck.tc_exp Symbol.empty (0,0) 
				(A.Op( A.Sub, [A.Int 2, A.Int 1]))
				), A.Inttp, fail );
			assert ( (T.tc_exp Symbol.empty (0,0) 
				(A.Op( A.Ref, [A.Int 1]))), 
				A.Reftp A.Inttp, 
				fail);
			assert ( (T.tc_exp Symbol.empty (0,0)
				(A.Op( A.Ref, [A.Op ( A.Ref, [A.Int 100])]))), 
				A.Reftp (A.Reftp A.Inttp), 
				fail);
			assert ( (T.tc_exp Symbol.empty (0,0)
				(A.Op( A.Get, [A.Op (A.Ref, [A.Int 10])]))),
				(A.Inttp),
				fail);
			assert( (T.tc_exp Symbol.empty (0,0)
				(A.Op (A.Set, [A.Op(A.Ref, [A.Int 10]),A.Int 11]))),
				(A.Tupletp []),
				fail);
			assert(
				T.tc_exp Symbol.empty (0,0)
				(A.Proj (1,( A.Tuple [ A.Tuple [ A.Tuple [A.Int 1, A.Int 2] ], A.Tuple [A.Int 3], A.Tuple [ A.Tuple [A.Int 4] ], A.Int 5]) )),
				(A.Tupletp [A.Inttp]),
				fail
				);
			assert(
				T.tc_exp Symbol.empty (0,0)
				(A.Proj(0, A.Proj (1,( A.Tuple [ A.Tuple [ A.Tuple [A.Int 1, A.Int 2] ], A.Tuple [A.Int 3], A.Tuple [ A.Tuple [A.Int 4] ], A.Int 5]) ))),
				A.Inttp,
				fail
				);
			assert(
				(T.tc_exp Symbol.empty (0,0)
				(A.While (A.Int 1, A.Tuple []))
				),
				(A.Tupletp []), fail
				);
			assert(
				(T.tc_exp Symbol.empty (0,0)
				(A.While (A.Int 1, A.Tuple [A.Int 10]))
				),
				(A.Tupletp []), fail
				);
			assert(
				(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Inttp, A.Inttp))) (0,0)
				(A.Call (A.Id (Symbol.symbol "foo"), A.Int 2))),
				A.Inttp, fail
				);
			assert(
				(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Tupletp [A.Inttp], A.Inttp))) (0,0)
				(A.Call (A.Id (Symbol.symbol "foo"), A.Tuple [A.Int 2]))),
				A.Inttp, fail
				);
			assert(
				(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Tupletp [A.Inttp], A.Tupletp [A.Inttp]))) (0,0)
				(A.Call (A.Id (Symbol.symbol "foo"), A.Tuple [A.Int 2]))),
				A.Tupletp [A.Inttp], fail
				);
			assert(
				(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Tupletp [A.Inttp], A.Tupletp [A.Inttp]))) (0,0)
				(A.Call (A.Id (Symbol.symbol "foo"), A.Tuple [A.Int 2, A.Int 3]))),
				A.Tupletp [A.Inttp], fail
				);
			assert(
				T.tc_exp Symbol.empty (0,0)
				(A.Let((Symbol.symbol "x"), A.Int 99, A.Id (Symbol.symbol "x"))),
				A.Inttp, fail
				);
			assert(
				T.tc_exp (Symbol.enter (Symbol.empty, Symbol.symbol "x", A.Inttp)) (0,0)
				(A.Constrain (A.Id (Symbol.symbol "x"), A.Inttp)),
				A.Inttp,
				fail
				);
			assert(
				T.tc_exp Symbol.empty (0,0)
				(A.If (A.Int 1, A.Tuple [A.Tuple [A.Int 3, A.Int 4], A.Int 5], 
					A.Tuple [ A.Tuple [A.Int 6], A.Int 7, A.Int 8])),
				(A.Tupletp [A.Tupletp [A.Inttp], A.Inttp]),
				fail
				);
        print("============================testexp end\n");
			!fail
		end

	fun testError () =
		let val fail = ref 0 in
		(* must raise assignment error *)
		assert( (T.tc_exp Symbol.empty (0,0)
			(A.Op (A.Set, [A.Op(A.Ref, [A.Int 10]),A.Tuple []]))),
			(A.Tupletp []),
			fail);
		(* must raise error cannot dereference *)
		assert ( (T.tc_exp Symbol.empty (0,0)
			(A.Op (A.Get, [A.Int 100]) )),
			(A.Inttp),
			fail);
		(* assignment right-hand side type error *)			
		assert( (T.tc_exp Symbol.empty (0,0)
			(A.Op(A.Set, [A.Int 10, A.Int 11]))),
			(A.Tupletp []),
			fail);
		(* while error *)
		assert(
			(T.tc_exp Symbol.empty (0,0)
			(A.While (A.Int 1, A.Int 2))
			),
			(A.Tupletp []), fail
			);
		(* function argument type error *)
		assert(
			(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Inttp, A.Inttp))) (0,0)
			(A.Call (A.Id (Symbol.symbol "foo"), A.Tuple [A.Int 2]))),
			A.Inttp, fail
			);
		(* function argument type error *)
		assert(
			(T.tc_exp (Symbol.enter(Symbol.empty, Symbol.symbol "foo", A.Arrowtp(A.Tupletp [A.Inttp, A.Inttp], A.Tupletp [A.Inttp]))) (0,0)
			(A.Call (A.Id (Symbol.symbol "foo"), A.Tuple [A.Int 2]))),
			A.Tupletp [A.Inttp], fail
			);
		(* constraint error *)
		assert(
				T.tc_exp (Symbol.enter (Symbol.empty, Symbol.symbol "x", A.Inttp)) (0,0)
				(A.Constrain (A.Id (Symbol.symbol "x"), A.Tupletp [ A.Inttp ])),
				A.Inttp,
				fail
				);
		(* join error *)
		assert( T.join complain (
				A.Inttp, 
				A.Tupletp [ A.Tupletp [ A.Inttp ] ]),
				(A.Tupletp []),
				fail);
		(* if condition is not int *)
		assert(
				T.tc_exp Symbol.empty (0,0)
				(A.If (A.Tuple [A.Int 1], A.Tuple [A.Tuple [A.Int 3, A.Int 4], A.Int 5], 
					A.Tuple [ A.Tuple [A.Int 6], A.Int 7, A.Int 8])),
				(A.Tupletp [A.Tupletp [A.Inttp], A.Inttp]),
				fail
				);
        print("============================testerror end\n");
		0 (* return 0 for testing errors *)
		end


	fun testJoin () =
		let val fail = ref 0 in
			assert( T.join complain (A.Inttp, A.Inttp),
				(A.Inttp),
				fail);
			assert( T.join complain (
				A.Tupletp [A.Tupletp [A.Inttp, A.Inttp], A.Tupletp [], A.Tupletp [A.Inttp]], 
				A.Tupletp [A.Tupletp [A.Inttp], A.Tupletp [A.Inttp], A.Tupletp [A.Inttp, A.Inttp]]),
				(A.Tupletp [A.Tupletp [A.Inttp], A.Tupletp [], A.Tupletp [A.Inttp]]),
				fail);
			assert( T.join complain (
				A.Tupletp [A.Tupletp [A.Inttp, A.Inttp], A.Tupletp [], A.Inttp], 
				A.Tupletp [A.Tupletp [A.Inttp], A.Tupletp [A.Inttp], A.Tupletp [A.Inttp, A.Inttp]]),
				(A.Tupletp [A.Tupletp [A.Inttp], A.Tupletp []]),
				fail);
			assert( T.join complain (
				A.Tupletp [ A.Inttp ], 
				A.Tupletp [ A.Tupletp [ A.Inttp ] ]),
				(A.Tupletp []),
				fail);
			assert( T.join complain (
				A.Arrowtp ( A.Tupletp [A.Inttp, A.Inttp], A.Tupletp []),
				A.Arrowtp ( A.Tupletp [A.Inttp], A.Tupletp [A.Inttp, A.Inttp])),
				A.Arrowtp (A.Tupletp [A.Inttp, A.Inttp], A.Tupletp []),
				fail);
        print("============================testjoin end\n");

			!fail
		end

	fun testAll () =
		testSub () + testExp () + testJoin () + testError ()
end
