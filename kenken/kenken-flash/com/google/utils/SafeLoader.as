package com.google.utils {
    import flash.utils.*;
    import flash.system.*;
    import flash.display.*;

    public class SafeLoader extends Loader {

        public static var uncaughtErrorEventHandler:Function;

        public function SafeLoader(){
            if (((!((uncaughtErrorEventHandler == null))) && (hasOwnProperty("uncaughtErrorEvents")))){
                Object(this).uncaughtErrorEvents.addEventListener("uncaughtError", uncaughtErrorEventHandler, false, -1);
            };
        }
        override public function loadBytes(_arg1:ByteArray, _arg2:LoaderContext=null):void{
            throw (new SecurityError());
        }

    }
}//package com.google.utils 
