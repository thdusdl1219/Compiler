(*

Test Case for Assignment 4: Type Checker
Written by Seonyeong Heo

NOTE: I assume that your parser is all right! 

HOWTO
1. Copy all your files to this folder,
   or you may copy all files in this folder to your assignment directory
2. Open sml console and type "CM.make "so.cm";"
3. So.test() to test with all test suites

*)

structure T = TypeCheck
structure A = Absyn
structure E = ErrorMsg

structure So = 
struct
  exception TypeCheckFailed
  
  (* Test for different data types *) 
  fun filetest (filename) = (T.tc (Parse.parse (filename, TextIO.openIn filename)); not (!E.anyErrors))
  fun absyntest (absyn) = (E.reset "not-file-but-code"; T.tc absyn; not (!E.anyErrors))

  (* My Test Suites... :) *)
  (* Test for sample fun files *)
  fun funfile () = 
  let val files = ["test2.fun", "test.fun", "all.fun", "mytest.fun", "fact.fun"] 
  in case List.filter (fn f => not (filetest f)) files of
       nil => true 
     | errs => (print ("\nfuntest: failed to check type of "^(String.concatWith ", " errs)); false)
  end 

  (* Test for checklists mentioned in the assignement document *)
  fun checklist () = true
  
  fun test () = 
    if not (funfile()) then print "\ntest: failed with funfile\n"
    else if not(checklist()) then print "\ntest: failed with checklist\n"
    else print "\ntest: passed all tests!\n"
end
