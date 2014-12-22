package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.display.*;
    import com.google.ads.ima.wrappers.*;

    class AdsManagerWrapper extends EventDispatcherWrapper implements AdsManager {

        private static const PLAYER_VPAID_VERSION_1:String = "1.0.0";

        private var localAdsRenderingSettings:AdsRenderingSettings;

        public function AdsManagerWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function destroy():void{
            remoteInstance.destroy();
        }
        public function stop():void{
            remoteInstance.stop();
        }
        public function align(_arg1:String, _arg2:String):void{
            remoteInstance.align(_arg1, _arg2);
        }
        public function get adsRenderingSettings():AdsRenderingSettings{
            if (localAdsRenderingSettings == null){
                localAdsRenderingSettings = new AdsRenderingSettings();
            };
            if (remoteInstance.adsRenderingSettings != null){
                wrappers.copy(remoteInstance.adsRenderingSettings, localAdsRenderingSettings);
            };
            return (localAdsRenderingSettings);
        }
        public function init(_arg1:Number, _arg2:Number, _arg3:String, _arg4:Number=-2, _arg5:String=null, _arg6:String=null):void{
            remoteInstance.init(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6);
        }
        public function getUiElement(_arg1:String):InteractiveObject{
            return (remoteInstance.getUiElement(_arg1));
        }
        public function get cuePoints():Array{
            return (remoteInstance.cuePoints);
        }
        public function get volume():Number{
            return (remoteInstance.volume);
        }
        public function get linear():Boolean{
            return (remoteInstance.linear);
        }
        public function expand():void{
            remoteInstance.expand();
        }
        public function get uiElements():Array{
            return (remoteInstance.uiElements);
        }
        public function resume():void{
            remoteInstance.resume();
        }
        public function get adsContainer():DisplayObjectContainer{
            return (remoteInstance.adsContainer);
        }
        public function resize(_arg1:Number, _arg2:Number, _arg3:String):void{
            remoteInstance.resize(_arg1, _arg2, _arg3);
        }
        public function sendImpressionUrls():void{
            remoteInstance.sendImpressionUrls();
        }
        public function set volume(_arg1:Number):void{
            remoteInstance.volume = _arg1;
        }
        public function get expanded():Boolean{
            return (remoteInstance.expanded);
        }
        public function collapse():void{
            remoteInstance.collapse();
        }
        public function set uiElements(_arg1:Array):void{
            remoteInstance.uiElements = _arg1;
        }
        public function handshakeVersion(_arg1:String="1.0.0"):String{
            return (remoteInstance.handshakeVersion(_arg1));
        }
        public function start():void{
            remoteInstance.start();
        }
        public function get remainingTime():Number{
            return (remoteInstance.remainingTime);
        }
        public function load(_arg1:Object=null):void{
            remoteInstance.load(_arg1);
        }
        public function play(_arg1:Object=null):void{
            remoteInstance.play(_arg1);
        }
        public function pause():void{
            remoteInstance.pause();
        }
        public function get currentAd():Ad{
            return ((wrappers.remoteToLocal(remoteMethodResultsStore, remoteInstance.currentAd, localInstance) as Ad));
        }
        public function set adsRenderingSettings(_arg1:AdsRenderingSettings):void{
            localAdsRenderingSettings = _arg1;
            remoteInstance.adsRenderingSettings = wrappers.localToRemote(_arg1);
        }
        public function skip():Boolean{
            return (remoteInstance.skip());
        }

    }
}//package com.google.ads.ima.wrappers 
