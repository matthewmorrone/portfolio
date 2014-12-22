package com.adobe.serialization.json {

    public final class JSON {

        public static function encode(_arg1:Object):String{
            return (new JSONEncoder(_arg1).getString());
        }
        public static function decode(_arg1:String, _arg2:Boolean=true){
            return (new JSONDecoder(_arg1, _arg2).getValue());
        }

    }
}//package com.adobe.serialization.json 
