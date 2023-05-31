(* Fonction permttant de voir si un nombre donné est absent sur une ligne d'un tableau *)
let absent_sur_ligne number grid line =
  let is_present = ref false and column = ref 0 in
  while not !is_present && !column < Array.length grid.(line) do
    if grid.(line).(!column) = number then
      is_present := true;
    incr column
  done;
  not !is_present;;


(* Fonction permettant de voir si un nombre est absent sur une colonne d'un tableau *)
let absent_sur_col number grid column =
  let is_present = ref false in
  for i = 0 to Array.length grid - 1 do
    if grid.(i).(column) = number then
      is_present := true
  done;
  not !is_present;;


(* Fonction permettant de voir si un nombre est absent sur un bloc  *)
let absent_sur_block number grid line column =
  let grid_length = Array.length grid in
  let block_size =
    int_of_float (sqrt (float_of_int grid_length)) in
  let block_start_line = line - line mod block_size and
    block_start_column = column - column mod block_size in
  try
    for row = block_start_line to block_start_line + block_size - 1 do
      for col = block_start_column to block_start_column + block_size - 1 do
        if grid.(row).(col) = number then raise Exit;
      done;
    done;
    true;
  with Exit -> false;;

exception SolutionTrouve;;

(* Fonction permettant de remplir une grille de sudoku  *)
let remplir grid =
  let grid_size = Array.length grid in
  let rec aux current_index =
    if current_index = grid_size*grid_size then true
    else
      begin
        let line = current_index/grid_size and column = current_index mod grid_size in
        if grid.(line).(column) <> 0 then aux (current_index+1)
        else
          (
            let number = ref 1 in
            try
              while !number <=grid_size do
                if absent_sur_ligne !number grid line
                && absent_sur_col !number grid column
                && absent_sur_block !number grid line column then
                  begin
                    grid.(line).(column) <- !number;
                    if aux (current_index+1) then raise SolutionTrouve;
                  end;
                incr number;
              done;
              grid.(line).(column)<-0;
              false
            with SolutionTrouve -> true
          )
      end in
  aux 0;;

(* Fonction permettant d'afficher la grille de sudoku *)
let display_grid grid =
  let size = Array.length grid in
  for i = 0 to size - 1 do
    if i mod 3 = 0 then
      Printf.printf "+-----------+-----------+-----------+\n";
    for j = 0 to size - 1 do
      if j = 0 && i != size then
        Printf.printf "|";
      Printf.printf " %d |" grid.(i).(j);
    done;
    Printf.printf "\n";
    if i = size - 1 then
      Printf.printf "+-----------+-----------+-----------+\n";
  done;;


let sudo =
  [|
    [|5; 3; 0; 0; 7; 0; 0; 0; 0|];
    [|6; 0; 0; 1; 9; 5; 0; 0; 0|];
    [|0; 9; 8; 0; 0; 0; 0; 6; 0|];
    [|8; 0; 0; 0; 6; 0; 0; 0; 3|];
    [|4; 0; 0; 8; 0; 3; 0; 0; 1|];
    [|7; 0; 0; 0; 2; 0; 0; 0; 6|];
    [|0; 6; 0; 0; 0; 0; 2; 8; 0|];
    [|0; 0; 0; 4; 1; 9; 0; 0; 5|];
    [|0; 0; 0; 0; 8; 0; 0; 7; 9|]
  |];;

absent_sur_ligne 8 sudo 0;;
absent_sur_col 3 sudo 0;;
absent_sur_block 2 sudo 1 1;;

remplir sudo;;
display_grid sudo;;