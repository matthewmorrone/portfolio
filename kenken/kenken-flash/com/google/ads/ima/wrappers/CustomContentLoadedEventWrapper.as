package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.events.*;
    import com.google.ads.ima.wrappers.*;

    class CustomContentLoadedEventWrapper extends CustomContentLoadedEvent {

        private var localInstance:Object;
        private var wrappersValue:Wrappers;
        private var remoteInstance:Object;

        public function CustomContentLoadedEventWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            this.remoteInstance = _arg2;
            this.localInstance = _arg3;
            wrappersValue = _arg1;
            super(_arg2.ima_internal_api::getCustomContentAd());
        }
        override public function displayCompanions():void{
            remoteInstance.displayCompanions();
        }
        override public function get content():String{
            return (remoteInstance.content);
        }
        override public function get userRequestContext():Object{
            return (remoteInstance.userRequestContext);
        }
        override public function clone():Event{
            return (new CustomContentLoadedEventWrapper(wrappersValue, remoteInstance, localInstance));
        }

    }
}//package com.google.ads.ima.wrappers 
