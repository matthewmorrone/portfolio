package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import com.google.ads.ima.wrappers.*;

    class HtmlCompanionAdWrapper extends Wrapper implements HtmlCompanionAd {

        public function HtmlCompanionAdWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function get content():String{
            return (remoteInstance.content);
        }
        public function get environment():String{
            return (remoteInstance.environment);
        }
        public function get isBackfill():Boolean{
            return (remoteInstance.isBackfill);
        }

    }
}//package com.google.ads.ima.wrappers 
