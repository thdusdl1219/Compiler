structure Interp = struct

    structure S = SLP
    (* Use S.CompoundStm, S.Plus, S.IdExp, etc. to refer to
     * items defined in structure SLP (see slp.sml) *)
    
    type table = (S.id * int) list

    fun update(tbl, ident, newval) = (ident, newval)::tbl
    (*assume the first occurrence of any id takes precedence
      over any later occurrences in the table*)

    exception UndefinedVariable of string

    fun lookup (tbl:table, ident) = 
          case tbl of 
            nil => raise UndefinedVariable(ident)
          | (x, xval)::xs => if ident=x then xval
			     else lookup(xs, ident)

    exception InterpUnimplemented

    fun interpOp S.Plus  = Int.+
      | interpOp S.Minus = Int.-
      | interpOp S.Times = Int.*
      | interpOp S.Div   = Int.div

    fun interpStm (s:S.stm, tbl:table) =
      case s of
          S.CompoundStm (stm1, stm2) => interpStm(stm2, interpStm(stm1, tbl))
      |   S.AssignStm (id, exp) => let 
                                  val (exp_i, tbll)  = interpExp(exp, tbl)
                                 in
                                  update(tbll, id, exp_i)
                                 end
      |   S.PrintStm explist => case explist of
                                   [] => (print ("\n");  tbl)
                                 | h::t => let 
                                            val (exp_i, tbll) =  interpExp(h, tbl)
                                           in
                                             print (Int.toString(exp_i) ^ " ");interpStm(S.PrintStm t, tbll)
                                           end
    and interpExp (e:S.exp, tbl:table) =
      case e of
          S.IdExp id => (lookup(tbl, id), tbl)
       |  S.NumExp n => (n, tbl)
       |  S.OpExp (exp1, bop, exp2) => let
                                    val (n1, tb1) = interpExp(exp1, tbl)
                                   in
                                    let
                                      val (n2, tb2) = interpExp(exp2, tb1)
                                    in
                                   ((interpOp bop (n1,n2)), tb2)
                                    end
                                   end
       |  S.EseqExp (stm, exp) => interpExp(exp, interpStm(stm, tbl)) 

    fun interp s = (*let val tbl = interpStm(s,nil) in tbl end*)
          (interpStm(s, nil); ())
end
