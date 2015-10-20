(* Chogas is good, but Lulu is best! *)
(* Also, milk is super delicious! *)
structure T = TypeCheck;
open Absyn;
val success_count = ref 0
val is_success = ref false
fun incr_count () = success_count := (!success_count)+1;
fun reset () = is_success := false
fun set _ = is_success := true
fun fail _ = (reset();print "Fail to join!!!!\n");
fun success _ = (incr_count();print "Success!!!!\n\n");
fun equal (Inttp,Inttp) = true
  | equal (Tupletp (tp1::tps1),Tupletp (tp2::tps2)) =
    equal (tp1,tp2) andalso equal (Tupletp tps1,Tupletp tps2)
  | equal (Tupletp [],Tupletp []) = true
  | equal (Arrowtp(dom1,ret1),Arrowtp(dom2,ret2)) =
    equal (dom1,dom2) andalso equal(ret1,ret2)
  | equal (Reftp tp1,Reftp tp2) = equal (tp1,tp2)
  | equal _ = false
fun join (tp1,tp2,a) =
    let val _ = set()
        val tp = T.join fail (tp1,tp2) 
      val _ = print("tp1: "^T.tp2string(tp1)^"\n")
      val _ = print("tp2: "^T.tp2string(tp2)^"\n")
      val _ = print("result: "^T.tp2string(tp)^"\n")
      val _ = print("expect: "^T.tp2string(a)^"\n")
    in if (!is_success) andalso equal (a,tp) then success ()
       else print "Wrong result!!!!\n\n"
    end
fun fail (tp1,tp2) = (reset();
let val tp = T.join set (tp1,tp2);
in if (!is_success) then success() else (
print (T.tp2string(tp1)^" \n"^T.tp2string(tp2)^"\n");
print ("result:"^T.tp2string(tp));print "\nUnjoinables are joined!!!\n\n")end);
val _ = print "****** Start Join Test ******\n";
(**********************************)
(* Basic Tests *)
val _ = join (Inttp, Inttp, Inttp);
val _ = fail (Inttp, Tupletp []);
val _ = fail (Tupletp[], Arrowtp(Tupletp[],Tupletp[]));
val _ = join (Tupletp [], Tupletp [Inttp],Tupletp[]);
val _ = join (Arrowtp(Tupletp[Tupletp[]],Tupletp[Inttp]),
              Arrowtp(Tupletp[Tupletp[],Inttp],Tupletp[Inttp,Inttp]),
              Arrowtp(Tupletp[Tupletp[],Inttp],Tupletp[Inttp]));
(* Ref Tests *)
val _ = fail (Reftp(Tupletp[Inttp]),Reftp(Tupletp[]));
val _ = fail (Reftp(Tupletp[]),Reftp(Tupletp[Inttp]));
val _ = join (Reftp(Tupletp[Inttp]),Reftp(Tupletp[Inttp]),
              Reftp(Tupletp[Inttp]));
(* Nested Arrowtp *)
val _ = join (Arrowtp(Arrowtp(Tupletp[Inttp],Tupletp[Inttp,Inttp]),Arrowtp(Tupletp[Inttp,Inttp],Tupletp[Inttp])),
              Arrowtp(Arrowtp(Tupletp[],Tupletp[Inttp]),Arrowtp(Tupletp[Inttp],Tupletp[])),
              Arrowtp(Arrowtp(Tupletp[],Tupletp[Inttp,Inttp]),Arrowtp(Tupletp[Inttp,Inttp],Tupletp[])))
val _ = fail (Arrowtp(Arrowtp(Inttp,Tupletp[Inttp,Inttp]),Arrowtp(Tupletp[Inttp,Inttp],Tupletp[Inttp])),
              Arrowtp(Arrowtp(Tupletp[],Tupletp[Inttp]),Arrowtp(Tupletp[Inttp],Tupletp[])))
(* Tuple of Functions *)
val _ = join (Tupletp[Arrowtp(Inttp,Tupletp[Inttp]),Inttp,Arrowtp(Inttp, Inttp)],
              Tupletp[Arrowtp(Inttp,Tupletp[]),Inttp,Arrowtp(Inttp, Inttp)],
              Tupletp[Arrowtp(Inttp,Tupletp[]),Inttp, Arrowtp(Inttp, Inttp)])
(* Function Reference *)
val _ = join (Reftp(Arrowtp(Inttp,Inttp)),
              Reftp(Arrowtp(Inttp,Inttp)),
              Reftp(Arrowtp(Inttp,Inttp)))
val _ = fail (Reftp(Arrowtp(Inttp,Tupletp[])),
              Reftp(Arrowtp(Inttp,Tupletp[Inttp])))
(* Tests from Joonsung *)
val _ = join (Tupletp[Inttp,Inttp],Tupletp[Tupletp[Inttp,Inttp]],
              Tupletp[])
val _ = join (Tupletp[Tupletp[Inttp,Inttp,Inttp],Tupletp[Inttp,Inttp],Inttp,Inttp],
              Tupletp[Tupletp[Inttp],Tupletp[Inttp,Inttp,Inttp],Tupletp[Inttp]],
              Tupletp[Tupletp[Inttp],Tupletp[Inttp,Inttp]])
val _ = join (Tupletp[Tupletp[Tupletp[Tupletp[Inttp,Inttp,Inttp],Tupletp[Inttp,Inttp,Inttp,Inttp]],Tupletp[Tupletp[Tupletp[Inttp,Inttp,Inttp]]]],Tupletp[Inttp,Inttp,Inttp]],
              Tupletp[Tupletp[Tupletp[Tupletp[Inttp],Tupletp[Inttp,Inttp,Inttp,Inttp,Inttp],Tupletp[Inttp,Inttp,Inttp],Tupletp[Inttp,Inttp,Inttp]],Inttp]],
              Tupletp[Tupletp[Tupletp[Tupletp[Inttp],Tupletp[Inttp,Inttp,Inttp,Inttp]]]])
val _ = join (Tupletp[Tupletp[], Tupletp[]], Tupletp[], Tupletp[])
val _ = join (Tupletp[Inttp, Tupletp[]], Tupletp[Tupletp[], Inttp], Tupletp[])
val _ = join (Tupletp[Inttp, Arrowtp(Inttp,Inttp), Inttp], Tupletp[Inttp, Inttp, Inttp], Tupletp[Inttp])
val _ = fail (Tupletp[], Inttp)
val _ = fail (Arrowtp(Inttp,Inttp), Inttp)
val _ = join (Tupletp[Tupletp[]], Tupletp[Inttp], Tupletp[])
              
(**********************************)
val _ = print ("\nTotal success: "^Int.toString(!success_count)^"/16\n\n")
