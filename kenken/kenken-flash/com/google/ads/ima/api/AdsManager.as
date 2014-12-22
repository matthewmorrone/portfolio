package com.google.ads.ima.api {
    import flash.display.*;
    import flash.events.*;

    public interface AdsManager extends IEventDispatcher {

        function handshakeVersion(_arg1:String="1.0"):String;
        function start():void;
        function get remainingTime():Number;
        function get linear():Boolean;
        function get volume():Number;
        function stop():void;
        function getUiElement(_arg1:String):InteractiveObject;
        function get uiElements():Array;
        function resume():void;
        function get cuePoints():Array;
        function init(_arg1:Number, _arg2:Number, _arg3:String, _arg4:Number=-2, _arg5:String=null, _arg6:String=null):void;
        function get adsContainer():DisplayObjectContainer;
        function destroy():void;
        function resize(_arg1:Number, _arg2:Number, _arg3:String):void;
        function sendImpressionUrls():void;
        function set uiElements(_arg1:Array):void;
        function get expanded():Boolean;
        function expand():void;
        function set volume(_arg1:Number):void;
        function collapse():void;
        function pause():void;
        function get currentAd():Ad;
        function skip():Boolean;

    }
}//package com.google.ads.ima.api 
