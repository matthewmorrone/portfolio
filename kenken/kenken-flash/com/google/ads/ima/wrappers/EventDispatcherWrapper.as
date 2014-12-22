package com.google.ads.ima.wrappers {
    import flash.utils.*;
    import flash.events.*;

    public class EventDispatcherWrapper extends EventDispatcher {

        private var remoteMethodResultsDictionary:Dictionary;
        private var localInstanceReference:Object;
        private var remoteInstanceReference:Object;
        private var wrappersValue:Wrappers;
        private var listenersMap:Object;

        public function EventDispatcherWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            listenersMap = {};
            super();
            remoteMethodResultsDictionary = new Dictionary();
            this.remoteInstanceReference = _arg2;
            this.localInstanceReference = _arg3;
            wrappersValue = _arg1;
        }
        private function listenerAdded(_arg1:String, _arg2:Function):void{
            var type:* = _arg1;
            var listener:* = _arg2;
            if (!listenersMap[type]){
                listenersMap[type] = {};
                listenersMap[type].count = 0;
                listenersMap[type].localListeners = new Dictionary();
                listenersMap[type].listener = function (_arg1:Event):void{
                    dispatchEvent((wrappers.unwrappedRemoteToLocal(remoteMethodResultsStore, _arg1) as Event));
                    delete remoteMethodResultsStore[_arg1];
                };
                remoteInstance.addEventListener(type, listenersMap[type].listener);
            };
            if (!localListenerExists(listener, listenersMap[type].localListeners)){
                listenersMap[type].localListeners[listener] = listener;
                listenersMap[type].count++;
            };
        }
        public function get localInstance():Object{
            return (localInstanceReference);
        }
        private function localListenerExists(_arg1:Function, _arg2:Dictionary):Boolean{
            return ((_arg2[_arg1] == _arg1));
        }
        override public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=false):void{
            super.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
            listenerAdded(_arg1, _arg2);
        }
        private function listenerRemoved(_arg1:String, _arg2:Function):void{
            if (listenersMap[_arg1]){
                if (localListenerExists(_arg2, listenersMap[_arg1].localListeners)){
                    listenersMap[_arg1].localListeners[_arg2] = null;
                    delete listenersMap[_arg1].localListeners[_arg2];
                    listenersMap[_arg1].count--;
                    if (listenersMap[_arg1].count == 0){
                        remoteInstance.removeEventListener(_arg1, listenersMap[_arg1].listener);
                        listenersMap[_arg1] = null;
                    };
                };
            };
        }
        protected function get wrappers():Wrappers{
            return (wrappersValue);
        }
        protected function get remoteMethodResultsStore():Dictionary{
            return (remoteMethodResultsDictionary);
        }
        override public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
            super.removeEventListener(_arg1, _arg2, _arg3);
            listenerRemoved(_arg1, _arg2);
        }
        public function get remoteInstance():Object{
            return (remoteInstanceReference);
        }

    }
}//package com.google.ads.ima.wrappers 
