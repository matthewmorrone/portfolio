package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import com.google.ads.ima.wrappers.*;

    class AdErrorWrapper extends Error implements AdError {

        private var remoteMethodResultsDictionary:Dictionary;
        private var localInstanceReference:Object;
        private var remoteInstanceReference:Object;
        private var wrappersValue:Wrappers;

        public function AdErrorWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            remoteMethodResultsDictionary = new Dictionary();
            this.remoteInstanceReference = _arg2;
            this.localInstanceReference = _arg3;
            wrappersValue = _arg1;
        }
        public function get adIds():Array{
            return (remoteInstance.adIds);
        }
        public function get localInstance():Object{
            return (localInstanceReference);
        }
        public function get adSystems():Array{
            return (remoteInstance.adSystems);
        }
        public function get errorType():String{
            return (remoteInstance.errorType);
        }
        protected function get remoteMethodResultsStore():Dictionary{
            return (remoteMethodResultsDictionary);
        }
        public function get errorCode():int{
            return (remoteInstance.errorCode);
        }
        public function get innerError():Error{
            return (remoteInstance.innerError);
        }
        public function get remoteInstance():Object{
            return (remoteInstanceReference);
        }
        public function get errorMessage():String{
            return (remoteInstance.errorMessage);
        }

    }
}//package com.google.ads.ima.wrappers 
