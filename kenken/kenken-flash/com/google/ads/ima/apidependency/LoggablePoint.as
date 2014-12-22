package com.google.ads.ima.apidependency {

    public class LoggablePoint {

        private var youtubeValue:Boolean;
        private var idValue:uint;
        private var experimentIdValue:String;
        private var logAlwaysValue:Boolean;

        public function LoggablePoint(_arg1:uint, _arg2:Boolean, _arg3:Boolean, _arg4:String=null){
            this.idValue = _arg1;
            this.youtubeValue = _arg2;
            this.logAlwaysValue = _arg3;
            this.experimentIdValue = (((_arg4 == "")) ? null : _arg4);
        }
        public function toString():String{
            return (((((((("id:" + id) + " youtube:") + logForYoutubeOnly) + " logAlways:") + logAlways) + " experimentId:") + experimentId));
        }
        public function get logForYoutubeOnly():Boolean{
            return (youtubeValue);
        }
        public function get logAlways():Boolean{
            return (logAlwaysValue);
        }
        public function get experimentId():String{
            return (experimentIdValue);
        }
        public function get id():uint{
            return (idValue);
        }
        public function equals(_arg1:LoggablePoint):Boolean{
            return ((((((((id == _arg1.id)) && ((logForYoutubeOnly == _arg1.logForYoutubeOnly)))) && ((logAlways == _arg1.logAlways)))) && ((experimentId == _arg1.experimentId))));
        }

    }
}//package com.google.ads.ima.apidependency 
