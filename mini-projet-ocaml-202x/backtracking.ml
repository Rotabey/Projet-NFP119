let absentSurLigne k g i =
  let present = ref false and j = ref 0 in
  while not !present
        && !j < Array.length g.(i) do
    if g.(i).(!j) = k
    then present := true;
    incr j;
  done;
  not !present;;

let absentSurCol k g j =
  try
    for i = 0 to (Array.length g -1) do
      if g.(i).(j) = k
      then raise Exit;
    done;
    true
  with Exit -> false;; 

let absentSurBloc k g i j =
  let n2 = Array.length g in
  let n =
    int_of_float (sqrt (float_of_int n2))
  in let u = i - i mod n and
      v = j - j mod n in
  try
    for u' = u to u+n-1 do
      for v' = v to v+n-1 do
        if g.(u').(v')=k then raise Exit;
      done;
    done;  true;
   with Exit -> false;;

exception Trouve;;

let remplir g =
  let nbl = Array.length g in
  let rec aux p =
    if p = nbl*nbl then true
    else
      begin
        let i = p/nbl and j = p mod nbl in
        if g.(i).(j) <> 0 then aux (p+1)
        else
          (
            let k = ref 1 in
            try
              while !k <=nbl do
                if absentSurLigne !k g i
                   && absentSurCol !k g j
                   && absentSurBloc !k g i j then
                  begin
                    g.(i).(j) <- !k;(*occuper; pas en avant*)
                    if aux (p+1) then raise Trouve;
                  end;              
                incr k;
              done;
              g.(i).(j)<-0;(*libérer; pas en arrière*)
              false
            with Trouve -> true
          )
      end in
  aux 0;;

let print_grille matrix = 
  for y = 0 to 8 do
    print_string "| ";
    for x = 0 to 8 do
      
      print_int matrix.(y).(x);
      print_string " | ";
    done;
    if y < 8 then
      if y mod 3 = 2 then print_string "\n+-----------+-----------+-----------+\n"
      else print_string "\n";
  done;;

let grille =    [|
  [|9;0;0;1;0;0;0;0;5|];
  [|0;0;5;0;9;0;2;0;1|];
  [|8;0;0;0;4;0;0;0;0|];
  [|0;0;0;0;8;0;0;0;0|];
  [|0;0;0;7;0;0;0;0;0|];
  [|0;0;0;0;2;6;0;0;9|];
  [|2;0;0;3;0;0;0;0;6|];
  [|0;0;0;2;0;0;9;0;0|];
  [|0;0;1;9;0;4;5;7;0|]
|];;

absentSurLigne 3 grille 0;;
absentSurLigne 1 grille 0;;
absentSurCol 3 grille 0;;
absentSurCol 2 grille 0;;
absentSurBloc 8 grille 5 4;;
absentSurBloc 4 grille 2 2;;

print_grille grille;;

remplir grille;;

grille;;

print_grille grille;;



