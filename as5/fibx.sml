structure Fibx =
  struct

    structure M = Mips
    structure E = ErrorMsg

  local
    (* Last label emitted. *)
    val last_lab = ref (NONE: M.lab option)
    (* List of instructions being generated in the current codeblock.
     * For efficiency, this list is kept in reverse order. *)
    val ilist = ref (nil:M.instruction list)
    (* List of codeblocks generated, in reverse order *)
    val blist = ref (nil:M.codeblock list)
    (* List of functions generated, in reverse order *)
    val flist = ref (nil:M.funcode list)
  in
    (* Here's the protocol for using these functions,
       described as a regular expression:

       init_lists ( (emit_label emit* )+ finish_fun )* finish_prog
    *)

    fun init_lists () = (ilist := nil; blist := nil; flist := nil; 
                         last_lab := NONE)

    fun finish_block () = 
           case (!last_lab, !ilist)
            of (NONE, nil) => ()
             | (NONE, _) => E.impossible "No start label"
             | (SOME lab, il) => 
                  (blist := (lab, rev il) :: (!blist);
                   ilist := nil;
                   last_lab := NONE)

    fun finish_fun () = (finish_block();
                         flist := (rev(!blist))::(!flist);
                         blist := nil)

    fun finish_prog() = 
	   case !last_lab
             of SOME _ => E.impossible "finish_prog without finish_fun"
              | NONE => rev(!flist) before flist := nil

    (* Append an instruction to the list of generated instructions. *)
    fun emit i = ilist := i::(!ilist)

    fun emit_label l = (finish_block(); last_lab := SOME l)
  end

    val newline_lab = M.thislab "NL"

    (* Memory management functions. *) 

    fun emit_main_func () = 
     let val ra_tmp_reg = M.newReg()
      in emit_label (M.thislab "main");
         emit (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed(~4)));
         emit (M.Sw(M.reg "$ra", (M.immed 0, M.reg "$sp")));
         emit (M.Li(M.reg "$a0", M.immed 3));
         emit (M.Jal(M.thislab "_fibrec"));
         emit (M.Move(M.reg "$a0", M.reg "$v0"));
         emit (M.Jal(M.thislab "_printint"));
         emit (M.Li(M.reg "$a0", M.immed 3));
         emit (M.Jal(M.thislab "_fibiter"));
         emit (M.Move(M.reg "$a0", M.reg "$v0"));
         emit (M.Jal(M.thislab "_printint"));
         emit (M.Lw(M.reg "$ra", (M.immed 0, M.reg "$sp")));
         emit (M.Arithi(M.Addi,M.reg "$sp", M.reg "$sp", M.immed 4));
         emit (M.Jr(M.reg "$ra", M.reg "$v0" :: M.calleeSaved));
         finish_fun()
      end

    fun emit_printint_func() =
      (emit_label (M.thislab "_printint");
       emit (M.Li(M.reg("$v0"), M.immed(1)));
       emit (M.Syscall);
       (* Print a newline after the integer, for clarity. *)
       emit (M.La(M.reg("$a0"), newline_lab));
       emit (M.Li(M.reg("$v0"), M.immed(4)));
       emit (M.Syscall);
       emit (M.Jr(M.reg("$ra"),M.reg "$v0" :: M.calleeSaved));
       finish_fun())

    fun emit_fibiter_func() = 
      ( emit_label (M.thislab "_fibiter");
        emit (M.Arithi(M.Addi, M.reg "$t0", M.reg "$zero", M.immed(1)));
        emit (M.Arithi(M.Addi, M.reg "$t1", M.reg "$zero", M.immed(1)));
        emit_label (M.thislab "loop");
        emit (M.Branch(M.Eq, M.reg "$a0", M.reg "$zero", M.thislab "end"));
        emit (M.Arithi(M.Addi, M.reg "$a0", M.reg "$a0", M.immed(~1)));
        emit (M.Move(M.reg "$t2", M.reg "$t0"));
        emit (M.Move(M.reg "$t0", M.reg "$t1"));
        emit (M.Arith3(M.Add, M.reg "$t1", M.reg "$t2", M.reg "$t0"));
        emit (M.J(M.thislab "loop"));
        emit_label (M.thislab "end");
        emit (M.Arith3(M.Add, M.reg "$v0", M.reg "$t0", M.reg "$zero"));
        emit (M.Jr(M.reg "$ra", M.reg "$v0" :: M.calleeSaved));
        finish_fun()
      )
    fun emit_fibrec_func() = 
      ( emit_label (M.thislab "_fibrec");
        emit (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed(~12)));
        emit (M.Sw(M.reg "$ra", (M.immed 8, M.reg "$sp")));
        emit (M.Sw(M.reg "$a0", (M.immed 4, M.reg "$sp")));
        emit (M.Arithi(M.Addi, M.reg "$a0", M.reg "$a0", M.immed(~2)));
        emit (M.Arithi(M.Addi, M.reg "$v0", M.reg "$zero", M.immed(1)));
        emit (M.Branchz(M.Lt, M.reg "$a0", M.thislab "done"));
        emit (M.Jal(M.thislab "_fibrec"));
        emit (M.Sw(M.reg "$v0", (M.immed 0, M.reg "$sp")));
        emit (M.Lw(M.reg "$a0", (M.immed 4, M.reg "$sp")));
        emit (M.Arithi(M.Addi, M.reg "$a0", M.reg "$a0", M.immed(~1)));
        emit (M.Jal(M.thislab "_fibrec"));
        emit (M.Lw(M.reg "$t0", (M.immed 0, M.reg "$sp")));
        emit (M.Arith3(M.Add, M.reg "$v0", M.reg "$t0", M.reg "$v0"));
        emit_label (M.thislab "done");
        emit (M.Lw(M.reg "$ra", (M.immed 8, M.reg "$sp")));
        emit (M.Arithi(M.Addi, M.reg "$sp", M.reg "$sp", M.immed(12)));
        emit (M.Jr(M.reg "$ra", M.reg "$v0" :: M.calleeSaved));
        finish_fun()
      )

    fun emit_all() =
        (init_lists(); 
         emit_main_func();
         emit_printint_func();
         emit_fibrec_func();
         emit_fibiter_func();
         ([(newline_lab,"\\n")], finish_prog())
        )

    fun go() =
     let val prog = emit_all()
         val out = TextIO.openOut "fibx.s"
      in Mips.printAssem(out, prog) before TextIO.closeOut out
	handle e => (TextIO.closeOut out; raise e)
     end

  end
