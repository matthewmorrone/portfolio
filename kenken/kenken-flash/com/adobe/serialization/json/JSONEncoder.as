package com.adobe.serialization.json {
    import flash.utils.*;

    public class JSONEncoder {

        private var jsonString:String;

        public function JSONEncoder(_arg1){
            this.jsonString = this.convertToString(_arg1);
        }
        public function getString():String{
            return (this.jsonString);
        }
        private function convertToString(_arg1):String{
            if ((_arg1 is String)){
                return (this.escapeString((_arg1 as String)));
            };
            if ((_arg1 is Number)){
                return (((isFinite((_arg1 as Number))) ? _arg1.toString() : "null"));
            };
            if ((_arg1 is Boolean)){
                return (((_arg1) ? "true" : "false"));
            };
            if ((_arg1 is Array)){
                return (this.arrayToString((_arg1 as Array)));
            };
            if ((((_arg1 is Object)) && (!((_arg1 == null))))){
                return (this.objectToString(_arg1));
            };
            return ("null");
        }
        private function escapeString(_arg1:String):String{
            var _local3:String;
            var _local6:String;
            var _local7:String;
            var _local2 = "";
            var _local4:Number = _arg1.length;
            var _local5:int;
            while (_local5 < _local4) {
                _local3 = _arg1.charAt(_local5);
                switch (_local3){
                    case "\"":
                        _local2 = (_local2 + "\\\"");
                        break;
                    case "\\":
                        _local2 = (_local2 + "\\\\");
                        break;
                    case "\b":
                        _local2 = (_local2 + "\\b");
                        break;
                    case "\f":
                        _local2 = (_local2 + "\\f");
                        break;
                    case "\n":
                        _local2 = (_local2 + "\\n");
                        break;
                    case "\r":
                        _local2 = (_local2 + "\\r");
                        break;
                    case "\t":
                        _local2 = (_local2 + "\\t");
                        break;
                    default:
                        if (_local3 < " "){
                            _local6 = _local3.charCodeAt(0).toString(16);
                            _local7 = (((_local6.length == 2)) ? "00" : "000");
                            _local2 = (_local2 + (("\\u" + _local7) + _local6));
                        } else {
                            _local2 = (_local2 + _local3);
                        };
                };
                _local5++;
            };
            return ((("\"" + _local2) + "\""));
        }
        private function arrayToString(_arg1:Array):String{
            var _local2 = "";
            var _local3:int = _arg1.length;
            var _local4:int;
            while (_local4 < _local3) {
                if (_local2.length > 0){
                    _local2 = (_local2 + ",");
                };
                _local2 = (_local2 + this.convertToString(_arg1[_local4]));
                _local4++;
            };
            return ((("[" + _local2) + "]"));
        }
        private function objectToString(_arg1:Object):String{
            var value:* = null;
            var key:* = null;
            var v:* = null;
            var o:* = _arg1;
            var s:* = "";
            var classInfo:* = describeType(o);
            if (classInfo.@name.toString() == "Object"){
                for (key in o) {
                    value = o[key];
                    if ((value is Function)){
                    } else {
                        if (s.length > 0){
                            s = (s + ",");
                        };
                        s = (s + ((this.escapeString(key) + ":") + this.convertToString(value)));
                    };
                };
            } else {
                for each (v in classInfo..*.(((name() == "variable")) || ((((name() == "accessor")) && ((attribute("access").charAt(0) == "r")))))) {
                    if (((v.metadata) && ((v.metadata.(@name == "Transient").length() > 0)))){
                    } else {
                        if (s.length > 0){
                            s = (s + ",");
                        };
                        s = (s + ((this.escapeString(v.@name.toString()) + ":") + this.convertToString(o[v.@name])));
                    };
                };
            };
            return ((("{" + s) + "}"));
        }

    }
}//package com.adobe.serialization.json 
