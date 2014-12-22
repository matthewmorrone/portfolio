package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import com.google.ads.ima.wrappers.*;

    class AdWrapper extends Wrapper implements Ad {

        public function AdWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function call(_arg1:String, ... _args):void{
            _args.unshift(_arg1);
            remoteInstance.call.apply(remoteInstance, _args);
        }
        public function getCompanionAds(_arg1:String, _arg2:Number, _arg3:Number, _arg4:CompanionAdSelectionSettings=null):Array{
            return ((wrappers.remoteToLocal(remoteMethodResultsStore, remoteInstance.getCompanionAds(_arg1, _arg2, _arg3, wrappers.localToRemote(_arg4)), localInstance) as Array));
        }
        public function reportEvents():void{
            remoteInstance.reportEvents();
        }
        public function get width():Number{
            return (remoteInstance.width);
        }
        public function reportCustomKeysAndValues(_arg1:Dictionary):void{
            remoteInstance.reportCustomKeysAndValues(_arg1);
        }
        public function get wrapperAdIds():Array{
            return (remoteInstance.wrapperAdIds);
        }
        public function get skippable():Boolean{
            return (remoteInstance.skippable);
        }
        public function get isci():String{
            return (remoteInstance.isci);
        }
        public function get duration():Number{
            return (remoteInstance.duration);
        }
        public function getCompanionAdUrl(_arg1:String, _arg2:String=null):String{
            return (remoteInstance.getCompanionAdUrl(_arg1, _arg2));
        }
        public function get id():String{
            return (remoteInstance.id);
        }
        public function get traffickingParameters():Dictionary{
            return (remoteInstance.traffickingParameters);
        }
        public function get title():String{
            return (remoteInstance.title);
        }
        public function get height():Number{
            return (remoteInstance.height);
        }
        public function get traffickingParametersAsString():String{
            return (remoteInstance.traffickingParametersAsString);
        }
        public function get adSkippableState():Boolean{
            return (remoteInstance.adSkippableState);
        }
        public function get linear():Boolean{
            return (remoteInstance.linear);
        }
        public function get currentTime():Number{
            return (remoteInstance.currentTime);
        }
        public function get wrapperAdSystems():Array{
            return (remoteInstance.wrapperAdSystems);
        }
        public function get adPodInfo():AdPodInfo{
            return ((wrappers.remoteToLocal(remoteMethodResultsStore, remoteInstance.adPodInfo) as AdPodInfo));
        }
        public function get adSystem():String{
            return (remoteInstance.adSystem);
        }
        public function get mediaUrl():String{
            return (remoteInstance.mediaUrl);
        }
        public function enableManualEventsReporting():void{
            remoteInstance.enableManualEventsReporting();
        }
        public function get surveyUrl():String{
            return (remoteInstance.surveyUrl);
        }

    }
}//package com.google.ads.ima.wrappers 
