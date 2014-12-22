package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.events.*;
    import com.google.ads.ima.wrappers.*;

    class AdsManagerLoadedEventWrapper extends AdsManagerLoadedEvent {

        private var localInstance:Object;
        private var wrappersValue:Wrappers;
        private var remoteMethodResultsStore:Dictionary;
        private var remoteInstance:Object;

        public function AdsManagerLoadedEventWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            remoteMethodResultsStore = new Dictionary();
            this.remoteInstance = _arg2;
            this.localInstance = _arg3;
            wrappersValue = _arg1;
            super(_arg2.ima_internal_api::getAdsManagerCreator(), _arg2.userRequestContext, _arg2.type);
        }
        override public function getAdsManager(_arg1:Object=null, _arg2:AdsRenderingSettings=null, _arg3:Object=null):AdsManager{
            var errorWrapper:* = null;
            var contentPlayback = _arg1;
            var adsRenderingSettings = _arg2;
            var videoAdPlayback = _arg3;
            try {
                return ((wrappersValue.remoteToLocal(remoteMethodResultsStore, remoteInstance.getAdsManager(contentPlayback, wrappersValue.localToRemote(adsRenderingSettings), videoAdPlayback)) as AdsManager));
            } catch(error:Error) {
                errorWrapper = (wrappersValue.remoteToLocal(remoteMethodResultsStore, error) as AdErrorWrapper);
                if (errorWrapper != null){
                    throw (errorWrapper);
                };
                throw (error);
            };
            return (null);
        }
        override public function clone():Event{
            return (new AdsManagerLoadedEventWrapper(wrappersValue, remoteInstance, localInstance));
        }
        override public function get userRequestContext():Object{
            return (remoteInstance.userRequestContext);
        }

    }
}//package com.google.ads.ima.wrappers 
