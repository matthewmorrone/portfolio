package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.events.*;
    import com.google.ads.ima.wrappers.*;

    class AdErrorEventWrapper extends AdErrorEvent {

        private var localInstance:Object;
        private var wrappersValue:Wrappers;
        private var remoteMethodResultsStore:Dictionary;
        private var remoteInstance:Object;

        public function AdErrorEventWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            remoteMethodResultsStore = new Dictionary();
            this.remoteInstance = _arg2;
            this.localInstance = _arg3;
            wrappersValue = _arg1;
            super((_arg1.remoteToLocal(remoteMethodResultsStore, _arg2.error, localInstance) as AdError), _arg2.userRequestContext);
        }
        override public function clone():Event{
            return (new AdErrorEventWrapper(wrappersValue, remoteInstance, localInstance));
        }

    }
}//package com.google.ads.ima.wrappers 
