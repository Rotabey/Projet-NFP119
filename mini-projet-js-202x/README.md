# Projet JS
Ce projet contient deux fichiers "project202x.js" et "mini-projet-js-202x.html".

## Fichier "project202x.js"
Voici  une description des fonctionnalités principales du programme :
- "byId(id)" est une fonction utilitaire qui récupère un élément du document en utilisant son ID.
- "tenthElement", "secondsElement", et "minutesElement" sont des références aux éléments HTML correspondants. 
- "nbTarget", "targetList", et "startedParty" sont des variables utilisées pour suivre l'état du jeu. 
- "initParty()" initialise le jeu en liant les événements aux boutons et en ajoutant un élément pour afficher le score. 
- "bindCreateOneTarget()" lie l'événement du bouton "create" à la génération d'une cible unique. Lorsque la cible est cliquée, elle ajoute la classe CSS "hit" à la cible.
- "bindGenerateTarget()" lie l'événement du bouton "start" au démarrage de la partie. Lorsque le bouton "start" est cliqué, la fonction "prepareParty()" est appelée. 
- "prepareParty()" prépare la partie en réinitialisant les éléments d'affichage et en générant les cibles. Elle met à jour le nombre de cibles restantes, gère les clics sur les cibles, et démarre le chronomètre.
- "generateTargets(n)" génère de manière asynchrone les cibles en fonction du niveau sélectionné. Elle crée des éléments div représentant les cibles et les ajoute au terrain. 
- "removeTarget(target)" supprime une cible après un délai d'une seconde en utilisant la fonction setTimeout.
- "removeAllTarget()" supprime toutes les cibles existantes en parcourant la liste targetList et en utilisant la méthode remove().
- "displayTime(suppr, minutesTime, secondsTime, tenthsecondsTime)" affiche le temps écoulé à la fin de la partie. Elle met à jour les éléments HTML correspondant aux dixièmes de seconde, aux secondes et aux minutes.
- "displayChronoTimer()" affiche le temps final du chronomètre en utilisant les valeurs des éléments HTML correspondant aux dixièmes de seconde, aux secondes et aux minutes.
- "timer()" gère le décompte du temps lors du démarrage de la partie. Elle utilise "setInterval()" pour mettre à jour les valeurs du chronomètre à intervalles réguliers.
- "initParty()" est appelée lors du chargement de la page pour initialiser le jeu.

En résumé, le code gère la génération de cibles, la manipulation des événements de clic, le suivi du temps et l'affichage des résultats.