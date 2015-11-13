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

 fun assignColor (stack : M.reg list, ig : IG.graph) : coloring = 
   ErrorMsg.impossible "Color.assignColor unimplemented"
   

 fun makeLowdegsHighdegs (adj : M.reg -> RS.set, nodes : unit -> RS.set, palette : RS.set) : {lowdegs : RS.set, highdegs : RS.set} = 
   let val lowdegs = RS.filter (fn reg : M.reg => RS.numItems(adj reg) < RS.numItems(palette) andalso RS.numItems(adj reg) > 0) (nodes()); val highdegs = RS.filter (fn reg : M.reg => RS.numItems(adj reg) > 0) (RS.difference(nodes(), lowdegs)) in ({lowdegs = lowdegs, highdegs = highdegs}) end

 fun remove_edge (adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit) (reg : M.reg) : unit = 
  let val adjSet = adj reg in RS.app (fn rg => (redgs reg rg; redgs rg reg)) adjSet end

 fun simplify (lowdegs : RS.set, stack : M.reg list, adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit) : M.reg list =
 let val reg = hd (RS.listItems lowdegs); val _ = remove_edge (adj, redgs) reg in reg :: stack end

 fun spillF (highdegs : RS.set, spill : RS.set, adj : M.reg -> RS.set, redgs : M.reg -> M.reg -> unit) : RS.set =
let val reg = hd (RS.listItems highdegs); val _ = remove_edge (adj, redgs) reg in (RS.add(spill, reg)) end

 fun coloringFunction (lowdegs : RS.set, highdegs: RS.set, org_ig : IG.graph, redgs : M.reg -> M.reg -> unit, adj : M.reg -> RS.set, nodes : unit -> RS.set, stack : M.reg list, spill : RS.set, palette : RS.set) : coloring =
   case (RS.numItems(lowdegs), RS.numItems(highdegs)) of
        (0, 0) => let val alloc_spills = assignColor (stack, org_ig) in {alloc = #alloc(alloc_spills), spills = RS.union(#spills(alloc_spills), spill)} end
      | (0, _) => let val spill = spillF (highdegs, spill, adj, redgs); val lowdegs_highdegs = makeLowdegsHighdegs (adj, nodes, palette) in 
        (coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), org_ig, redgs, adj, nodes, stack, spill, palette)) end
      | (_, _) => let val stack = simplify (lowdegs,stack,adj, redgs); val lowdegs_highdegs = makeLowdegsHighdegs (adj, nodes, palette) in 
        coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), org_ig, redgs, adj, nodes, stack, spill, palette) 
 end
      



 fun verify {complain: string -> unit,
             func: M.funcode, 
             spillCost: M.reg -> int,
             palette: RS.set,
	     coloring={alloc: M.allocation, spills: RS.set}} : unit =
   ErrorMsg.impossible "Color.verify unimplemented"

 fun color ({interference = ig: IG.graph,
             moves: IG.graph,
             spillCost: M.reg ->int,
             palette: RS.set}) : coloring = let 
               val org_ig = ig
               fun redgs r1 r2 = IG.rm_edge ig {from = r1, to = r2}
               fun adj r = IG.adj ig r 
               fun nodes() = IG.nodes ig 
               val lowdegs_highdegs = makeLowdegsHighdegs (adj, nodes, palette)
               val result = coloringFunction (#lowdegs(lowdegs_highdegs), #highdegs(lowdegs_highdegs), ig, redgs, adj, nodes, nil, RS.empty, palette) in (print("print_set : ");print_set (#spills(result)); result) end

end

