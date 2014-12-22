package scripts {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;

    public class FishEyeSmallButton extends MovieClip {

        private var relativePoint:Point;
        protected var textTitle:TextField;
        protected var textTitleStyle:TextFormat;
        public var numAdjustScale:Number;

        public function FishEyeSmallButton(){
            this.textTitle = new TextField();
            this.textTitleStyle = new TextFormat();
            super();
            this.relativePoint = new Point(0, 0);
            this.numAdjustScale = 1;
            this.textTitleStyle.font = "Arial";
            this.textTitleStyle.size = 18;
            this.textTitleStyle.bold = true;
            this.textTitleStyle.color = 0xFFFFFF;
            this.textTitle.x = -9.5;
            this.textTitle.y = -12;
            this.textTitle.width = 20;
            this.textTitle.height = 20;
            this.textTitle.mouseEnabled = false;
            this.textTitle.selectable = false;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            this.textTitle.autoSize = TextFieldAutoSize.CENTER;
            this.mouseEnabled = true;
            this.buttonMode = true;
            this.useHandCursor = true;
            this.addChild(this.textTitle);
        }
        public function EVENT_SmallButton_Click(_arg1:Event):void{
        }
        public function SetScale(_arg1:Point, _arg2:Point):void{
            var _local4:Number;
            var _local3:Number = Point.distance(_arg2, _arg1);
            _local4 = this.numAdjustScale;
            if (_local3 < 20){
                _local4 = (this.numAdjustScale + (0.5 * (1 - (_local3 / 20))));
            };
            if (_local3 < (10 * this.numAdjustScale)){
            };
            this.scaleX = _local4;
            this.scaleY = _local4;
        }
        public function SetTitle(_arg1:String):void{
            this.textTitle.text = _arg1;
        }
        public function SetColor(_arg1:uint):void{
            this.textTitleStyle.color = _arg1;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            trace(this.textTitleStyle.color);
        }
        public function GetWidth():Number{
            return ((this.width + (10 * this.scaleX)));
        }
        public function AdjustScale(_arg1:Number):void{
            this.numAdjustScale = _arg1;
            this.scaleX = this.numAdjustScale;
            this.scaleY = this.numAdjustScale;
        }

    }
}//package scripts 
