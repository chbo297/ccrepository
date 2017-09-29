var UIManager = pc.createScript('UIManager');


UIManager.prototype.initialize =  function(){

            var app = this.app;
            var manager = app.root.findByName("Manager");
            this.gamemanager = manager.script.GameStateManager;
            this.pathmanager = manager.script.PathManager;
            var curcamera = app.root.findByName("Camera");
            this.camerafollow = curcamera.script.CameraFollow;
            var player = app.root.findByName("player");
            this.playercontrol = player.script.PlayerControl;

            this.showEndUI = false;

            var div = document.createElement("div");

            div.innerHTML =

                            "<p id = 'score'>0</p>";

            document.body.appendChild(div);

           var style = document.createElement("style");

           style.innerHTML =
                            "#score{position: absolute;width: 100%;top: 5%;color: #ffffff;font-size: 40px; font-family: initial;text-align: center;display:none;}"+
                            "@media screen and (max-width : 320px) { #score{ font-size:3.3em;}}";
           document.head.appendChild(style);


           var self = this;
           var again = document.getElementById("loadscene");
           var start = document.getElementById("start");
           this.score = document.getElementById("score");

           again.addEventListener('click',function(event){



               self.score.innerHTML = "0";
               self.camerafollow.Init();
               self.pathmanager.Init();
               self.playercontrol.Init();
               self.gamemanager.Init();
               self.Init();
           });


           start.addEventListener('click',function(event){

               self.gamemanager.start = true;
               self.playercontrol.tips.enabled = true;
               self.gamemanager.GameStart();
               self.score.style.display = "block";
           });

            this.losetimer = 0;


};

        // Called every frame, dt is time in seconds since last update
UIManager.prototype.update =  function (dt) {
           if(this.gamemanager.lose)
           {
               this.losetimer +=dt;
               if(this.losetimer >1.2 && !this.showEndUI)
               {
                   this.gamemanager.GameEnd();
                   this.showEndUI = true;
               }
           }

};

UIManager.prototype.Init = function(){
            this.losetimer = 0;
            this.showEndUI = false;
};


