package com.google.ads.ima.apidependency {
    import flash.utils.*;
    import flash.net.*;
    import flash.events.*;
    import com.google.utils.timer.*;

    public class ResourceLoadTracker extends EventDispatcher {

        public static const LOAD_TIMEOUT_EVENT:String = "loadTimeoutEvent";
        private static const DEFAULT_LOAD_TIMEOUT_MS:int = 8000;

        protected var request:URLRequest;
        protected var resourceLoaderValue:EventDispatcher;
        public var loadTimeout:int = 8000;
        private var loadTimer:Timer;

        public function ResourceLoadTracker(_arg1:EventDispatcher, _arg2:int){
            resourceLoaderValue = _arg1;
            if (_arg2 > 0){
                loadTimeout = _arg2;
            };
        }
        protected function errorHandler(_arg1:ErrorEvent):void{
            destroy();
        }
        protected function addEventListeners():void{
            resourceLoaderValue.addEventListener(Event.COMPLETE, completeHandler);
            resourceLoaderValue.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            resourceLoaderValue.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        }
        protected function removeEventListeners():void{
            resourceLoaderValue.removeEventListener(Event.COMPLETE, completeHandler);
            resourceLoaderValue.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            resourceLoaderValue.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
        }
        protected function destroyLoadTimer():void{
            if (loadTimer != null){
                loadTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, loadTimeoutHandler);
                loadTimer.stop();
                loadTimer = null;
            };
        }
        public function aboutToLoad(_arg1:URLRequest):void{
            this.request = _arg1;
            destroy();
            addEventListeners();
            startLoadTimer(loadTimeout);
        }
        protected function loadTimeoutHandler(_arg1:TimerEvent):void{
            dispatchEvent(new Event(LOAD_TIMEOUT_EVENT));
            destroy();
        }
        protected function completeHandler(_arg1:Event):void{
            destroy();
        }
        protected function destroy():void{
            removeEventListeners();
            destroyLoadTimer();
        }
        protected function startLoadTimer(_arg1:int):void{
            destroyLoadTimer();
            loadTimer = TimerFactory.createTimer(_arg1, 1);
            loadTimer.addEventListener(TimerEvent.TIMER_COMPLETE, loadTimeoutHandler);
            loadTimer.start();
        }

    }
}//package com.google.ads.ima.apidependency 
