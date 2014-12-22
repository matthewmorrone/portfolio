package com.google.ads.ima.apidependency {
    import com.google.ads.ima.api.*;
    import flash.utils.*;

    public class BufferedSdkStatisticsLoggerImpl implements SdkStatisticsLogger {

        private var methodCallsAndArguments:Array;

        public function BufferedSdkStatisticsLoggerImpl(){
            methodCallsAndArguments = [];
        }
        public function get loggingEnabled():Boolean{
            throw (new Error("Dummy method to satisfy API contract, do not use it."));
        }
        public function set loggingEnabled(_arg1:Boolean):void{
            throw (new Error("Dummy method to satisfy API contract, do not use it."));
        }
        public function get logPercent():uint{
            throw (new Error("Dummy method to satisfy API contract, do not use it."));
        }
        public function reportApi(_arg1:uint, _arg2:Dictionary=null):void{
            store("reportApi", arguments);
        }
        public function setPersistentProperty(_arg1:String, _arg2:Object):void{
            store("setPersistentProperty", arguments);
        }
        private function store(_arg1:String, _arg2:Object):void{
            methodCallsAndArguments.push({
                methodName:_arg1,
                args:_arg2
            });
        }
        public function reportAdError(_arg1:uint, _arg2:String, _arg3:AdError, _arg4:Dictionary=null):void{
            store("reportAdError", arguments);
        }
        public function reportError(_arg1:uint, _arg2:String, _arg3:Dictionary=null):void{
            store("reportError", arguments);
        }
        public function executeStoredMethodsOn(_arg1:SdkStatisticsLogger):void{
            var _local2:Object;
            for each (_local2 in methodCallsAndArguments) {
                _arg1[_local2.methodName].apply(_arg1, _local2.args);
            };
            methodCallsAndArguments = [];
        }
        public function report(_arg1:uint, _arg2:String=null, _arg3:Dictionary=null):void{
            store("report", arguments);
        }

    }
}//package com.google.ads.ima.apidependency 
