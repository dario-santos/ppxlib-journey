open Ppxlib
let expand ~ctxt _ =
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  [%expr 1 + 1]

let my_extension =
  Extension.V3.declare 
    "my_ext" 
    Extension.Context.expression
    Ast_pattern.(single_expr_payload (estring __))
    expand

let rule = Ppxlib.Context_free.Rule.extension my_extension

let () =
  Driver.register_transformation
    ~rules:[rule]
    "my_ext"

  


(*
 1- Como é que o While é representado na AST do OCAML? Como detetar um While?



 Estrutura:

 while <condição> do
  <corpo>
 done

 Converter para:

 # !! Novo !! 
 if <condição> then corpo;
 
 # O que já existia
 while <condição> do
  <corpo>
 done
*)



    