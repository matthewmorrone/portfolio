package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.display.*;
    import com.google.ads.ima.wrappers.*;

    class FlashCompanionAdWrapper extends Wrapper implements FlashCompanionAd {

        public function FlashCompanionAdWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function destroy():void{
            remoteInstance.destroy();
        }
        public function start():void{
            remoteInstance.start();
        }
        public function init():void{
            remoteInstance.init();
        }
        public function get adsContainer():DisplayObjectContainer{
            return (remoteInstance.adsContainer);
        }
        public function get isBackfill():Boolean{
            return (remoteInstance.isBackfill);
        }
        public function get environment():String{
            return (remoteInstance.environment);
        }

    }
}//package com.google.ads.ima.wrappers 
