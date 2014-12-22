package com.google.ads.ima.apidependency {
    import flash.net.*;
    import flash.system.*;
    import com.google.utils.*;

    public class TimedLoader extends SafeLoader {

        private var resourceLoadLogger:ResourceLoadLogger;

        public function TimedLoader(_arg1:ResourceLoadLogger=null){
            Trace.traceUncaughtErrors(this);
            if (_arg1 == null){
                _arg1 = new ResourceLoadLogger(contentLoaderInfo);
            };
            this.resourceLoadLogger = _arg1;
        }
        override public function load(_arg1:URLRequest, _arg2:LoaderContext=null):void{
            resourceLoadLogger.aboutToLoad(_arg1);
            doActualLoad(_arg1, _arg2);
        }
        protected function doActualLoad(_arg1:URLRequest, _arg2:LoaderContext=null):void{
            super.load(_arg1, _arg2);
        }

    }
}//package com.google.ads.ima.apidependency 
