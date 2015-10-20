structure MaxArg = struct

    structure S = SLP
    (* Use S.CompoundStm, S.Plus, S.IdExp, etc. to refer to
     * items defined in structure SLP (see slp.sml) *)

    exception MaxUnimplemented


    fun maxarg s = 
      case s of
        S.CompoundStm(s1, s2) =>
          let val args1 = maxarg s1
	      val args2 = maxarg s2
	  in Int.max (args1, args2)
	  end
      | S.AssignStm(x, e) => maxExpArg e
      | S.PrintStm elist => let fun maxL(L) = if L = [] then 0 else Int.max(hd(L), maxL(tl(L))) in Int.max ((length elist),maxL((map maxExpArg
      elist))) end

    and maxExpArg e =
      case e of
        S.IdExp _ => 0
      | S.NumExp _ => 0
      | S.OpExp (e1, bop, e2) => Int.max (maxExpArg e1, maxExpArg e2)
      | S.EseqExp (stm, e) => Int.max (maxarg stm, maxExpArg e)  
end
