package com.google.ads.ima.api {
    import com.google.ads.ima.api.*;

    class AdsLoaderError extends Error implements AdError {

        private var adIdsValue:Array;
        private var adSystemsValue:Array;
        private var flashError:Error;
        private var type:String;

        public function AdsLoaderError(_arg1:String="", _arg2:int=0){
            super(_arg1, _arg2);
        }
        public function get adSystems():Array{
            return (adSystemsValue);
        }
        public function set adSystems(_arg1:Array):void{
            adSystemsValue = _arg1;
        }
        public function set errorType(_arg1:String):void{
            this.type = _arg1;
        }
        public function get adIds():Array{
            return (adIdsValue);
        }
        public function get innerError():Error{
            return (flashError);
        }
        public function get errorMessage():String{
            return (super.message);
        }
        public function get errorType():String{
            return (type);
        }
        public function set innerError(_arg1:Error):void{
            this.flashError = _arg1;
        }
        public function set adIds(_arg1:Array):void{
            adIdsValue = _arg1;
        }
        public function get errorCode():int{
            return (super.errorID);
        }

    }
}//package com.google.ads.ima.api 
