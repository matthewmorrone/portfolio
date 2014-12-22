package com.google.utils {
    import flash.external.*;

    public class ExternalInterfaceUtils {

        public static function executeJavascriptFunction(_arg1:String):Object{
            var jsFunctionCode:* = _arg1;
            try {
                if (ExternalInterface.available){
                    return ((ExternalInterface.call(jsFunctionCode) as Object));
                };
            } catch(error:SecurityError) {
            };
            return (null);
        }
        public static function getUserAgent():String{
            return ((makeExternalCall("navigator.userAgent.toString") as String));
        }
        public static function exposeFunctionToJavascript(_arg1:String, _arg2:Function):void{
            var functionName:* = _arg1;
            var closure:* = _arg2;
            try {
                if (ExternalInterface.available){
                    ExternalInterface.addCallback(functionName, closure);
                };
            } catch(error:SecurityError) {
            };
        }
        public static function makeExternalCall(_arg1:String, ... _args):Object{
            var functionName:* = _arg1;
            var args:* = _args;
            try {
                if (ExternalInterface.available){
                    args.unshift(functionName);
                    return ((ExternalInterface.call.apply(null, args) as Object));
                };
            } catch(error:SecurityError) {
            };
            return (null);
        }

    }
}//package com.google.utils 
