package scripts {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;

    public class WinScreenButton extends MovieClip {

        public var textTitle:TextField;
        public var textTitleStyle:TextFormat;
        public var mcBackground:MovieClip;
        public var bFullFeatured:Boolean = true;
        public var colFullFeatured:uint = 2179753;
        public var colFeatureDisabled:uint = 0xAAAAAA;

        public function WinScreenButton(){
            this.textTitle = new TextField();
            this.textTitleStyle = new TextFormat();
            this.mcBackground = new MovieClip();
            super();
            this.textTitleStyle.font = "Arial";
            this.textTitleStyle.size = 16;
            this.textTitleStyle.color = 0xFFFFFF;
            this.textTitleStyle.bold = false;
            this.textTitle.x = 0;
            this.textTitle.y = 0;
            this.textTitle.width = 400;
            this.textTitle.height = 60;
            this.textTitle.mouseEnabled = false;
            this.textTitle.selectable = false;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            this.textTitle.multiline = false;
            this.textTitle.autoSize = TextFieldAutoSize.CENTER;
            this.addEventListener(MouseEvent.MOUSE_OVER, this.EVENT_WinScreenButton_MouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.EVENT_WinScreenButton_MouseOut);
        }
        public function FullFeatured(_arg1:Boolean):void{
            var _local2:ColorTransform;
            this.bFullFeatured = _arg1;
            if (!this.bFullFeatured){
                _local2 = this.mcBackground.transform.colorTransform;
                _local2.color = this.colFeatureDisabled;
                this.mcBackground.transform.colorTransform = _local2;
            };
        }
        public function IsFullFeatured():Boolean{
            return (this.bFullFeatured);
        }
        public function SetTitle(_arg1:String){
            this.textTitle.text = _arg1;
            this.mcBackground.name = "winScreenButtonBackground";
            this.mcBackground.graphics.beginFill(this.colFullFeatured, 1);
            this.mcBackground.graphics.drawRect((this.textTitle.x - 10), -2, (this.textTitle.width + 25), 25);
            this.addChild(this.mcBackground);
            this.addChild(this.textTitle);
        }
        public function SetWidth(_arg1:Number){
            this.textTitle.width = _arg1;
        }
        public function SetTitlePosition(_arg1:Point){
            this.textTitle.x = _arg1.x;
            this.textTitle.y = _arg1.y;
        }
        public function Unavailable():void{
            if (!this.bFullFeatured){
                return;
            };
            this.mcBackground.alpha = 0.5;
        }
        public function Available():void{
            if (!this.bFullFeatured){
                return;
            };
            this.mcBackground.alpha = 1;
        }
        private function EVENT_WinScreenButton_MouseOver(_arg1:Event):void{
            var _local2:ColorTransform = this.mcBackground.transform.colorTransform;
            _local2.color = 4619183;
            this.mcBackground.transform.colorTransform = _local2;
        }
        private function EVENT_WinScreenButton_MouseOut(_arg1:Event):void{
            var _local2:ColorTransform = this.mcBackground.transform.colorTransform;
            if (this.bFullFeatured){
                _local2.color = this.colFullFeatured;
            } else {
                _local2.color = this.colFeatureDisabled;
            };
            this.mcBackground.transform.colorTransform = _local2;
        }

    }
}//package scripts 
