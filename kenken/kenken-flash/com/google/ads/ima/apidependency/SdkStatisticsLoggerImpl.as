package com.google.ads.ima.apidependency {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.net.*;
    import flash.system.*;
    import com.google.ads.ima.common.*;

    public class SdkStatisticsLoggerImpl implements SdkStatisticsLogger {

        public static const REPORT_KEY_AD_SYSTEM:String = "adsys";
        public static const REPORT_KEY_LOG_ID:String = "lid";
        public static const REPORT_KEY_EVENTS:String = "evts";
        public static const REPORT_KEY_SOURCE:String = "src";
        public static const REPORT_VALUE_FALSE:String = "f";
        public static const REPORT_KEY_USER_CHOICE_ADS_COUNT:String = "ucac";
        public static const LOGGING_ID:String = "ima_sdk";
        public static const REPORT_KEY_MULTIPART_MESSAGE_VALUE:String = "mtpv";
        public static const REPORT_KEY_AD_SERVER:String = "adsrv";
        public static const REPORT_KEY_TIMEOUT_COUNT:String = "tc";
        public static const REPORT_PUBLISHER_PAGE_HOST:String = "pph";
        public static const REPORT_KEY_ADS_MANAGER_TYPE:String = "mt";
        public static const ERROR_TYPE:String = "ima_error";
        public static const REPORT_KEY_AFV_PUBLISHER_ID:String = "pid";
        public static const REPORT_KEY_ADS_RESPONSE_TYPE:String = "art";
        public static const REPORT_KEY_USER_CHOICE_EVENT_TIME:String = "ucevtt";
        public static const REPORT_KEY_USER_CHOICE_RENDERING_STYLE:String = "ucrs";
        public static const REPORT_KEY_AD_TYPE:String = "adt";
        private static const REPORT_KEY_DEBUGGER:String = "d";
        private static const REPORT_KEY_OS:String = "os";
        public static const REPORT_VALUE_NONE:String = "none";
        public static const REPORT_KEY_EXPERIMENT_ID:String = "exp";
        public static const ADS_LOADER_SOURCE:String = "adsldr";
        public static const REPORT_KEY_USER_CHOICE_ALTERNATIVE_ADS_COUNT:String = "ucalt_ads";
        public static const REPORT_KEY_ADS_MANAGER_VERSION:String = "mv";
        public static const API_TYPE:String = "ima_api";
        public static const SDK_LOADER_SOURCE:String = "sdkldr";
        public static const REPORT_KEY_AD_SLOT_ID:String = "slot";
        public static const REPORT_KEY_AD_ID:String = "aid";
        public static const REPORT_URL_PREFIX:String = "http://pagead2.googlesyndication.com/pagead/gen_204";
        private static const youtubeHosts:Array = ["youtube.com", "ytimg.com"];
        public static const REPORT_KEY_YOUTUBE:String = "yt";
        public static const REPORT_KEY_USER_CHOICE_CLICKED_UI_ID:String = "uccui";
        private static const REPORT_KEY_MANUFACTURER:String = "m";
        public static const REPORT_KEY_VIDEO_AD_DURATION:String = "vdur";
        private static const REPORT_KEY_LANGUAGE:String = "l";
        public static const REPORT_KEY_ID:String = "id";
        public static const REPORT_KEY_SDK_VERSION:String = "sv";
        public static const REPORT_KEY_AD_EVENT:String = "aevt";
        public static const REPORT_KEY_YOUTUBE_VIDEO_AD_ID:String = "ytvid";
        public static const REPORT_VALUE_TRUE:String = "t";
        public static const REPORT_KEY_ERROR_URL:String = "url";
        public static const REPORT_KEY_MULTIPART_MESSAGE_ID:String = "mtpid";
        public static const REPORT_KEY_ERROR_EVENT_TEXT:String = "eet";
        public static const REPORT_KEY_ADS_MANAGER_CONTEXT_ID:String = "amcid";
        public static const REPORT_KEY_SHORT_MESSAGE:String = "msg";
        public static const REPORT_KEY_DFP_TO_XFP_MIGRATION:String = "dxm";
        public static const REPORT_KEY_VALUE_SEPARATOR:String = "|";
        private static const REPORT_KEY_PLAYER_TYPE:String = "pt";
        public static const REPORT_KEY_VAST_AD_DATA_TYPE:String = "vadt";
        public static const REPORT_KEY_TYPE:String = "type";
        public static const REPORT_KEY_VAST_LINEARS_COUNT:String = "vlc";
        public static const REPORT_KEY_VAST_NONLINEARS_COUNT:String = "vnlc";
        public static const SWC_SOURCE:String = "swc";
        private static const REPORT_KEY_FLASH_VERSION:String = "fv";

        private static var instanceValue:SdkStatisticsLogger;

        private var config:SdkStatisticsLoggerConfig;
        private var logPercentValue:uint;
        private var persistentProperties:Dictionary;
        private var loggingEnabledValue:Boolean;

        public function SdkStatisticsLoggerImpl(_arg1:SdkStatisticsLoggerConfig){
            persistentProperties = new Dictionary();
            super();
            this.config = _arg1;
            loggingEnabled = decideToLog(_arg1.logPercent);
        }
        public static function set instance(_arg1:SdkStatisticsLogger):void{
            var _local2:BufferedSdkStatisticsLoggerImpl;
            if ((instanceValue is BufferedSdkStatisticsLoggerImpl)){
                _local2 = (instanceValue as BufferedSdkStatisticsLoggerImpl);
                _local2.executeStoredMethodsOn(_arg1);
            };
            instanceValue = _arg1;
        }
        private static function matchesHostname(_arg1:String, _arg2:String):Boolean{
            _arg2 = _arg2.toLowerCase();
            if (_arg2.substr(0, 2) == "*."){
                _arg2 = _arg2.slice(2);
                if (_arg2.length > _arg1.length){
                    return (false);
                };
                return ((((_arg1.slice(-(_arg2.length)) == _arg2)) && ((((_arg1.length == _arg2.length)) || ((_arg1.charAt(((_arg1.length - _arg2.length) - 1)) == "."))))));
            };
            return ((_arg2 == _arg1));
        }
        public static function get instance():SdkStatisticsLogger{
            if (instanceValue == null){
                instanceValue = new BufferedSdkStatisticsLoggerImpl();
            };
            return (instanceValue);
        }
        private static function createQueryParam(_arg1:String, _arg2:String):String{
            return (((encodeURIComponent(_arg1) + "=") + encodeURIComponent(_arg2)));
        }
        public static function isYoutubeHost(_arg1:String):Boolean{
            var hostName:* = null;
            var domain:* = null;
            var subdomain:* = null;
            var publisherUrl:* = _arg1;
            try {
                hostName = publisherUrl.split("/")[2];
                for each (domain in youtubeHosts) {
                    subdomain = ("*." + domain);
                    if (((matchesHostname(hostName, domain)) || (matchesHostname(hostName, subdomain)))){
                        return (true);
                    };
                };
            } catch(error:Error) {
            };
            return (false);
        }

        public function decideToLog(_arg1:Number):Boolean{
            return (MathUtils.isRandomlySelected(_arg1));
        }
        public function reportApi(_arg1:uint, _arg2:Dictionary=null):void{
            if (_arg2 == null){
                _arg2 = new Dictionary();
            };
            _arg2[REPORT_KEY_TYPE] = API_TYPE;
            report(_arg1, null, _arg2);
        }
        private function shouldReportData(_arg1:Dictionary, _arg2:LoggablePoint):Boolean{
            if (_arg2.logForYoutubeOnly){
                return ((_arg1[SdkStatisticsLoggerImpl.REPORT_KEY_YOUTUBE] == SdkStatisticsLoggerImpl.REPORT_VALUE_TRUE));
            };
            return (true);
        }
        public function report(_arg1:uint, _arg2:String=null, _arg3:Dictionary=null):void{
            var _local6:URLRequest;
            if (!shouldLog(_arg1)){
                return;
            };
            if (_arg3 == null){
                _arg3 = new Dictionary();
            };
            if (_arg2 != null){
                _arg3[REPORT_KEY_SHORT_MESSAGE] = _arg2;
            };
            _arg3[REPORT_KEY_LOG_ID] = _arg1;
            var _local4:MultipartMessage = removeMultipartMessage(_arg3);
            if (_local4 != null){
                _arg3[REPORT_KEY_MULTIPART_MESSAGE_ID] = _local4.id;
            };
            var _local5:Dictionary = processQueryParams(_arg3);
            if (shouldReportData(_local5, config.loggablePoints[_arg1])){
                _local6 = createReportingUrl(_local5);
                sendToURL(_local6);
                if (_local4 != null){
                    sendMultipartMessage(_local4);
                };
            };
        }
        public function setPersistentProperty(_arg1:String, _arg2:Object):void{
            persistentProperties[_arg1] = getParamValue(_arg2);
        }
        private function mergeProperties(_arg1:Dictionary, _arg2:Dictionary):void{
            var _local3:String;
            for (_local3 in _arg1) {
                _arg2[_local3] = _arg1[_local3];
            };
        }
        public function set loggingEnabled(_arg1:Boolean):void{
            loggingEnabledValue = _arg1;
        }
        public function reportAdError(_arg1:uint, _arg2:String, _arg3:AdError, _arg4:Dictionary=null):void{
            if (_arg4 == null){
                _arg4 = new Dictionary();
            };
            if (_arg3.errorType != null){
                _arg4["errType"] = _arg3.errorType;
            };
            if (_arg3.errorMessage != null){
                _arg4["errMsg"] = _arg3.errorMessage;
            };
            if (_arg3.errorCode > 0){
                _arg4["errCode"] = _arg3.errorCode;
            };
            if (_arg3.innerError != null){
                _arg4["innerCode"] = _arg3.innerError.errorID;
            };
            reportError(_arg1, _arg2, _arg4);
        }
        private function getParamValue(_arg1:Object):String{
            if ((_arg1 is String)){
                return ((_arg1 as String));
            };
            if ((_arg1 is Boolean)){
                return (((_arg1) ? REPORT_VALUE_TRUE : REPORT_VALUE_FALSE));
            };
            return (((_arg1)==null) ? "null" : _arg1.toString());
        }
        protected function sendToURL(_arg1:URLRequest):void{
            sendToURL(_arg1);
        }
        private function removeMultipartMessage(_arg1:Dictionary):MultipartMessage{
            var _local2:MultipartMessage;
            var _local3:String;
            for (_local3 in _arg1) {
                if ((_arg1[_local3] is MultipartMessage)){
                    _local2 = (_arg1[_local3] as MultipartMessage);
                    _arg1[_local3] = null;
                    delete _arg1[_local3];
                    break;
                };
            };
            return (_local2);
        }
        public function get logPercent():uint{
            return (logPercentValue);
        }
        public function get loggingEnabled():Boolean{
            return (loggingEnabledValue);
        }
        private function sendMultipartMessage(_arg1:MultipartMessage):void{
            var _local6:URLRequest;
            var _local2:Dictionary = new Dictionary();
            _local2[REPORT_KEY_MULTIPART_MESSAGE_ID] = _arg1.id;
            var _local3:Dictionary = processQueryParams(_local2, false);
            var _local4:URLRequest = createReportingUrl(_local3);
            var _local5 = (((_local4.url + "&") + REPORT_KEY_MULTIPART_MESSAGE_VALUE) + "=");
            while (_arg1.hasDataLeft()) {
                _local6 = new URLRequest(_arg1.appendDataPartToUrl(_local5));
                sendToURL(_local6);
            };
        }
        public function reportError(_arg1:uint, _arg2:String, _arg3:Dictionary=null):void{
            if (_arg3 == null){
                _arg3 = new Dictionary();
            };
            _arg3[REPORT_KEY_TYPE] = ERROR_TYPE;
            report(_arg1, _arg2, _arg3);
        }
        private function createReportingUrl(_arg1:Dictionary):URLRequest{
            var _local4:String;
            var _local2:URLRequest = new URLRequest();
            _local2.url = (REPORT_URL_PREFIX + "?");
            var _local3:Boolean;
            for (_local4 in _arg1) {
                if (_local3){
                    _local2.url = (_local2.url + ("&" + createQueryParam(_local4, _arg1[_local4])));
                } else {
                    _local2.url = (_local2.url + createQueryParam(_local4, _arg1[_local4]));
                    _local3 = true;
                };
            };
            return (_local2);
        }
        private function shouldLog(_arg1:uint):Boolean{
            var _local2:LoggablePoint;
            if ((((_arg1 > 0)) && (!((config.loggablePoints[_arg1] == null))))){
                _local2 = config.loggablePoints[_arg1];
                if (loggingEnabled){
                    return (true);
                };
                return (_local2.logAlways);
            };
            return (false);
        }
        private function processQueryParams(_arg1:Dictionary, _arg2:Boolean=true):Dictionary{
            var _local4:String;
            var _local3:Dictionary = new Dictionary();
            mergeProperties(persistentProperties, _arg1);
            for (_local4 in _arg1) {
                _local3[_local4] = getParamValue(_arg1[_local4]);
            };
            _local3[REPORT_KEY_ID] = getParamValue(LOGGING_ID);
            if (_arg2){
                _local3[REPORT_KEY_DEBUGGER] = getParamValue(((Capabilities.isDebugger) ? REPORT_VALUE_TRUE : REPORT_VALUE_FALSE));
                _local3[REPORT_KEY_LANGUAGE] = getParamValue(Capabilities.language);
                _local3[REPORT_KEY_MANUFACTURER] = getParamValue(Capabilities.manufacturer);
                _local3[REPORT_KEY_OS] = getParamValue(Capabilities.os);
                _local3[REPORT_KEY_PLAYER_TYPE] = getParamValue(Capabilities.playerType);
                _local3[REPORT_KEY_FLASH_VERSION] = getParamValue(Capabilities.version);
            };
            return (_local3);
        }

    }
}//package com.google.ads.ima.apidependency 
