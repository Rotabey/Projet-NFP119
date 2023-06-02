Projet ocaml 

Voici les différentes fonctions crées :
absent_sur_ligne, absent_sur_colonne, absent_sur_bloc, remplir_le_sudoku, afficher_le_sudoku.

La fonction absent_sur_ligne :
Prend en parametres, le nombre à vérifier, la grille de sudoku et le numéro de la ligne.
On crée une variable mutable "is_present" qui est initialisée à false. Cette dernière sera utilisée pour indiquer si le nombre est présent ou non sur la ligne.
On crée une autre variable mutable nommé "column" initialisée à 0 qui sera utilisée pour parcourir les colonnes de la ligne.
On utilise une boucle "while" pour parcourir les colonnes de la ligne tant que le nombre n'a pas été trouvé (!is_present = false) et que la colonne (!column) est inférieure à la longueur du tableau (grid.(line)) le nombre de colonnes de la ligne.
Pour chaque itération de la boucle, on vérifie si la valeur de la case dans la ligne et la colonne actuelle (grid.(line).(!column)) est égale au nombre donné (number). Si c'est le cas, elle met à jour la variable "is_present' en la mettant à true', indiquant ainsi que le nombre est présnet sur la ligne.*
On incrémente la variable 'column' afin de passer à la colonne suivante.
Une fois la boucle terminée, on renvoie la négation de la variable 'is_present' (not !is_present).
Si 'is_present' est 'false', cela signifie que le nombre est absent sur la ligne, et donc la fonction renvoie 'false'.
On parcours donc les cases d'une ligne donnée d'une grille de sudoku et on verifie si un nombre est présent cette ligne. On renvoie 'true' si le nombre est absent sur la ligne et 'false' s'il est présent.

