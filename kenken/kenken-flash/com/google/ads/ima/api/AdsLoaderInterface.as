package com.google.ads.ima.api {
    import flash.events.*;

    public interface AdsLoaderInterface extends IEventDispatcher {

        function requestAds(_arg1:AdsRequest, _arg2:Object=null):void;
        function contentComplete(_arg1:String=null):void;
        function get settings():ImaSdkSettings;
        function destroy():void;

    }
}//package com.google.ads.ima.api 
