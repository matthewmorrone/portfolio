package com.google.utils {

    public class KeyValuePair {

        public var value:Object;
        public var key:Object;

        public function KeyValuePair(_arg1:Object, _arg2:Object){
            this.key = _arg1;
            this.value = _arg2;
        }
        public function toString():String{
            return ((((("{" + key) + ": ") + value) + "}"));
        }

    }
}//package com.google.utils 
