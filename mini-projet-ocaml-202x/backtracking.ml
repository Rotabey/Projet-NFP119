(* Permet de voir si un nombre donné est absent sur une ligne d'un tableau *)
let absent_sur_ligne number grid line =
  let is_present = ref false and column = ref 0 in
  while not !is_present && !column < Array.length grid.(line) do
    if grid.(line).(!column) = number then
      is_present := true;
    incr column
  done;
  not !is_present;;


(* Permet de voir si un nombre est absent sur une colonne d'un tableau *)
let absent_sur_colonne number grid column =
  let is_present = ref false in
  for i = 0 to Array.length grid - 1 do
    if grid.(i).(column) = number then
      is_present := true
  done;
  not !is_present;;


(* Permet de voir si un nombre est absent sur un bloc *)
let absent_sur_bloc number grid line column =
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

(* Permet de remplir une grille de sudoku *)
let remplir_le_sudoku grid =
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
                && absent_sur_colonne !number grid column
                && absent_sur_bloc !number grid line column then
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

(* Permet d'afficher la grille de sudoku *)
let afficher_le_sudoku grid =
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


(* Test des fonctions *)
let sudo1 = [|
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


let sudo2 = [|
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


let sudo3 = [|
    [|0; 0; 0; 2; 0; 0; 0; 4; 0|];
    [|0; 0; 9; 0; 0; 0; 0; 0; 5|];
    [|0; 0; 0; 0; 1; 0; 0; 0; 3|];
    [|5; 0; 4; 0; 0; 0; 7; 0; 0|];
    [|0; 0; 0; 0; 0; 0; 0; 0; 0|];
    [|0; 0; 3; 0; 0; 0; 9; 0; 8|];
    [|1; 0; 0; 0; 3; 0; 0; 0; 0|];
    [|4; 0; 0; 0; 0; 0; 6; 0; 0|];
    [|0; 3; 0; 0; 0; 6; 0; 0; 0|]
  |];;

let genere_random_number () =
   Random.int 9;;

let absent_sur_colonne_test grid () =
   let colonne = genere_random_number () in
     let value = genere_random_number () in
     let message = "Colonne test valeur: " ^ string_of_int value ^ " colonne: " ^ string_of_int colonne in
       print_string message;
     absent_sur_colonne value grid colonne;;

let absent_sur_ligne_test grid () =
let ligne = genere_random_number () in
let value = genere_random_number () in
   let message = "Ligne test valeur: " ^ string_of_int value ^ " ligne: " ^ string_of_int ligne in
       print_string message;
absent_sur_ligne value grid ligne;;

let absent_sur_bloc_test grid () =
let ligne = genere_random_number () in
let value = genere_random_number () in
let colonne = genere_random_number () in
     let message = "Bloc test valeur: " ^ string_of_int value ^ " colonne: " ^ string_of_int colonne ^ " ligne: " ^ string_of_int ligne in
       print_string message;
absent_sur_bloc value grid ligne colonne;;

let run_test grid =
  absent_sur_colonne_test grid;
  absent_sur_ligne_test grid;
  absent_sur_bloc_test grid;
  remplir_le_sudoku grid;
  afficher_le_sudoku grid;
;;

let sudo_array = [|sudo1; sudo2; sudo3|];
List.iter (fun sudo ->
  run_test sudo;
) sudo_array;;