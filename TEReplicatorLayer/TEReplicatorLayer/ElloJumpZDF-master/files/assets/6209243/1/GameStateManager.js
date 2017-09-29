var GameStateManager = pc.createScript('GameStateManager');

GameStateManager.prototype.initialize = function () {
            //needInit
            var app = this.app;
            this.start = false;
            this.lose = false;
            this.taplose = false;
            this.timeoutlose = false;
            this.startgame = false;
            var player = app.root.findByName("player");
            this.playercontrol = player.script.PlayerControl;

            this.playtimer = 0;
            //initHandle();
};

        // Called every frame, dt is time in seconds since last update
GameStateManager.prototype.update = function (dt) {
            if(!this.startgame || this.lose)
            {
                return;
            }

            this.playtimer += dt;

};

GameStateManager.prototype.GameStartGame = function(){

            console.log('PlayGame');
};

GameStateManager.prototype.GameStart = function(){
            console.log("GameStart");

            //startHandle();
};

GameStateManager.prototype.GameEnd = function(){
            console.log("GameEnd");
            var scoreinfo={"score":this.playercontrol.score,'coin':this.playercontrol.coins};
            console.log(JSON.stringify(scoreinfo));
            $('.endPage').fadeIn();
};

GameStateManager.prototype.Init = function(){
            this.start = false;
            this.lose = false;
            this.taplose = false;
            this.timeoutlose = false;
            this.startgame = false;
            this.playtimer = 0;
            //resetHandle();
};
