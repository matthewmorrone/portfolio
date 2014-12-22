package scripts {
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class KenKenTimer extends MovieClip {

        public var display:TextField;
        private var secondsTimer:Timer;
        private var secondsCount:uint;
        private var timeString:String = "";
        private var sec:uint = 0;
        private var min:uint = 0;
        private var hrs:uint = 0;
        private var bDisabled:Boolean;

        public function KenKenTimer(){
            this.secondsTimer = new Timer(1000, 0);
            super();
            trace("KenKen timer created.");
            this.bDisabled = false;
            this.display.selectable = false;
            this.secondsCount = 0;
            this.secondsTimer.addEventListener(TimerEvent.TIMER, this.EVENT_TIMER_SecondsTimer);
        }
        private function EVENT_TIMER_SecondsTimer(_arg1:Event):void{
            this.secondsCount++;
            var _local2:Number = (this.secondsCount % 60);
            var _local3:Number = (Math.floor((this.secondsCount / 60)) % 60);
            var _local4:Number = (Math.floor((this.secondsCount / 3600)) % 60);
            var _local5:String = _local2.toString();
            var _local6:String = _local3.toString();
            var _local7:String = _local4.toString();
            _local5 = (((_local2 < 10)) ? ("0" + _local5) : _local5);
            _local6 = (((_local3 < 10)) ? ("0" + _local6) : _local6);
            _local7 = (((_local4 < 10)) ? ("0" + _local7) : _local7);
            if (!this.bDisabled){
                this.timeString = ((((_local7 + ":") + _local6) + ":") + _local5);
                this.display.text = this.timeString;
            } else {
                this.display.text = "00:00:00";
            };
            this.sec = _local2;
            this.min = _local3;
            this.hrs = _local4;
        }
        public function Disabled():void{
            this.bDisabled = true;
        }
        public function Enabled():void{
            this.bDisabled = false;
        }
        public function Reset():void{
            this.secondsCount = 0;
            this.timeString = "00:00:00";
            this.display.text = this.timeString;
            this.secondsTimer.reset();
        }
        public function Start():void{
            this.secondsTimer.start();
        }
        public function Stop():void{
            this.secondsTimer.stop();
        }
        public function GetTime():String{
            return (this.timeString);
        }
        public function GetSec():uint{
            return (this.sec);
        }
        public function GetMin():uint{
            return (this.min);
        }
        public function GetHrs():uint{
            return (this.hrs);
        }

    }
}//package scripts 
