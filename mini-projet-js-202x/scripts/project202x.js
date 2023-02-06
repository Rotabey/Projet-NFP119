// YOUR NAME HERE

class Party {
    constructor() {
        this.tenthElement = this.byId('tenth');
        this.secondsElement = this.byId('seconds');
        this.minutesElement = this.byId('minutes');

        this.nbTarget = 0;
        this.targetList = [];
        this.startedParty = false;

        this.chronoTimer = 0;
        this.timerId = null;

        this.initParty();
    }

    byId(id){
        if (id){
           return document.getElementById(id); 
        }
    }

    initParty(){
        this.bindCreateOneTarget();
        this.bindGenerateTarget();
    }

    bindCreateOneTarget(){
        this.byId('create').addEventListener('click', () => {
            this.generateTarget(1).then(() => {
                this.targetList[0].addEventListener('click', () => {
                    this.targetList[0].classList.add('hit');
                });
            });
        });
    }

    bindGenerateTarget(){
        this.byId('start').addEventListener('click', () => {
            this.prepareParty();
        });
    }

    prepareParty() {
        this.nbTarget = this.byId('nbtargets').value;

        if (this.startedParty == true){
            this.startedParty = false;
            this.displayTime(true);
        } else {
            if (this.chronoTimer != 0){
                this.displayTime(true);
            }
        }

        this.generateTarget(this.nbTarget)
            .then(() => {
                this.byId('remaining').textContent = this.nbTarget;
                for (let target of this.targetList) {
                    target.addEventListener('click', () => {
                        if (this.startedParty == false){
                            this.startedParty = true;
                            this.timer();
                        }
                        target.classList.add('hit');
                        this.nbTarget -= 1;
                        if (this.nbTarget == 0 && this.startedParty == true){
                            this.startedParty = false;
                            this.displayChronoTimer();
                        }
                        this.byId('remaining').textContent = this.nbTarget;
                    });
                }
        });
    }

    displayChronoTimer(){
        let arrayTimer = this.chronoTimer.split(' ');
        let minutes = arrayTimer[0];
        let seconds = arrayTimer[2];
        let centi = arrayTimer[4];
        this.byId('score').innerHTML = "<p>Votre temps est de " + minutes + "m : " + seconds +"s . " + centi + "</p>";
    }

    displayTime(suppr = false, minutesTime, secondsTime, centisecondsTime){
        let displayCentiseconds;
        let displaySeconds;
        let displayMinutes;

        if (suppr == true){
            this.tenthElement.textContent = "00";
            this.secondsElement.textContent = "00";
            this.minutesElement.textContent = "00";
        } else {
            if (centisecondsTime < 10){
                displayCentiseconds = '0' + centisecondsTime;
                this.tenthElement.textContent = displayCentiseconds;
            } else if (centisecondsTime < 100) {
                this.tenthElement.textContent = centisecondsTime;
            }

            if (secondsTime < 10){
                displaySeconds = '0' + secondsTime;
                this.secondsElement.textContent = displaySeconds;
            } else if (secondsTime < 60) {
                this.secondsElement.textContent = secondsTime;
            }

            if (minutesTime < 10){
                displayMinutes = '0' + minutesTime;
                this.minutesElement.textContent = displayMinutes;
            } else {
                this.minutesElement.textContent = minutesTime;
            }

            this.chronoTimer = `${minutesTime}` + ' : ' + `${secondsTime}` + ' . ' + `${centisecondsTime}`;
        }
    }

    timer(){
        let minutesTime = 0;
        let secondsTime = 0;
        let centisecondsTime = 0;

        if (this.timerId) {
            clearInterval(this.timerId);
        }

        this.timerId = setInterval(() => {
            if (this.startedParty == true){
                centisecondsTime +=1;
                if (centisecondsTime == 100){
                    centisecondsTime = 0;
                    secondsTime += 1;
                }
                if (secondsTime == 60){
                    secondsTime = 0;
                    minutesTime += 1;
                }
                this.displayTime(false, minutesTime, secondsTime, centisecondsTime);
            }
        }, 10);
    }

    async generateTarget(n = 0){
        let terrain = this.byId('terrain');
        let terrain_vide = true;

        if (this.targetList.length > 0){
            terrain_vide = await this.removeAllTarget();
            this.targetList = [];
        }

        if (terrain_vide){
            for(let i = 0; i < n; i++){
                let target = document.createElement('div');
                target.classList = 'target';
                target.classList.add('on');
                target.style.left = Math.floor(Math.random() * 350) + 'px';
                target.style.top = Math.floor(Math.random() * 350)  + 'px';
                terrain.appendChild(target);
                this.targetList.push(target);
            }
        }
    }

    removeAllTarget(){
        return new Promise((resolve) => {
            for(let target of this.targetList){
                target.remove();
            }
            resolve(true);
        });
    }
}

new Party();