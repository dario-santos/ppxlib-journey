type t =
{ a : string; 
  b : int
}
[@@deriving accessors]

let _ = Printf.printf "AAAAA\n"

let v = {a = "hey"; b = 2}


let _ = Printf.printf "%d" (b v)