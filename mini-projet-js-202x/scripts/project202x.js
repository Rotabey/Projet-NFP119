// YOUR NAME HERE
//J-Baptiste Cherrier

class Party {
    static TARGET_WIDTH = 40;
    static TARGET_HEIGHT = 40;

    constructor() {
        this.nbTarget = 0;

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
        this.bindCreateTarget();
        this.bindStartParty();
    }

    bindCreateTarget(){
        this.byId('create').addEventListener('click', () => {
            this.generateTarget(1);
        });
    }

    bindStartParty(){
        this.byId('start').addEventListener('click', () => {
            this.startParty();
        });
    }

    startParty() {
        console.log(this.nbTarget);
        if(parseInt(this.nbTarget) > 0){
            console.log('ici');
            this.removeAllTarget();
        }
        this.nbTarget = this.byId('nbtargets').value;
        this.generateTarget();
        this.byId('remaining').textContent = this.nbTarget;
    }

    generateTarget(){
        let terrain = this.byId('terrain');
        for(let i = 0; i < this.nbTarget; i++){
            let target = document.createElement('div');
            target.classList = 'target';
            target.classList.add('on');
            target.style.zIndex = i;
            target.style.left = Math.floor(Math.random() * 350) + 'px';
            target.style.top = Math.floor(Math.random() * 350)  + 'px';
            terrain.appendChild(target);
            target.addEventListener('click', () => {
                target.remove();
            });
        }
    }

    removeAllTarget(){
        return new Promise(() => {
            let target_list = document.getElementsByClassName('target');
            console.log(target_list);
            for(let targ of target_list){
                targ.remove();
            }
            return true;
        });
    }
}

// YOUR CODE BELOW
new Party();