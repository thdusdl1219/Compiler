signature REGALLOC = sig
(* alloc(f) returns mips code for function f that has all the temporaries
    replaced by mips regs and the load/store of spilled temps taken care of
*)
 val alloc : Mips.funcode ->  Mips.funcode 
end

structure RegAlloc :> REGALLOC =
struct
   structure M = Mips
   structure RS = Mips.RegSet
   structure IG = Liveness.IG
   structure RT = M.RegTb 
   fun spillCost x = 1

   fun getmove g (M.Move(r1,r2)) = IG.mk_edge g {from=r2,to=r1} 
     | getmove g _ = ()

   val index = ref (~1)

   fun rename_spills (table : M.address RT.table, spills) = 
    let fun f r = if RS.member(spills, r)
              (* then (ErrorMsg.impossible ("rename_spills in non-move : " ^
              M.reg2name r); r) *)
                  then r
                  else r
        fun g r =  
                case RT.look(table, r) of SOME x => x
                   | NONE => ErrorMsg.impossible ("rename_spills in move : " ^
                   M.reg2name r)
            
    in
      fn M.Move(rd, rs) => 
        if RS.member(spills, rd) then
          M.Sw(rs, g rd) else ( 
            if RS.member(spills, rs) then 
              M.Lw(rd, g rs) else M.Move(f rd, f rs))
       | M.Arith2(i,rd,rs) => M.Arith2(i, f rd, f rs)
       | M.Arith3(i,rd,rs,rt) => M.Arith3(i, f rd, f rs, f rt)
       | M.Arithi(i,rt,rs,n) => M.Arithi(i, f rt, f rs, n)
       | M.Li(r,n) => M.Li(f r, n)
       | M.La(r,lab) => M.La(f r, lab)
       | M.Lw(r,(lab,ra)) => M.Lw(f r, (lab, f ra))
       | M.Sw(r,(lab,ra)) => M.Sw(f r, (lab, f ra))
       | M.Branchz(i,r,lab) => M.Branchz(i, f r, lab)
       | M.Branchu(i,r1,r2,lab) => M.Branchu(i, f r1, f r2, lab)
       | M.Branch(i,r1,r2,lab) => M.Branch(i, f r1, f r2, lab)
       | M.J(lab) => M.J lab
       | M.Jal(lab) => M.Jal lab
       | M.Jr(r,also) => M.Jr(f r, map f also)
       | M.Jalr(r1,r2,use,def) => M.Jalr(f r1, f r2, map f use, map f def)
       | M.Syscall => M.Syscall
       | M.Nop => M.Nop
   end
      

   fun make_end (instrL : M.funcode) n =
     case instrL of
       (l, instrs)::[] => if n = 0 then [(l, instrs)] else [(l, (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed (n*4)))::instrs)]
     | h::t => h :: make_end t n

   fun alloc(instrL as ((funlab,block)::rest) : M.funcode) = 
   let val ig = Liveness.interference_graph instrL
       val movegraph = IG.newGraph()
       val _ = app (fn (_,l) => app (getmove movegraph) l) instrL
       val _ = print "###### Move graph\n"
       val _ = Liveness.printgraph print movegraph
       val spillReg = M.list2set (M.reg "$t0" :: [ M.reg "$t1"])
       val palette = RS.difference (M.list2set (M.reg"$ra"::M.callerSaved @
       M.calleeSaved), spillReg)
       val coloring = Color.color {interference = ig, moves=movegraph, 
	                  spillCost = spillCost, palette=palette}
       val _ = Color.verify{complain=ErrorMsg.impossible, func=instrL, 
                            spillCost=spillCost, palette=palette, 
                            coloring=coloring}
       val _ = print "Register Allocation verified.\n"
       val {alloc,spills} = coloring
       val _ = (print "Spills: "; 
                RS.app (fn r => (print (M.reg2name r); print " ")) spills;
	        print "\n")
       val n = RS.numItems spills
       val spillL = map (fn reg => (index := !index + 1 ; (!index, reg))) (RS.listItems spills)
       val instrL = if n = 0 then instrL else (funlab, (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed
       (~(n*4)))) :: block)::rest
       val spillT = foldl (fn ((index, reg), table) => RT.enter(table, reg,
       (M.immed (index * 4), M.reg "$sp"))) (RT.empty) spillL 

       val instrL = List.map (fn (l,instrs) => (l,List.map (M.rename_regs alloc) instrs)) instrL
       val instrL = List.map (fn (l,instrs) => (l, List.map (rename_spills
       (spillT,spills)) instrs)) instrL
       val instrL = make_end instrL n
   in
     instrL
  end

end
