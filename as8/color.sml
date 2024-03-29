structure Color : COLOR = 
struct

 structure IG = Liveness.IG
 structure M = Mips
 structure RS = M.RegSet
 structure RT = M.RegTb

 val (SOME spillCostInfinity) = Int.maxInt

 type coloring = {alloc: M.allocation, spills: RS.set}

 fun print_set set : unit = 
   (RS.app (fn reg => (print " "; print (M.reg2name reg))) set; print "\n")

 fun print_list list : unit =
   (app (fn reg => (print " "; print (M.reg2name reg))) list; print "\n")

 fun int2reg r = r

 fun assignColor (stack : M.reg list, ig : IG.graph, palette : RS.set, spill : RS.set, precolored : M.allocation, colorResult : coloring) : coloring = 
   case stack of
      reg::tail => 
        let val adjSet = IG.adj ig reg ; val tmpReg = M.newReg (); val colorSet =
        RS.filter (fn colorreg => not (colorreg = tmpReg))
        (RS.map (fn prereg =>
          (case RT.look(precolored, prereg) of
              SOME precolorreg => precolorreg
            | NONE =>
                (case RT.look(#alloc(colorResult), prereg) of
                  SOME colorreg => colorreg
                | NONE => tmpReg)
          )) adjSet);
          val okColor = RS.difference(palette, colorSet) in 
            (case (RS.numItems okColor) of
              0 => let val colorResult = {alloc = RT.enter(#alloc(colorResult),reg, reg), spills = RS.add(#spills(colorResult), reg)} in assignColor (tail, ig, palette, spill, precolored, colorResult) end
            | _ => let val colorResult = {alloc = RT.enter(#alloc(colorResult), reg, hd (RS.listItems okColor)), spills = #spills(colorResult)} in assignColor (tail, ig, palette, spill, precolored, colorResult) end )
        end
    | [] => 
      {alloc = #alloc(colorResult), spills = RS.union(#spills(colorResult), spill)} 
   (*ErrorMsg.impossible "Color.assignColor unimplemented"*)
   

 fun makeLowdegsHighdegs (adj : M.reg -> RS.set, nodes : unit -> RS.set, palette : RS.set) : {lowdegs : RS.set, highdegs : RS.set} = 
   let val lowdegs = RS.filter (fn reg : M.reg => RS.numItems(adj reg) < RS.numItems(palette) andalso RS.numItems(adj reg) > 0 andalso M.isvirtual reg) (nodes()); val highdegs = RS.filter (fn reg : M.reg => RS.numItems(adj reg) > 0 andalso M.isvirtual reg) (RS.difference(nodes(), lowdegs)) in ({lowdegs = lowdegs, highdegs = highdegs}) end


 fun remove_edge (adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit) (reg : M.reg) : unit = 
  let val adjSet = adj reg in RS.app (fn rg => (redgs reg rg; redgs rg reg)) adjSet end


 fun simplify (lowdegs : RS.set, stack : M.reg list, adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit) : M.reg list =
 let val regList = RS.listItems lowdegs; val _ = app (fn reg => remove_edge (adj, redgs) reg) regList in regList @ stack end


 fun spillF (highdegs : RS.set, spill : RS.set, adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit, spillCost : M.reg -> int) : RS.set =
let val reg = foldl (fn (a, b) => if((spillCost a) > (spillCost b)) then b else a) (hd (RS.listItems highdegs)) (tl (RS.listItems highdegs)); val _ = remove_edge (adj, redgs) reg in (RS.add(spill, reg)) end


 fun coloringFunction (lowdegs : RS.set, highdegs: RS.set, org_ig : IG.graph, ig : IG.graph, stack : M.reg list, spill : RS.set, palette : RS.set, spillCost : M.reg -> int) : coloring =
  let fun redgs r1 r2 = IG.rm_edge ig {from = r1, to = r2}
      fun adj r = IG.adj ig r 
      fun nodes() = IG.nodes ig
  in
   case (RS.numItems(lowdegs), RS.numItems(highdegs)) of
        (0, 0) => let val allReg = M.list2set M.registers; val precolored = RS.difference(nodes(), RS.difference(nodes(), allReg)); val alloc = (RS.foldl (fn (reg, table) => RT.enter(table, reg, reg)) (RT.empty) precolored);
          val alloc_spills = assignColor (stack, org_ig, palette, spill, alloc,{alloc = RT.empty, spills = RS.empty}) in alloc_spills  end

      | (0, _) => let val spill = spillF (highdegs, spill, adj, redgs, spillCost); val lowdegs_highdegs = makeLowdegsHighdegs (adj, nodes, palette) in 
        (coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), org_ig, ig, stack, spill, palette, spillCost)) end

      | (_, _) => let  val stack = simplify (lowdegs,stack,adj, redgs); val lowdegs_highdegs = makeLowdegsHighdegs (adj, nodes, palette) in 
        coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), org_ig, ig, stack, spill, palette, spillCost) end
  end
      
(*
 fun check_alloc_palette (ig: IG.graph, alloc : M.allocation, spills : RS.set, palette: RS.set) : unit =
   let val regSet = IG.nodes ig; val allocSet = RS.difference(regSet, spills); val allReg = M.list2set M.registers; val precolored = RS.difference(regSet, RS.difference(regSet, allReg)); val allocSet = RS.difference(allocSet, precolored) in
     RS.app (fn reg => 
      case RT.look(alloc, reg) of
           SOME(allocReg) => if(RS.member(palette, allocReg)) then () else ErrorMsg.impossible "allocReg isn't in palette" 
         | NONE => () 
     ) allocSet end 
(* alloc has allocReg and spillReg *)
 fun check_func_coloring (ig : IG.graph, alloc : M.allocation, spills : RS.set, palette : RS.set) : unit =
  let val regSet = IG.nodes ig; val virtualSet = RS.filter (fn reg => M.isvirtual reg) regSet; val allReg = M.list2set M.registers; 
  val nonPrecolored = RS.difference(regSet, allReg) in
    RS.app (fn reg => 
      case RT.look(alloc, reg) of
           SOME(allocReg) => () 
         | NONE => if(RS.member(spills, reg)) then () else ErrorMsg.impossible "virtual reg isn't in alloc"
    ) virtualSet ;
    RS.app (fn reg =>
      case RT.look(alloc, reg) of
           SOME(allocReg) => () 
         | NONE => if(RS.member(spills, reg)) then () else ErrorMsg.impossible (M.reg2name reg ^ "no precolored reg isn't in alloc")
    ) nonPrecolored  end

 fun check_interfere_coloring (ig : IG.graph, alloc : M.allocation, spills : RS.set) : unit =
 let val regSet = IG.nodes ig; val allReg = M.list2set M.registers; val precolored = RS.difference(regSet, RS.difference(regSet, allReg)); val precolored = (RS.foldl (fn (reg, table) => RT.enter(table, reg, reg)) (RT.empty) precolored) in 
   RS.app (fn reg =>
    let val adjSet = RS.filter (fn adjreg => not (adjreg = reg)) (IG.adj ig reg);
        val tmpReg = M.newReg ();
        val colorSet = RS.filter (fn colorreg => not (colorreg = tmpReg))
        (RS.map (fn adjreg => 
          (case RT.look(precolored, adjreg) of
             SOME(precolorReg) => precolorReg
           | NONE => 
               (case RT.look(alloc, adjreg) of
                    SOME(colorReg) => colorReg 
                  | NONE => tmpReg
               )
          )
        ) adjSet )
        in
          let val tmpReg = M.newReg(); val colorReg = 
            (case RT.look(precolored, reg) of
              SOME(colorReg) => SOME(colorReg)
            | NONE =>
                (case RT.look(alloc, reg) of
                    SOME(colorReg) => SOME(colorReg)
                  | NONE => if(RS.member(spills, reg)) then NONE else ErrorMsg.impossible (M.reg2name reg ^ " reg ins't in alloc")
                )
            ) in
              case colorReg of
                  SOME(colorReg) =>
              if(RS.member(colorSet, colorReg)) then (print_set colorSet; ErrorMsg.impossible (M.reg2name reg ^ "interfere reg has same color")) else () 
                | NONE => ()
          end
    end 
   ) regSet 
 end
 *)

 fun check_spillcost (spills : RS.set, spillCost: M.reg -> int) : unit =
   RS.app (fn spillReg => if(spillCost spillReg >= spillCostInfinity)
    then ErrorMsg.impossible "spillCost overflow spillCostInfinity"
    else ()) spills

 fun check_alloc_palette (r : M.reg, alloc : M.allocation, palette : RS.set) : unit =
   case RT.look(alloc, r) of
        SOME(allocReg) => if(RS.member(palette, allocReg)) then () else ErrorMsg.impossible "allocReg isn't in palette"
      | NONE => ()

 fun check_func_coloring (r : M.reg, alloc : M.allocation, spills : RS.set) : unit =
   if(M.isvirtual r) then
     case RT.look(alloc, r) of
          SOME(allocReg) => ()
        | NONE => if(RS.member(spills, r)) then () else ErrorMsg.impossible "virtual reg isn't in alloc & spills"
   else
     case RT.look(alloc, r) of
          SOME(allocReg) => ErrorMsg.impossible "precolored reg can't be in alloc"
        | NONE => if(RS.member(spills, r)) then ErrorMsg.impossible "precolored reg can't be in spill" else ()

 fun check_interfere_coloring (r1 : M.reg, r2 : M.reg, alloc : M.allocation, spills : RS.set) : unit =
   if(r1 = r2) then ( )
   else if(RS.member(spills, r1)) then ( ) 
   else if(RS.member(spills, r2)) then ( )
   else
    case (M.isvirtual(r1), M.isvirtual(r2)) of
         (true, true) => 
         (case (RT.look(alloc, r1)) of 
          SOME(colorReg) => (case (RT.look(alloc, r2)) of 
                                  SOME(colorReg2) => if(colorReg = colorReg2) then ( ErrorMsg.impossible "clover 1")
                                                 else ()
                                | NONE => ErrorMsg.impossible "clover 2" )
        | NONE => ErrorMsg.impossible "clover 3" 
          )
       | (true, false) => 
         (case (RT.look(alloc, r1)) of 
               SOME(colorReg) => if(colorReg = r2) then ErrorMsg.impossible("clover 1") 
                                 else ()
             | NONE => ErrorMsg.impossible("clover 3")
             )
       | (false, true) => 
         (case (RT.look(alloc, r2)) of 
               SOME(colorReg) => if(colorReg = r1) then ErrorMsg.impossible("clover 1") 
                                 else ()
             | NONE => ErrorMsg.impossible("clover 3")
             )
       | (false, false) => ()

 fun verify {complain: string -> unit,
             func: M.funcode, 
             spillCost: M.reg -> int,
             palette: RS.set,
	     coloring={alloc: M.allocation, spills: RS.set}} : unit =
       let
         val _ = check_spillcost(spills, spillCost)
         fun interfere_verify (r1 : M.reg) (r2 : M.reg) =
            let 
              val _ = check_interfere_coloring(r1, r2, alloc, spills) 
            in () end
         fun mention_verify (r : M.reg) =
            let
              val _ = check_alloc_palette(r, alloc, palette)
              val _ = check_func_coloring(r, alloc, spills)
            in () end
       in Liveness.analyze {mention = mention_verify, interfere = interfere_verify} func end

 fun color ({interference = ig: IG.graph,
             moves: IG.graph,
             spillCost: M.reg ->int,
             palette: RS.set}) : coloring = let 
               val org_ig : IG.graph = ref (!ig)
               val lowdegs_highdegs = makeLowdegsHighdegs ((fn r => IG.adj ig r), (fn () => IG.nodes ig), palette)
               val result = coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), org_ig, ig, nil, RS.empty, palette, spillCost) in (result) end

end

