package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;

    public class ImaSdkSettingsWrapper extends Wrapper implements ImaSdkSettings, DelayedRemoteInstance {

        private var delayedMethods:Array;

        public function ImaSdkSettingsWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
            delayedMethods = [];
        }
        public function set numRedirects(_arg1:uint):void{
            if (remoteInstance == null){
                delayedMethods.push(delayMethod(arguments.callee, arguments));
            } else {
                remoteInstance.numRedirects = _arg1;
            };
        }
        private function delayMethod(_arg1:Function, _arg2:Array):Function{
            var scope:* = null;
            var method:* = _arg1;
            var args:* = _arg2;
            scope = this;
            return (function ():void{
                method.apply(scope, args);
            });
        }
        public function set enableUiRegistry(_arg1:Boolean):void{
            if (remoteInstance == null){
                delayedMethods.push(delayMethod(arguments.callee, arguments));
            } else {
                remoteInstance.enableUiRegistry = _arg1;
            };
        }
        public function set uniqueAds(_arg1:Boolean):void{
            if (remoteInstance == null){
                delayedMethods.push(delayMethod(arguments.callee, arguments));
            } else {
                remoteInstance.uniqueAds = _arg1;
            };
        }
        public function invokeDelayedMethods(_arg1:Object):void{
            var _local2:Function;
            super.remoteInstance = _arg1;
            for each (_local2 in delayedMethods) {
                _local2();
            };
        }
        public function set companionBackfill(_arg1:String):void{
            if (remoteInstance == null){
                delayedMethods.push(delayMethod(arguments.callee, arguments));
            } else {
                remoteInstance.companionBackfill = _arg1;
            };
        }
        public function set competitiveExclusion(_arg1:String):void{
            if (remoteInstance == null){
                delayedMethods.push(delayMethod(arguments.callee, arguments));
            } else {
                remoteInstance.competitiveExclusion = _arg1;
            };
        }

    }
}//package com.google.ads.ima.wrappers 
