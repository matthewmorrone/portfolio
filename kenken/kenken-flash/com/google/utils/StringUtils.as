package com.google.utils {
    import flash.utils.*;
    import flash.text.*;

    public class StringUtils {

        private static const ASPECT_REGEX:RegExp = /^([0-9\.]+)\:([0-9\.]+)$/;
        private static const NUMBER_GROUP_RE:RegExp = /([0-9]{3})/g;
        private static const ALPHANUM_CHAR_ARRAY:Array = new String(("abcdefghijkl" + "mnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")).split("");
        private static const TIME_DELIM_RE:RegExp = /^\s*(?P<sign>-)?((?P<h>\d+:)?(?P<m>\d+:))?(?P<s>\d+(\.(?P<ss>\d*))?)/i;
        private static const TIME_HMS_RE:RegExp = /^\s*(?P<sign>-)?(?P<h>\d+h)?(?P<m>\d+m)?(?P<s>\d+(\.(?P<ss>\d*))?s)?/i;
        private static const NUMBER_RE:RegExp = /^(?P<prefix>[0-9]*?)([0-9]{3})*$/;
        private static const MISSING_CLOSE_BRACKET:String = 'Single close bracket not found "{"';

        public static function toCamelCase(_arg1:String):String{
            var _local4:int;
            var _local2:Array = _arg1.toLowerCase().split("_");
            var _local3 = "";
            if (_local2.length > 0){
                _local3 = _local2[0];
                _local4 = 1;
                while (_local4 < _local2.length) {
                    if (_local3.length > 0){
                        _local3 = _local3.concat(_local2[_local4].charAt(0).toUpperCase(), _local2[_local4].substring(1, _local2[_local4].length));
                    } else {
                        _local3 = _local2[_local4];
                    };
                    _local4++;
                };
            };
            return (_local3);
        }
        public static function beginsWith(_arg1:String, _arg2:String):Boolean{
            if ((((((((((_arg1 == null)) || (!(_arg1.length)))) || ((_arg2 == null)))) || (!(_arg2.length)))) || ((_arg1.length < _arg2.length)))){
                return (false);
            };
            var _local3:Number = 0;
            while (_local3 < _arg2.length) {
                if (_arg1.charCodeAt(_local3) != _arg2.charCodeAt(_local3)){
                    return (false);
                };
                _local3++;
            };
            return (true);
        }
        public static function ellipsis(_arg1:String, _arg2:TextField, _arg3:TextFormat=null):String{
            var _local6:Number;
            var _local7:Number;
            var _local4:String = _arg2.text;
            var _local5:String = _arg1;
            if (_arg3){
                _arg2.setTextFormat(_arg3);
            };
            _arg2.text = _arg1;
            if ((((_arg2.textWidth > _arg2.width)) || ((_arg2.textHeight > _arg2.height)))){
                _local6 = Math.round((_arg1.length / 2));
                _local7 = _local6;
                do  {
                    _local6 = Math.floor((_local6 / 2));
                    _arg2.text = (_arg1.substring(0, _local7) + "...");
                    if ((((_arg2.textWidth > _arg2.width)) || ((_arg2.textHeight > _arg2.height)))){
                        _local7 = (_local7 - _local6);
                    } else {
                        _local7 = (_local7 + _local6);
                        _local5 = _arg2.text;
                    };
                } while (_local6);
            };
            _arg2.text = _local4;
            return (_local5);
        }
        public static function rtrim(_arg1:String):String{
            var _local2:int = _arg1.length;
            while (_local2--) {
                if (_arg1.charCodeAt(_local2) > 32){
                    return (_arg1.substring(0, (_local2 + 1)));
                };
            };
            return ("");
        }
        public static function parseRatio(_arg1:String):Number{
            var _local5:Number;
            if (!_arg1){
                return (0);
            };
            var _local2:Object = ASPECT_REGEX.exec(_arg1);
            if (!_local2){
                _local5 = parseFloat(_arg1);
                if (isNaN(_local5)){
                    return (0);
                };
                return (_local5);
            };
            var _local3:Number = parseFloat(_local2[1]);
            var _local4:Number = parseFloat(_local2[2]);
            if ((((((_local4 == 0)) || (isNaN(_local3)))) || (isNaN(_local4)))){
                return (0);
            };
            return ((_local3 / _local4));
        }
        public static function isNullOrEmpty(_arg1:String):Boolean{
            if (((_arg1) && (Boolean(trim(_arg1))))){
                return (false);
            };
            return (true);
        }
        public static function underscoreSeparatedNumbersToArray(_arg1:String, _arg2:int=-1):Array{
            var _local5:Number;
            if (!_arg1){
                return (null);
            };
            var _local3:Array = _arg1.split("_");
            if (((!((_arg2 == -1))) && (!((_local3.length == _arg2))))){
                return (null);
            };
            var _local4:int;
            while (_local4 < _local3.length) {
                _local5 = parseFloat(_local3[_local4]);
                if (isNaN(_local5)){
                    return (null);
                };
                _local3[_local4] = _local5;
                _local4++;
            };
            return (_local3);
        }
        public static function formatNumber(_arg1:Number):String{
            var _local2:String = _arg1.toString();
            var _local3:Object = NUMBER_RE.exec(_local2);
            if (_local3[2]){
                if (_local3.prefix){
                    _local2 = _local2.substr(_local3.prefix.length);
                    _local2 = _local2.replace(NUMBER_GROUP_RE, "$1,").slice(0, -1);
                    return (((_local3.prefix + ",") + _local2));
                };
                _local2 = _local2.replace(NUMBER_GROUP_RE, "$1,").slice(0, -1);
                return (_local2);
            };
            return (_local2);
        }
        public static function formatTime(_arg1:Number, _arg2:Boolean=false, _arg3:uint=3, _arg4:Boolean=false):String{
            var _local15:Number;
            if (isNaN(_arg1)){
                return ("");
            };
            var _local5:Array = [];
            var _local6 = "";
            if (_arg1 < 0){
                _local6 = "-";
                _arg1 = -(Math.ceil(_arg1));
            } else {
                _arg1 = Math.floor(_arg1);
            };
            var _local7:Number = (Math.floor((_arg1 / 1000)) % 60);
            var _local8:Number = (Math.floor((_arg1 / 60000)) % 60);
            var _local9:Number = ((_arg4) ? (Math.floor((_arg1 / 3600000)) % 24) : Math.floor((_arg1 / 3600000)));
            var _local10:Number = Math.floor((_arg1 / 86400000));
            var _local11:String = ((_local7)<10) ? ("0" + _local7.toString()) : _local7.toString();
            if (!_arg2){
                _local15 = (_arg1 % 1000);
                _local11 = _local11.concat(".", (((_local15 < 10)) ? "0" : ""), (((_local15 < 100)) ? "0" : ""), _local15.toString());
            };
            var _local12:String = (((((_local8 < 10)) && ((((((_local9 > 0)) || ((_local10 > 0)))) || ((_arg3 > 3)))))) ? ("0" + _local8.toString()) : _local8.toString());
            var _local13 = "";
            var _local14 = "";
            if (_arg4){
                _local13 = (((((_local9 < 10)) && ((((_local10 > 0)) || ((_arg3 > 5)))))) ? ("0" + _local9.toString()) : _local9.toString());
                _local14 = ((_local10) ? _local10.toString() : "");
                _local14 = (repeat("0", ((_arg3 - _local14.length) - 6)) + _local14);
            } else {
                _local13 = ((_local9) ? _local9.toString() : "");
                _local13 = (repeat("0", ((_arg3 - _local13.length) - 4)) + _local13);
            };
            pushNonEmptyStrings(_local5, _local14, _local13, _local12, _local11);
            return (_local6.concat(_local5.join(":")));
        }
        public static function ltrim(_arg1:String):String{
            var _local2:uint = _arg1.length;
            var _local3:uint;
            while (_local3 < _local2) {
                if (_arg1.charCodeAt(_local3) > 32){
                    return (_arg1.substring(_local3));
                };
                _local3++;
            };
            return ("");
        }
        public static function parseTime(_arg1:String):Number{
            var _local2:Object = TIME_DELIM_RE.exec(_arg1);
            if (((!(_local2)) || ((_local2[0].length == 0)))){
                return (NaN);
            };
            return ((((_local2.sign) ? -1 : 1) * ((((((parseInt(_local2.h)) || (0)) * 3600000) + (((parseInt(_local2.m)) || (0)) * 60000)) + (((parseInt(_local2.s)) || (0)) * 1000)) + ((parseInt(_local2.ss.concat("000").substr(0, 3))) || (0)))));
        }
        private static function pushNonEmptyStrings(_arg1:Array, ... _args):void{
            var _local3:String;
            for each (_local3 in _args) {
                if (_local3){
                    _arg1.push(_local3);
                };
            };
        }
        public static function generateRandomString(_arg1:uint):String{
            var _local2:int = ALPHANUM_CHAR_ARRAY.length;
            var _local3 = "";
            var _local4:uint;
            while (_local4 < _arg1) {
                _local3 = (_local3 + ALPHANUM_CHAR_ARRAY[int(Math.floor((Math.random() * _local2)))]);
                _local4++;
            };
            return (_local3);
        }
        public static function parseTimeEnglish(_arg1:String):Number{
            var _local2:Object = TIME_HMS_RE.exec(_arg1);
            if (((!(_local2)) || ((_local2[0].length == 0)))){
                return (NaN);
            };
            return ((((_local2.sign) ? -1 : 1) * ((((((parseInt(_local2.h)) || (0)) * 3600000) + (((parseInt(_local2.m)) || (0)) * 60000)) + (((parseInt(_local2.s)) || (0)) * 1000)) + ((parseInt(_local2.ss.concat("000").substr(0, 3))) || (0)))));
        }
        public static function trim(_arg1:String):String{
            return (ltrim(rtrim(_arg1)));
        }
        public static function repeat(_arg1:String, _arg2:Number):String{
            var _local3 = "";
            var _local4:uint;
            while (_local4 < _arg2) {
                _local3 = (_local3 + _arg1);
                _local4++;
            };
            return (_local3);
        }
        public static function parseStringToMap(_arg1:String, _arg2:String=",", _arg3:String="="):Dictionary{
            var _local6:String;
            var _local7:Array;
            var _local8:String;
            var _local9:String;
            if (isNullOrEmpty(_arg1)){
                return (new Dictionary());
            };
            var _local4:Dictionary = new Dictionary();
            var _local5:Array = _arg1.split(_arg2);
            for each (_local6 in _local5) {
                _local7 = _local6.split(_arg3);
                if (_local7.length != 2){
                    return (null);
                };
                _local8 = trim(_local7[0]);
                _local9 = trim(_local7[1]);
                _local4[_local8] = _local9;
            };
            return (_local4);
        }
        public static function format(_arg1:String, _arg2:Object):String{
            var part:* = null;
            var pos:* = 0;
            var key:* = null;
            var template:* = _arg1;
            var args:* = _arg2;
            var unescapeClosingBrackets:* = function (_arg1:String):String{
                _arg1 = _arg1.replace(/\}\}/g, "{");
                if (_arg1.indexOf("}") > -1){
                    throw (new ArgumentError("Found close bracket without open bracket \"}\""));
                };
                return (_arg1.replace(/\{/g, "}"));
            };
            var parts:* = template.split("{");
            var max:* = parts.length;
            parts[0] = unescapeClosingBrackets(parts[0]);
            var i:* = 1;
            for (;i < max;(i = (i + 1))) {
                part = parts[i];
                if (part == ""){
                    parts[i] = "{";
                    i = (i + 1);
                    if (i < max){
                        parts[i] = unescapeClosingBrackets(parts[i]);
                        continue;
                    };
                    throw (new ArgumentError(MISSING_CLOSE_BRACKET));
                };
                pos = part.indexOf("}");
                if (pos == -1){
                    throw (new ArgumentError(MISSING_CLOSE_BRACKET));
                };
                key = part.substr(0, pos);
                if ((key in args)){
                    parts[i] = (args[key] + unescapeClosingBrackets(part.substr((pos + 1))));
                } else {
                    throw (new ArgumentError(((("Args object didn't contain argument \"" + key) + "\" but ") + "it was found in the template string")));
                };
            };
            return (parts.join(""));
        }
        private static function getKeyIndex(_arg1:String, _arg2:String, _arg3:String, _arg4:int):int{
            var _local5:String = (_arg3 + _arg2);
            return (_arg1.indexOf(_local5, _arg4));
        }
        public static function addWholeWords(_arg1:Array, _arg2:uint, _arg3:String=""):String{
            var _local6:String;
            var _local7:uint;
            if (_arg1 == null){
                return (_arg3);
            };
            var _local4:Array = ((StringUtils.isNullOrEmpty(_arg3)) ? [] : [_arg3]);
            var _local5:uint = _arg3.length;
            for each (_local6 in _arg1) {
                _local7 = (_local5 + _local6.length);
                _local7 = (_local7 + (((_local5 > 0)) ? 1 : 0));
                if (_local7 <= _arg2){
                    _local4.push(_local6);
                    _local5 = _local7;
                } else {
                    break;
                };
            };
            return (_local4.join(" "));
        }
        public static function fromCamelCase(_arg1:String):String{
            var _local5:Number;
            var _local2 = "";
            var _local3:int;
            var _local4 = 1;
            while (_local4 < _arg1.length) {
                _local5 = _arg1.charCodeAt(_local4);
                if ((((_local5 >= 65)) && ((_local5 <= 90)))){
                    if (_local2.length == 0){
                        _local2 = _local2.concat(_arg1.substring(_local3, _local4).toLowerCase());
                    } else {
                        _local2 = _local2.concat("_", _arg1.substring(_local3, _local4).toLowerCase());
                    };
                    _local3 = _local4;
                };
                _local4++;
            };
            if (_local2.length == 0){
                _local2 = _local2.concat(_arg1.substring(_local3).toLowerCase());
            } else {
                _local2 = _local2.concat("_", _arg1.substring(_local3).toLowerCase());
            };
            return (_local2);
        }
        public static function removeKeyValues(_arg1:String, _arg2:String, _arg3:String):String{
            var _local7:int;
            var _local8:int;
            var _local9:String;
            var _local10:String;
            var _local4:String = _arg1;
            var _local5:int;
            var _local6:int = getKeyIndex(_local4, _arg2, _arg3, _local5);
            while (_local6 != -1) {
                _local7 = _local4.indexOf("=", _local6);
                if (_local7 == -1){
                    _local5 = ((_local6 + _arg2.length) + 1);
                } else {
                    _local8 = _local4.indexOf(_arg3, _local7);
                    if (_local8 == -1){
                        _local4 = _local4.substring(0, _local6);
                    } else {
                        _local9 = _local4.substring(0, _local6);
                        _local10 = _local4.substring(_local8);
                        _local4 = (_local9 + _local10);
                    };
                };
                _local6 = getKeyIndex(_local4, _arg2, _arg3, _local5);
            };
            return (_local4);
        }

    }
}//package com.google.utils 
