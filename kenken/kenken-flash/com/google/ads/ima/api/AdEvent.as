﻿package com.google.ads.ima.api {
    import flash.events.*;

    public class AdEvent extends Event {

        public static const LOADED:String = "loaded";
        public static const CLICKED:String = "clicked";
        public static const IMPRESSION:String = "impression";
        public static const ALL_ADS_COMPLETED:String = "allAdsCompleted";
        public static const EXPANDED_CHANGED:String = "expandedChanged";
        public static const SKIPPED:String = "skipped";
        public static const SKIPPABLE_STATE_CHANGED:String = "skippableStateChanged";
        public static const LOG:String = "log";
        public static const CUSTOM_EVENT:String = "customEvent";
        public static const STOPPED:String = "stopped";
        public static const PAUSED:String = "paused";
        public static const COMPLETED:String = "completed";
        public static const VOLUME_UNMUTED:String = "volumeUnmuted";
        public static const RESUMED:String = "resumed";
        public static const FULLSCREEN:String = "fullScreen";
        public static const USER_ACCEPTED_INVITATION:String = "userAcceptedInvitation";
        public static const CONTENT_PAUSE_REQUESTED:String = "contentPauseRequested";
        public static const AD_METADATA:String = "adMetadata";
        public static const MIDPOINT:String = "midpoint";
        public static const FIRST_QUARTILE:String = "firstQuartile";
        public static const USER_CLOSED:String = "userClosed";
        public static const STARTED:String = "started";
        public static const CONTENT_RESUME_REQUESTED:String = "contentResumeRequested";
        public static const VOLUME_MUTED:String = "volumeMuted";
        public static const DURATION_CHANGED:String = "durationChanged";
        public static const REMAINING_TIME_CHANGED:String = "remainingTimeChanged";
        public static const VOLUME_CHANGED:String = "volumeChanged";
        public static const INTERACTION:String = "interaction";
        public static const USER_MINIMIZED:String = "userMinimized";
        public static const LINEAR_CHANGED:String = "linearChanged";
        public static const THIRD_QUARTILE:String = "thirdQuartile";

        private var adDataValue:Object;
        private var adValue:Ad;

        public function AdEvent(_arg1:String, _arg2:Ad, _arg3:Object=null){
            super(_arg1);
            adValue = _arg2;
            adDataValue = _arg3;
        }
        override public function clone():Event{
            return (new AdEvent(type, adValue, adDataValue));
        }
        public function get ad():Ad{
            return (adValue);
        }
        public function get adData():Object{
            return (adDataValue);
        }

    }
}//package com.google.ads.ima.api 
