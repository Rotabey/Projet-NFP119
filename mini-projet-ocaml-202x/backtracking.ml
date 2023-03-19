let absent_sur_block k_number grid line colonne =
  let n2 = Array.length grid in
  let n =
    int_of_float (sqrt (float_of_int n2))
  in let u = line - line mod n and
      v = colonne - colonne mod n in
  try
    for u' = u to u+n-1 do
      for v' = v to v+n-1 do
        if grid.(u').(v')=k_number then raise Exit;
      done;
    done;  true;
   with Exit -> false;;

let absent_sur_ligne k_number grid line =
  let present = ref false and colonne = ref 0 in
  while not !present
        && !colonne < Array.length grid.(line) do
    if grid.(line).(!colonne) = k_number
    then present := true;
    incr colonne;
  done;
  not !present;;

let absent_sur_colonne k_number grid colonne =
  try
    for line = 0 to (Array.length grid -1) do
      if grid.(line).(colonne) = k_number
      then raise Exit;
    done;
    true
  with Exit -> false;;


exception Trouve;;

let remplir grid =
  let nbl = Array.length grid in
  let rec aux p =
    if p = nbl*nbl then true
    else
      begin
        let line = p/nbl and colonne = p mod nbl in
        if grid.(line).(colonne) <> 0 then aux (p+1)
        else
          (
            let k_number = ref 1 in
            try
              while !k_number <=nbl do
                if absent_sur_ligne !k_number grid line
                   && absent_sur_colonne !k_number grid colonne
                   && absent_sur_block !k_number grid line colonne then
                  begin
                    grid.(line).(colonne) <- !k_number;
                    if aux (p+1) then raise Trouve;
                  end;
                incr k_number;
              done;
              grid.(line).(colonne)<-0;(*libérer; pas en arrière*)
              false
            with Trouve -> true
          )
      end in
  aux 0;;

let display_grid matrix =
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

let sudoku_grid =    [|
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

absent_sur_colonne 3 sudoku_grid 0;;
absent_sur_colonne 2 sudoku_grid 0;;

absent_sur_ligne 3 sudoku_grid 0;;
absent_sur_ligne 1 sudoku_grid 0;;

absent_sur_block 8 sudoku_grid 5 4;;
absent_sur_block 4 sudoku_grid 2 2;;

display_grid sudoku_grid;;

remplir sudoku_grid;;

sudoku_grid;;

display_grid sudoku_grid;;