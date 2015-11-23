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

   val regX = M.reg "$t0"
   val regY = M.reg "$t1"

   fun flat xs = List.foldr op@ [] xs

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
        if (RS.member(spills, rd) andalso RS.member(spills, rs)) then
          M.Lw(regX, g rs) :: [M.Sw(regX, g rd)]
        else
        if RS.member(spills, rd) then
          [M.Sw(rs, g rd)] else ( 
            if RS.member(spills, rs) then 
              [M.Lw(rd, g rs)] else [M.Move(f rd, f rs)])

       | M.Arith2(i,rd,rs) => 
           if (RS.member(spills, rs) andalso RS.member(spills, rd))
           then [M.Lw(regX, g rs), M.Arith2(i, regY ,regX), M.Sw(regY, g rd)]
           else if RS.member(spills, rs)
           then [M.Lw(regX, g rs), M.Arith2(i, rd, regX)]
           else if RS.member(spills, rd)
           then [M.Arith2(i, regX, rs), M.Sw(regX, g rd)]
           else [M.Arith2(i, f rd, f rs)]

       | M.Arith3(i,rd,rs,rt) => 
           if (RS.member(spills, rs) andalso RS.member(spills, rt) andalso
           RS.member(spills, rd))
           then [M.Lw(regY, g rs), M.Lw(regX, g rt), M.Arith3(i, regY, regY,
           regX), M.Sw(regY, g rd)]
           else if (RS.member(spills, rs) andalso RS.member(spills, rd))
           then [M.Lw(regY, g rs), M.Arith3(i, regY, regY,
           f rt), M.Sw(regY, g rd)]
           else if (RS.member(spills, rt) andalso RS.member(spills, rd))
           then [M.Lw(regY, g rt), M.Arith3(i, regY, f rs,
           regY), M.Sw(regY, g rd)]
           else if (RS.member(spills, rs) andalso RS.member(spills, rt))
           then [M.Lw(regY, g rs), M.Lw(regX, g rt), M.Arith3(i, f rd, regY,
           regX)]
           else if RS.member(spills, rs)
           then [M.Lw(regX, g rs), M.Arith3(i, f rd, regX, f rt)]
           else if RS.member(spills, rt)
           then [M.Lw(regX, g rt), M.Arith3(i, f rd, f rs, regX)]
           else if RS.member(spills, rd)
           then [M.Arith3(i, regX, f rs, f rt), M.Sw(regX, g rd)]
           else [M.Arith3(i, f rd, f rs, f rt)]
           
       | M.Arithi(i,rt,rs,n) => 
           if (RS.member(spills, rs) andalso RS.member(spills, rt))
           then [M.Lw(regX, g rs), M.Arithi(i, regY ,regX, n), M.Sw(regY, g rt)]
           else if RS.member(spills, rs)
           then [M.Lw(regX, g rs), M.Arithi(i, rt, regX, n)]
           else if RS.member(spills, rt)
           then [M.Arithi(i, regX, rs, n), M.Sw(regX, g rt)]
           else [M.Arithi(i, f rt, f rs, n)]

       | M.Li(r,n) => 
           if (RS.member(spills, r))
           then [M.Li(regX, n), M.Sw(regX, g r)]
           else [M.Li(f r, n)]
           
       | M.La(r,lab) => 
           if (RS.member(spills, r))
           then [M.La(regX, lab), M.Sw(regX, g r)]
           else [M.La(f r, lab)]

       | M.Lw(r,(lab,ra)) => 
           if (RS.member(spills, r) andalso RS.member(spills, ra))
           then [M.Lw(regX, g ra), M.Lw(regY, (lab, regX)), M.Sw(regY, g r)]
           else if (RS.member(spills, r))
           then [M.Lw(regX, (lab, f ra)), M.Sw(regX, g r)]
           else if (RS.member(spills, ra))
           then [M.Lw(regX, g ra), M.Lw(f r, (lab, regX))]
           else [M.Lw(f r, (lab, f ra))]

       | M.Sw(r,(lab,ra)) =>
           if (RS.member(spills, r) andalso RS.member(spills, ra))
           then [M.Lw(regX, g r), M.Lw(regY, g ra), M.Sw(regX, (lab, regY))]
           else if (RS.member(spills, r))
           then [M.Lw(regX, g r), M.Sw(regX, (lab, f ra))]
           else if (RS.member(spills, ra))
           then [M.Lw(regX, g ra), M.Sw(f r, (lab, regX))]
           else [M.Sw(f r, (lab, f ra))]

       | M.Branchz(i,r,lab) => 
           if (RS.member(spills, r))
           then [M.Lw(regX, g r), M.Branchz(i, regX, lab)]
           else [M.Branchz(i, f r, lab)]

       | M.Branchu(i,r1,r2,lab) => 
           if (RS.member(spills, r1) andalso RS.member(spills, r2))
           then [M.Lw(regX, g r1), M.Lw(regY, g r2), M.Branchu(i, regX, regY,
           lab)]
           else if (RS.member(spills, r1))
           then [M.Lw(regX, g r1), M.Branchu(i, regX, f r2, lab)]
           else if (RS.member(spills, r2))
           then [M.Lw(regX, g r2), M.Branchu(i, f r1, regX, lab)]
           else [M.Branchu(i, f r1, f r2, lab)]

       | M.Branch(i,r1,r2,lab) => 
           if (RS.member(spills, r1) andalso RS.member(spills, r2))
           then [M.Lw(regX, g r1), M.Lw(regY, g r2), M.Branch(i, regX, regY,
           lab)]
           else if (RS.member(spills, r1))
           then [M.Lw(regX, g r1), M.Branch(i, regX, f r2, lab)]
           else if (RS.member(spills, r2))
           then [M.Lw(regX, g r2), M.Branch(i, f r1, regX, lab)]
           else [M.Branch(i, f r1, f r2, lab)]

       | M.J(lab) => [M.J lab]
       | M.Jal(lab) => [M.Jal lab]
       | M.Jr(r,also) => 
           if (RS.member(spills, r))
           then [M.Lw(regX, g r), M.Jr(regX, map f also)]
           else [M.Jr(f r, map f also)]
       | M.Jalr(r1,r2,use,def) => 
           if (RS.member(spills, r1) andalso RS.member(spills, r2))
           then [M.Lw(regX, g r2), M.Jalr(regY ,regX, map f use, map f def), M.Sw(regY, g r1)]
           else if RS.member(spills, r2)
           then [M.Lw(regX, g r2), M.Jalr(f r1, regX, map f use, map f def)]
           else if RS.member(spills, r1)
           then [M.Jalr(regX, f r2, map f use, map f def), M.Sw(regX, g r1)]
           else [M.Jalr(f r1, f r2, map f use, map f def)]

       | M.Syscall => [M.Syscall]
       | M.Nop => [M.Nop]
   end
      

   fun make_end (instrL : M.funcode) n =
     case instrL of
       (l, instrs)::[] => if n = 0 then [(l, instrs)] else [(l, (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed (n*4)))::instrs)]
     | h::t => h :: make_end t n

   fun alloc(instrL as ((funlab,block)::rest) : M.funcode) = 
   let 
       val index = ref (~1)
       val ig = Liveness.interference_graph instrL
       val movegraph = IG.newGraph()
       val _ = app (fn (_,l) => app (getmove movegraph) l) instrL
       val _ = print "###### Move graph\n"
       val _ = Liveness.printgraph print movegraph
       val spillReg = M.list2set (regX :: [ regY ])
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
       val spillL = map (fn reg => (index := !index + 1;
       print(Int.toString(!index)) ; (!index, reg))) (RS.listItems spills)
       val instrL = if n = 0 then instrL else (funlab, (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed
       (~(n*4)))) :: block)::rest
       val spillT = foldl (fn ((index, reg), table) => RT.enter(table, reg,
       (M.immed (index * 4), M.reg "$sp"))) (RT.empty) spillL 

       val instrL = List.map (fn (l,instrs) => (l,List.map (M.rename_regs alloc) instrs)) instrL
       val instrL = List.map (fn (l,instrs) => (l, flat(List.map (rename_spills
       (spillT,spills)) instrs))) instrL
       val instrL = make_end instrL n
   in
     instrL
  end

end
