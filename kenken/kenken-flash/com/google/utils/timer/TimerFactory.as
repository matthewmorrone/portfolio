package com.google.utils.timer {
    import flash.utils.*;

    public class TimerFactory {

        private static var timerClass:Class = Timer;

        public static function createTimer(_arg1:Number, _arg2:Number=0):Timer{
            return (new timerClass(_arg1, _arg2));
        }
        public static function setTimerClassForTesting(_arg1:Class):void{
            timerClass = _arg1;
        }

    }
}//package com.google.utils.timer 
