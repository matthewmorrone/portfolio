package scripts {
    import flash.display.*;
    import flash.text.*;
    import flash.geom.*;

    public class FishEyeButton extends MovieClip {

        public var textTitle:TextField;
        public var textTitleStyle:TextFormat;
        private var relativePoint:Point;
        private var scaleOffset:Number = 1;
        public var fontArialBlack:Font;

        public function FishEyeButton(){
            this.textTitle = new TextField();
            this.textTitleStyle = new TextFormat();
            this.fontArialBlack = new ArialBlack();
            super();
            this.relativePoint = new Point(0, 0);
            this.textTitleStyle.font = this.fontArialBlack.fontName;
            this.textTitleStyle.size = 16;
            this.textTitleStyle.color = 0;
            this.textTitle.x = -30;
            this.textTitle.y = -12;
            this.textTitle.width = 60;
            this.textTitle.height = 60;
            this.textTitle.mouseEnabled = false;
            this.textTitle.selectable = false;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            this.textTitle.multiline = true;
            this.textTitle.autoSize = TextFieldAutoSize.CENTER;
            this.addChild(this.textTitle);
        }
        public function SetScaleOffset(_arg1:Number):void{
            this.scaleOffset = _arg1;
            this.scaleX = _arg1;
            this.scaleY = _arg1;
        }
        public function SetScale(_arg1:Point):void{
            var _local4:Number;
            var _local2:Point = new Point((this.x + this.relativePoint.x), (this.y + this.relativePoint.y));
            var _local3:Number = Point.distance(_local2, _arg1);
            _local4 = (1 * this.scaleOffset);
            if (_local3 < 100){
                _local4 = ((1.5 * this.scaleOffset) - (_local3 / 100));
            };
            if (_local4 < this.scaleOffset){
                _local4 = this.scaleOffset;
            };
            this.scaleX = _local4;
            this.scaleY = _local4;
        }
        public function SetTitle(_arg1:String){
            this.textTitle.text = _arg1;
        }
        public function SetTitleSize(_arg1:uint){
            this.textTitleStyle.size = _arg1;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
        }
        public function SetTitlePosition(_arg1:Point){
            this.textTitle.x = _arg1.x;
            this.textTitle.y = _arg1.y;
        }
        public function GetWidth():Number{
            return ((this.width + (35 * this.scaleX)));
        }
        public function SetRelativePoint(_arg1:Point):void{
            this.relativePoint = _arg1;
        }

    }
}//package scripts 
