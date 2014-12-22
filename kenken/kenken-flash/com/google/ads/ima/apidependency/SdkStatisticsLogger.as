package com.google.ads.ima.apidependency {
    import com.google.ads.ima.api.*;
    import flash.utils.*;

    public interface SdkStatisticsLogger {

        function reportAdError(_arg1:uint, _arg2:String, _arg3:AdError, _arg4:Dictionary=null):void;
        function get loggingEnabled():Boolean;
        function reportError(_arg1:uint, _arg2:String, _arg3:Dictionary=null):void;
        function report(_arg1:uint, _arg2:String=null, _arg3:Dictionary=null):void;
        function reportApi(_arg1:uint, _arg2:Dictionary=null):void;
        function get logPercent():uint;
        function set loggingEnabled(_arg1:Boolean):void;
        function setPersistentProperty(_arg1:String, _arg2:Object):void;

    }
}//package com.google.ads.ima.apidependency 
