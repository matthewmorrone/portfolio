package com.google.utils {
    import flash.display.*;
    import flash.external.*;

    public class HttpSecure {

        private static const DEFAULT_PROTOCOL:String = "http";
        public static const HTTP:String = "http";
        public static const HTTP_SECURE:String = "https";

        private static var singletonManager:SingletonManager = new SingletonManager(HttpSecure);

        protected var referrerUrlValue:String;
        protected var embeddedUrlRetrieved:Boolean;
        protected var embeddedUrlValue:String;
        protected var pageLocationValue:String;
        protected var embeddedUrlProtocolValue:String;
        protected var loaderUrlValue:String;

        public function HttpSecure(){
            singletonManager.validateAndStoreInstance(this);
        }
        public static function getInstance(_arg1:Class=null):HttpSecure{
            return ((singletonManager.getInstance(_arg1) as HttpSecure));
        }

        public function get pageLocation():String{
            if (pageLocationValue != null){
                return (pageLocationValue);
            };
            pageLocationValue = (makeExternalCall("top.location.href.toString") as String);
            return (((StringUtils.isNullOrEmpty(pageLocationValue)) ? null : pageLocationValue));
        }
        public function get embeddedUrl():String{
            var _local1:String;
            if (!embeddedUrlRetrieved){
                _local1 = loaderUrl;
                if (_local1 == null){
                    _local1 = pageLocation;
                };
                if (_local1 == null){
                    _local1 = referrerUrl;
                };
                embeddedUrlRetrieved = true;
                embeddedUrlValue = _local1;
            };
            return (embeddedUrlValue);
        }
        public function useCorrectProtocolForUrl(_arg1:String, _arg2:String=null):String{
            var _local3:Url = new Url(_arg1);
            _local3.protocol = embeddedUrlProtocol;
            if (((!((_arg2 == null))) && ((_local3.protocol == HTTP_SECURE)))){
                _local3.hostname = _arg2;
            };
            return (_local3.recombineUrl());
        }
        public function get referrerUrl():String{
            if (referrerUrlValue != null){
                return (referrerUrlValue);
            };
            referrerUrlValue = (makeExternalCall("document.referrer.toString") as String);
            return (((StringUtils.isNullOrEmpty(referrerUrlValue)) ? null : referrerUrlValue));
        }
        public function get isSecure():Boolean{
            return ((embeddedUrlProtocol == HTTP_SECURE));
        }
        public function get loaderUrl():String{
            if (loaderUrlValue == null){
                loaderUrlValue = new Loader().contentLoaderInfo.loaderURL;
            };
            return (((StringUtils.isNullOrEmpty(loaderUrlValue)) ? null : loaderUrlValue));
        }
        public function get embeddedUrlProtocol():String{
            var _local1:String;
            var _local2:Url;
            if (embeddedUrlProtocolValue == null){
                _local1 = embeddedUrl;
                embeddedUrlProtocolValue = DEFAULT_PROTOCOL;
                if (_local1 != null){
                    _local2 = new Url(_local1);
                    if (_local2.protocol == HTTP_SECURE){
                        embeddedUrlProtocolValue = HTTP_SECURE;
                    };
                };
            };
            return (embeddedUrlProtocolValue);
        }
        protected function makeExternalCall(_arg1:String, ... _args):Object{
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
