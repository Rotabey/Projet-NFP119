// YOUR NAME HERE

class Party {
    constructor() {
        this.tenthElement = this.byId('tenth');
        this.secondsElement = this.byId('seconds');
        this.minutesElement = this.byId('minutes');

        this.nbTarget = 0;
        this.targetList = [];
        this.startedParty = false;

        this.time = 0;
        this.timerId = null;

        this.initParty();
    }

    byId(id) {
        if (id) {
            return document.getElementById(id);
        }
    }

    initParty() {
        this.bindCreateOneTarget();
        this.bindGenerateTarget();
        this.byId('control').insertAdjacentHTML('beforeend', '<div id="score"></div>');
    }

    bindCreateOneTarget() {
        this.byId('create').addEventListener('click', () => {
            this.generateTarget(1).then(() => {
                this.targetList[0].addEventListener('click', () => {
                    this.targetList[0].classList.add('hit');
                });
            });
        });
    }

    bindGenerateTarget() {
        this.byId('start').addEventListener('click', () => {
            this.prepareParty();
        });
    }

    prepareParty() {
        this.byId('score').textContent = '';
        this.nbTarget = this.byId('nbtargets').value;

        if (this.startedParty == true) {
            this.startedParty = false;
            this.displayTime(true);
        } else {
            if (this.time != 0) {
                this.displayTime(true);
            }
        }

        this.generateTarget(this.nbTarget)
            .then(() => {
                this.byId('remaining').textContent = this.nbTarget;
                for (let target of this.targetList) {
                    target.addEventListener('click', () => {
                        if (this.startedParty == false) {
                            this.startedParty = true;
                            this.timer();
                        }
                        target.classList.add('hit');
                        this.nbTarget -= 1;
                        if (this.nbTarget == 0 && this.startedParty == true) {
                            this.startedParty = false;
                            this.displayChronoTimer();
                        }
                        this.byId('remaining').textContent = this.nbTarget;
                        this.removeTarget(target);
                    });
                }
            });
    }

    displayChronoTimer() {
        let arrayTimer = this.time.split(' ');
        let minutes = arrayTimer[0];
        let seconds = arrayTimer[2];
        let tenth = arrayTimer[4];
        this.byId('score').innerHTML = "<p>Votre temps est de " + minutes + "m : " + seconds + "s . " + tenth + "</p>";
    }

    displayTime(suppr = false, minutesTime, secondsTime, tenthsecondsTime) {
        let displaySeconds;
        let displayMinutes;

        if (suppr == true) {
            this.tenthElement.textContent = "0";
            this.secondsElement.textContent = "00";
            this.minutesElement.textContent = "00";
        } else {
            if (tenthsecondsTime < 10) {
                this.tenthElement.textContent = tenthsecondsTime;
            }

            if (secondsTime < 10) {
                displaySeconds = '0' + secondsTime;
                this.secondsElement.textContent = displaySeconds;
            } else if (secondsTime < 60) {
                this.secondsElement.textContent = secondsTime;
            }

            if (minutesTime < 10) {
                displayMinutes = '0' + minutesTime;
                this.minutesElement.textContent = displayMinutes;
            } else {
                this.minutesElement.textContent = minutesTime;
            }
        }
    }

    timer() {
        let minutesTime = 0;
        let secondsTime = 0;
        let tenthsecondsTime = 0;

        if (this.timerId) {
            clearInterval(this.timerId);
        }

        this.timerId = setInterval(() => {
            if (this.startedParty == true) {
                tenthsecondsTime += 1;
                if (tenthsecondsTime == 10) {
                    tenthsecondsTime = 0;
                    secondsTime += 1;
                }
                if (secondsTime == 60) {
                    secondsTime = 0;
                    minutesTime += 1;
                }
                this.time = `${minutesTime}` + ' : ' + `${secondsTime}` + ' . ' + `${tenthsecondsTime}`;
                this.displayTime(false, minutesTime, secondsTime, tenthsecondsTime);
            }
        }, 100);
    }

    async generateTarget(n = 0) {
        let level = this.byId('level').value;
        console.log(level);
        let terrain = this.byId('terrain');
        let emptyPlayground = true;

        if (this.targetList.length > 0) {
            emptyPlayground = await this.removeAllTarget();
            this.targetList = [];
        }

        if (emptyPlayground) {
            for (let i = 0; i < n; i++) {
                let target = document.createElement('div');
                target.classList = 'target';
                if (level == 'hard') {
                    this.byId('terrain').classList.add('hard-playground');
                    target.classList.add('hard');
                } else {
                    this.byId('terrain').classList.remove('hard-playground');
                    target.classList.remove('hard');
                }
                target.classList.add('on');
                let position_left = 350;
                if (level == 'hard'){
                    position_left = 550;
                }
                target.style.left = Math.floor(Math.random() * position_left) + 'px';
                target.style.top = Math.floor(Math.random() * 350) + 'px';
                terrain.appendChild(target);
                this.targetList.push(target);
            }
        }
    }

    removeTarget(target) {
        setTimeout(() => {
            this.byId('terrain').removeChild(target);
        }, 1000);
    }

    removeAllTarget() {
        return new Promise((resolve) => {
            for (let target of this.targetList) {
                target.remove();
            }
            resolve(true);
        });
    }
}

new Party();