package com.google.ads.ima.wrappers {
    import flash.utils.*;
    import flash.events.*;
    import com.google.ads.ima.wrappers.*;

    class Wrapper extends EventDispatcher {

        private var remoteMethodResultsDictionary:Dictionary;
        private var localInstanceValue:Object;
        private var remoteInstanceValue:Object;
        private var wrappersValue:Wrappers;

        public function Wrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            remoteMethodResultsDictionary = new Dictionary();
            super();
            wrappersValue = _arg1;
            remoteMethodResultsDictionary = new Dictionary();
            remoteInstanceValue = _arg2;
            localInstanceValue = _arg3;
        }
        public function get localInstance():Object{
            return (localInstanceValue);
        }
        protected function get wrappers():Wrappers{
            return (wrappersValue);
        }
        protected function get remoteMethodResultsStore():Dictionary{
            return (remoteMethodResultsDictionary);
        }
        public function get remoteInstance():Object{
            return (remoteInstanceValue);
        }
        public function set remoteInstance(_arg1:Object):void{
            remoteInstanceValue = _arg1;
        }

    }
}//package com.google.ads.ima.wrappers 
