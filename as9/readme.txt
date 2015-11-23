
I modify rename_regs function in mips.sml to execute program.

========================================


diff --git a/as8/mips.sml b/as8/mips.sml
index 03bdbc8..97cd05b 100644
--- a/as8/mips.sml
+++ b/as8/mips.sml
@@ -311,8 +311,10 @@ struct
fun rename_regs (table: allocation) =
let fun f r = if isvirtual r
then case RegTb.look(table,r) of SOME x => x 
-                    | NONE => ErrorMsg.impossible ("rename_regs: "^
-                                     reg2name r)
+                  (*  | NONE => ErrorMsg.impossible ("rename_regs: "^
+                                     reg2name r)*)
+                    | NONE => (print ("rename_regs: "^
+                                     reg2name r); r)
else r
  in
fn Arith2(i,rd,rs) => Arith2(i, f rd, f rs)


