// YOUR NAME HERE

class Party {
    static TARGET_WIDTH = 40;
    static TARGET_HEIGHT = 40;

    constructor() {
        this.nbTarget = 0;
        this.targetList = [];

        this.chronoTimer = 0;
        // timer variable 
        this.time = 0;

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
        this.generateTarget(this.nbTarget)
            .then(() => {
                for (let target of this.targetList) {
                    target.addEventListener('click', () => {
                        //this.timer();
                        target.classList.add('hit');
                        this.nbTarget -= 1;
                        if (this.nbTarget == 0){
                            //this.timer(true);
                        }
                        this.byId('remaining').textContent = `${this.nbTarget}`;
                    });
                }
        });
        this.byId('remaining').textContent = this.nbTarget;
    }

    timer(stop = false){
        let minutes_time = 0;
        let seconds_time= 0;
        let centiseconds_time = 0;

        let i = 0;
        while (centiseconds_time != 100){
            setTimeout(() => {
                centiseconds_time += i;
                i++;
            }, 1000);
        }
        console.log(centiseconds_time);
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
        return new Promise(resolve => {
            for(let target of this.targetList){
                target.remove();
            }
            resolve(true);
        });
    }
}

// YOUR CODE BELOW
new Party();
