package scripts {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;

    public class FishEyeButtonSidebar extends MovieClip {

        public var textTitle:TextField;
        public var textTitleStyle:TextFormat;
        public var mcBackground:MovieClip;
        public var bFullFeatured:Boolean = true;
        public var colFullFeatured:uint = 2179753;
        public var colFeatureDisabled:uint = 0xAAAAAA;
        private var colBaseColor:uint = 0;

        public function FishEyeButtonSidebar(){
            this.textTitle = new TextField();
            this.textTitleStyle = new TextFormat();
            this.mcBackground = new MovieClip();
            super();
            this.mcBackground.name = "sidebarButtonBackground";
            this.mcBackground.graphics.beginFill(this.colFullFeatured, 1);
            this.mcBackground.graphics.drawRect(0, 0, 145, 25);
            this.addChild(this.mcBackground);
            this.textTitleStyle.font = "Arial";
            this.textTitleStyle.size = 16;
            this.textTitleStyle.color = 0xFFFFFF;
            this.textTitleStyle.bold = false;
            this.textTitleStyle.align = TextFormatAlign.CENTER;
            this.textTitle.x = 0;
            this.textTitle.y = 0;
            this.textTitle.width = 60;
            this.textTitle.height = 60;
            this.textTitle.mouseEnabled = false;
            this.textTitle.selectable = false;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            this.textTitle.multiline = false;
            this.textTitle.autoSize = TextFieldAutoSize.LEFT;
            this.addChild(this.textTitle);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.EVENT_Sidebar_MouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.EVENT_Sidebar_MouseOut);
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
            this.textTitle.defaultTextFormat = this.textTitleStyle;
        }
        public function SetTitlePosition(_arg1:Point){
            this.textTitle.x = _arg1.x;
            this.textTitle.y = _arg1.y;
        }
        public function Unavailable():void{
            if (!this.bFullFeatured){
                return;
            };
            var _local1:ColorTransform = this.mcBackground.transform.colorTransform;
            _local1.color = this.LightenColor(this.colBaseColor, 0.6);
            this.mcBackground.transform.colorTransform = _local1;
        }
        public function Available():void{
            if (!this.bFullFeatured){
                return;
            };
            var _local1:ColorTransform = this.mcBackground.transform.colorTransform;
            _local1.color = this.colBaseColor;
            this.mcBackground.transform.colorTransform = _local1;
        }
        public function SetBaseColor(_arg1:uint):void{
            this.colBaseColor = _arg1;
            var _local2:ColorTransform = this.mcBackground.transform.colorTransform;
            _local2.color = _arg1;
            this.mcBackground.transform.colorTransform = _local2;
        }
        private function EVENT_Sidebar_MouseOver(_arg1:Event):void{
            var _local2:ColorTransform = this.mcBackground.transform.colorTransform;
            _local2.color = this.LightenColor(this.colBaseColor, 0.4);
            this.mcBackground.transform.colorTransform = _local2;
        }
        private function EVENT_Sidebar_MouseOut(_arg1:Event):void{
            var _local2:ColorTransform = this.mcBackground.transform.colorTransform;
            if (this.bFullFeatured){
                _local2.color = this.colBaseColor;
            } else {
                _local2.color = this.colFeatureDisabled;
            };
            this.mcBackground.transform.colorTransform = _local2;
        }
        private function LightenColor(_arg1:uint, _arg2:Number):uint{
            var _local3:uint;
            _local3 = ((_arg1 & 0xFF0000) + ((Number((0xFF - ((_arg1 & 0xFF0000) >> 16))) * _arg2) << 16));
            _local3 = (_local3 | ((_arg1 & 0xFF00) + ((Number((0xFF - ((_arg1 & 0xFF00) >> 8))) * _arg2) << 8)));
            _local3 = (_local3 | ((_arg1 & 0xFF) + (Number((0xFF - (_arg1 & 0xFF))) * _arg2)));
            return (_local3);
        }

    }
}//package scripts 
