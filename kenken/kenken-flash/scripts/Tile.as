package scripts {
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;

    public class Tile extends MovieClip {

        private var index:uint;
        private var solution:uint;
        private var value:uint;
        private var title:String;
        private var operator:String;
        private var mcOperator:MovieClip;
        public var mcEraser:EraserImage;
        public var mcRedCross:CommandRedCross;
        private var single:int = -1;
        private var puzzleSize:uint;
        private var numValueBtnAngleStep:Number;
        private var numValueBtnRadius:Number;
        private var arrValueBtnScaleAdjust:Array;
        private var arrRadiusValueScaleAdjust:Array;
        private var numCandBtnAngleStep:Number;
        private var numCandBtnRadius:Number;
        private var arrCandBtnScaleAdjust:Array;
        private var arrSelectedCandidates:Array;
        private var textTitle:TextField;
        private var textTitleStyle:TextFormat;
        private var textValue:TextField;
        private var textValueStyle:TextFormat;
        private var textCandidates:TextField;
        private var textCandidatesStyle:TextFormat;
        private var mcSelected:MovieClip;
        private var mcAlert:MovieClip;
        private var mcApprove:MovieClip;
        private var mcHover:MovieClip;
        public var candidateBar:MovieClip;
        public var valueBar:MovieClip;
        private var candidatesArray:Array;
        private var unalertTimer:Timer;
        private var unapproveTimer:Timer;
        public var fontArialBlack:Font;

        public function Tile(){
            this.mcOperator = new MovieClip();
            this.mcEraser = new EraserImage();
            this.mcRedCross = new CommandRedCross();
            this.arrValueBtnScaleAdjust = [1.5, 1.4, 1.3, 1, 1, 1, 1];
            this.arrRadiusValueScaleAdjust = [1, 0.8, 0.8, 0.75, 0.8, 0.8, 0.8];
            this.arrCandBtnScaleAdjust = [1, 1, 1, 1, 1, 1, 1];
            this.arrSelectedCandidates = new Array();
            this.textTitle = new TextField();
            this.textTitleStyle = new TextFormat();
            this.textValue = new TextField();
            this.textValueStyle = new TextFormat();
            this.textCandidates = new TextField();
            this.textCandidatesStyle = new TextFormat();
            this.mcSelected = new MovieClip();
            this.mcAlert = new MovieClip();
            this.mcApprove = new MovieClip();
            this.mcHover = new MovieClip();
            this.candidateBar = new MovieClip();
            this.candidatesArray = new Array();
            this.unalertTimer = new Timer(500, 0);
            this.unapproveTimer = new Timer(500, 0);
            this.fontArialBlack = new ArialBlack();
            super();
            this.mcOperator.name = "mcOperator";
            this.unapproveTimer.addEventListener(TimerEvent.TIMER, this.EVENT_TIMER_Unapprove);
            this.unalertTimer.addEventListener(TimerEvent.TIMER, this.EVENT_TIMER_Unalert);
            this.mcSelected.name = "mcSelected";
            this.mcSelected.graphics.beginFill(0xFFFF00, 0.3);
            this.mcSelected.graphics.drawRect(this.x, this.y, this.width, this.height);
            this.mcAlert.name = "mcAlert";
            this.mcAlert.graphics.beginFill(0xFF0000, 0.3);
            this.mcAlert.graphics.drawRect(this.x, this.y, this.width, this.height);
            this.mcApprove.name = "mcApprove";
            this.mcApprove.graphics.beginFill(0xFF00, 0.3);
            this.mcApprove.graphics.drawRect(this.x, this.y, this.width, this.height);
            this.mcHover.name = "mcHover";
            this.mcHover.graphics.beginFill(0xFF, 0.3);
            this.mcHover.graphics.drawRect(this.x, this.y, this.width, this.height);
            this.textTitleStyle.font = this.fontArialBlack.fontName;
            this.textTitleStyle.size = 22;
            this.textTitle.x = 10;
            this.textTitle.y = 4;
            this.textTitle.autoSize = TextFieldAutoSize.LEFT;
            this.textTitle.type = TextFieldType.DYNAMIC;
            this.textTitle.selectable = false;
            this.textTitle.mouseEnabled = false;
            this.textTitle.defaultTextFormat = this.textTitleStyle;
            this.addChild(this.textTitle);
            this.textValueStyle.font = this.fontArialBlack.fontName;
            this.textValueStyle.size = 48;
            this.textValue.x = 0;
            this.textValue.y = 25;
            this.textValue.autoSize = TextFieldAutoSize.CENTER;
            this.textValue.type = TextFieldType.DYNAMIC;
            this.textValue.selectable = false;
            this.textValue.mouseEnabled = false;
            this.textValue.defaultTextFormat = this.textValueStyle;
            this.textCandidatesStyle.font = this.fontArialBlack.fontName;
            this.textCandidatesStyle.size = 18;
            this.textCandidatesStyle.color = 0xFF;
            this.textCandidatesStyle.align = TextFormatAlign.RIGHT;
            this.textCandidates.x = 2;
            this.textCandidates.y = 35;
            this.textCandidates.autoSize = TextFieldAutoSize.NONE;
            this.textCandidates.type = TextFieldType.DYNAMIC;
            this.textCandidates.selectable = false;
            this.textCandidates.mouseEnabled = false;
            this.textCandidates.defaultTextFormat = this.textCandidatesStyle;
            this.textCandidates.width = 95;
            this.textCandidates.height = 60;
            this.textCandidates.multiline = true;
            this.addChild(this.textCandidates);
            this.addChild(this.textTitle);
            this.addChild(this.textValue);
            this.buttonMode = true;
            this.useHandCursor = true;
            addEventListener(MouseEvent.ROLL_OVER, this.EVENT_Tile_HoverIn);
            addEventListener(MouseEvent.ROLL_OUT, this.EVENT_Tile_HoverOut);
        }
        public function DisableTile():void{
            removeEventListener(MouseEvent.ROLL_OVER, this.EVENT_Tile_HoverIn);
            removeEventListener(MouseEvent.ROLL_OUT, this.EVENT_Tile_HoverOut);
            this.RemoveHover();
        }
        public function EnableTile():void{
            addEventListener(MouseEvent.ROLL_OVER, this.EVENT_Tile_HoverIn);
            addEventListener(MouseEvent.ROLL_OUT, this.EVENT_Tile_HoverOut);
        }
        public function CreateValueBar(_arg1:uint):void{
            var _local3:uint;
            var _local8:FishEyeSmallButton;
            var _local9:Point;
            var _local10:String;
            this.numValueBtnAngleStep = (360 / (_arg1 + 2));
            this.numValueBtnRadius = (70 * this.arrRadiusValueScaleAdjust[(_arg1 - 3)]);
            this.valueBar = new MovieClip();
            this.valueBar.name = "mcTileValueBar";
            this.valueBar.mouseEnabled = true;
            this.valueBar.buttonMode = true;
            this.valueBar.useHandCursor = true;
            var _local2:Number = this.arrValueBtnScaleAdjust[(_arg1 - 3)];
            _local3 = 0;
            while (_local3 < _arg1) {
                _local8 = new FishEyeSmallButton();
                _local8.AdjustScale(_local2);
                _local9 = this.CalcButtonPosition(_local3, this.numValueBtnRadius);
                _local8.x = _local9.x;
                _local8.y = _local9.y;
                _local10 = String((_local3 + 1));
                _local8.SetTitle(_local10);
                _local8.name = ("btnValue" + _local10);
                this.valueBar.addChild(_local8);
                _local3++;
            };
            var _local4:FishEyeSmallButton = new FishEyeSmallWhiteCommandButton();
            _local4.AdjustScale(_local2);
            var _local5:Point = this.CalcButtonPosition((_local3 + 1), this.numValueBtnRadius);
            _local4.x = _local5.x;
            _local4.y = _local5.y;
            _local4.AddMovieClip(this.mcRedCross);
            _local4.name = "btnValueX";
            this.valueBar.addChild(_local4);
            var _local6:FishEyeSmallButton = new FishEyeSmallWhiteCommandButton();
            _local6.AdjustScale(_local2);
            var _local7:Point = this.CalcButtonPosition(_local3, this.numValueBtnRadius);
            _local6.x = _local7.x;
            _local6.y = _local7.y;
            _local6.AddMovieClip(this.mcEraser);
            _local6.name = "btnValueC";
            this.valueBar.addChild(_local6);
        }
        public function CreateCandidateBar(_arg1:Number, _arg2:uint):void{
            var _local4:int;
            var _local9:Object;
            var _local10:FishEyeSmallCandSelButton;
            var _local11:Object;
            var _local12:Point;
            var _local13:String;
            var _local3:uint = this.candidateBar.numChildren;
            _local4 = (_local3 - 1);
            while (_local4 >= 0) {
                _local9 = this.candidateBar.getChildAt(_local4);
                this.candidateBar.removeChildAt(_local4);
                _local4--;
            };
            this.numCandBtnAngleStep = (360 / _arg2);
            this.numCandBtnRadius = _arg1;
            this.candidateBar.name = "mcTileCandidateBar";
            this.candidateBar.mouseEnabled = true;
            this.candidateBar.buttonMode = true;
            this.candidateBar.useHandCursor = true;
            var _local5:Number = this.arrCandBtnScaleAdjust[(_arg2 - 3)];
            if (this.single != -1){
                _local10 = new FishEyeSmallCandSelButton();
                _local10.AdjustScale(_local5);
                _local10.x = 0;
                _local10.y = 0;
                _local10.SetTitle(String(this.single));
                _local10.name = ("btnCandidate" + this.single);
                this.candidateBar.addChild(MovieClip(_local10));
                this.arrSelectedCandidates[(this.single - 1)] = true;
                return;
            };
            var _local6:Point = new Point(0, 0);
            _local4 = 0;
            while (_local4 < _arg2) {
                if (this.arrSelectedCandidates[_local4]){
                    _local11 = new FishEyeSmallCandSelButton();
                } else {
                    _local11 = new FishEyeSmallCandButton();
                };
                _local11.AdjustScale(_local5);
                _local12 = this.CalcCandidateButtonPosition(_local4, ((_local11.GetWidth() / 2) + 13));
                _local6.x = ((_local12.x + (_local11.GetWidth() / 2)) + 13);
                _local6.y = _local12.y;
                _local11.x = _local12.x;
                _local11.y = _local12.y;
                _local13 = String((_local4 + 1));
                _local11.SetTitle(_local13);
                _local11.name = ("btnCandidate" + _local13);
                this.candidateBar.addChild(MovieClip(_local11));
                _local4++;
            };
            var _local7:Object = new FishEyeCandSelectAll();
            _local7.AdjustScale(_local5);
            _local7.x = 0;
            _local7.y = (this.GetRowsCount() * ((_local7.GetWidth() / 2) + 13));
            _local7.name = "btnCandidateAll";
            this.candidateBar.addChild(MovieClip(_local7));
            var _local8:Object = new FishEyeCandUnSelectAll();
            _local8.AdjustScale(_local5);
            _local8.x = (2 * ((_local8.GetWidth() / 2) + 13));
            _local8.y = (this.GetRowsCount() * ((_local8.GetWidth() / 2) + 13));
            _local8.name = "btnCandidateNone";
            this.candidateBar.addChild(MovieClip(_local8));
        }
        public function Select():void{
            var _local1:Object = this.getChildByName("mcHover");
            if (_local1){
                this.removeChild(this.mcHover);
            };
            var _local2:Object = this.getChildByName("mcSelected");
            if (!_local2){
                this.addChild(this.mcSelected);
            };
        }
        private function CalcButtonPosition(_arg1:uint, _arg2:Number):Point{
            return (new Point((Math.cos(((((_arg1 * this.numValueBtnAngleStep) - 90) * Math.PI) / 180)) * _arg2), (Math.sin(((((_arg1 * this.numValueBtnAngleStep) - 90) * Math.PI) / 180)) * _arg2)));
        }
        private function CalcCandidateButtonPosition(_arg1:uint, _arg2:Number):Point{
            return (new Point(((_arg1 % 3) * _arg2), (int((_arg1 / 3)) * _arg2)));
        }
        public function UpdateFishButtons(_arg1:Point):void{
            var _local2:uint;
            var _local3:FishEyeSmallButton;
            var _local4:Point;
            var _local5:FishEyeSmallButton;
            var _local6:Point;
            _local2 = 0;
            while (_local2 < this.valueBar.numChildren) {
                _local3 = FishEyeSmallButton(this.valueBar.getChildAt(_local2));
                if (_local3){
                    _local4 = new Point((((_local3.x + this.x) + (this.width / 2)) + KenKen.mcContainerTiles.x), (((_local3.y + this.y) + (this.height / 2)) + KenKen.mcContainerTiles.y));
                    _local3.SetScale(_arg1, _local4);
                };
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.candidateBar.numChildren) {
                _local5 = FishEyeSmallButton(this.candidateBar.getChildAt(_local2));
                if (_local5){
                    _local6 = new Point((_local5.x + this.candidateBar.x), (_local5.y + this.candidateBar.y));
                    _local5.SetScale(_arg1, _local6);
                };
                _local2++;
            };
        }
        public function Unselect():void{
            var _local1:Object = this.getChildByName("mcSelected");
            if (_local1){
                this.removeChild(this.mcSelected);
            };
        }
        public function SetIndex(_arg1:uint):void{
            this.index = _arg1;
        }
        public function GetIndex():uint{
            return (this.index);
        }
        public function SetSolution(_arg1:int):void{
            this.solution = _arg1;
        }
        public function GetSolution():int{
            return (this.solution);
        }
        public function SetTitle(_arg1:String, _arg2:String):void{
            this.textTitle.text = _arg1;
            var _local3:Number = 1.2;
            if (_arg2 == "/"){
                this.mcOperator = new DivideOperator();
                this.mcOperator.x = ((this.textTitle.x + this.textTitle.width) + 2);
                this.mcOperator.y = (this.textTitle.y + 7);
                this.mcOperator.scaleX = _local3;
                this.mcOperator.scaleY = _local3;
                this.addChild(this.mcOperator);
            } else {
                if (_arg2 == "*"){
                    this.mcOperator = new MultiplyOperator();
                    this.mcOperator.x = ((this.textTitle.x + this.textTitle.width) + 2);
                    this.mcOperator.y = (this.textTitle.y + 11);
                    this.mcOperator.scaleX = _local3;
                    this.mcOperator.scaleY = _local3;
                    this.addChild(this.mcOperator);
                } else {
                    if (_arg2 == "+"){
                        this.mcOperator = new AddOperator();
                        this.mcOperator.x = ((this.textTitle.x + this.textTitle.width) + 2);
                        this.mcOperator.y = (this.textTitle.y + 8);
                        this.mcOperator.scaleX = _local3;
                        this.mcOperator.scaleY = _local3;
                        this.addChild(this.mcOperator);
                    } else {
                        if (_arg2 == "-"){
                            this.mcOperator = new SubtractOperator();
                            this.mcOperator.x = ((this.textTitle.x + this.textTitle.width) + 2);
                            this.mcOperator.y = (this.textTitle.y + 16);
                            this.mcOperator.scaleX = _local3;
                            this.mcOperator.scaleY = _local3;
                            this.addChild(this.mcOperator);
                        };
                    };
                };
            };
        }
        public function GetTitle():String{
            return (this.textTitle.text);
        }
        public function SetValue(_arg1:String):void{
            this.textValue.text = _arg1;
        }
        public function GetValue():String{
            return (this.textValue.text);
        }
        public function SetSingle(_arg1:int):void{
            this.single = _arg1;
        }
        public function GetSingle():int{
            return (this.single);
        }
        public function GetCandidates():Array{
            return (this.arrSelectedCandidates);
        }
        public function SetCandidates(_arg1){
            this.arrSelectedCandidates = _arg1;
        }
        public function EnableCandidate(_arg1:uint):void{
            this.arrSelectedCandidates[(_arg1 - 1)] = true;
        }
        public function DisableCandidate(_arg1:uint):void{
            this.arrSelectedCandidates[(_arg1 - 1)] = false;
        }
        public function DisableAllCandidates(_arg1:uint):void{
            var _local2:uint;
            _local2 = 0;
            while (_local2 < _arg1) {
                this.arrSelectedCandidates[_local2] = false;
                _local2++;
            };
        }
        public function IsCandidateSelected(_arg1:uint):uint{
            return (this.arrSelectedCandidates[(_arg1 - 1)]);
        }
        public function CreateCandidatesArray(_arg1:uint):void{
            var _local2:uint;
            this.puzzleSize = _arg1;
            _local2 = 0;
            while (_local2 < _arg1) {
                this.arrSelectedCandidates.push(false);
                _local2++;
            };
        }
        public function ClearCandidatesArray():void{
            this.arrSelectedCandidates.splice(0, this.arrSelectedCandidates.length);
        }
        public function CheckCandidate(_arg1:uint):uint{
            if (this.GetValue() == String(_arg1)){
                this.Alert();
                return (0);
            };
            return (1);
        }
        public function Alert():void{
            this.unalertTimer.start();
            var _local1:Object = this.getChildByName("mcAlert");
            if (!_local1){
                this.addChild(this.mcAlert);
            };
        }
        public function Unalert():void{
            var _local1:Object = this.getChildByName("mcAlert");
            if (_local1){
                this.removeChild(this.mcAlert);
            };
        }
        private function EVENT_TIMER_Unalert(_arg1:Event):void{
            this.Unalert();
            this.unalertTimer.stop();
            this.unalertTimer.reset();
        }
        public function Approve():void{
            this.unapproveTimer.start();
            var _local1:Object = this.getChildByName("mcApprove");
            if (!_local1){
                this.addChild(this.mcApprove);
            };
        }
        public function Unapprove():void{
            var _local1:Object = this.getChildByName("mcApprove");
            if (_local1){
                this.removeChild(this.mcApprove);
            };
        }
        private function EVENT_TIMER_Unapprove(_arg1:Event):void{
            this.Unapprove();
            this.unapproveTimer.stop();
            this.unapproveTimer.reset();
        }
        private function EVENT_Tile_HoverIn(_arg1:Event):void{
            var _local2:Object = this.getChildByName("mcSelected");
            if (_local2){
                return;
            };
            var _local3:Object = this.getChildByName("mcHover");
            if (!_local3){
                this.addChild(this.mcHover);
            };
        }
        private function EVENT_Tile_HoverOut(_arg1:Event):void{
            this.RemoveHover();
        }
        public function RemoveHover():void{
            var _local1:Object = this.getChildByName("mcHover");
            if (_local1){
                this.removeChild(this.mcHover);
            };
        }
        public function GetHoverCandidatesArray():Array{
            return (this.arrSelectedCandidates);
        }
        public function RenderCandidates():void{
            var _local2:uint;
            var _local3:*;
            var _local4:*;
            if (this.single != -1){
                return;
            };
            if (this.textValue.text != ""){
                return;
            };
            this.textCandidates.text = "";
            var _local1 = "";
            _local2 = 0;
            while (_local2 < this.arrSelectedCandidates.length) {
                if (this.arrSelectedCandidates[_local2]){
                    _local1 = (_local1 + ((_local2 + 1) + " "));
                };
                _local2++;
            };
            if (_local1.length >= (4 * 2)){
                _local3 = _local1.slice(0, (4 * 2));
                _local4 = _local1.slice((4 * 2), _local1.length);
                _local1 = ((_local3 + "\n") + _local4);
            };
            this.textCandidates.text = _local1;
        }
        public function HideCandidates():void{
            this.textCandidates.text = "";
        }
        private function GetRowsCount():uint{
            return (((((this.puzzleSize / 3) == int((this.puzzleSize / 3)))) ? (this.puzzleSize / 3) : int(((this.puzzleSize / 3) + 1))));
        }

    }
}//package scripts 
