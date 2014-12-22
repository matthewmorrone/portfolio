package com.google.analytics {
    import com.google.analytics.v4.*;
    import com.google.analytics.debug.*;
    import flash.events.*;

    public interface AnalyticsTracker extends GoogleAnalyticsAPI, IEventDispatcher {

        function set account(_arg1:String):void;
        function get config():Configuration;
        function get mode():String;
        function set config(_arg1:Configuration):void;
        function set mode(_arg1:String):void;
        function set debug(_arg1:DebugConfiguration):void;
        function get visualDebug():Boolean;
        function get account():String;
        function set visualDebug(_arg1:Boolean):void;
        function isReady():Boolean;
        function get debug():DebugConfiguration;

    }
}//package com.google.analytics 
