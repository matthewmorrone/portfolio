package com.google.utils {
    import flash.utils.*;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;

    public class Trace {

        public static function debug(_arg1:String):void{
            trace("debug", _arg1);
            ExternalInterfaceUtils.makeExternalCall("console.debug", _arg1);
        }
        public static function traceObject(_arg1:Object, _arg2:String=""):void{
            Trace.info(buildObjectTrace(_arg1, _arg2));
        }
        public static function traceUncaughtErrors(_arg1:DisplayObject):void{
            addUncaughtErrorEventlistener(_arg1);
            if (_arg1.hasOwnProperty("loaderInfo")){
                addUncaughtErrorEventlistener(_arg1.loaderInfo);
            };
        }
        public static function error(_arg1:String):void{
            trace("error", _arg1);
            ExternalInterfaceUtils.makeExternalCall("console.error", _arg1);
        }
        private static function uncaughtErrorEventHandler(_arg1:Event):void{
            var _local3:Error;
            var _local2:String = ("Uncaught error: " + _arg1);
            if (_arg1.hasOwnProperty("error")){
                if ((_arg1["error"] is Error)){
                    _local3 = (_arg1["error"] as Error);
                    _local2 = ("Uncaught error: " + _local3);
                } else {
                    _local2 = ("Uncaught error: " + _arg1["error"]);
                };
            };
            if (Capabilities.isDebugger){
                Trace.error(_local2);
            } else {
                Trace.error(((_local2 + "\n") + "Use debug flash player to get full trace"));
            };
        }
        private static function addUncaughtErrorEventlistener(_arg1:EventDispatcher):void{
            if (((_arg1) && (_arg1.hasOwnProperty("uncaughtErrorEvents")))){
                Object(_arg1).uncaughtErrorEvents.addEventListener("uncaughtError", uncaughtErrorEventHandler, false, 0, true);
            };
        }
        public static function warning(_arg1:String):void{
            trace("warning", _arg1);
            ExternalInterfaceUtils.makeExternalCall("console.warning", _arg1);
        }
        public static function info(_arg1:String):void{
            trace("info", _arg1);
            ExternalInterfaceUtils.makeExternalCall("console.info", _arg1);
        }
        public static function buildObjectTrace(_arg1:Object, _arg2:String=""):String{
            var _local4:String;
            var _local3 = "";
            for (_local4 in _arg1) {
                if (typeof(_arg1[_local4]) == "object"){
                    _local3 = (_local3 + ((((_arg2 + _local4) + ": [") + getQualifiedClassName(_arg1[_local4])) + "]\n"));
                    _local3 = (_local3 + buildObjectTrace(_arg1[_local4], ("  " + _arg2)));
                } else {
                    _local3 = (_local3 + ((((_arg2 + _local4) + ": ") + _arg1[_local4]) + "\n"));
                };
            };
            return (_local3);
        }

    }
}//package com.google.utils 
