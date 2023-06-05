# Projet ocaml

## Installation OCaml :
Voir le lien : https://v2.ocaml.org/docs/install.fr.html

## Lancement :
- Ouvrer un terminal et rendez-vous sur le projet "Projet-NFP119/mini-projet-ocaml-202x".
- Ensuite, lancer la commande suivante : 
````
ocamlc -o sudoku backtracking.ml sudoku_test.ml
````
- Enfin, lancer le programme :
````
./sudoku
````

# Description du code
Ce projet contient deux fichiers "backtracking.ml" et "sudoku_test.ml".

### Fichier "backtracking.ml"
Le programme du fichier "backtracking.ml" définit un module Backtracking qui implémente les fonctions nécessaires pour résoudre un Sudoku. Le module a une signature BacktrackingSig qui décrit les types et les fonctions disponibles.

Voici les différentes fonctions crées dans le fichier "backtracking" :
absent_sur_ligne, absent_sur_colonne, absent_sur_bloc, remplir_le_sudoku, afficher_le_sudoku.

#### La fonction absent_sur_ligne :
- Prends en paramètres, le nombre à vérifier, la grille de sudoku et le numéro de la ligne.
- On crée une variable mutable "is_present" qui est initialisée à false. Cette dernière sera utilisée pour indiquer si le nombre est présent ou non sur la ligne.
- On crée une autre variable mutable nommée "column" initialisée à 0 qui sera utilisée pour parcourir les colonnes de la ligne.
- On utilise une boucle "while" pour parcourir les colonnes de la ligne tant que le nombre n'a pas été trouvé (!is_present = false) et que la colonne (!column) est inférieure à la longueur du tableau (grid.(line)) le nombre de colonnes de la ligne.
- Pour chaque itération de la boucle, on vérifie si la valeur de la case dans la ligne et la colonne actuelle (grid.(line).(!column)) est égale au nombre donné (number). Si c'est le cas, elle met à jour la variable "is_present' en la mettant à true', indiquant ainsi que le nombre est présnet sur la ligne.*
- On incrémente la variable 'column' afin de passer à la colonne suivante.
- Une fois la boucle terminée, on renvoie la négation de la variable 'is_present' (not !is_present).
- Si 'is_present' est 'false', cela signifie que le nombre est absent sur la ligne, et donc la fonction renvoie 'false'.
- On parcourt donc les cases d'une ligne donnée d'une grille de sudoku et on verifie si un nombre donné est présent sur cette ligne.
- On renvoie 'true' si le nombre est absent sur la ligne et 'false' s'il est présent.

#### La fonction absent_sur_colonne :
- La fonction prend en paramètres le nombre à vérifier, la grille de sudoku et le numéro de la colonne à vérifier.
- On crée un variable mutable "is_present" initialisée à false qui sera utilisée pour indiquer si le nombre est présent sur la colonne.
- On utilise une boucle "for" pour parcourir les différentes lignes du tableau.
- Pour chaque itération, on vérifie si la valeur de la case dans la ligne actuelle (grid.(i)) et la colonne spécifiée (column) est égale au nombre donné (number). Si c'est le cas, elle met à jour la variable (is_present) en définissant sa valeur à 'true', ce qui indique que le nombre est présent sur la colonne.
- La boucle terminée, on renvoie la négation de la variable 'is_present' (not !is_present). Si (is_present) est 'false', cela signifie que le nombre est absent sur la colonne ainsi la fonction renvoie true. Sinon, elle renvoie false cela signifie que le nombre est présent sur la colonne.

#### La fonction absent_sur_colonne :
- Cette fonction prend en paramètres le nombre à vérifier (number), la grille de sudoku (grid), la ligne (line) et la colonne (column)
- On détermine la taille de la grille avec (Array.length grid) et on stocke cette dernière dans la variable (grid_length).
- On calcule la taille d'un bloc en utilisant la formule (block_size = int_of_float (sqrt (float_of_int grid_length))). La grille de sudoku est un carré parfait, donc le nombre de colonnes est égal aux nombres de lignes.
- On détermine la ligne de départ du bloc en utilisant (block_start_line = line - line mod block_size). Grâce à cela, on obtient l'indice de la première colonne du bloc.
- Ensuite, on utilise (try with) afin de gérer les exceptions. Cela permet de sortir des boucles imbriquées lorsqu'un nombre est trouvé dans le bloc.
- Dans ce (try) on peut trouver deux boucle 'for' imbriqués qui parcourent les cases du bloc. Les variables (row) et (col) prennent les valeurs des indices des lignes et des colonnes du bloc.
- Pour chaque itération des boucles, on vérifie si la valeur de la case dans la grille (grid.(row).(line)) est égale au nombre donné (number). Si c'est le cas, on lance une exception (Exit) pour sortir des boucles.
- Si les boucles sont parcourues entièrement sans trouver le nombre, cela signifie que le nombre est absent dans le bloc et on renvoie alors true. Si une exception (Exit) est levée, cela signifie que le nombre a été trouvé dans le bloc, on capture cette exception avec la structure with Exit et on renvoie false.


#### La fonction remplir_le_sudoku :
- Cette fonction prend en paramètres une grille de sudoku (grid).
- On commence par déterminer la taille de la grille en utilisant (Array.length grid) et on stocke dans la variable (grid_size).
- Puis, on définit une fonction récursive (aux) qui prend en paramètre (current_index) qui correspond à l'indice de la case actuelle dans le parcours de la grille.
- (aux) vérifie si l'indice (current_index) est égal au nombre total de cases dans la grille. Si c'est le cas, cela signifie que toutes les cases, on été remplies avec succès et la fonction renvoie (true) pour indiquer que la grille est résolue.
- Si l'indice (current_index) n'est pas égal au nombre total de cases, ça signifie qu'il reste des cases à remplir. On continue donc son exécution en utilisant une condition (if) et (else).
- Dans cette condition, on calcule la ligne et la colonne correspondant à l'indice dans la grille. Cela permet de déterminer les coordonnées de la prochaine case à remplir.
- Puis, on vérifie si la case actuelle est déjà remplie en vérifiant si sa valeur est différente de zéro (grid.(line).(column) <> 0). Si la case est déjà remplie, on appelle récursivement (aux) avec l'indice de la case suivante pour passer à la prochaine case à remplir.
- Si la case est vide, on tente un remplissage en utilisant la boucle while.
- Cette boucle itère sur les nombres possibles pour la case actuelle, de 1 à (grid_size). Pour chaque nombre, on vérifie s'il est absent sur la ligne (absent_sur_ligne), sur la colonne (absent_sur_colonne) et dans le bloc (absent_sur_bloc). S'il est absent dans les trois cas, c'est qu'on peut le placé dans la case.
- Dans ce cas, on met à jour la valeur de la case avec le nombre en utilisant un référencement. (number) est déclaré comme une référence mutable (ref) et initialisé à 1. Ensuite, on appelle récursivement (aux) avec l'indice de la case suivante (current_index) pour continuer à remplir le reste de la grille.
- Si la récursion réussie (que toutes les cases sont remplies), on utilise l'instruction (raise SolutionTrouve) pour lancer une exception indiquant que la solution a été trouvée.
- Dans le cas où la boucle while se termine sans trouver de nombre convenable, c'est qu'aucun nombre ne peut être placé dans la case actuelle tout en respectant les contraintes du Sudoku. Dans ce cas, on met à jour la valeur de la case avec 0 pour la réinitialiser, puis on renvoie false pour indiquer l'échec de la résolution.
- Grâce à (try with), on capture l'exception SolutionTrouve qui est levée lorsque la solution est trouvée. Si l'exception est capturée, la fonction renvoie true pour indiquer que la grille est résolue avec succès.
- Enfin, cette fonction appelle (aux) avec l'indice initial 0 pour démarrer la résolution.


#### La fonction afficher_le_sudoku :
- Elle prend en paramètres la grille de sudoku (grid).
- On détermine la taille de la grille et on la stocke dans une variable.
- On utilise une boucle (for) pour parcourir les lignes de la grille. L'indice de ligne est représenté par la variable (i), qui va de 0 à (size - 1).
- Dans cette première boucle, on utilise une condition pour vérifier si l'indice de ligne (i) est un multiple de 3. Cela permet d'ajouter des lignes horizontales de séparation dans l'affichage pour mieux visualiser les blocs du sudoku.
- Puis, on utilise une deuxième boucle (for) pour parcourir les colonnes de la grille. L'indice de colonne est représenté par la variable (j), qui va également de 0 à (size - 1).
- Dans cette boucle, on utilise une autre condition pour vérifier si l'indice (j) est égal à 0 et si l'indice (i) n'est pas égal à (size). Cela permet d'ajouter des lignes verticales de séparation dans l'affichage. Si les conditions sont satisfaites, on affiche (|) pour séparer les colonnes.
- Puis on affiche la valeur de la case (grid.(i).(j)).
- Ensuite, on passe à la ligne suivante.
- Enfin, avec une condition, on vérifie si l'indice de la ligne (i) est égal à (size - 1). Dans ce cas, ça signifie que c'est la dernière ligne de la grille et on affiche une ligne de séparation finale.


### Fichier "sudoku_test.ml"
Ce dernier est un programme test.
Le programme du fichier "sudoku_test.ml" effectue plusieurs tests liés à la résolution de grilles de Sudoku en utilisant le module Backtracking.

#### Le programme :
- Commence par ouvrir le module "Backtracking" et ce qui permet d'accéder aux fonctions qu'il contient.
- Définis 3 grilles de sudoku.
- La fonction "absent_sur_colonne_test" vérifie si un nombre est absent sur une colonne donnée de la grille. Elle génère une colonne aléatoire et une valeur aléatoire, puis utilise la fonction (absent_sur_colonne) du module "Backtracking" pour effectuer la vérification.
- La fonction "absent_sur_ligne_test" vérifie si un nombre est absent sur une ligne donnée de la grille. Elle génère une ligne aléatoire et une valeur aléatoire, puis utilise la fonction "absent_sur_ligne" du module "Backtracking" pour effectuer la vérification.
- La fonction "absent_sur_bloc_test" vérifie si un nombre est absent dans le bloc auquel appartient une certaine position (ligne, colonne) de la grille. Elle génère une ligne aléatoire, une colonne aléatoire et une valeur aléatoire, puis utilise la fonction "absent_sur_bloc" du module "Backtracking" pour effectuer la vérification.
- Ce programme définit également une fonction "genere_random_number" qui permet de générer un nombre aléatoire entre 0 et 8 inclus.
- Puis pour chaque grille de sudoku contenu dans le tableau (sudo_array), ce programme exécute la fonction (run_test) en lui passant en paramètre la grille et le numéro de la grille.
- La fonction (run_test) effectue les tests de présence sur colonne, ligne et bloc, puis utilise les fonctions "remplir_le_sudoku" et "afficher_le sudoku" du module "Backtracking" afin de résoudre et afficher le sudoku.