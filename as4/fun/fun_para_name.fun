/* Did you make sure to allow a parameter name the same as a global function name? */
/* it should be successfully typechecked */
fun foo(foo:int):int =
    foo + 100

fun main(arg:int) : int =
    let z = foo(50) in
        (printint(z); z)

