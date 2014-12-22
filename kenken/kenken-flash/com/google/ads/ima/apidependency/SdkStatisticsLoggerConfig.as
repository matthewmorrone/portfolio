package com.google.ads.ima.apidependency {
    import flash.utils.*;

    public class SdkStatisticsLoggerConfig {

        private var logPercentValue:Number;
        private var loggablePointsValue:Dictionary;

        public function SdkStatisticsLoggerConfig(_arg1:XML){
            loggablePointsValue = new Dictionary();
            parse(_arg1);
        }
        private function parseIds(_arg1:XMLList, _arg2:Boolean):void{
            var _local3:XML;
            var _local4:Array;
            var _local5:String;
            var _local6:uint;
            var _local7:LoggablePoint;
            for each (_local3 in _arg1) {
                _local4 = _local3.toString().split(",");
                if (_local4.length > 0){
                    for each (_local5 in _local4) {
                        _local6 = parseInt(_local5);
                        if (loggablePoints[_local6] == null){
                            _local7 = new LoggablePoint(_local6, _arg2, (_local3.@logAlways == "true"), _local3.@cexp);
                            loggablePoints[_local6] = _local7;
                        };
                    };
                };
            };
        }
        public function get loggablePoints():Dictionary{
            return (loggablePointsValue);
        }
        public function get logPercent():Number{
            return (logPercentValue);
        }
        private function parse(_arg1:XML):void{
            var logConfig:* = _arg1;
            try {
                logPercentValue = parseFloat(logConfig.@p);
                parseIds(logConfig.Youtube.Ids, true);
                parseIds(logConfig.All.Ids, false);
            } catch(error:Error) {
            };
        }

    }
}//package com.google.ads.ima.apidependency 
