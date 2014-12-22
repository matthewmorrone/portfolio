package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.events.*;
    import com.google.ads.ima.wrappers.*;

    class AdEventWrapper extends AdEvent {

        private var localInstance:Object;
        private var wrappersValue:Wrappers;
        private var remoteMethodResultsStore:Dictionary;
        private var remoteInstance:Object;

        public function AdEventWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            remoteMethodResultsStore = new Dictionary();
            this.remoteInstance = _arg2;
            this.localInstance = _arg3;
            wrappersValue = _arg1;
            super(_arg2.type, (_arg1.remoteToLocal(remoteMethodResultsStore, _arg2.ad, localInstance) as Ad), _arg2.adData);
        }
        override public function clone():Event{
            return (new AdEventWrapper(wrappersValue, remoteInstance, localInstance));
        }

    }
}//package com.google.ads.ima.wrappers 
