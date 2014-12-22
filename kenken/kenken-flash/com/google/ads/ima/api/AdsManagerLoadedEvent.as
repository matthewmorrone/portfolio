package com.google.ads.ima.api {
    import flash.display.*;
    import flash.events.*;

    public class AdsManagerLoadedEvent extends Event {

        public static const ADS_MANAGER_LOADED:String = "adsManagerLoaded";

        private var adsManagerCreatorValue:Function;
        private var userRequestContextValue:Object;

        public function AdsManagerLoadedEvent(_arg1:Function, _arg2:Object, _arg3:String="adsManagerLoaded"){
            super(_arg3);
            adsManagerCreatorValue = _arg1;
            userRequestContextValue = _arg2;
        }
        public function getAdsManager(_arg1:Object=null, _arg2:AdsRenderingSettings=null, _arg3:Object=null):AdsManager{
            var contentPlayback = _arg1;
            var adsRenderingSettings = _arg2;
            var publisherVideoAdPlayback = _arg3;
            if (contentPlayback == null){
                contentPlayback = {time:function ():Number{
                        return (0);
                    }};
            };
            if (adsRenderingSettings == null){
                adsRenderingSettings = new AdsRenderingSettings();
            };
            return ((adsManagerCreatorValue(new Sprite(), contentPlayback, adsRenderingSettings, publisherVideoAdPlayback) as AdsManager));
        }
        ima_internal_api function getAdsManagerCreator():Function{
            return (adsManagerCreatorValue);
        }
        public function get userRequestContext():Object{
            return (userRequestContextValue);
        }
        override public function clone():Event{
            return (new AdsManagerLoadedEvent(adsManagerCreatorValue, userRequestContext));
        }

    }
}//package com.google.ads.ima.api 
