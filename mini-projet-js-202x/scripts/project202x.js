// YOUR NAME HERE

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

function initParty() {
    bindCreateOneTarget();
    bindGenerateTarget();
    byId('control').insertAdjacentHTML('beforeend', '<div id="score"></div>');
}

function bindCreateOneTarget() {
    byId('create').addEventListener('click', () => {
        generateTarget(1).then(() => {
            targetList[0].addEventListener('click', () => {
                targetList[0].classList.add('hit');
            });
        });
    });
}

function bindGenerateTarget() {
    byId('start').addEventListener('click', () => {
        prepareParty();
    });
}

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

    generateTarget(nbTarget)
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

async function generateTarget(n = 0) {
    let level = byId('level').value;
    let terrain = byId('terrain');
    let emptyPlayground = true;

    if (targetList.length > 0) {
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

function removeTarget(target) {
    setTimeout(() => {
        byId('terrain').removeChild(target);
    }, 1000);
}

function removeAllTarget() {
    return new Promise((resolve) => {
        for (let target of targetList) {
            target.remove();
        }
        resolve(true);
    });
}

function displayTime(suppr = false, minutesTime, secondsTime, tenthsecondsTime) {
    let displaySeconds;
    let displayMinutes;

    if (suppr == true) {
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

function displayChronoTimer() {
    byId('score').innerHTML = "<p>Votre temps est de " + minutesElement.textContent + "m : " + secondsElement.textContent + "s . " + tenthElement.textContent + "</p>";
}

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

initParty();
