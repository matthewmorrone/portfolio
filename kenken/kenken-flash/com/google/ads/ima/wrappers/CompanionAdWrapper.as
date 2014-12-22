package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import com.google.ads.ima.wrappers.*;

    class CompanionAdWrapper extends Wrapper implements CompanionAd {

        public function CompanionAdWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function get environment():String{
            return (remoteInstance.environment);
        }
        public function get isBackfill():Boolean{
            return (remoteInstance.isBackfill);
        }

    }
}//package com.google.ads.ima.wrappers 
