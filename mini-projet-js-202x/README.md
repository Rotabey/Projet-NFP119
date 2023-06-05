# Projet JS 
Ce projet contient deux fichiers "project202x.js" et "mini-projet-js-202x.html".

## Fichier "project202x.js"
.
Voici  une description des fonctionnalités principales du programme :
- La fonction "byId(id)" est une fonction utilitaire pour récupérer un élément du DOM à l'aide de son ID.
- Les constantes "tenthElement", "secondsElement" et "minutesElement" représentent des éléments du DOM correspondant à des affichages de temps.
- Les variables "nbTarget", "targetList" et "startedParty" sont utilisées pour suivre le nombre de cibles, la liste des cibles et l'état du jeu.
- "initParty()" initialise le jeu en ajoutant des écouteurs d'événements aux boutons et en ajoutant un élément de score dans le DOM.
- "bindCreateOneTarget()" ajoute un écouteur d'événement au bouton "create" pour générer une cible lorsque le bouton est cliqué.
- "bindGenerateTarget()" ajoute un écouteur d'événement au bouton "start" pour préparer le jeu lorsque le bouton est cliqué.
- "prepareParty()" prépare le jeu en réinitialisant les valeurs, en générant les cibles et en ajoutant des écouteurs d'événements pour chaque cible.
- "generateTarget(n)" génère un nombre spécifié de cibles sur le terrain en utilisant des paramètres de niveau pour modifier les classes CSS des cibles.
- "removeTarget(target)" supprime une cible spécifiée du terrain après une certaine durée.
- "removeAllTarget()" supprime toutes les cibles du terrain en utilisant une promesse pour indiquer quand l'opération est terminée.
- "reinitDisplayTime()" réinitialise l'affichage du temps à zéro.
- "displayTime(minutesTime, secondsTime, tenthsecondsTime)" affiche le temps écoulé en minutes, secondes et dixièmes de seconde.
- "displayChronoTimer()" affiche le temps écoulé dans l'élément de score.
- "timer()" met à jour le temps toutes les 100 millisecondes et met à jour les affichages du temps.
- "initParty()" initialise le jeu en appelant d'autres fonctions pour mettre en place les fonctionnalités du jeu.
- "initParty()" démarre le jeu en lançant l'initialisation.

En résumé, le code gère la génération de cibles, la manipulation des événements de clic, le suivi du temps et l'affichage des résultats.