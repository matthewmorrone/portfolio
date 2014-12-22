package com.google.ads.ima.apidependency {
    import flash.utils.*;
    import com.google.utils.*;
    import mx.utils.*;

    public class MultipartMessage {

        private static const URL_LENGTH_LIMIT:uint = 2000;

        private var originalMessageValue:String;
        private var urlLengthLimitValue:uint;
        private var idValue:String;
        private var dataLeft:String;

        public function MultipartMessage(_arg1:String, _arg2:Boolean=true, _arg3:uint=2000){
            idValue = ("id_" + Math.floor((Math.random() * 1000000)));
            urlLengthLimitValue = _arg3;
            originalMessageValue = _arg1;
            if (_arg2){
                dataLeft = compress(_arg1);
            } else {
                dataLeft = _arg1;
            };
        }
        public function getNextDataPart(_arg1:String):String{
            var _local2:int = getAvailableSpace(_arg1);
            if (_local2 > 0){
                return (takeDataForAvailableSpace(_local2));
            };
            return ("");
        }
        private function compress(_arg1:String):String{
            var _local2:ByteArray = new ByteArray();
            _local2.writeUTFBytes(_arg1);
            _local2.compress();
            var _local3:Base64Encoder = new Base64Encoder();
            _local3.encodeBytes(_local2);
            return (_local3.toString());
        }
        public function hasDataLeft():Boolean{
            return (!(StringUtils.isNullOrEmpty(dataLeft)));
        }
        private function takeDataForAvailableSpace(_arg1:int):String{
            var _local3:String;
            var _local4:String;
            var _local5:uint;
            var _local2 = "";
            if (hasDataLeft()){
                _local5 = 0;
                while (_local5 < dataLeft.length) {
                    _local3 = dataLeft.charAt(_local5);
                    _local4 = encodeURIComponent(_local3);
                    _arg1 = (_arg1 - _local4.length);
                    if (_arg1 >= 0){
                        _local2 = (_local2 + _local3);
                    } else {
                        break;
                    };
                    _local5++;
                };
                dataLeft = dataLeft.slice(_local2.length);
            };
            return (_local2);
        }
        private function getAvailableSpace(_arg1:String):int{
            return ((urlLengthLimitValue - _arg1.length));
        }
        public function get id():String{
            return (idValue);
        }
        public function appendDataPartToUrl(_arg1:String):String{
            return ((_arg1 + encodeURIComponent(getNextDataPart(_arg1))));
        }

    }
}//package com.google.ads.ima.apidependency 
