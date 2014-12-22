package com.google.ads.ima.api {
    import flash.utils.*;
    import flash.net.*;
    import flash.system.*;
    import flash.display.*;
    import flash.events.*;
    import com.google.utils.*;
    import com.google.ads.ima.apidependency.*;
    import com.google.ads.ima.wrappers.*;

    public class AdsLoader extends EventDispatcher {

        private static const REQUEST_ADS_METHOD:String = "requestAds";
        private static const SDK_LOCATION:String = (("http://" + SDK_HOST) + "/instream/flash/v3/adsapi_");
        private static const SDK_LOADER_CLASSNAME:String = "com.google.ads.ima.sdkloader::VersionedSdkLoader";
        private static const DOUBLECLICK_MEDIA_SERVER:String = "m1.2mdn.net";
        private static const CONTENT_COMPLETE_METHOD:String = "contentComplete";
        private static const QUEUED_REQUEST_TYPE_METHOD:String = "method";
        private static const SDK_SECURE_HOST:String = "static.doubleclick.net";
        private static const SDK_MAJOR_VERSION:String = "3";
        private static const DESTROY_METHOD:String = "destroy";
        private static const SDK_HOST:String = "s0.2mdn.net";
        private static const QUEUED_REQUEST_TYPE_PROPERTY:String = "property";

        private static var settingsValue:ImaSdkSettingsWrapper;

        private var queuedListeners:Array;
        private var wrappersValue:Wrappers;
        private var loader:Loader;
        private var queuedRequests:Array;
        var sdkLoaderFactory:Function;
        private var adsLoaderWrapper:IEventDispatcher;

        public function AdsLoader(){
            queuedRequests = [];
            queuedListeners = [];
            sdkLoaderFactory = createSdkLoader;
            super();
            allowTrustedDomains();
        }
        private function get wrappers():Wrappers{
            return (wrappersValue);
        }
        private function dispatchSdkLoadError(_arg1:String):void{
            var _local2:Dictionary = new Dictionary();
            _local2["errMsg"] = _arg1;
            var _local3:AdsLoaderError = new AdsLoaderError(_arg1);
            _local3.errorType = AdErrorTypes.AD_LOAD_ERROR;
            var _local4:AdErrorEvent = new AdErrorEvent(_local3);
            dispatchEvent(_local4);
        }
        private function removeSdkLoadListeners():void{
            loader.removeEventListener(Event.COMPLETE, sdkLoadedHandler);
            loader.removeEventListener(ErrorEvent.ERROR, onSdkLoadError);
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, sdkLoaderSwfLoadCompleteHandler);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onSdkLoadError);
            loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSdkLoadError);
        }
        private function setWrapperProperty(_arg1:String, _arg2):void{
            if ((_arg1 in adsLoaderWrapper)){
                adsLoaderWrapper[_arg1] = _arg2;
            } else {
                dispatchSdkLoadError(("Internal error: No such property: " + _arg1));
            };
        }
        override public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
            var _local4:Object;
            if (isLocallyDispatchedEvent(_arg1)){
                super.removeEventListener(_arg1, _arg2);
            };
            if (adsLoaderWrapper != null){
                adsLoaderWrapper.removeEventListener(_arg1, _arg2, _arg3);
            } else {
                for each (_local4 in queuedListeners) {
                    if ((((_arg1 == _local4.type)) && ((_arg2 == _local4.listener)))){
                        queuedListeners.splice(queuedListeners.indexOf(_local4), 1);
                        break;
                    };
                };
            };
        }
        protected function isLocallyDispatchedEvent(_arg1:String):Boolean{
            return ((_arg1 == AdErrorEvent.AD_ERROR));
        }
        override public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=false):void{
            if (isLocallyDispatchedEvent(_arg1)){
                super.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
            };
            if (adsLoaderWrapper != null){
                adsLoaderWrapper.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
            } else {
                queuedListeners.push({
                    type:_arg1,
                    listener:_arg2,
                    useCapture:_arg3,
                    priority:_arg4,
                    useWeakReference:_arg5
                });
            };
        }
        public function contentComplete(_arg1:String=null):void{
            invokeRemoteMethod(CONTENT_COMPLETE_METHOD, _arg1);
        }
        private function get sdkUrl():String{
            var _local1 = (SDK_MAJOR_VERSION + ".swf");
            var _local2:String = (SDK_LOCATION + _local1);
            return (HttpSecure.getInstance().useCorrectProtocolForUrl(_local2, SDK_SECURE_HOST));
        }
        private function createAdsLoaderWrapper(_arg1:Object):IEventDispatcher{
            if (settingsValue != null){
                settingsValue.invokeDelayedMethods(_arg1.settings);
            };
            return (new AdsLoaderWrapper(wrappers, _arg1, this));
        }
        private function invokeRemoteMethod(_arg1:String, ... _args):void{
            if (adsLoaderWrapper != null){
                invokeWrapperMethod(_arg1, _args);
            } else {
                queuedRequests.push({
                    requestType:QUEUED_REQUEST_TYPE_METHOD,
                    method:_arg1,
                    args:_args
                });
                load();
            };
        }
        public function requestAds(_arg1:AdsRequest, _arg2:Object=null):void{
            SdkStatisticsLoggerImpl.instance.reportApi(LogIds.AdsLoader_requestAds);
            invokeRemoteMethod(REQUEST_ADS_METHOD, _arg1, _arg2);
        }
        public function get settings():ImaSdkSettings{
            if (settingsValue == null){
                settingsValue = new ImaSdkSettingsWrapper(wrappers, null);
            };
            return (settingsValue);
        }
        private function processQueuedListeners():void{
            var _local1:Object;
            for each (_local1 in queuedListeners) {
                adsLoaderWrapper.addEventListener(_local1.type, _local1.listener, _local1.useCapture, _local1.priority, _local1.useWeakReference);
            };
            queuedListeners = [];
        }
        private function addSdkLoadListeners():void{
            loader.addEventListener(Event.COMPLETE, sdkLoadedHandler);
            loader.addEventListener(ErrorEvent.ERROR, onSdkLoadError);
            loader.addEventListener(ErrorEvent.ERROR, onSdkLoadError);
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, sdkLoaderSwfLoadCompleteHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onSdkLoadError);
            loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSdkLoadError);
        }
        private function allowTrustedDomains():void{
            Security.allowDomain(SDK_HOST);
            Security.allowDomain(SDK_SECURE_HOST);
            Security.allowDomain(DOUBLECLICK_MEDIA_SERVER);
            Security.allowInsecureDomain(DOUBLECLICK_MEDIA_SERVER);
        }
        private function createSdkLoader():Loader{
            try {
                return (new SdkSwfLoader(ApplicationDomain.currentDomain));
            } catch(error:Error) {
            };
            return (new SdkSwfLoader(null));
        }
        private function sdkLoadedHandler(_arg1:Event):void{
            removeSdkLoadListeners();
            var _local2:Object = _arg1;
            wrappersValue = new Wrappers(_local2.remoteApplicationDomain);
            adsLoaderWrapper = createAdsLoaderWrapper(_local2.adsLoader);
            if (adsLoaderWrapper != null){
                processQueuedListeners();
                processQueuedRequests();
            } else {
                dispatchSdkLoadError("Internal error: remote wrapper is null");
            };
        }
        private function load():void{
            var _local1:URLRequest;
            if (loader == null){
                loader = sdkLoaderFactory();
                addSdkLoadListeners();
                _local1 = new URLRequest(sdkUrl);
                loader.load(_local1);
            };
        }
        private function processQueuedRequests():void{
            var _local1:Object;
            for each (_local1 in queuedRequests) {
                switch (_local1.requestType){
                    case QUEUED_REQUEST_TYPE_METHOD:
                        invokeWrapperMethod(_local1.method, _local1.args);
                        break;
                    case QUEUED_REQUEST_TYPE_PROPERTY:
                        setWrapperProperty(_local1.propertyName, _local1.propertyValue);
                        break;
                };
            };
            queuedRequests = [];
        }
        private function sdkLoaderSwfLoadCompleteHandler(_arg1:Event):void{
            var loadedClassName:* = null;
            var event:* = _arg1;
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, sdkLoaderSwfLoadCompleteHandler);
            try {
                loadedClassName = getQualifiedClassName(loader.content);
                if (loadedClassName != SDK_LOADER_CLASSNAME){
                    handleSdkLoadError(("SDK could not be loaded from " + sdkUrl));
                };
            } catch(error:SecurityError) {
                handleSdkLoadError(("SDK could not be loaded from " + sdkUrl));
            };
        }
        private function handleSdkLoadError(_arg1:String):void{
            removeSdkLoadListeners();
            dispatchSdkLoadError(_arg1);
        }
        public function destroy():void{
            if (loader != null){
                invokeRemoteMethod(DESTROY_METHOD);
                removeSdkLoadListeners();
                if (loader.parent != null){
                    loader.parent.removeChild(loader);
                };
                if (loader.hasOwnProperty("unloadAndStop")){
                    var _local1 = loader;
                    _local1["unloadAndStop"]();
                } else {
                    loader.unload();
                };
                loader = null;
                queuedRequests = [];
                queuedListeners = [];
            };
        }
        private function invokeWrapperMethod(_arg1:String, _arg2:Array):void{
            var _local3:Function = adsLoaderWrapper[_arg1];
            if (_local3 != null){
                _local3.apply(adsLoaderWrapper, _arg2);
            } else {
                dispatchSdkLoadError(("Internal error: No such method: " + _arg1));
            };
        }
        private function onSdkLoadError(_arg1:ErrorEvent):void{
            handleSdkLoadError(_arg1.text);
        }

    }
}//package com.google.ads.ima.api 
