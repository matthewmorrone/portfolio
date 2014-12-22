package com.google.ads.ima.common {

    public class MathUtils {

        public static function isRandomlySelected(_arg1:Number):Boolean{
            if (_arg1 <= 0){
                return (false);
            };
            if (_arg1 >= 1){
                return (true);
            };
            return ((Math.random() <= _arg1));
        }

    }
}//package com.google.ads.ima.common 
