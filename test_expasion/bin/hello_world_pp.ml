let _ = 
  let n = ref 0 in
  [%change
    while !n < 10 do
      Printf.printf "%d\n" !n;
      n := !n + 1;
    done]


