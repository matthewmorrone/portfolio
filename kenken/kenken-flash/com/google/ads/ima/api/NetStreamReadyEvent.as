package com.google.ads.ima.api {
    import flash.net.*;
    import flash.events.*;

    public class NetStreamReadyEvent extends AdEvent {

        public static const NETSTREAM_READY:String = "netStreamReady";

        private var netStreamInstance:NetStream = null;

        public function NetStreamReadyEvent(_arg1:Ad, _arg2:NetStream){
            super(NETSTREAM_READY, _arg1);
            netStreamInstance = _arg2;
        }
        public function get netStream():NetStream{
            return (netStreamInstance);
        }
        override public function clone():Event{
            return (new NetStreamReadyEvent(ad, netStream));
        }

    }
}//package com.google.ads.ima.api 
