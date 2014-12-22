package com.google.utils {

    public class Url {

        protected static const USER_PASS_HOST_PORT_MATCH:RegExp = /^(?#uspa) (([^:@]*)(:([^@]*))?@)? (?#host)([^:]*) (?#port)(:(.*))?/ix;
        protected static const AUTHORITY_MATCH:RegExp = /^(\/\/)? (?#authority) ([^\/]*) (?#rest) (.*)$/ix;
        protected static const PATH_MATCH:RegExp = /^(?#fullPath) (\/[^;]*) (?#parameters) (;(.*))?$/ix;
        protected static const PROTO_MATCH:RegExp = /^(?#protocol) (([a-zA-Z0-9\+\.\-]+):)? (?#rest) (.*)$/ix;
        protected static const QUERY_FRAG_MATCH:RegExp = /^(?#rest) ([^\?\#]*) (?#query) (\?([^\#]*))? (?#frag) (\#(.*))?$/ix;
        protected static const PARAM_MATCH:RegExp = /(?#id)([^=;]+) (=?) (?#value)([^;]*) [;|$]?/ixg;
        protected static const QUERY_MATCH:RegExp = /(?#id)([^=&]+) (=?) (?#value)([^&]*) [&|$]?/ixg;

        public var port:String = "";
        public var authority:String = "";
        public var query:String = "";
        public var queryVars:Object;
        public var username:String = "";
        public var fragment:String = "";
        public var protocol:String = "";
        public var fullPath:String = "";
        public var originalUrl:String = "";
        public var isResource:Boolean;
        public var password:String = "";
        public var parameters:String = "";
        public var hostname:String = "";
        public var parameterVars:Array;

        public function Url(_arg1:String=""){
            var _local2:String;
            var _local3:Array;
            var _local4:String;
            var _local5:String;
            var _local6:String;
            var _local7:String;
            parameterVars = [];
            queryVars = {};
            super();
            originalUrl = _arg1;
            _local3 = (PROTO_MATCH.exec(originalUrl) as Array);
            protocol = ((_local3[2]) || (""));
            _local2 = ((_local3[3]) || (""));
            protocol = protocol.toLowerCase();
            _local3 = (QUERY_FRAG_MATCH.exec(_local2) as Array);
            _local2 = ((_local3[1]) || (""));
            query = ((_local3[3]) || (""));
            fragment = ((_local3[5]) || (""));
            _local3 = (AUTHORITY_MATCH.exec(_local2) as Array);
            isResource = (_local3[1] == "//");
            authority = ((_local3[2]) || (""));
            _local2 = ((_local3[3]) || (""));
            _local3 = (PATH_MATCH.exec(_local2) as Array);
            if (_local3){
                fullPath = ((_local3[1]) || (""));
                parameters = ((_local3[3]) || (""));
            };
            _local3 = (USER_PASS_HOST_PORT_MATCH.exec(authority) as Array);
            username = ((_local3[2]) || (""));
            password = ((_local3[4]) || (""));
            hostname = ((_local3[5]) || (""));
            port = ((_local3[7]) || (""));
            hostname = hostname.toLowerCase();
            if (parameters){
                PARAM_MATCH.lastIndex = 0;
                while ((_local3 = (PARAM_MATCH.exec(parameters) as Array))) {
                    _local4 = _local3[1];
                    _local5 = ((_local3[2]) ? _local3[3] : null);
                    parameterVars.push(new KeyValuePair(_local4, _local5));
                };
            };
            if (query){
                QUERY_MATCH.lastIndex = 0;
                while ((_local3 = (QUERY_MATCH.exec(query) as Array))) {
                    _local6 = _local3[1];
                    _local7 = ((_local3[2]) ? _local3[3] : null);
                    queryVars[decodeURIComponent(_local6)] = ((_local7) ? decodeURIComponent(_local7) : _local7);
                };
            };
        }
        private static function findUrlParameter(_arg1:String, _arg2:String):Object{
            var _local5:Number;
            var _local3:Object = new Object();
            _local3.found = false;
            _local3.hasQuestionMark = false;
            var _local4:int = _arg1.indexOf("?");
            if (_local4 > 0){
                _local3.hasQuestionMark = true;
            };
            while ((((_local4 > 0)) && ((_local4 < _arg1.length)))) {
                _local4 = _arg1.indexOf(_arg2, (_local4 + 1));
                if ((((((_local4 > 0)) && ((((_arg1.charAt((_local4 - 1)) == "?")) || ((_arg1.charAt((_local4 - 1)) == "&")))))) && ((_arg1.charAt((_local4 + _arg2.length)) == "=")))){
                    _local5 = _arg1.indexOf("&", _local4);
                    if (_local5 < 0){
                        _local5 = _arg1.length;
                    };
                    _local3.found = true;
                    _local3.nameStart = _local4;
                    _local3.nameEnd = (_local4 + _arg2.length);
                    _local3.valueStart = ((_local4 + _arg2.length) + 1);
                    _local3.valueEnd = _local5;
                    break;
                };
            };
            return (_local3);
        }
        public static function resolve(_arg1:String, _arg2:Url):Url{
            var _local4:*;
            var _local5:*;
            var _local3:Url = new Url(_arg1);
            do  {
                if (_local3.protocol){
                    break;
                };
                _local3.protocol = _arg2.protocol;
                if (_local3.isResource){
                    break;
                };
                if (_local3.authority){
                    _local3.fullPath = (_local3.authority + _local3.fullPath);
                };
                _local3.username = ((_arg2.isResource) ? _arg2.username : "");
                _local3.password = ((_arg2.isResource) ? _arg2.password : "");
                _local3.hostname = ((_arg2.isResource) ? _arg2.hostname : "");
                _local3.authority = ((_arg2.isResource) ? _arg2.authority : "");
                _local3.port = ((_arg2.isResource) ? _arg2.port : "");
                _local3.isResource = _arg2.isResource;
                if (_local3.fullPath.charAt(0) == "/"){
                    break;
                };
                if (_local3.fullPath){
                    _local5 = ((_arg2.isResource) ? _arg2.fullPath : (_arg2.authority + _arg2.fullPath));
                    _local5 = _local5.substr(0, (_local5.lastIndexOf("/") + 1));
                    _local3.fullPath = (_local5 + _local3.fullPath);
                    break;
                };
                _local3.fullPath = _arg2.fullPath;
                _local3.parameters = _arg2.parameters;
                _local3.parameterVars = _arg2.parameterVars.concat();
                if (_local3.query){
                    break;
                };
                _local3.query = _arg2.query;
                _local3.queryVars = {};
                for (_local4 in _arg2.queryVars) {
                    _local3.queryVars[_local4] = _arg2.queryVars[_local4];
                };
                _local3.fragment = ((_local3.fragment) || (_arg2.fragment));
            } while (false);
            _local3.removeDotSegments();
            return (_local3);
        }
        private static function getProperty(_arg1:Array, _arg2:String):KeyValuePair{
            var _local3:KeyValuePair;
            var _local4:String;
            for each (_local3 in _arg1) {
                _local4 = String(_local3.key);
                if (_local3.key == _arg2){
                    return (_local3);
                };
            };
            return (null);
        }
        public static function getUrlParameter(_arg1:String, _arg2:String):String{
            var _local3:Object = findUrlParameter(_arg1, _arg2);
            if (!_local3.found){
                return (null);
            };
            return (_arg1.slice(_local3.valueStart, _local3.valueEnd));
        }
        public static function setUrlParameter(_arg1:String, _arg2:String, _arg3:String):String{
            var _local5:String;
            var _local6:String;
            var _local4:Object = findUrlParameter(_arg1, _arg2);
            if (_local4.found){
                _local5 = _arg1.slice(0, _local4.valueStart);
                _local6 = _arg1.slice(_local4.valueEnd);
                return (((_local5 + _arg3) + _local6));
            };
            if (_local4.hasQuestionMark){
                return (((((_arg1 + "&") + _arg2) + "=") + _arg3));
            };
            return (((((_arg1 + "?") + _arg2) + "=") + _arg3));
        }
        private static function setProperty(_arg1:Array, _arg2:String, _arg3:String):void{
            var _local4:KeyValuePair = getProperty(_arg1, _arg2);
            if (_local4){
                _local4.value = _arg3;
            } else {
                _arg1.push(new KeyValuePair(_arg2, _arg3));
            };
        }
        public static function isWhiteListedUrl(_arg1:String, _arg2:Array):Boolean{
            var _local4:int;
            var _local5:Url;
            var _local6:String;
            var _local7:String;
            if (_arg1 == null){
                return (false);
            };
            var _local3:Url = new Url(_arg1);
            if ((((((_local3.protocol == "http")) || ((_local3.protocol == "https")))) || ((_local3.protocol == "ftp")))){
                _local4 = 0;
                while (_local4 < _arg2.length) {
                    _local5 = new Url(_arg2[_local4]);
                    _local6 = _local5.hostname;
                    _local7 = ("*." + _local6);
                    if (((_local3.matchesHostname(_local6)) || (_local3.matchesHostname(_local7)))){
                        if (((StringUtils.isNullOrEmpty(_local5.fullPath)) || (_local3.matchesPath(_local5.fullPath)))){
                            return (true);
                        };
                    };
                    _local4++;
                };
            };
            return (false);
        }
        public static function equals(_arg1:String, _arg2:String):Boolean{
            var _local3:Url = new Url(_arg1);
            var _local4:Url = new Url(_arg2);
            return (_local3.equals(_local4));
        }

        private function diffValues(_arg1:Object, _arg2:Object):String{
            if (_arg1 != _arg2){
                return ("Expected ".concat(_arg1, ", but found ", _arg2, "."));
            };
            return ("");
        }
        public function getExtension():String{
            var _local1:int;
            if (fullPath){
                _local1 = fullPath.lastIndexOf(".");
                if (_local1 != -1){
                    return (fullPath.substring((_local1 + 1)));
                };
            };
            return (null);
        }
        public function setParam(_arg1:String, _arg2:String):void{
            setProperty(parameterVars, _arg1, _arg2);
        }
        public function diffUrl(_arg1:Url):String{
            var _local3:String;
            var _local2 = "";
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.protocol, _arg1.protocol), "protocol"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.isResource, _arg1.isResource), "isResource"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.hostname, _arg1.hostname), "hostname"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.username, _arg1.username), "username"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.password, _arg1.password), "password"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.port, _arg1.port), "port"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.fullPath, _arg1.fullPath), "fullPath"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffValues(this.fragment, _arg1.fragment), "fragment"));
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffProperties(this.parameterVars, _arg1.parameterVars), "parameterVars"));
            var _local4:Array = [];
            var _local5:Array = [];
            for (_local3 in this.queryVars) {
                _local4.push(new KeyValuePair(_local3, this.queryVars[_local3]));
            };
            for (_local3 in _arg1.queryVars) {
                _local5.push(new KeyValuePair(_local3, _arg1.queryVars[_local3]));
            };
            _local2 = _local2.concat(calculateDiffPartToAppend(_local2, diffProperties(_local4, _local5), "queryVars"));
            return (_local2);
        }
        public function matchesHostname(_arg1:String):Boolean{
            _arg1 = _arg1.toLowerCase();
            if (_arg1.substr(0, 2) == "*."){
                _arg1 = _arg1.slice(2);
                if (_arg1.length > hostname.length){
                    return (false);
                };
                return ((((hostname.slice(-(_arg1.length)) == _arg1)) && ((((hostname.length == _arg1.length)) || ((hostname.charAt(((hostname.length - _arg1.length) - 1)) == "."))))));
            };
            return ((_arg1 == hostname));
        }
        private function calculateDiffPartToAppend(_arg1:String, _arg2:String, _arg3:String):String{
            if (_arg2){
                return (((_arg1) ? "\n" : "").concat(_arg3, ": ", _arg2));
            };
            return ("");
        }
        protected function removeDotSegments():void{
            var _local2:Boolean;
            var _local1:Array = fullPath.split("/");
            if (((_local1.length) && ((_local1[0] == "")))){
                _local2 = true;
                _local1.shift();
            };
            var _local3:Array = [];
            while (_local1.length) {
                if (((((!(_local2)) && ((_local1[0] == "..")))) || ((_local1[0] == ".")))){
                    _local1.shift();
                } else {
                    if (((_local2) && ((_local1[0] == ".")))){
                        _local1.shift();
                    } else {
                        if (((_local2) && ((_local1[0] == "..")))){
                            _local1.shift();
                            _local3.pop();
                        } else {
                            if (((!(_local3.length)) && (_local2))){
                                _local3.push("");
                            };
                            _local3.push(_local1.shift());
                            _local2 = (_local1.length > 0);
                        };
                    };
                };
            };
            if (_local2){
                _local3.push("");
            };
            fullPath = _local3.join("/");
        }
        private function diffProperties(_arg1:Array, _arg2:Array):String{
            var _local4:KeyValuePair;
            var _local5:KeyValuePair;
            var _local6:Boolean;
            var _local3 = "";
            for each (_local4 in _arg2) {
                _local6 = false;
                for each (_local5 in _arg1) {
                    if ((((_local5.key == _local4.key)) && ((_local5.value == _local4.value)))){
                        _local6 = true;
                        break;
                    };
                };
                if (!_local6){
                    _local3 = _local3.concat(((_local3) ? "\n\t" : ""), "Extra ", _local4, " found.");
                };
            };
            for each (_local5 in _arg1) {
                _local6 = false;
                for each (_local4 in _arg2) {
                    if ((((_local5.key == _local4.key)) && ((_local5.value == _local4.value)))){
                        _local6 = true;
                        break;
                    };
                };
                if (!_local6){
                    _local3 = _local3.concat(((_local3) ? "\n\t" : ""), _local5, " not found.");
                };
            };
            return (_local3);
        }
        public function recombineUrl(_arg1:Boolean=false, _arg2:Object=null):String{
            var _local4:KeyValuePair;
            var _local7:Object;
            var _local8:Array;
            var _local9:String;
            var _local3:String = "".concat(((protocol) ? (protocol + ":") : ""), ((isResource) ? "//" : ""));
            if (_arg1){
                _local3 = (_local3 + authority);
            } else {
                if (((username) || (password))){
                    _local3 = _local3.concat(((username) ? username : ""), ((password) ? (":" + password) : ""), "@");
                };
                _local3 = _local3.concat(hostname, ((port) ? (":" + port) : ""));
            };
            _local3 = (_local3 + fullPath);
            var _local5:String = parameters;
            if (!_arg1){
                _local5 = "";
                for each (_local4 in parameterVars) {
                    _local5 = (_local5 + (((_local5) ? ";" : "") + _local4.key));
                    if (_local4.value != null){
                        _local5 = (_local5 + ("=" + _local4.value));
                    };
                };
            };
            _local3 = (_local3 + ((_local5) ? (";" + _local5) : ""));
            var _local6:String = query;
            if (!_arg1){
                _local6 = "";
                _local7 = ((_arg2) ? _arg2 : this.queryVars);
                _local8 = [];
                for (_local9 in _local7) {
                    _local8.push(_local9);
                };
                _local8.sort();
                for each (_local9 in _local8) {
                    _local6 = (_local6 + (((_local6) ? "&" : "") + encodeURIComponent(_local9)));
                    if (_local7[_local9] != null){
                        _local6 = (_local6 + ("=" + encodeURIComponent(String(_local7[_local9]))));
                    };
                };
            };
            _local3 = (_local3 + ((_local6) ? ("?" + _local6) : ""));
            _local3 = (_local3 + ((fragment) ? ("#" + fragment) : ""));
            return (_local3);
        }
        public function matchesPath(_arg1:String):Boolean{
            var _local2:String = fullPath;
            if (_arg1.charAt((_arg1.length - 1)) == "*"){
                _local2 = _local2.slice(0, (_arg1.length - 1));
                _arg1 = _arg1.slice(0, (_arg1.length - 1));
            };
            return ((((_local2 == _arg1)) || ((((_arg1 == "/")) && (StringUtils.isNullOrEmpty(_local2))))));
        }
        public function getParam(_arg1:String):String{
            var _local2:KeyValuePair = getProperty(parameterVars, _arg1);
            if (_local2 != null){
                return ((_local2.value as String));
            };
            return (null);
        }
        public function toString():String{
            return ("[Url url=".concat(recombineUrl(), " originalUrl=", originalUrl, "]"));
        }
        public function equals(_arg1:Url):Boolean{
            return (!(diffUrl(_arg1)));
        }

    }
}//package com.google.utils 
