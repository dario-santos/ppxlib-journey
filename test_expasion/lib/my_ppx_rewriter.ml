open Ppxlib
let expand ~ctxt expr_ast =
  let loc = Expansion_context.Extension.extension_point_loc ctxt in
  match expr_ast with
  (*| [%expr 1 + [%e? _] + [%e? b]] ->  [%expr [%e b]]
  | [%expr if [%e? c] then [%e? a] else [%e? b]] ->  [%expr if [%e c] then [%e b] else [%e a]]*)
  | [%expr while [%e? c] do [%e? body] done] ->

      (*1 - Generate 5 ifs *)
      let a = ref [%expr if [%e c] then ([%e body]; Printf.printf "IF\n";)] in
      for _=2 to 5 do
        a := [%expr [%e !a]; if [%e c] then ([%e body]; Printf.printf "IF\n";)];
      done;
      (*2 - Concatenate ifs to while *)
      [%expr
        [%e !a];
        while [%e c] do [%e body] done
      ]

  | z -> z (* if it's given an unknow expression to the PPX then do nothing*)

let my_extension =
  Extension.V3.declare 
    "change" 
    Extension.Context.expression
    Ast_pattern.(single_expr_payload __)
    expand

let rule = Ppxlib.Context_free.Rule.extension my_extension

let () =
  Driver.register_transformation ~rules:[rule] "change"

  


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



    