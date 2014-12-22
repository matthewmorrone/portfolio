package com.google.ads.ima.apidependency {
    import flash.utils.*;
    import flash.events.*;

    public class ResourceLoadLogger extends ResourceLoadTracker {

        private static var MAX_REPORTED_URL_LENGTH:int = 100;

        private var receivedEvents:Array;

        public function ResourceLoadLogger(_arg1:EventDispatcher, _arg2:int=-1){
            receivedEvents = [];
            super(_arg1, _arg2);
        }
        public static function formatEventsData(_arg1:String, _arg2:Array):String{
            var _local3:String = _arg1;
            if (_arg2.length > 0){
                _local3 = (_local3 + ("_" + _arg2.join(",")));
            };
            return ((_local3 + ";"));
        }

        override protected function destroy():void{
            receivedEvents = [];
            super.destroy();
        }
        override protected function errorHandler(_arg1:ErrorEvent):void{
            var _local2:Dictionary = createCommonReportableValues();
            _local2[SdkStatisticsLoggerImpl.REPORT_KEY_ERROR_EVENT_TEXT] = _arg1.text;
            SdkStatisticsLoggerImpl.instance.reportError(LogIds.ResourceLoadLogger_errorHandler, null, _local2);
            super.errorHandler(_arg1);
        }
        private function getReceivedEvent(_arg1:String):Object{
            var _local2:Object;
            for each (_local2 in receivedEvents) {
                if (_local2.eventType == _arg1){
                    return (_local2);
                };
            };
            return (null);
        }
        private function progressEventHandler(_arg1:ProgressEvent):void{
            recordReceivedEvent(_arg1.type);
        }
        override protected function addEventListeners():void{
            super.addEventListeners();
            resourceLoaderValue.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusEventHandler);
            resourceLoaderValue.addEventListener(Event.OPEN, openEventHandler);
            resourceLoaderValue.addEventListener(ProgressEvent.PROGRESS, progressEventHandler);
        }
        private function recordReceivedEvent(_arg1:String, _arg2:Array=null):void{
            if (_arg2 == null){
                _arg2 = [];
            };
            var _local3:Object = getReceivedEvent(_arg1);
            if (_local3 == null){
                receivedEvents.push({
                    eventType:_arg1,
                    eventData:_arg2
                });
            } else {
                _local3.eventData = _local3.eventData.concat(_arg2);
            };
        }
        override protected function removeEventListeners():void{
            resourceLoaderValue.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusEventHandler);
            resourceLoaderValue.removeEventListener(Event.OPEN, openEventHandler);
            resourceLoaderValue.removeEventListener(ProgressEvent.PROGRESS, progressEventHandler);
        }
        private function httpStatusEventHandler(_arg1:HTTPStatusEvent):void{
            var _local2:Array = [];
            _local2.push(_arg1.status);
            recordReceivedEvent(_arg1.type, _local2);
        }
        override protected function loadTimeoutHandler(_arg1:TimerEvent):void{
            logTimeout();
            super.loadTimeoutHandler(_arg1);
        }
        private function createCommonReportableValues():Dictionary{
            var _local3:Object;
            var _local1:Dictionary = new Dictionary();
            var _local2 = "";
            for each (_local3 in receivedEvents) {
                _local2 = (_local2 + formatEventsData(_local3.eventType, _local3.eventData));
            };
            if (_local2 != ""){
                _local1[SdkStatisticsLoggerImpl.REPORT_KEY_EVENTS] = _local2;
            };
            _local1[SdkStatisticsLoggerImpl.REPORT_KEY_ERROR_URL] = request.url.substr(0, MAX_REPORTED_URL_LENGTH);
            return (_local1);
        }
        private function openEventHandler(_arg1:Event):void{
            recordReceivedEvent(_arg1.type);
        }
        private function logTimeout():void{
            var _local1:Dictionary = createCommonReportableValues();
            SdkStatisticsLoggerImpl.instance.reportError(LogIds.ResourceLoadLogger_logTimeout, null, _local1);
        }

    }
}//package com.google.ads.ima.apidependency 
