package com.google.ads.ima.api {
    import flash.utils.*;

    public interface Ad {

        function reportCustomKeysAndValues(_arg1:Dictionary):void;
        function getCompanionAds(_arg1:String, _arg2:Number, _arg3:Number, _arg4:CompanionAdSelectionSettings=null):Array;
        function get wrapperAdIds():Array;
        function get width():Number;
        function get isci():String;
        function get duration():Number;
        function getCompanionAdUrl(_arg1:String, _arg2:String=null):String;
        function get title():String;
        function get id():String;
        function call(_arg1:String, ... _args):void;
        function get traffickingParametersAsString():String;
        function get linear():Boolean;
        function get currentTime():Number;
        function get height():Number;
        function get adSkippableState():Boolean;
        function get skippable():Boolean;
        function enableManualEventsReporting():void;
        function reportEvents():void;
        function get wrapperAdSystems():Array;
        function get adPodInfo():AdPodInfo;
        function get adSystem():String;
        function get surveyUrl():String;
        function get traffickingParameters():Dictionary;
        function get mediaUrl():String;

    }
}//package com.google.ads.ima.api 
