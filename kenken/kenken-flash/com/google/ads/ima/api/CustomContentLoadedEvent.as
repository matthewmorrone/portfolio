package com.google.ads.ima.api {
    import flash.events.*;

    public class CustomContentLoadedEvent extends Event {

        public static var CUSTOM_CONTENT_LOADED:String = "customContentLoaded";

        private var userRequestContextValue:Object;
        private var customContentAdValue:Object;

        public function CustomContentLoadedEvent(_arg1:Object, _arg2:Object=null){
            super(CUSTOM_CONTENT_LOADED);
            customContentAdValue = _arg1;
            userRequestContextValue = _arg2;
        }
        public function displayCompanions():void{
            customContentAdValue.displayCompanions();
        }
        public function get userRequestContext():Object{
            return (userRequestContextValue);
        }
        override public function clone():Event{
            return (new CustomContentLoadedEvent(customContentAdValue, userRequestContextValue));
        }
        ima_internal_api function getCustomContentAd():Object{
            return (customContentAdValue);
        }
        public function get content():String{
            return (customContentAdValue.content);
        }

    }
}//package com.google.ads.ima.api 
