package com.google.ads.ima.api {
    import flash.system.*;
    import flash.events.*;

    public class AdErrorEvent extends ErrorEvent {

        private static const DEBUG_PLAYER_RECOMMENDED:String = "Use Flash debug player to see stack trace for the error.";
        public static const AD_ERROR:String = "adError";

        private var adError:AdError;
        private var userRequestContextObject:Object = null;

        public function AdErrorEvent(_arg1:AdError, _arg2:Object=null){
            super(AD_ERROR);
            this.adError = _arg1;
            if (_arg1){
                this.text = _arg1.errorMessage;
                if (_arg1.innerError){
                    if (_arg1.innerError.getStackTrace()){
                        this.text = (this.text + ("\n" + _arg1.innerError.getStackTrace()));
                    } else {
                        if (!Capabilities.isDebugger){
                            this.text = (this.text + ("\n" + DEBUG_PLAYER_RECOMMENDED));
                        };
                    };
                };
            };
            this.userRequestContextObject = _arg2;
        }
        public function get error():AdError{
            return (adError);
        }
        public function get userRequestContext():Object{
            return (userRequestContextObject);
        }
        override public function clone():Event{
            return (new AdErrorEvent(adError, userRequestContextObject));
        }

    }
}//package com.google.ads.ima.api 
