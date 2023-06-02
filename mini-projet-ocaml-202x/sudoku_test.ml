open Backtracking

(* grilles *)
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

(* Test des fonctions *)
let genere_random_number () : int =
  Random.int 9;;

let absent_sur_colonne_test grid () =
  let colonne = genere_random_number () in
  let value = genere_random_number () in
  let message = "Absent sur colonne : valeur = " ^ string_of_int value ^ " colonne = " ^ string_of_int colonne in
  print_string message;
  Printf.printf "\n";
  let result = Backtracking.absent_sur_colonne value grid colonne in
  print_string (string_of_bool result);
  Printf.printf "\n"

let absent_sur_ligne_test grid () =
  let ligne = genere_random_number () in
  let value = genere_random_number () in
  let message = "Absent sur ligne test : valeur = " ^ string_of_int value ^ " ligne = " ^ string_of_int ligne in
  print_string message;
  Printf.printf "\n";
  let result = Backtracking.absent_sur_ligne value grid ligne in
  print_string (string_of_bool result);
  Printf.printf "\n"

let absent_sur_bloc_test grid () =
  let ligne = genere_random_number () in
  let value = genere_random_number () in
  let colonne = genere_random_number () in
  let message = "Absent sur bloc test : valeur = " ^ string_of_int value ^ " colonne = " ^ string_of_int colonne ^ " ligne = " ^ string_of_int ligne in
  print_string message;
  Printf.printf "\n";
  let result = Backtracking.absent_sur_bloc value grid ligne colonne in
  print_string (string_of_bool result);
  Printf.printf "\n"

let run_test grid numero_grille =
  Printf.printf "%d" numero_grille;
  absent_sur_colonne_test grid ();
  absent_sur_ligne_test grid ();
  absent_sur_bloc_test grid ();
  Backtracking.remplir_le_sudoku grid;
  Backtracking.afficher_le_sudoku grid;
  Printf.printf "\n";;

let sudo_array = [|sudo1; sudo2; sudo3|] in
Array.iteri (fun i grid -> run_test grid (i + 1)) sudo_array;;