function byId(id) {
    if (id) {
        return document.getElementById(id);
    }
}

const tenthElement = byId('tenth');
const secondsElement = byId('seconds');
const minutesElement = byId('minutes');

let nbTarget = 0;
let targetList = [];
let startedParty = false;

let time = 0;
let timerId = null;

// Initialise la partie en liant les événements aux boutons et en ajoutant un élément pour afficher le score.
function initParty() {
    bindCreateOneTarget();
    bindGenerateTarget();
    byId('control').insertAdjacentHTML('beforeend', '<div id="score"></div>');
}

// Lie l'événement du bouton "create" à la génération d'une cible unique.
function bindCreateOneTarget() {
    byId('create').addEventListener('click', () => {
        generateTargets(1).then(() => {
            targetList[0].addEventListener('click', () => {
                targetList[0].classList.add('hit');
            });
        });
    });
}

// Lie l'événement du bouton "start" au démarrage de la partie.
function bindGenerateTarget() {
    byId('start').addEventListener('click', () => {
        prepareParty();
    });
}

// Prépare la partie en réinitialisant les éléments d'affichage et en générant les cibles.
function prepareParty() {
    byId('score').textContent = '';
    nbTarget = byId('nbtargets').value;

    if (startedParty == true) {
        startedParty = false;
        displayTime(true);
    } else {
        if (time != 0) {
            displayTime(true);
        }
    }

    generateTargets(nbTarget)
        .then(() => {
            byId('remaining').textContent = nbTarget;
            for (let target of targetList) {
                target.addEventListener('click', () => {
                    if (startedParty == false) {
                        startedParty = true;
                        timer();
                    }
                    target.classList.add('hit');
                    nbTarget -= 1;
                    if (nbTarget == 0 && startedParty == true) {
                        startedParty = false;
                        displayChronoTimer();
                    }
                    byId('remaining').textContent = nbTarget;
                    removeTarget(target);
                });
            }
        });
}

// Génère les cibles de manière asynchrone en fonction du niveau sélectionné.
async function generateTargets(n = 0) {
    let level = byId('level').value;
    let terrain = byId('terrain');
    let emptyPlayground = true;

    if (targetList.length > 0) {
        //Attends que la fonction "removeAllTarget" soit terminée
        //afin d'éviter les erreurs de suppression des nouvelles cibles
        emptyPlayground = await removeAllTarget();
        targetList = [];
    }

    if (emptyPlayground) {
        for (let i = 0; i < n; i++) {
            let target = document.createElement('div');
            target.classList = 'target';
            if (level == 'hard') {
                byId('terrain').classList.add('hard-playground');
                target.classList.add('hard');
            } else {
                byId('terrain').classList.remove('hard-playground');
                target.classList.remove('hard');
            }
            target.classList.add('on');
            let position_left = 350;
            if (level == 'hard') {
                position_left = 550;
            }
            target.style.left = Math.floor(Math.random() * position_left) + 'px';
            target.style.top = Math.floor(Math.random() * 350) + 'px';
            terrain.appendChild(target);
            targetList.push(target);
        }
    }
}

// Supprime une cible après un délai d'une seconde.
function removeTarget(target) {
    setTimeout(() => {
        byId('terrain').removeChild(target);
    }, 1000);
}

// Supprime toutes les cibles existantes.
function removeAllTarget() {
    // Retourne une promesse afin d'éviter les erreurs de suppression des nouvelles cibles
    return new Promise((resolve) => {
        for (let target of targetList) {
            target.remove();
        }
        resolve(true);
    });
}

// Affiche le temps écoulé à la fin de la partie.
function displayTime(suppr = false, minutesTime, secondsTime, tenthsecondsTime) {
    let displaySeconds;
    let displayMinutes;

    if (suppr == true){
        // Réinitialise les valeurs des éléments d'affichage
        tenthElement.textContent = "0";
        secondsElement.textContent = "00";
        minutesElement.textContent = "00";
    } else {
        if (tenthsecondsTime < 10) {
            tenthElement.textContent = tenthsecondsTime;
        }

        if (secondsTime < 10) {
            displaySeconds = '0' + secondsTime;
            secondsElement.textContent = displaySeconds;
        } else if (secondsTime < 60) {
            secondsElement.textContent = secondsTime;
        }

        if (minutesTime < 10) {
            displayMinutes = '0' + minutesTime;
            minutesElement.textContent = displayMinutes;
        } else {
            minutesElement.textContent = minutesTime;
        }
    }
}

// Affiche le temps final du chrono.
function displayChronoTimer() {
    byId('score').innerHTML = "<p>Votre temps est de " + minutesElement.textContent + "m : " + secondsElement.textContent + "s . " + tenthElement.textContent + "</p>";
}

// Gère le décompte du temps lors du démarrage de la partie.
function timer() {
    let minutesTime = 0;
    let secondsTime = 0;
    let tenthsecondsTime = 0;

    if (timerId) {
        clearInterval(timerId);
    }

    timerId = setInterval(() => {
        if (startedParty == true) {
            tenthsecondsTime = time / 100;
            if (tenthsecondsTime == 10) {
                tenthsecondsTime = 0;
            }
            if (time == 1000) {
                time = 0;
                secondsTime += 1;
            }
            if (secondsTime == 60) {
                secondsTime = 0;
                minutesTime += 1;
            }
            displayTime(false, minutesTime, secondsTime, tenthsecondsTime);
            time += 100;
        }
    }, 100);
}

// Initialise la partie lors du chargement de la page.
initParty();