let test = [|
  [| Some 5 ; None   ; None   ; Some 2 ; None   ; Some 4 ; None   ; None   ; None |];
  [| None   ; None   ; None   ; None   ; Some 6 ; None   ; None   ; Some 8 ; None |];
  [| Some 7 ; None   ; None   ; Some 5 ; None   ; Some 8 ; Some 4 ; Some 3 ; None |];
  [| Some 1 ; Some 5 ; None   ; Some 6 ; None   ; None   ; Some 2 ; None   ; None |];
  [| None   ; Some 6 ; Some 3 ; None   ; Some 2 ; None   ; Some 8 ; Some 1 ; None |];
  [| None   ; None   ; Some 8 ; None   ; None   ; Some 3 ; None   ; Some 6 ; Some 9 |];
  [| None   ; Some 9 ; Some 5 ; Some 3 ; None   ; Some 2 ; None   ; None   ; Some 1 |];
  [| None   ; Some 1 ; None   ; None   ; Some 7 ; None   ; None   ; None   ; None |];
  [| None   ; None   ; None   ; Some 9 ; None   ; Some 5 ; None   ; None   ; Some 8 |]|];;

let test2 = [|
  [| None   ; Some 4 ; None   ; None   ; Some 7 ; None   ; None   ; Some 3 ; None |];
  [| None   ; None   ; Some 3 ; None   ; Some 8 ; Some 2 ; None   ; Some 1 ; None |];
  [| None   ; None   ; None   ; None   ; None   ; None   ; Some 8 ; None   ; Some 2 |];
  [| Some 9 ; Some 1 ; None   ; Some 6 ; Some 2 ; None   ; None   ; None   ; None |];
  [| Some 8 ; None   ; None   ; None   ; None   ; None   ; None   ; None   ; Some 4 |];
  [| None   ; None   ; None   ; None   ; Some 1 ; Some 5 ; None   ; Some 7 ; Some 9; |];
  [| Some 3 ; None   ; Some 9 ; None   ; None   ; None   ; None   ; None   ; None |];
  [|None    ; Some 8 ; None   ; Some 9 ; Some 4 ; None   ; Some 6 ; None   ; None  |];
  [|None    ; Some 7 ; None   ; None   ; Some 6 ; None   ; None   ; Some 9 ; None |]|];;

let difficult1 = [|
  [| Some 7 ; None   ; None   ; None   ; None   ; None   ; Some 4 ; None   ; None |];
  [| None   ; Some 2 ; None   ; None   ; Some 7 ; None   ; None   ; Some 8 ; None |];
  [| None   ; None   ; Some 3 ; None   ; None   ; Some 8 ; None   ; None   ; Some 9 |];
  [| None   ; None   ; None   ; Some 5 ; None   ; None   ; Some 3 ; None   ; None |];
  [| None   ; Some 6 ; None   ; None   ; Some 2 ; None   ; None   ; Some 4 ; None |];
  [| None   ; None   ; Some 1 ; None   ; None   ; Some 7 ; None   ; None   ; Some 6 |];
  [| None   ; None   ; None   ; Some 3 ; None   ; None   ; Some 9 ; None   ; None |];
  [| None   ; Some 3 ; None   ; None   ; Some 4 ; None   ; None   ; Some 6 ; None |];
  [| None   ; None   ; Some 9 ; None   ; None   ; Some 1 ; None   ; None   ; Some 5 |]|];;

let difficult2 = [|
  [| None   ; None   ; None   ; Some 7 ; None   ; None   ; Some 8 ; None   ; None |];
  [| None   ; None   ; None   ; None   ; Some 4 ; None   ; None   ; Some 3 ; None |];
  [| None   ; None   ; None   ; None   ; None   ; Some 9 ; None   ; None   ; Some 1 |];
  [| Some 6 ; None   ; None   ; Some 5 ; None   ; None   ; None   ; None   ; None |];
  [| None   ; Some 1 ; None   ; None   ; Some 3 ; None   ; None   ; Some 4 ; None |];
  [| None   ; None   ; Some 5 ; None   ; None   ; Some 1 ; None   ; None   ; Some 7 |];
  [| Some 5 ; None   ; None   ; Some 2 ; None   ; None   ; Some 6 ; None   ; None |];
  [| None   ; Some 3 ; None   ; None   ; Some 8 ; None   ; None   ; Some 9 ; None |];
  [| None   ; None   ; Some 7 ; None   ; None   ; None   ; None   ; None   ; Some 2 |]|];;

let difficult3 = [|
  [| None   ; None   ; None   ; Some 7 ; None   ; None   ; Some 8 ; None   ; None |];
  [| None   ; None   ; None   ; None   ; Some 4 ; None   ; None   ; Some 3 ; None |];
  [| None   ; None   ; None   ; None   ; None   ; Some 9 ; None   ; None   ; Some 1 |];
  [| Some 6 ; None   ; None   ; Some 5 ; None   ; None   ; None   ; None   ; None |];
  [| None   ; Some 1 ; None   ; None   ; Some 3 ; None   ; None   ; Some 4 ; None |];
  [| None   ; None   ; Some 5 ; None   ; None   ; Some 1 ; None   ; None   ; Some 7 |];
  [| Some 5 ; None   ; None   ; Some 2 ; None   ; None   ; Some 6 ; None   ; None |];
  [| None   ; Some 3 ; None   ; None   ; Some 8 ; None   ; None   ; Some 9 ; None |];
  [| None   ; None   ; Some 7 ; None   ; None   ; None   ; None   ; None    |]|];;

(*question1*) 
let init sudoku() =
  let s = Array . make 9 [||] in
  for i = 0 to 8 do s.(i)<-Array.make 9 None done ;
  s;; 

(*question 2*)
let check1 s = 
  if Array.length s <> 9
  then failwith "Taille incorrecte Ligne..." ;
  for i = 0 to 8 do
    if Array.length s.(i) <> 9
    then failwith "Taille incorrecte colonne..."
  done ;;

check1(test);;
check1(difficult3);;

(*question 3*)
let case s l c = s.(l).(c);;

case test 0 0;;
case test 0 8;;
case test 0 0;;

(*question 4*)
(* verifier si v est licite dans
    la case ligne l colonne c de la
    grilles *)
let verif_case s l c v =
  let result = ref true in
  (* verifier la ligne *)
  for i = 0 to 8 do
    if i<>c && s.(l) .(i) = Some v
    then result := false
  done ;
  (* verifier la colonne *)
  for i = 0 to 8 do
    if i<>l && s.(i).(c) = Some v
    then result := false
  done ;
  (* verifier le cadran *)
  for i=l-(l mod 3)to l-(l mod 3)+2 do
    for j=c-(c mod 3) to c-(c mod 3)+2 do
      if (not(i=l && j=c)) && s.(i).(j) = Some v
      then result := false ;
    done
  done ;
  !result;;

verif_case test 0 0 0;;
verif_case test 0 0 1;;
verif_case test 0 0 2;;
verif_case test 0 0 3;;
verif_case test 0 0 4;;
verif_case test 0 0 5;;
verif_case test 0 0 6;;
verif_case test 0 0 7;;
verif_case test 0 0 8;;
verif_case test 0 0 9;;

(*question 5*)
(*for i=0 to 2 do
   for j=0 to 2 do
     print_int ((i+3∗j)mod 9+1)
   done
 done;;*)

(*question 6*)
let remplis g x =
  let x=ref x in
  for i=0 to 2 do
    for j=0 to 2 do
      for k=0 to 8 do
        g.((i+3*j)mod 9).(k)<-Some((k+ !x) mod 9+1)
      done ;
      x:= !x+1
    done
  done;;


(*question 7*)
exception SolutionTrouvee ;;
exception PasDeSolution ;;
  
let backtracking su =
  let rec backtracking_aux su n =
    if n >80 then raise SolutionTrouvee
    else
      let l = n / 9 in (*ligne *)
      let c = n mod 9 in (*colonne*)
      if su.(l).(c) <> None then backtracking_aux su (n+1)
      else
        for i = 1 to 9 do
          if verif_case su l c i
          then begin
            su.(l).(c)<-Some i ;
            backtracking_aux su (n+1);
            su.(l).(c)<-None
          end
        done
  in let temp = sudoku.copy su in
  try
    backtracking_aux temp 0 ;
    raise PasDeSolution
  with SolutionTrouvee -> print.sudoku temp ; temp;;

