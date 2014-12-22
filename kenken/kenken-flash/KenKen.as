package {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.net.*;
    import flash.display.*;
    import flash.events.*;
    import com.adobe.serialization.json.*;
    import flash.text.*;
    import com.google.analytics.*;
    import flash.geom.*;
    import scripts.*;
    import flash.ui.*;
    import flash.external.*;
    import flash.printing.*;

    public class KenKen extends MovieClip {

        private static const LINEAR_AD_TAG:String = "http://googleads.g.doubleclick.net/pagead/ads?ad_type=video_text_image_flash&client=ca-games-test&description_url=http%3A%2F%2Fwww.kenken.com";

        public static var stageRef:Stage;
        public static var mcContainerMenu:ContainerMenu = new ContainerMenu();
        public static var mcContainerTiles:ContainerTiles = new ContainerTiles();
        public static var mcContainerHowTo:MovieClip;
        public static var mcContainerRules:MovieClip;
        public static var mcContainerCage:MovieClip = new MovieClip();

        private var CFG_DEBUG:Boolean = true;
        private var _TRACE_EVENTS:Boolean = false;
        private var DEVELOPMENT:Boolean = false;
        private var _hiddenText:TextField;
        public var mcPauseScreen:PauseScreen;
        public var arrMonthName:Array;
        private var puzzleFilename:String = "";
        private var puzzleSize:uint = 9;
        private var puzzleIndex:uint = 0;
        var puzzleScaleFactor:Number = 1;
        private var tileSize:uint = 100;
        public var bdImage3x3:BitmapData;
        public var bdImage4x4:BitmapData;
        public var bdImage5x5:BitmapData;
        public var bdImage6x6:BitmapData;
        public var bdImage7x7:BitmapData;
        public var bdImage8x8:BitmapData;
        public var bdImage9x9:BitmapData;
        var bmpPuzzleImage:Bitmap;
        private var puzzleSolution:Array;
        private var puzzleCageTotal:Array;
        private var puzzleCageOperator:Array;
        private var puzzleCageBarsV:Array;
        private var puzzleCageBarsH:Array;
        private var puzzleValueUndo:Array;
        private var puzzleCandidatesUndo:Array;
        private var arrUndoValueStates:Array;
        private var arrUndoCandidateStates:Array;
        private var iUndoState:int = -1;
        private var puzzleLoader:URLLoader;
        private var fishArray:Array;
        private var fishSideBarArray:Array;
        private var textMainMenuTitle:TextField;
        private var textMainMenuTitleStyle:TextFormat;
        private var textCandidatesAutoremove:TextField;
        private var textCandidatesAutoremoveStyle:TextFormat;
        private var textHoverStyle:TextFormat;
        private var textHoverSelStyle:TextFormat;
        public var mcPuzzleFooter:PuzzleFooter;
        public var mcPuzzleNumber:PuzzleNumber;
        public var iPuzzleNumber:uint = 0;
        public var mcKenKenLink:KenKenLink;
        public var mcPrintPuzzleBtn:PrinterIcon;
        public var mcPausePuzzleBtn:PauseButton;
        public var mcUnPausePuzzleBtn:UnPauseButton;
        public var mcKenKenTimerDisplay:KenKenTimer;
        public var mcCopyrightFooter:MovieClip;
        public var mcCongratulations:MovieClip;
        public var mcCongratsSolveAnother:CongratsSolveAnother;
        public var mcNotificationPopup:mcNotification;
        public var mcPurchasePuzzle:PurchasePuzzle;
        public var mcWarning:Warning;
        public var mcPreRollScreen:PreRollScreen;
        public var mcSidebarBackground:SidebarBackground;
        public var mcTryAgain:TryAgainText;
        public var mcCandidatesControl:CandidatesControl;
        public var mcNotesControl:NotesControl;
        public var mcLevelDisplay:LevelDisplay;
        public var mcLevelStar:LevelStar;
        private var bFullFeatured:Boolean = false;
        private var bDemo:Boolean = false;
        private var strRegularPuzzlePrice:String = "";
        public var mcFlagButtonEN:mcFlagEN;
        public var mcFlagButtonIT:mcFlagIT;
        public var mcFlagButtonSP:mcFlagSP;
        public var mcFlagButtonFR:mcFlagFR;
        public var mcFlagButtonDE:mcFlagDE;
        public var mcFlagButtonPT:mcFlagPT;
        public var mcFlagButtonAE:mcFlagAE;
        public var mcFlagButtonHR:mcFlagHR;
        public var mcFlagButtonCN:mcFlagCN;
        private var bMouseEnabled:Boolean = true;
        private var targetTile:Tile;
        private var candidateTile:Tile;
        private var tileDragSource:Tile;
        private var tileDragDestination:Tile;
        private var startGameTimer:Timer;
        private var hoverBar:MovieClip;
        private var soSavedStatus:SharedObject;
        private var arrFinishedPuzzles:Array;
        private var bCandidatesAutoremove:Boolean = true;
        public var mcDebugConsole:DebugConsole;
        public var gaTracker:AnalyticsTracker = null;
        public var gaPuzzleDescription:String;
        private var sessionHash:String;
        private var iPuzzleLevel:uint = 0;
        private var _strPuzzleLevel:String = "";
        private var strPuzzleOperations:String = "";
        private var _strPuzzleType = "";
        private var bSolutionUsed:Boolean = false;
        private var iPuzzlePaused:uint = 0;
        private var lang:Language;
        private var objLoadedPuzzleState:Object = null;
        private var _bDailyPuzzle:Boolean = true;
        private var _bGuestPlay:Boolean = true;
        private var _puzzleData:String = "";
        private var _gameState:String = "";
        public var fontArialBlack:Font;
        private var adsLoader:AdsLoader;
        private var adsManager:AdsManager;
        private var contentPlayheadTime:Number;
        private var _afgContainerWidth:uint;
        private var _afgContainerHeight:uint;
        private var _afgContainerX:uint;
        private var _afgContainerY:uint;
        private var _afgAdsQueue:Array = null;
        private var _afgHouseAdLoader:Loader = null;
        private var _afgHouseAdImage:Sprite = null;
        private var _bPlayMoreVideo:Boolean = true;

        public function KenKen(){
            this.mcPauseScreen = new PauseScreen();
            this.arrMonthName = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
            this.bdImage3x3 = new Image3x3();
            this.bdImage4x4 = new Image4x4();
            this.bdImage5x5 = new Image5x5();
            this.bdImage6x6 = new Image6x6();
            this.bdImage7x7 = new Image7x7();
            this.bdImage8x8 = new Image8x8();
            this.bdImage9x9 = new Image9x9();
            this.bmpPuzzleImage = new Bitmap();
            this.puzzleSolution = new Array();
            this.puzzleCageTotal = new Array();
            this.puzzleCageOperator = new Array();
            this.puzzleCageBarsV = new Array();
            this.puzzleCageBarsH = new Array();
            this.puzzleValueUndo = new Array();
            this.puzzleCandidatesUndo = new Array();
            this.arrUndoValueStates = new Array();
            this.arrUndoCandidateStates = new Array();
            this.fishArray = new Array();
            this.fishSideBarArray = new Array();
            this.textMainMenuTitle = new TextField();
            this.textMainMenuTitleStyle = new TextFormat();
            this.textCandidatesAutoremove = new TextField();
            this.textCandidatesAutoremoveStyle = new TextFormat();
            this.textHoverStyle = new TextFormat();
            this.textHoverSelStyle = new TextFormat();
            this.mcPuzzleFooter = new PuzzleFooter();
            this.mcPuzzleNumber = new PuzzleNumber();
            this.mcKenKenLink = new KenKenLink();
            this.mcPrintPuzzleBtn = new PrinterIcon();
            this.mcPausePuzzleBtn = new PauseButton();
            this.mcUnPausePuzzleBtn = new UnPauseButton();
            this.mcPreRollScreen = new PreRollScreen();
            this.mcSidebarBackground = new SidebarBackground();
            this.mcTryAgain = new TryAgainText();
            this.mcCandidatesControl = new CandidatesControl();
            this.mcNotesControl = new NotesControl();
            this.mcLevelDisplay = new LevelDisplay();
            this.mcLevelStar = new LevelStar();
            this.mcFlagButtonEN = new mcFlagEN();
            this.mcFlagButtonIT = new mcFlagIT();
            this.mcFlagButtonSP = new mcFlagSP();
            this.mcFlagButtonFR = new mcFlagFR();
            this.mcFlagButtonDE = new mcFlagDE();
            this.mcFlagButtonPT = new mcFlagPT();
            this.mcFlagButtonAE = new mcFlagAE();
            this.mcFlagButtonHR = new mcFlagHR();
            this.mcFlagButtonCN = new mcFlagCN();
            this.startGameTimer = new Timer(1000, 0);
            this.hoverBar = new MovieClip();
            this.arrFinishedPuzzles = [false, false, false, false, false, false];
            this.mcDebugConsole = new DebugConsole();
            this.lang = new Language();
            this.fontArialBlack = new ArialBlack();
            super();
            stageRef = stage;
            this._hiddenText = new TextField();
            this._hiddenText.type = TextFieldType.INPUT;
            this._hiddenText.width = 1;
            this._hiddenText.height = 1;
            this._hiddenText.alpha = 0;
            this._hiddenText.mouseEnabled = false;
            addChild(this._hiddenText);
            stage.focus = this._hiddenText;
            this._hiddenText.addEventListener(FocusEvent.FOCUS_OUT, this.EVENT_HiddenText_FocusLost);
            this.mcDebugConsole.x = (this.mcDebugConsole.width / 2);
            this.mcDebugConsole.y = (this.mcDebugConsole.height / 2);
            this.mcKenKenTimerDisplay = new KenKenTimer();
            this.textHoverStyle.font = this.fontArialBlack.fontName;
            this.textHoverStyle.size = 10;
            this.textHoverStyle.color = 0xEEEEEE;
            this.textHoverSelStyle.font = this.fontArialBlack.fontName;
            this.textHoverSelStyle.size = 10;
            this.textHoverSelStyle.color = 0xFF;
            mcContainerCage.mouseEnabled = false;
            mcContainerCage.name = "ContainerCage";
            mcContainerTiles.name = "ContainerTiles";
            mcContainerTiles.x = ((375 - (mcContainerTiles.width / 2)) + 50);
            mcContainerTiles.y = 50;
            mcContainerCage.x = mcContainerTiles.x;
            mcContainerCage.y = mcContainerTiles.y;
            mcContainerMenu.x = 0;
            mcContainerMenu.y = 0;
            this.mcPauseScreen.x = mcContainerTiles.x;
            this.mcPauseScreen.y = mcContainerTiles.y;
            this.mcPauseScreen.addEventListener(MouseEvent.CLICK, this.EVENT_Pause_MouseClick);
            this.mcPauseScreen.visible = false;
            this.mcPauseScreen.buttonMode = true;
            this.mcPauseScreen.useHandCursor = true;
            this.mcSidebarBackground.x = 14;
            this.mcSidebarBackground.y = mcContainerTiles.y;
            this.mcPuzzleNumber.x = (mcContainerTiles.x - 4);
            this.mcPuzzleNumber.y = (mcContainerTiles.y - this.mcPuzzleNumber.height);
            this.mcPuzzleNumber.name = "PuzzleNumber";
            this.mcKenKenTimerDisplay.addEventListener(MouseEvent.CLICK, this.EVENT_KenKenTimer_MouseClick);
            this.mcKenKenTimerDisplay.x = (mcContainerTiles.x + 220);
            this.mcKenKenTimerDisplay.y = ((mcContainerTiles.y - this.mcKenKenTimerDisplay.height) - 2);
            this.mcKenKenTimerDisplay.name = "KenKenTimerDisplay";
            this.mcKenKenTimerDisplay.timerOFF.visible = false;
            this.mcKenKenTimerDisplay.buttonMode = true;
            this.mcKenKenTimerDisplay.useHandCursor = true;
            this.mcPuzzleFooter.mouseEnabled = false;
            this.mcPuzzleFooter.x = 45;
            this.mcPuzzleFooter.y = 695;
            this.mcPuzzleFooter.name = "PuzzleFooter";
            this.mcTryAgain.mouseEnabled = false;
            this.mcTryAgain.x = 300;
            this.mcTryAgain.y = 670;
            this.mcTryAgain.name = "LoseScreen";
            stage.addEventListener(MouseEvent.MOUSE_UP, this.EVENT_MouseUp);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, this.EVENT_MouseMove);
            stage.addEventListener(MouseEvent.CLICK, this.EVENT_MouseClick);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.EVENT_Stage_KeyPress);
            this.gaTracker = new GATracker(this, "UA-5627971-1", "AS3");
            this.startGameTimer.addEventListener(TimerEvent.TIMER, this.EVENT_TIMER_StartGame);
            this.mcFlagButtonEN.name = "mcFlagButtonEN";
            this.mcFlagButtonEN.selectable = false;
            this.mcFlagButtonEN.buttonMode = true;
            this.mcFlagButtonEN.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonIT.name = "mcFlagButtonIT";
            this.mcFlagButtonIT.selectable = false;
            this.mcFlagButtonIT.buttonMode = true;
            this.mcFlagButtonIT.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonSP.name = "mcFlagButtonSP";
            this.mcFlagButtonSP.selectable = false;
            this.mcFlagButtonSP.buttonMode = true;
            this.mcFlagButtonSP.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonFR.name = "mcFlagButtonFR";
            this.mcFlagButtonFR.selectable = false;
            this.mcFlagButtonFR.buttonMode = true;
            this.mcFlagButtonFR.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonDE.name = "mcFlagButtonDE";
            this.mcFlagButtonDE.selectable = false;
            this.mcFlagButtonDE.buttonMode = true;
            this.mcFlagButtonDE.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonPT.name = "mcFlagButtonPT";
            this.mcFlagButtonPT.selectable = false;
            this.mcFlagButtonPT.buttonMode = true;
            this.mcFlagButtonPT.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonAE.name = "mcFlagButtonAE";
            this.mcFlagButtonAE.selectable = false;
            this.mcFlagButtonAE.buttonMode = true;
            this.mcFlagButtonAE.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonHR.name = "mcFlagButtonHR";
            this.mcFlagButtonHR.selectable = false;
            this.mcFlagButtonHR.buttonMode = true;
            this.mcFlagButtonHR.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            this.mcFlagButtonCN.name = "mcFlagButtonCN";
            this.mcFlagButtonCN.selectable = false;
            this.mcFlagButtonCN.buttonMode = true;
            this.mcFlagButtonCN.addEventListener(MouseEvent.CLICK, this.EVENT_Flag_MouseClick);
            trace("KenKen activated.");
            this.InitializeGame(true);
        }
        private function InitializeGame(_arg1:Boolean):void{
            mcContainerHowTo = this.lang.mcHowTo;
            mcContainerHowTo.name = "ContainerHowTo";
            mcContainerRules = this.lang.mcRules;
            mcContainerRules.name = "ContainerRules";
            this.mcCongratulations = this.lang.mcCongratulations;
            this.mcCongratulations.mouseEnabled = false;
            this.mcCongratulations.x = 0;
            this.mcCongratulations.y = 0;
            this.mcCongratulations.name = "WinScreen";
            this.mcCongratulations.addEventListener(MouseEvent.CLICK, this.EVENT_Congratulations_MouseClick);
            this.mcCongratulations.solveAnotherPuzzle.buttonMode = true;
            this.mcCongratulations.solveAnotherPuzzle.useHandCursor = true;
            this.mcCongratulations.solveAnotherPuzzle.addEventListener(MouseEvent.CLICK, this.EVENT_Congratulations_SolveAnother_MouseClick);
            this.mcCongratulations.btnFindOutMore.buttonMode = true;
            this.mcCongratulations.btnFindOutMore.useHandCursor = true;
            this.mcCongratulations.btnFindOutMore.selectable = false;
            this.mcCongratulations.btnFindOutMore.addEventListener(MouseEvent.CLICK, this.EVENT_Congratulations_FindOutMore_MouseClick);
            this.mcPreRollScreen.visible = false;
            this.mcPreRollScreen.btnFindOutMore.buttonMode = true;
            this.mcPreRollScreen.btnFindOutMore.useHandCursor = true;
            this.mcPreRollScreen.btnFindOutMore.selectable = false;
            this.mcPreRollScreen.btnFindOutMore.addEventListener(MouseEvent.CLICK, this.EVENT_Congratulations_FindOutMore_MouseClick);
            stage.addChild(this.mcPreRollScreen);
            this.mcNotificationPopup = new mcNotification();
            this.mcNotificationPopup.mouseEnabled = false;
            this.mcNotificationPopup.x = ((stage.width - this.mcNotificationPopup.width) / 2);
            this.mcNotificationPopup.y = 240;
            this.mcNotificationPopup.name = "NotificationPopup";
            this.mcNotificationPopup.addEventListener(MouseEvent.CLICK, this.EVENT_NotificationPopup_MouseClick);
            this.CreateNotificationButton();
            this.mcPurchasePuzzle = new PurchasePuzzle();
            this.mcPurchasePuzzle.mouseEnabled = false;
            this.mcPurchasePuzzle.x = ((stage.width - this.mcPurchasePuzzle.width) / 2);
            this.mcPurchasePuzzle.y = 240;
            this.mcPurchasePuzzle.name = "PurchasePuzzle";
            this.mcPurchasePuzzle.addEventListener(MouseEvent.CLICK, this.EVENT_PurchasePuzzle_MouseClick);
            this.mcWarning = new Warning();
            this.mcWarning.mouseEnabled = false;
            this.mcWarning.x = (((mcContainerTiles.x + mcContainerTiles.width) - this.mcWarning.width) / 2);
            this.mcWarning.y = (((mcContainerTiles.y + mcContainerTiles.height) - this.mcWarning.height) / 2);
            this.mcWarning.name = "Warning";
            this.mcWarning.addEventListener(MouseEvent.CLICK, this.EVENT_Warning_MouseClick);
            this.mcCopyrightFooter = this.lang.mcCopyright;
            this.mcCopyrightFooter.mouseEnabled = false;
            this.mcCopyrightFooter.x = 0;
            this.mcCopyrightFooter.y = 736;
            this.mcCopyrightFooter.name = "CopyrightFooter";
            this.mcPrintPuzzleBtn.x = (((mcContainerTiles.x + mcContainerTiles.width) - this.mcPrintPuzzleBtn.width) + 2);
            this.mcPrintPuzzleBtn.y = ((mcContainerTiles.y + mcContainerTiles.height) + 2);
            this.mcPrintPuzzleBtn.name = "PrintPuzzleBtn";
            this.mcPrintPuzzleBtn.selectable = false;
            this.mcPrintPuzzleBtn.buttonMode = true;
            this.mcPrintPuzzleBtn.addEventListener(MouseEvent.CLICK, this.EVENT_Print_MouseClick);
            this.mcPausePuzzleBtn.x = (this.mcPrintPuzzleBtn.x + 4);
            this.mcPausePuzzleBtn.y = ((mcContainerTiles.y - this.mcUnPausePuzzleBtn.height) + 1);
            this.mcPausePuzzleBtn.name = "PausePuzzleBtn";
            this.mcPausePuzzleBtn.selectable = false;
            this.mcPausePuzzleBtn.buttonMode = true;
            this.mcPausePuzzleBtn.visible = true;
            this.mcPausePuzzleBtn.addEventListener(MouseEvent.CLICK, this.EVENT_Pause_MouseClick);
            this.mcUnPausePuzzleBtn.x = this.mcPausePuzzleBtn.x;
            this.mcUnPausePuzzleBtn.y = this.mcPausePuzzleBtn.y;
            this.mcUnPausePuzzleBtn.name = "UnPausePuzzleBtn";
            this.mcUnPausePuzzleBtn.selectable = false;
            this.mcUnPausePuzzleBtn.buttonMode = true;
            this.mcUnPausePuzzleBtn.visible = false;
            this.mcUnPausePuzzleBtn.addEventListener(MouseEvent.CLICK, this.EVENT_Pause_MouseClick);
            stage.frameRate = 50;
            this.tileDragSource = null;
            this.tileDragDestination = null;
            this.hoverBar = null;
            try {
                ExternalInterface.addCallback("sendPuzzleData", this.JAVASCRIPT_GetPuzzleData);
                ExternalInterface.addCallback("loadPuzzleState", this.JAVASCRIPT_LoadPuzzleState);
                ExternalInterface.addCallback("sendWidgetAdBeforeGame", this.JAVASCRIPT_AdBeforeGame);
                ExternalInterface.addCallback("sendWidgetAdBeforePrint", this.JAVASCRIPT_AdBeforePrint);
                ExternalInterface.addCallback("sendWidgetAdBeforePause", this.JAVASCRIPT_AdBeforePause);
                ExternalInterface.addCallback("sendWidgetAdBeforeSolution", this.JAVASCRIPT_AdBeforeSolution);
                ExternalInterface.addCallback("sendWidgetAdOnKengratulations", this.JAVASCRIPT_AdOnKengratulations);
            } catch(err:Error) {
            };
            if (this.DEVELOPMENT){
                this.LoadPuzzleDescriptions();
            } else {
                if (_arg1){
                    if (ExternalInterface.available){
                        ExternalInterface.call("kenken.game.getPuzzle");
                    };
                };
            };
        }
        private function StartGame(_arg1:Boolean):void{
            trace("KenKen started.");
            this.RemoveMenu();
            this.RemoveTiles();
            this.RemoveSideBar();
            this.RemoveWinScreen();
            this.CreateSideBar();
            this.CreatePuzzle();
            if (_arg1){
                this.SetLoadedPuzzleState();
            };
            this.ShowPuzzle();
            this.DrawCage();
            if (!this.bFullFeatured){
                this.mcPausePuzzleBtn.alpha = 0.5;
                this.mcPausePuzzleBtn.removeEventListener(MouseEvent.CLICK, this.EVENT_Pause_MouseClick);
                this.mcKenKenTimerDisplay.alpha = 0.5;
            } else {
                this.mcPausePuzzleBtn.alpha = 1;
                this.mcKenKenTimerDisplay.alpha = 1;
            };
            var _local2:Tile = this.GetTile("00");
            if (_local2 != null){
                this.targetTile = _local2;
                this.targetTile.Select();
                this.AddCandidateBarEventListeners(this.targetTile);
                this.ShowCandidateBar(this.targetTile);
            };
            this.mcKenKenTimerDisplay.Reset();
            this.mcKenKenTimerDisplay.Start();
            ExternalInterface.call("kenken.game.puzzleStarted", "");
            this.UndoSave();
        }
        public function JAVASCRIPT_AdBeforeGame(_arg1):void{
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            if (((((!((_local3 == null))) && ((_local3.length > 0)))) && (!((_local3[0].adTag == ""))))){
                this.mcPreRollScreen.visible = true;
                this.AdsController(_local3);
            } else {
                this.WidgetAdFinished();
            };
        }
        public function JAVASCRIPT_AdBeforePrint(_arg1):void{
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            if (((((!((_local3 == null))) && ((_local3.length > 0)))) && (!((_local3[0].adTag == ""))))){
                this.mcPreRollScreen.visible = false;
                this.AdsController(_local3);
            } else {
                this.WidgetAdFinished();
            };
        }
        public function JAVASCRIPT_AdBeforePause(_arg1):void{
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            if (((((!((_local3 == null))) && ((_local3.length > 0)))) && (!((_local3[0].adTag == ""))))){
                this.mcPreRollScreen.visible = false;
                this.AdsController(_local3);
            } else {
                this.WidgetAdFinished();
            };
        }
        public function JAVASCRIPT_AdBeforeSolution(_arg1):void{
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            if (((((!((_local3 == null))) && ((_local3.length > 0)))) && (!((_local3[0].adTag == ""))))){
                this.mcPreRollScreen.visible = false;
                this.AdsController(_local3);
            } else {
                this.WidgetAdFinished();
            };
        }
        public function JAVASCRIPT_AdOnKengratulations(_arg1):void{
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            if (((((!((_local3 == null))) && ((_local3.length > 0)))) && (!((_local3[0].adTag == ""))))){
                this.mcPreRollScreen.visible = false;
                this.AdsController(_local3);
            } else {
                this.WidgetAdFinished();
            };
        }
        public function JAVASCRIPT_LoadPuzzleState(_arg1:String):void{
        }
        public function JAVASCRIPT_GetPuzzleData(_arg1:String):void{
            var _local5:Object;
            var _local2:String = _arg1;
            var _local3:Object = JSON.decode(_local2);
            this._bGuestPlay = _local3.guest;
            var _local4:uint = _local3.no;
            if (_local4 == this.iPuzzleNumber){
                return;
            };
            this.mcPuzzleNumber.text.text = ((((((("Puzzle No. " + _local3.no) + ", ") + _local3.size) + "x") + _local3.size) + ", ") + _local3.level);
            this.iPuzzleNumber = _local3.no;
            this._strPuzzleType = "Unlimited";
            if (_local3.daily){
                this._strPuzzleType = "Daily";
            };
            this.strPuzzleOperations = _local3.operations;
            this._strPuzzleLevel = _local3.level;
            switch (_local3.level){
                case "easiest":
                    this.iPuzzleLevel = 1;
                    break;
                case "easy":
                    this.iPuzzleLevel = 2;
                    break;
                case "medium":
                    this.iPuzzleLevel = 3;
                    break;
                case "hard":
                    this.iPuzzleLevel = 4;
                    break;
                case "expert":
                    this.iPuzzleLevel = 5;
                    break;
                default:
                    this.iPuzzleLevel = 0;
            };
            this.strRegularPuzzlePrice = String(_local3.regular_price);
            this.bDemo = _local3.demo;
            this.bFullFeatured = true;
            trace("full featured: ", this.bFullFeatured);
            if (_local3.state != null){
                _local5 = JSON.decode(_local3.state);
                this.objLoadedPuzzleState = _local5;
            };
            this._puzzleData = _local3.data;
            if (_local3.u_level == "B"){
                this.mcCongratulations.btnFindOutMore.visible = true;
                this.mcCongratulations.AdFreeQuestion.visible = true;
            } else {
                this.mcCongratulations.btnFindOutMore.visible = false;
                this.mcCongratulations.AdFreeQuestion.visible = false;
            };
            this.HideGame();
            this._gameState = "start";
            ExternalInterface.call("kenken.game.widgetAdBeforeGame");
        }
        private function EVENT_Congratulations_FindOutMore_MouseClick(_arg1:Event):void{
            var url:* = null;
            var event:* = _arg1;
            url = "/membership";
            var request:* = new URLRequest(url);
            try {
                navigateToURL(request, "_self");
            } catch(e:Error) {
                trace(("Error while opening " + url));
            };
        }
        private function EVENT_Congratulations_SolveAnother_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Congratulations_SolveAnother_MouseClick");
            };
            _arg1.stopPropagation();
            this.RemoveLoseText();
            this.RemoveWinText();
            this.RemoveWinScreen();
            this.RestartKenKen();
            this.destroyAdsManager();
            ExternalInterface.call("kenken.game.solveAnother");
        }
        private function EVENT_Help_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Help_Click");
            };
            _arg1.stopPropagation();
        }
        private function EVENT_WarningRevealBoxButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_WarningRevealBoxButton_Click");
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
            this.RevealValue();
            this.UndoSave();
        }
        private function EVENT_WarningSolveAnotherButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_WarningSolveAnotherButton_Click");
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
            this.RemoveLoseText();
            this.RemoveWinText();
            this.RemoveWinScreen();
            this.RestartKenKen();
            ExternalInterface.call("kenken.game.solveAnother");
        }
        private function EVENT_WarningResetButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_WarningResetButton_Click");
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
            this.StartGame(false);
        }
        private function EVENT_WarningSolutionButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_WarningSolutionButton_Click");
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
            this.gaPuzzleDescription = ((((((((("" + this.puzzleSize) + "x") + this.puzzleSize) + "_") + this._strPuzzleLevel) + "_") + this.strPuzzleOperations) + "_") + this._strPuzzleType);
            this.gaTracker.trackEvent("widget", "solution", this.gaPuzzleDescription, 1);
            ExternalInterface.call("kenken.game.onSolution");
            this.RevealAll();
            this.UndoSave();
        }
        private function EVENT_FreeSolveAnotherButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_FreeSolveAnotherButton_Click");
            };
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
            this.RemoveLoseText();
            this.RemoveWinText();
            this.RemoveWinScreen();
            this.RestartKenKen();
            ExternalInterface.call("kenken.game.chooseAnother", "");
        }
        private function EVENT_PurchasePuzzleButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_PurchasePuzzleButton_Click");
            };
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
            this.RemoveLoseText();
            this.RemoveWinText();
            this.RemoveWinScreen();
            this.RestartKenKen();
            ExternalInterface.call("kenken.game.solveAnother", "");
        }
        private function EVENT_NotificationButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_NotificationButton_Click");
            };
            if (stage.getChildByName("mcNotificationPopup")){
                stage.removeChild(this.mcNotificationPopup);
            };
            ExternalInterface.call("kenken.game.activateFullFeatured", "");
        }
        private function EVENT_WinScreenButton_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_WinScreenButton_Click");
            };
            this.RemoveLoseText();
            this.RemoveWinText();
            this.RemoveWinScreen();
            this.RestartKenKen();
            ExternalInterface.call("kenken.game.solveAnother", "");
        }
        private function EVENT_KenKenTimer_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_KenKenTimer_MouseClick");
            };
            if (!this.bFullFeatured){
                return;
            };
            if (this.mcKenKenTimerDisplay.timerOFF.visible == true){
                this.mcKenKenTimerDisplay.Enabled();
                this.mcKenKenTimerDisplay.timerOFF.visible = false;
                this.mcKenKenTimerDisplay.timerON.visible = true;
            } else {
                this.mcKenKenTimerDisplay.Disabled();
                this.mcKenKenTimerDisplay.display.text = "00:00:00";
                this.mcKenKenTimerDisplay.timerOFF.visible = true;
                this.mcKenKenTimerDisplay.timerON.visible = false;
            };
        }
        private function EVENT_NotesControl_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_NotesControl_MouseClick");
            };
            if (this.mcNotesControl.notesOFF.visible == true){
                if (!this.bFullFeatured){
                    return;
                };
                this.mcNotesControl.notesON.visible = true;
                this.mcNotesControl.notesOFF.visible = false;
                this.bCandidatesAutoremove = true;
            } else {
                this.mcNotesControl.notesON.visible = false;
                this.mcNotesControl.notesOFF.visible = true;
                this.bCandidatesAutoremove = false;
            };
        }
        private function EVENT_Warning_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Warning_MouseClick");
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
        }
        private function EVENT_PurchasePuzzle_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_PurchasePuzzle_MouseClick");
            };
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
        }
        private function EVENT_NotificationPopup_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_NotificationPopup_MouseClick");
            };
            if (stage.getChildByName("NotificationPopup")){
                trace("removing notification");
                stage.removeChild(this.mcNotificationPopup);
            };
        }
        private function EVENT_Congratulations_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Congratulations_MouseClick");
            };
            _arg1.stopPropagation();
            if (stage.getChildByName("WinScreen")){
            };
        }
        private function EVENT_StoreLinkClick(_arg1:Event):void{
        }
        private function EVENT_LoaderMissing(_arg1:Event):void{
            trace("Puzzle not found. Ignoring loading request.");
            this.RestartKenKen();
        }
        private function EVENT_TIMER_StartGame(_arg1:Event):void{
            ExternalInterface.call("widgetStartGame", "");
            this.startGameTimer.stop();
        }
        private function EVENT_TIMER_MouseOver(_arg1:Event):void{
        }
        private function EVENT_TIMER_WinScreenDelay(_arg1:Event):void{
            this.ShowWinScreen();
        }
        private function EVENT_TIMER_MenuButtonDelay(_arg1:Event):void{
            this.ShowButton("btnSolveAnother");
        }
        private function EVENT_SideBar_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_SideBar_Click");
            };
            var _local2:String = String(_arg1.currentTarget.name);
            var _local3:FishEyeButtonSidebar = FishEyeButtonSidebar(_arg1.currentTarget);
            if (_local2 == "btnSolveAnother"){
                if (((_local3.IsFullFeatured()) || (this.bDemo))){
                    this.WarningSolveAnother();
                } else {
                    this.ShowFreeSolveAnother();
                };
            } else {
                if (_local2 == "btnChooseAnother"){
                    trace("choose another");
                    ExternalInterface.call("kenken.game.chooseAnother", "");
                } else {
                    if (_local2 == "btnLoad"){
                        this.LoadPuzzle();
                    } else {
                        if (_local2 == "btnSave"){
                            if (_local3.IsFullFeatured()){
                                this.SendSaveState();
                            } else {
                                this.ShowNotification();
                            };
                        } else {
                            if (_local2 == "btnReveal"){
                                ExternalInterface.call("kenken.game.onReveal", "");
                                if (_local3.IsFullFeatured()){
                                    this.RevealValue();
                                    this.UndoSave();
                                } else {
                                    this.ShowNotification();
                                };
                            } else {
                                if (_local2 == "btnReset"){
                                    if (_local3.IsFullFeatured()){
                                        this.WarningResetPuzzle();
                                    } else {
                                        this.ShowNotification();
                                    };
                                } else {
                                    if (_local2 == "btnCheck"){
                                        ExternalInterface.call("kenken.game.onCheck", "");
                                        this.CheckPuzzleSolution(false);
                                    } else {
                                        if (_local2 == "btnSolution"){
                                            this.HandleSolution();
                                        } else {
                                            if (_local2 == "btnDone"){
                                                this.RemoveLoseText();
                                                this.RemoveWinText();
                                                this.ProceedToNextPuzzle();
                                            } else {
                                                if (_local2 == "btnUndo"){
                                                    this.RemovePopups();
                                                    if (_local3.IsFullFeatured()){
                                                        this.UndoRestore();
                                                    } else {
                                                        this.ShowNotification();
                                                    };
                                                } else {
                                                    if (_local2 == "btnRedo"){
                                                        this.RemovePopups();
                                                        if (_local3.IsFullFeatured()){
                                                            this.RedoStates();
                                                        } else {
                                                            this.ShowNotification();
                                                        };
                                                    } else {
                                                        if (_local2 == "btnHowTo"){
                                                            this.ShowHowToPage();
                                                        } else {
                                                            if (_local2 == "btnRules"){
                                                                this.ShowRulesPage();
                                                            } else {
                                                                if (_local2 == "btnBack"){
                                                                    this.HideHowToPage();
                                                                    this.HideRulesPage();
                                                                    this.ShowCandidateBar(this.targetTile);
                                                                };
                                                            };
                                                        };
                                                    };
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            _arg1.stopPropagation();
        }
        private function LoadPuzzle():void{
            var url:* = null;
            url = "/puzzle/saved";
            var request:* = new URLRequest(url);
            try {
                navigateToURL(request, "_self");
            } catch(e:Error) {
                trace(("Error while opening " + url));
            };
        }
        private function HandleSolution():void{
            if (this.bFullFeatured){
                this.WarningShowSolution();
            } else {
                this.ShowNotification();
            };
        }
        private function GetTile(_arg1:String):Tile{
            var _local2:String = ("Tile" + _arg1);
            var _local3:Tile = Tile(mcContainerTiles.getChildByName(_local2));
            return (_local3);
        }
        private function EVENT_Stage_KeyPress(_arg1:KeyboardEvent){
            var _local6:Tile;
            if (this._TRACE_EVENTS){
                trace("EVENT_Stage_KeyPress");
            };
            _arg1.stopPropagation();
            if (this._gameState == "kengratulations"){
                return;
            };
            var _local2:Tile;
            var _local3:Tile;
            if (((!((this.candidateTile == null))) && ((this.targetTile == null)))){
                _local2 = this.candidateTile;
                _local3 = this.candidateTile;
            } else {
                if ((((this.candidateTile == null)) && (!((this.targetTile == null))))){
                    _local2 = this.targetTile;
                    _local3 = this.targetTile;
                } else {
                    if (((!((this.candidateTile == null))) && (!((this.targetTile == null))))){
                        _local2 = this.candidateTile;
                        _local3 = this.targetTile;
                    } else {
                        _local6 = this.GetTile("00");
                        if (_local6 == null){
                            return;
                        };
                        _local2 = _local6;
                        _local3 = _local6;
                    };
                };
            };
            if ((((_local2 == null)) || ((_local3 == null)))){
                return;
            };
            Mouse.hide();
            this.bMouseEnabled = false;
            var _local4:uint = _arg1.keyCode;
            var _local5 = -1;
            if ((((_local4 > 96)) && ((_local4 <= 105)))){
                _local5 = (_local4 - 96);
                if (_local5 > this.puzzleSize){
                    return;
                };
                if (_arg1.shiftKey){
                    this.KeyPressCandidate(_local5, _local2);
                } else {
                    this.KeyPressValue(_local5, _local2);
                };
            } else {
                if ((((_local4 > 48)) && ((_local4 <= 57)))){
                    _local5 = (_local4 - 48);
                    if (_local5 > this.puzzleSize){
                        return;
                    };
                    if (_arg1.shiftKey){
                        this.KeyPressCandidate(_local5, _local2);
                    } else {
                        this.KeyPressValue(_local5, _local2);
                    };
                } else {
                    if (_local4 == 27){
                        this.RemoveValueBar();
                        return;
                    };
                    if (_local4 == 87){
                    } else {
                        if ((((_local4 == 85)) || ((_local4 == 117)))){
                            this.RemovePopups();
                            this.UndoRestore();
                        } else {
                            if ((((_local4 == 82)) || ((_local4 == 112)))){
                                this.RemovePopups();
                                this.RedoStates();
                            } else {
                                if ((((_local4 == 67)) || ((_local4 == 99)))){
                                    this.KeyPressClearValue(_local2);
                                } else {
                                    if (_local4 == 37){
                                        this.KeyPressMoveLeft(_local3);
                                        this.AddCandidateBarEventListeners(this.targetTile);
                                        this.ShowCandidateBar(this.targetTile);
                                        return;
                                    };
                                    if (_local4 == 38){
                                        this.KeyPressMoveUp(_local3);
                                        this.AddCandidateBarEventListeners(this.targetTile);
                                        this.ShowCandidateBar(this.targetTile);
                                        return;
                                    };
                                    if (_local4 == 39){
                                        this.KeyPressMoveRight(_local3);
                                        this.AddCandidateBarEventListeners(this.targetTile);
                                        this.ShowCandidateBar(this.targetTile);
                                        return;
                                    };
                                    if (_local4 == 40){
                                        this.KeyPressMoveDown(_local3);
                                        this.AddCandidateBarEventListeners(this.targetTile);
                                        this.ShowCandidateBar(this.targetTile);
                                        return;
                                    };
                                    return;
                                };
                            };
                        };
                    };
                };
            };
            this.CheckPuzzleFilled();
        }
        private function KeyPressMoveRight(_arg1:Tile){
            if (_arg1 == null){
                return;
            };
            var _local2:uint = uint(_arg1.name.charAt(4));
            if (_local2 >= (this.puzzleSize - 1)){
                return;
            };
            _local2++;
            var _local3:String = (_local2.toString() + _arg1.name.charAt(5));
            var _local4:Tile = this.GetTile(_local3);
            if (_local4 == null){
                return;
            };
            this.UnselectAllTiles();
            this.targetTile = _local4;
            if (this.candidateTile != null){
                this.candidateTile.RemoveHover();
            };
            this.candidateTile = null;
            this.targetTile.Select();
        }
        private function KeyPressMoveLeft(_arg1:Tile){
            if (_arg1 == null){
                return;
            };
            var _local2:uint = uint(_arg1.name.charAt(4));
            if (_local2 <= 0){
                return;
            };
            _local2--;
            var _local3:String = (_local2.toString() + _arg1.name.charAt(5));
            var _local4:Tile = this.GetTile(_local3);
            if (_local4 == null){
                return;
            };
            this.UnselectAllTiles();
            this.targetTile = _local4;
            if (this.candidateTile != null){
                this.candidateTile.RemoveHover();
            };
            this.candidateTile = null;
            this.targetTile.Select();
        }
        private function KeyPressMoveUp(_arg1:Tile){
            if (_arg1 == null){
                return;
            };
            var _local2:uint = uint(_arg1.name.charAt(5));
            if (_local2 <= 0){
                return;
            };
            _local2--;
            var _local3:String = (_arg1.name.charAt(4) + _local2.toString());
            var _local4:Tile = this.GetTile(_local3);
            if (_local4 == null){
                return;
            };
            this.UnselectAllTiles();
            this.targetTile = _local4;
            if (this.candidateTile != null){
                this.candidateTile.RemoveHover();
            };
            this.candidateTile = null;
            this.targetTile.Select();
        }
        private function KeyPressMoveDown(_arg1:Tile){
            if (_arg1 == null){
                return;
            };
            var _local2:uint = uint(_arg1.name.charAt(5));
            if (_local2 >= (this.puzzleSize - 1)){
                return;
            };
            _local2++;
            var _local3:String = (_arg1.name.charAt(4) + _local2.toString());
            var _local4:Tile = this.GetTile(_local3);
            if (_local4 == null){
                return;
            };
            this.UnselectAllTiles();
            this.targetTile = _local4;
            if (this.candidateTile != null){
                this.candidateTile.RemoveHover();
            };
            this.candidateTile = null;
            this.targetTile.Select();
        }
        private function KeyPressClearValue(_arg1:Tile){
            if (_arg1 == null){
                return;
            };
            var _local2:* = _arg1.GetValue();
            if (_local2 != ""){
                _arg1.SetValue("");
                _arg1.RenderCandidates();
            } else {
                _arg1.ClearCandidatesArray();
                _arg1.DisableAllCandidates(this.puzzleSize);
                _arg1.CreateCandidateBar(-1, this.puzzleSize);
                _arg1.RenderCandidates();
            };
            this.UndoSave();
        }
        private function KeyPressValue(_arg1:int, _arg2:Tile){
            if (_arg2 == null){
                return;
            };
            if (this._gameState == "kengratulations"){
                return;
            };
            _arg2.SetValue(String(_arg1));
            if (this.bCandidatesAutoremove){
                this.CorrectCandidates(_arg2, _arg1);
            };
            _arg2.HideCandidates();
            this.UndoSave();
        }
        private function KeyPressCandidate(_arg1:int, _arg2:Tile){
            if (_arg2 == null){
                return;
            };
            if (this._gameState == "kengratulations"){
                return;
            };
            var _local3:Boolean = this.UpdateTileCandidates(_arg2, _arg1);
            _arg2.CreateCandidateBar(-1, this.puzzleSize);
            _arg2.RenderCandidates();
            this.AddCandidateBarEventListeners(_arg2);
            if (((_local3) && ((_arg2.GetSingle() == -1)))){
                this.UndoSave();
            };
        }
        private function EVENT_Flag_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Flag_MouseClick");
            };
            if (_arg1.currentTarget.name == "mcFlagButtonEN"){
                this.lang = new Language();
            } else {
                if (_arg1.currentTarget.name == "mcFlagButtonIT"){
                    this.lang = new ItalianTranslation();
                } else {
                    if (_arg1.currentTarget.name == "mcFlagButtonSP"){
                        this.lang = new SpanishTranslation();
                    } else {
                        if (_arg1.currentTarget.name == "mcFlagButtonFR"){
                            this.lang = new FrenchTranslation();
                        } else {
                            if (_arg1.currentTarget.name == "mcFlagButtonDE"){
                                this.lang = new GermanTranslation();
                            } else {
                                if (_arg1.currentTarget.name == "mcFlagButtonPT"){
                                    this.lang = new PortugueseTranslation();
                                } else {
                                    if (_arg1.currentTarget.name == "mcFlagButtonAE"){
                                        this.lang = new ArabicTranslation();
                                    } else {
                                        if (_arg1.currentTarget.name == "mcFlagButtonHR"){
                                            this.lang = new CroatianTranslation();
                                        } else {
                                            if (_arg1.currentTarget.name == "mcFlagButtonCN"){
                                                this.lang = new ChineseTranslation();
                                            };
                                        };
                                    };
                                };
                            };
                        };
                    };
                };
            };
            trace(this.lang.lang);
            this.RestartKenKen();
        }
        private function EVENT_ValueButtonBar_MouseUp(_arg1:Event):void{
            this.HideHoverBar();
        }
        private function EVENT_ValueButtonBar_Click(_arg1:Event):void{
            var _local3:*;
            if (this._TRACE_EVENTS){
                trace("EVENT_ValueButtonBar_Click");
            };
            var _local2:String = String(_arg1.currentTarget.name);
            if (_local2 == "btnValueX"){
            } else {
                if (_local2 == "btnValueC"){
                    _local3 = this.targetTile.GetValue();
                    if (_local3 != ""){
                        this.targetTile.SetValue("");
                        this.targetTile.RenderCandidates();
                    } else {
                        this.targetTile.ClearCandidatesArray();
                        this.targetTile.DisableAllCandidates(this.puzzleSize);
                        this.targetTile.CreateCandidateBar(-1, this.puzzleSize);
                        this.targetTile.RenderCandidates();
                    };
                    this.UndoSave();
                } else {
                    this.targetTile.SetValue(_local2.charAt(8));
                    if (this.bCandidatesAutoremove){
                        this.CorrectCandidates(this.targetTile, uint(_local2.charAt(8)));
                    };
                    this.targetTile.HideCandidates();
                    this.UndoSave();
                };
            };
            this.RemoveValueBar();
            this.AddCandidateBarEventListeners(this.targetTile);
            this.ShowCandidateBar(this.targetTile);
            this.CheckPuzzleFilled();
            _arg1.stopPropagation();
        }
        private function EVENT_CandidateButtonBar_Click(_arg1:Event):void{
            var _local4:*;
            if (this._TRACE_EVENTS){
                trace("EVENT_CandidateButtonBar_Click");
            };
            var _local2:String = String(_arg1.currentTarget.name);
            var _local3:Boolean;
            if (_local2 == "btnCandidateAll"){
                _local3 = this.EnableAvailableCandidates(this.targetTile);
            } else {
                if (_local2 == "btnCandidateNone"){
                    this.targetTile.DisableAllCandidates(this.puzzleSize);
                } else {
                    _local4 = _local2.charAt(12);
                    _local3 = this.UpdateTileCandidates(this.targetTile, _local4);
                };
            };
            this.targetTile.CreateCandidateBar(-1, this.puzzleSize);
            this.targetTile.RenderCandidates();
            this.AddCandidateBarEventListeners(this.targetTile);
            if (((((_local3) && (!((this.targetTile == null))))) && ((this.targetTile.GetSingle() == -1)))){
                this.UndoSave();
            };
            this.SendBoardState();
            _arg1.stopPropagation();
        }
        private function EVENT_Tile_MouseOver(_arg1:Event):void{
            if (!this.bMouseEnabled){
                return;
            };
            if (_arg1.currentTarget == this.candidateTile){
                return;
            };
            this.candidateTile = Tile(_arg1.currentTarget);
            if (((this.targetTile) && ((this.targetTile.GetIndex() == this.candidateTile.GetIndex())))){
                return;
            };
        }
        private function EVENT_Tile_MouseDown(_arg1:Event):void{
            this.tileDragSource = Tile(_arg1.currentTarget);
        }
        private function EVENT_Tile_MouseUp(_arg1:Event):void{
            this.HideHoverBar();
            if (!this.tileDragSource){
                return;
            };
            this.tileDragDestination = Tile(_arg1.currentTarget);
            if (this.tileDragDestination.GetSingle() != -1){
                this.tileDragSource = null;
                return;
            };
            this.tileDragDestination.SetCandidates(this.CopyArray(this.tileDragSource.GetCandidates()));
            this.tileDragDestination.CreateCandidateBar(-1, this.puzzleSize);
            this.tileDragDestination.RenderCandidates();
            this.tileDragSource = null;
        }
        private function EVENT_Tile_MouseOut(_arg1:Event):void{
            this.candidateTile = null;
        }
        private function EVENT_Tile_Click(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_Tile_Click");
            };
            if (this._gameState == "kengratulations"){
                return;
            };
            this.RemoveLoseText();
            this.RemoveWinText();
            this.UnselectAllTiles();
            this.targetTile = Tile(_arg1.currentTarget);
            this.targetTile.Select();
            this.AddValueBarEventListeners(this.targetTile);
            this.AddCandidateBarEventListeners(this.targetTile);
            this.ShowValueBar(this.targetTile);
            this.ShowCandidateBar(this.targetTile);
            _arg1.stopPropagation();
        }
        private function EVENT_MouseOver(_arg1:Event):void{
        }
        private function EVENT_MouseUp(_arg1:Event):void{
            this.HideHoverBar();
            this.tileDragSource = null;
        }
        private function EVENT_MouseMove(_arg1:Event):void{
            Mouse.show();
            if (!this.bMouseEnabled){
            };
            this.bMouseEnabled = true;
            var _local2:Point = new Point(mouseX, mouseY);
            if (((this.tileDragSource) && (!(this.hoverBar)))){
                this.ShowHoverBar();
            };
            if (this.hoverBar){
                this.hoverBar.x = mouseX;
                this.hoverBar.y = mouseY;
            };
            this.HandleFish(_local2);
            this.HandleSideBarFish(_local2);
            if ((((((this.candidateTile == null)) && ((this.targetTile == null)))) && (!((this._gameState == "kengratulations"))))){
                this.targetTile = this.GetTile("00");
                if (this.targetTile != null){
                    this.targetTile.Select();
                };
            };
        }
        private function EVENT_Pause_MouseClick(_arg1:Event):void{
            _arg1.stopPropagation();
            if (this._TRACE_EVENTS){
                trace("EVENT_Pause_MouseClick");
            };
            if (this.iPuzzlePaused == 0){
                this._gameState = "pause";
                this.PauseGame();
                this.HideGame();
                ExternalInterface.call("kenken.game.widgetAdBeforePause");
            } else {
                this.PauseGame();
            };
        }
        private function PauseGame():void{
            this.UnselectAllTiles();
            this.HandlePuzzlePause();
        }
        private function HandlePuzzlePause():void{
            var _local1:Tile;
            this.iPuzzlePaused = (this.iPuzzlePaused ^ 1);
            if (this.iPuzzlePaused == 1){
                this.gaPuzzleDescription = ((((((("" + this.puzzleSize) + "x") + this.puzzleSize) + "_") + this._strPuzzleLevel) + "_") + this.strPuzzleOperations);
                this.gaTracker.trackEvent("widget", "pause", this.gaPuzzleDescription, 1);
                ExternalInterface.call("kenken.game.onPause");
                this.mcPausePuzzleBtn.visible = false;
                this.mcUnPausePuzzleBtn.visible = true;
                trace("paused");
                this.mcKenKenTimerDisplay.Stop();
                this.mcPauseScreen.visible = true;
                mcContainerTiles.visible = false;
                mcContainerCage.visible = false;
            } else {
                trace("unpaused");
                this.mcKenKenTimerDisplay.Start();
                this.mcPausePuzzleBtn.visible = true;
                this.mcUnPausePuzzleBtn.visible = false;
                this.mcPauseScreen.visible = false;
                mcContainerTiles.visible = true;
                mcContainerCage.visible = true;
                _local1 = this.GetTile("00");
                if (_local1 != null){
                    this.targetTile = _local1;
                    this.targetTile.Select();
                    this.AddCandidateBarEventListeners(this.targetTile);
                    this.ShowCandidateBar(this.targetTile);
                };
            };
        }
        private function EVENT_Print_MouseClick(_arg1:Event):void{
            _arg1.stopPropagation();
            if (this._TRACE_EVENTS){
                trace("EVENT_Print_MouseClick");
            };
            this.HideGame();
            this._gameState = "print";
            ExternalInterface.call("kenken.game.widgetAdBeforePrint");
        }
        private function HandlePrinting():void{
            var puzzlePrintJob:* = null;
            var puzzlePrintJobOptions:* = null;
            var puzzlePrintArea:* = null;
            var startResult:* = false;
            var iChild:* = 0;
            this.gaPuzzleDescription = ((((((("" + this.puzzleSize) + "x") + this.puzzleSize) + "_") + this._strPuzzleLevel) + "_") + this.strPuzzleOperations);
            this.gaTracker.trackEvent("widget", "print", this.gaPuzzleDescription, 1);
            ExternalInterface.call("kenken.game.onPrint");
            this.UnselectAllTiles();
            var strPuzzleLevel:* = "";
            switch (this.iPuzzleLevel){
                case 1:
                    strPuzzleLevel = "Easiest";
                    break;
                case 2:
                    strPuzzleLevel = "Easy";
                    break;
                case 3:
                    strPuzzleLevel = "Medium";
                    break;
                case 4:
                    strPuzzleLevel = "Hard";
                    break;
                case 5:
                    strPuzzleLevel = "Expert";
                    break;
                default:
                    strPuzzleLevel = "";
            };
            var strOriginalNumberText:* = this.mcPuzzleNumber.text.text;
            var bTilesVisible:* = mcContainerTiles.visible;
            var bCageVisible:* = mcContainerCage.visible;
            mcContainerTiles.visible = true;
            mcContainerCage.visible = true;
            var spPrint:* = new Sprite();
            spPrint.name = "spPrint";
            spPrint.x = 0;
            spPrint.y = 0;
            stage.addChild(spPrint);
            spPrint.addChild(mcContainerTiles);
            spPrint.addChild(mcContainerCage);
            spPrint.addChild(this.mcPuzzleNumber);
            spPrint.addChild(this.mcCopyrightFooter);
            spPrint.addChild(this.mcKenKenLink);
            var bWinRemoved:* = false;
            if (stage.getChildByName("WinScreen")){
                stage.removeChild(this.mcCongratulations);
                bWinRemoved = true;
            };
            var pOldCagePos:* = new Point(mcContainerCage.x, mcContainerCage.y);
            var pOldTilesPos:* = new Point(mcContainerTiles.x, mcContainerTiles.y);
            mcContainerCage.x = 30;
            mcContainerCage.y = 50;
            mcContainerTiles.x = mcContainerCage.x;
            mcContainerTiles.y = mcContainerCage.y;
            var pOldPuzzleNumber:* = new Point(this.mcPuzzleNumber.x, this.mcPuzzleNumber.y);
            this.mcPuzzleNumber.x = (mcContainerCage.x + 2);
            this.mcPuzzleNumber.y = ((mcContainerCage.y + mcContainerCage.height) + 8);
            this.mcCopyrightFooter.x = -70;
            this.mcCopyrightFooter.y = 750;
            this.mcKenKenLink.x = mcContainerCage.x;
            this.mcKenKenLink.y = (mcContainerCage.y - 30);
            spPrint.scaleX = 1;
            spPrint.scaleY = 1;
            try {
                puzzlePrintJob = new PrintJob();
                puzzlePrintJobOptions = new PrintJobOptions();
                puzzlePrintArea = new Rectangle(0, 0, ((mcContainerCage.width + mcContainerCage.x) + 20), 800);
                puzzlePrintJobOptions.printAsBitmap = true;
                startResult = puzzlePrintJob.start();
                if (startResult){
                    puzzlePrintJob.addPage(spPrint, puzzlePrintArea, puzzlePrintJobOptions);
                    puzzlePrintJob.send();
                } else {
                    trace("Printing failed or canceled.");
                };
            } catch(err:Error) {
                trace("PrintJob exception caught.");
            };
            if (stage.getChildByName("spPrint")){
                stage.removeChild(spPrint);
            };
            if (stage.getChildByName("PuzzlePrintBtn")){
                stage.removeChild(this.mcPrintPuzzleBtn);
            };
            if (stage.getChildByName("PausePrintBtn")){
                stage.removeChild(this.mcPausePuzzleBtn);
            };
            if (stage.getChildByName("UnPausePrintBtn")){
                stage.removeChild(this.mcUnPausePuzzleBtn);
            };
            mcContainerCage.x = pOldCagePos.x;
            mcContainerCage.y = pOldCagePos.y;
            mcContainerTiles.x = mcContainerCage.x;
            mcContainerTiles.y = mcContainerCage.y;
            this.mcPuzzleNumber.x = pOldPuzzleNumber.x;
            this.mcPuzzleNumber.y = pOldPuzzleNumber.y;
            stage.addChild(mcContainerTiles);
            stage.addChild(mcContainerCage);
            stage.addChild(this.mcPuzzleNumber);
            stage.addChild(this.mcPrintPuzzleBtn);
            stage.addChild(this.mcPausePuzzleBtn);
            stage.addChild(this.mcUnPausePuzzleBtn);
            mcContainerTiles.visible = bTilesVisible;
            mcContainerCage.visible = bCageVisible;
            if (bWinRemoved){
                stage.addChild(this.mcCongratulations);
            };
            this.mcPuzzleNumber.text.text = strOriginalNumberText;
            var tile:* = this.GetTile("00");
            if (tile != null){
                this.targetTile = tile;
                this.targetTile.Select();
                this.AddCandidateBarEventListeners(this.targetTile);
                this.ShowCandidateBar(this.targetTile);
            };
            stage.focus = this._hiddenText;
        }
        private function EVENT_KenKenLink_MouseOver(_arg1:Event):void{
            var _local2:ColorTransform = this.mcKenKenLink.transform.colorTransform;
            _local2.color = 0xFF;
            this.mcKenKenLink.transform.colorTransform = _local2;
        }
        private function EVENT_KenKenLink_MouseOut(_arg1:Event):void{
            var _local2:ColorTransform = this.mcKenKenLink.transform.colorTransform;
            _local2.color = 0;
            this.mcKenKenLink.transform.colorTransform = _local2;
        }
        private function EVENT_MouseClick(_arg1:Event):void{
            if (this._TRACE_EVENTS){
                trace("EVENT_MouseClick");
            };
            if (this._gameState == "kengratulations"){
                return;
            };
            this.UnselectAllTiles();
            if ((((this.candidateTile == null)) && ((this.targetTile == null)))){
                this.targetTile = this.GetTile("00");
                if (this.targetTile != null){
                    this.targetTile.Select();
                    this.AddCandidateBarEventListeners(this.targetTile);
                    this.ShowCandidateBar(this.targetTile);
                };
            };
        }
        private function EVENT_HiddenText_FocusLost(_arg1:Event):void{
            stage.focus = this._hiddenText;
        }
        private function JAVASCRIPT_StartGame(_arg1:String){
            this.PuzzleDescriptionParser(_arg1);
            trace("KenKen initialized.");
            this.gaPuzzleDescription = ((((((((("" + this.puzzleSize) + "x") + this.puzzleSize) + "_") + this._strPuzzleLevel) + "_") + this.strPuzzleOperations) + "_") + this._strPuzzleType);
            this.gaTracker.trackEvent("widget", "play", this.gaPuzzleDescription, 1);
            var _local2:Beacon = new Beacon(this.sessionHash);
            _local2.MarkStarted(this.gaPuzzleDescription);
            this.StartGame(true);
        }
        private function EVENT_PuzzleLoaded(_arg1:Event):void{
            var _local4:Object;
            var _local2:String = String(_arg1.target.data);
            var _local3:Object = JSON.decode(_local2);
            this.PuzzleDescriptionParser(_local3.data);
            this.strPuzzleOperations = _local3.operations;
            this._strPuzzleLevel = _local3.level;
            switch (_local3.level){
                case "easiest":
                    this.iPuzzleLevel = 1;
                    break;
                case "easy":
                    this.iPuzzleLevel = 2;
                    break;
                case "medium":
                    this.iPuzzleLevel = 3;
                    break;
                case "hard":
                    this.iPuzzleLevel = 4;
                    break;
                case "expert":
                    this.iPuzzleLevel = 5;
                    break;
                default:
                    this.iPuzzleLevel = 0;
            };
            this.strRegularPuzzlePrice = String(_local3.regular_price);
            this.bDemo = _local3.demo;
            this._bGuestPlay = _local3.guest;
            trace("guest play: ", _local3.guest);
            this.bFullFeatured = ((_local3.full_featured) || (this.bDemo));
            trace("full featured: ", this.bFullFeatured);
            trace("puzzle number: ", _local3.no);
            this.mcPuzzleNumber.text.text = ((((((("Puzzle No. " + _local3.no) + ", ") + _local3.size) + "x") + _local3.size) + ", ") + _local3.level);
            if (_local3.state != null){
                _local4 = JSON.decode(_local3.state);
                this.objLoadedPuzzleState = _local4;
            };
            if (this.DEVELOPMENT){
            };
            this.StartGame(true);
        }
        private function EVENT_MainMenuFishButton_Click(_arg1:Event):void{
            var _local2:FishEyeButton = FishEyeButton(_arg1.currentTarget);
            this.puzzleSize = int(_local2.name.charAt(18));
            this.ResetPuzzleArrays();
            trace((((("Initializing " + this.puzzleSize) + "x") + this.puzzleSize) + " KenKen."));
            this.sessionHash = String(Math.random());
            this.gaPuzzleDescription = ((("" + this.puzzleSize) + "x") + this.puzzleSize);
            this.gaTracker.trackEvent("widget", "play", this.gaPuzzleDescription, 1);
            var _local3:Beacon = new Beacon(this.sessionHash);
            _local3.MarkStarted(this.gaPuzzleDescription);
            this.puzzleFilename = this.CreatePuzzleFilename(this.puzzleSize);
            this.LoadPuzzleDescriptions();
        }
        private function EVENT_CandidateAutoremoveButtonBar_Click(_arg1:Event):void{
        }
        private function DrawCage():void{
            var _local4:uint;
            var _local5:uint;
            var _local6:String;
            var _local7:Number;
            var _local8:Number;
            var _local9:Number;
            var _local10:Number;
            mcContainerCage.graphics.clear();
            var _local1:* = mcContainerTiles.width;
            var _local2:* = 6;
            var _local3:* = 0;
            mcContainerCage.graphics.lineStyle((_local2 * this.puzzleScaleFactor), 0, 1, false, "normal", CapsStyle.NONE, JointStyle.MITER, 1);
            mcContainerCage.graphics.moveTo(_local3, _local3);
            mcContainerCage.graphics.lineTo((_local1 - _local3), _local3);
            mcContainerCage.graphics.lineTo((_local1 - _local3), (_local1 - _local3));
            mcContainerCage.graphics.lineTo(_local3, (_local1 - _local3));
            mcContainerCage.graphics.lineTo(_local3, _local3);
            _local4 = 0;
            while (_local4 < this.puzzleSize) {
                _local5 = 0;
                while (_local5 < (this.puzzleSize - 1)) {
                    _local6 = this.puzzleCageBarsV[this.puzzleIndex][_local4][_local5];
                    if (_local6 == "1"){
                        _local7 = ((_local5 + 1) * (this.tileSize * this.puzzleScaleFactor));
                        _local8 = (_local4 * (this.tileSize * this.puzzleScaleFactor));
                        _local9 = _local7;
                        _local10 = ((_local4 + 1) * (this.tileSize * this.puzzleScaleFactor));
                        mcContainerCage.graphics.moveTo(_local7, _local8);
                        mcContainerCage.graphics.lineTo(_local9, _local10);
                    };
                    _local5++;
                };
                _local4++;
            };
            _local4 = 0;
            while (_local4 < this.puzzleSize) {
                _local5 = 0;
                while (_local5 < (this.puzzleSize - 1)) {
                    _local6 = this.puzzleCageBarsH[this.puzzleIndex][_local4][_local5];
                    if (_local6 == "1"){
                        _local7 = (_local4 * (this.tileSize * this.puzzleScaleFactor));
                        _local8 = ((_local5 + 1) * (this.tileSize * this.puzzleScaleFactor));
                        _local9 = ((_local4 + 1) * (this.tileSize * this.puzzleScaleFactor));
                        _local10 = _local8;
                        mcContainerCage.graphics.moveTo(_local7, _local8);
                        mcContainerCage.graphics.lineTo(_local9, _local10);
                    };
                    _local5++;
                };
                _local4++;
            };
            stage.addChild(mcContainerCage);
        }
        private function CreateCandidateAutoremoveButtons():void{
        }
        private function CreatePuzzle():void{
            var _local1:uint;
            var _local2:uint;
            var _local3:String;
            var _local4:String;
            var _local5:Tile;
            var _local6:String;
            this.puzzleScaleFactor = ((Number(mcContainerTiles.width) / Number(this.puzzleSize)) / 100);
            _local1 = 0;
            while (_local1 < this.puzzleSize) {
                _local2 = 0;
                while (_local2 < this.puzzleSize) {
                    _local5 = new Tile();
                    _local5.CreateCandidatesArray(this.puzzleSize);
                    if (this.puzzleCageOperator[this.puzzleIndex][_local2][_local1] == "1"){
                        _local5.SetSingle(this.puzzleSolution[this.puzzleIndex][_local2][_local1]);
                    };
                    _local5.name = (("Tile" + _local1) + _local2);
                    _local5.CreateValueBar(this.puzzleSize);
                    _local5.CreateCandidateBar(70, this.puzzleSize);
                    _local5.addEventListener(MouseEvent.CLICK, this.EVENT_Tile_Click);
                    _local5.addEventListener(MouseEvent.MOUSE_OVER, this.EVENT_Tile_MouseOver);
                    _local5.addEventListener(MouseEvent.MOUSE_OUT, this.EVENT_Tile_MouseOut);
                    if (this.bFullFeatured){
                        _local5.addEventListener(MouseEvent.MOUSE_DOWN, this.EVENT_Tile_MouseDown);
                        _local5.addEventListener(MouseEvent.MOUSE_UP, this.EVENT_Tile_MouseUp);
                    };
                    _local5.x = ((_local1 * this.tileSize) * this.puzzleScaleFactor);
                    _local5.y = ((_local2 * this.tileSize) * this.puzzleScaleFactor);
                    _local5.SetIndex((_local1 + (_local2 * this.puzzleSize)));
                    _local6 = this.puzzleCageOperator[this.puzzleIndex][_local2][_local1];
                    _local3 = this.CreateTileTitle(_local1, _local2);
                    _local5.SetTitle(_local3, _local6);
                    _local5.SetSolution(this.puzzleSolution[this.puzzleIndex][_local2][_local1]);
                    _local5.scaleX = this.puzzleScaleFactor;
                    _local5.scaleY = this.puzzleScaleFactor;
                    mcContainerTiles.addChild(_local5);
                    this.puzzleValueUndo[_local2][_local1] = "";
                    this.puzzleCandidatesUndo[_local2][_local1] = "";
                    this.arrUndoValueStates.splice(0, this.arrUndoValueStates.length);
                    this.arrUndoCandidateStates.splice(0, this.arrUndoCandidateStates.length);
                    this.iUndoState = -1;
                    _local2++;
                };
                _local1++;
            };
        }
        private function CreateMenu():void{
            var _local4:Object;
            var _local5:String;
            var _local6:String;
            var _local7:uint;
            var _local8:FishEyeButton;
            mcContainerMenu.name = "MainMenu";
            this.CreateMainMenuText();
            var _local1:Number = 205;
            var _local2:Number = 120;
            var _local3:Number = 1.7;
            if (this.IsFinished(4)){
                _local4 = new FishEyeDoneButton4();
            } else {
                _local4 = new FishEyeButton4();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("4x4");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (0 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            if (this.IsFinished(5)){
                _local4 = new FishEyeDoneButton5();
            } else {
                _local4 = new FishEyeButton5();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("5x5");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (1 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            if (this.IsFinished(6)){
                _local4 = new FishEyeDoneButton6();
            } else {
                _local4 = new FishEyeButton6();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("6x6");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (2 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            _local2 = 245;
            if (this.IsFinished(7)){
                _local4 = new FishEyeDoneButton7();
            } else {
                _local4 = new FishEyeButton7();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("7x7");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (0 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            if (this.IsFinished(8)){
                _local4 = new FishEyeDoneButton8();
            } else {
                _local4 = new FishEyeButton8();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("8x8");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (1 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            if (this.IsFinished(9)){
                _local4 = new FishEyeDoneButton9();
            } else {
                _local4 = new FishEyeButton9();
            };
            _local4.SetScaleOffset(_local3);
            _local4.SetRelativePoint(new Point(mcContainerMenu.x, mcContainerMenu.y));
            _local5 = new String("9x9");
            _local4.name = ("MainMenuFishButton" + _local5);
            _local6 = "";
            _local4.SetTitleSize(10);
            _local4.SetTitle(_local6);
            _local4.addEventListener(MouseEvent.CLICK, this.EVENT_MainMenuFishButton_Click);
            _local4.buttonMode = true;
            _local4.useHandCursor = true;
            _local4.x = (_local1 + (2 * 140));
            _local4.y = _local2;
            this.fishArray.push(_local4);
            _local7 = 0;
            while (_local7 < this.fishArray.length) {
                _local8 = this.fishArray[_local7];
                mcContainerMenu.addChild(_local8);
                _local7++;
            };
            mcContainerMenu.addChild(this.lang.mcMenu);
            mcContainerMenu.addChild(this.mcCopyrightFooter);
            this.mcFlagButtonCN.x = 555;
            this.mcFlagButtonCN.y = 5;
            this.mcFlagButtonHR.x = (this.mcFlagButtonCN.x - 35);
            this.mcFlagButtonHR.y = 5;
            this.mcFlagButtonAE.x = (this.mcFlagButtonHR.x - 35);
            this.mcFlagButtonAE.y = 5;
            this.mcFlagButtonPT.x = (this.mcFlagButtonAE.x - 35);
            this.mcFlagButtonPT.y = 5;
            this.mcFlagButtonFR.x = (this.mcFlagButtonPT.x - 35);
            this.mcFlagButtonFR.y = 5;
            this.mcFlagButtonDE.x = (this.mcFlagButtonFR.x - 35);
            this.mcFlagButtonDE.y = 5;
            this.mcFlagButtonIT.x = (this.mcFlagButtonDE.x - 35);
            this.mcFlagButtonIT.y = 5;
            this.mcFlagButtonSP.x = (this.mcFlagButtonIT.x - 35);
            this.mcFlagButtonSP.y = 5;
            this.mcFlagButtonEN.x = (this.mcFlagButtonSP.x - 35);
            this.mcFlagButtonEN.y = 5;
        }
        private function CreateSidebarNotes():void{
            this.mcCandidatesControl.x = 20;
            this.mcCandidatesControl.y = (mcContainerTiles.y + 8);
            this.mcNotesControl.buttonMode = true;
            this.mcNotesControl.useHandCursor = true;
            this.mcNotesControl.x = (mcContainerTiles.x - 5);
            this.mcNotesControl.y = ((mcContainerTiles.y + mcContainerTiles.height) + 5);
            this.mcNotesControl.notesON.visible = true;
            this.mcNotesControl.notesOFF.visible = false;
            this.mcNotesControl.addEventListener(MouseEvent.CLICK, this.EVENT_NotesControl_MouseClick);
            stage.addChild(this.mcSidebarBackground);
            stage.addChild(this.mcCandidatesControl);
            stage.addChild(this.mcNotesControl);
        }
        private function CreateSidebarLevelDisplay():void{
            var _local3:uint;
            var _local4:MovieClip;
            var _local5:MovieClip;
            var _local6:MovieClip;
            this.mcLevelDisplay.x = ((this.mcNotesControl.x + this.mcNotesControl.width) + 1);
            this.mcLevelDisplay.y = this.mcNotesControl.y;
            var _local1:Number = 70;
            var _local2:Number = 5;
            _local3 = 0;
            while (_local3 < this.iPuzzleLevel) {
                _local4 = new LevelStar();
                _local4.x = (_local1 + ((_local4.width + 5) * _local3));
                _local4.y = _local2;
                _local4.scaleX = 0.8;
                _local4.scaleY = 0.8;
                if (this.bFullFeatured){
                    this.mcLevelDisplay.addChild(_local4);
                };
                _local3++;
            };
            if (!this.bFullFeatured){
                _local5 = MovieClip(this.mcLevelDisplay.getChildByName("LevelsFade"));
                if (_local5){
                    this.mcLevelDisplay.removeChild(_local5);
                };
                _local6 = new MovieClip();
                _local6.name = "LevelsFade";
                _local6.graphics.beginFill(0xFFFFFF, 0.6);
                _local6.graphics.drawRect(0, 0, this.mcLevelDisplay.width, this.mcLevelDisplay.height);
                this.mcLevelDisplay.addChild(_local6);
            } else {
                _local5 = MovieClip(this.mcLevelDisplay.getChildByName("LevelsFade"));
                if (_local5){
                    this.mcLevelDisplay.removeChild(_local5);
                };
            };
            stage.addChild(this.mcLevelDisplay);
        }
        private function CreateSideBar():void{
            var _local1:int;
            var _local14:Object;
            var _local15:Object;
            var _local16:FishEyeButtonSidebar;
            this.CreateSidebarNotes();
            var _local2:Number = (10 + 10);
            var _local3:Number = ((this.mcCandidatesControl.y + this.mcCandidatesControl.height) + 14);
            var _local4:Number = 1;
            var _local5:Number = 0;
            var _local6:Object;
            _local6 = new FishEyeButtonSidebar();
            _local6.SetTitlePosition(new Point(2, 4));
            _local6.SetTitle(this.lang.choose_another);
            this.SetupSidebarButton(_local6, 10341494, "btnChooseAnother", _local2, (_local3 + _local5), true);
            var _local7:Object;
            if (this.lang.lang == "Chinese"){
                _local7 = new SidebarButtonMenuCN();
            } else {
                _local7 = new FishEyeButtonSidebar();
                _local7.FullFeatured(((this.bFullFeatured) || (this.bDemo)));
                _local7.SetTitlePosition(new Point(2, 4));
                _local7.SetTitle(this.lang.solve_another);
            };
            var _temp1 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local7, 10341494, "btnSolveAnother", _local2, ((_local3 + _local5) + (27 * _temp1)), true);
            _local5 = (_local5 + 10);
            var _local8:Object;
            if (this.lang.lang == "Chinese"){
                _local8 = new SidebarButtonUndoCN();
            } else {
                _local8 = new FishEyeButtonSidebar();
                _local8.FullFeatured(this.bFullFeatured);
                _local8.SetTitlePosition(new Point(2, 4));
                _local8.SetTitle(this.lang.undo);
            };
            var _temp2 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local8, 1812694, "btnUndo", _local2, ((_local3 + _local5) + (27 * _temp2)), true);
            var _local9:Object;
            _local9 = new FishEyeButtonSidebar();
            _local9.FullFeatured(this.bFullFeatured);
            _local9.SetTitlePosition(new Point(2, 4));
            _local9.SetTitle(this.lang.redo);
            var _temp3 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local9, 1812694, "btnRedo", _local2, ((_local3 + _local5) + (27 * _temp3)), true);
            _local5 = (_local5 + 10);
            var _local10:Object;
            if (this.lang.lang == "Chinese"){
                _local10 = new SidebarButtonRevealCN();
            } else {
                _local10 = new FishEyeButtonSidebar();
                _local10.SetTitlePosition(new Point(2, 4));
                _local10.SetTitle(this.lang.reveal);
            };
            var _temp4 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local10, 16687674, "btnReveal", _local2, ((_local3 + _local5) + (27 * _temp4)), true);
            var _local11:Object;
            if (this.lang.lang == "Chinese"){
                _local11 = new SidebarButtonCheckCN();
            } else {
                _local11 = new FishEyeButtonSidebar();
                _local11.SetTitlePosition(new Point(2, 4));
                _local11.SetTitle(this.lang.check);
            };
            var _temp5 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local11, 16687674, "btnCheck", _local10.x, ((_local3 + _local5) + (27 * _temp5)), true);
            var _local12:Object;
            _local12 = new FishEyeButtonSidebar();
            _local12.FullFeatured(this.bFullFeatured);
            _local12.SetTitlePosition(new Point(2, 4));
            _local12.SetTitle(this.lang.solution);
            var _temp6 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local12, 16687674, "btnSolution", _local2, ((_local3 + _local5) + (27 * _temp6)), true);
            _local5 = (_local5 + 10);
            if (!this._bGuestPlay){
                _local14 = null;
                _local14 = new FishEyeButtonSidebar();
                _local14.FullFeatured(this.bFullFeatured);
                _local14.SetTitlePosition(new Point(2, 4));
                _local14.SetTitle("Resume");
                var _temp7 = _local4;
                _local4 = (_local4 + 1);
                this.SetupSidebarButton(_local14, 15607332, "btnLoad", _local2, ((_local3 + _local5) + (27 * _temp7)), true);
            };
            if (!this._bGuestPlay){
                _local15 = null;
                _local15 = new FishEyeButtonSidebar();
                _local15.FullFeatured(this.bFullFeatured);
                _local15.SetTitlePosition(new Point(2, 4));
                _local15.SetTitle(this.lang.save);
                var _temp8 = _local4;
                _local4 = (_local4 + 1);
                this.SetupSidebarButton(_local15, 15607332, "btnSave", _local2, ((_local3 + _local5) + (27 * _temp8)), true);
            };
            var _local13:Object;
            _local13 = new FishEyeButtonSidebar();
            _local13.FullFeatured(this.bFullFeatured);
            _local13.SetTitlePosition(new Point(2, 4));
            _local13.SetTitle(this.lang.reset);
            var _temp9 = _local4;
            _local4 = (_local4 + 1);
            this.SetupSidebarButton(_local13, 15607332, "btnReset", _local2, ((_local3 + _local5) + (27 * _temp9)), true);
            _local1 = 0;
            while (_local1 < this.fishSideBarArray.length) {
                _local16 = this.fishSideBarArray[_local1];
                stage.addChild(_local16);
                _local1++;
            };
        }
        private function SetupSidebarButton(_arg1:Object, _arg2:uint, _arg3:String, _arg4:Number, _arg5:Number, _arg6:Boolean){
            _arg1.name = _arg3;
            _arg1.addEventListener(MouseEvent.CLICK, this.EVENT_SideBar_Click);
            _arg1.buttonMode = true;
            _arg1.useHandCursor = true;
            _arg1.visible = _arg6;
            _arg1.x = _arg4;
            _arg1.y = _arg5;
            _arg1.SetBaseColor(_arg2);
            this.fishSideBarArray.push(_arg1);
        }
        private function CreateMainMenuText():void{
            this.textMainMenuTitleStyle.font = "Cooper Std Black";
            this.textMainMenuTitleStyle.size = 36;
            this.textMainMenuTitleStyle.color = 0;
            this.textMainMenuTitle.x = 220;
            this.textMainMenuTitle.y = 180;
            this.textMainMenuTitle.autoSize = TextFieldAutoSize.LEFT;
            this.textMainMenuTitle.type = TextFieldType.DYNAMIC;
            this.textMainMenuTitle.selectable = false;
            this.textMainMenuTitle.mouseEnabled = false;
            this.textMainMenuTitle.defaultTextFormat = this.textMainMenuTitleStyle;
            this.textMainMenuTitle.name = "txtMainMenu";
            this.textMainMenuTitle.text = "";
            mcContainerMenu.addChild(this.textMainMenuTitle);
        }
        private function CreateSideBarText():void{
        }
        private function CreateTileTitle(_arg1:uint, _arg2:uint):String{
            var _local3:String = this.puzzleCageTotal[this.puzzleIndex][_arg2][_arg1];
            if (_local3 == "0"){
                _local3 = "";
            };
            return (_local3);
        }
        private function CreatePuzzleFilename(_arg1:uint):String{
            var _local2:Date = new Date();
            var _local3:* = ("000" + _local2.getDate().toString());
            var _local4:* = this.arrMonthName[_local2.getMonth()];
            var _local5:* = ((_arg1 + "x") + _arg1);
            var _local6:* = (((((_local4 + "/KenKen.com.") + _local5) + _local4) + _local3.substr((_local3.length - 4), 4)) + ".txt");
            var _local7:String = ("http://ken.applnk.com/kenken/puzzles/KenKen/" + _local6);
            return (_local7);
        }
        private function ShowHowToPage():void{
            var _local3:uint;
            mcContainerHowTo.addEventListener(MouseEvent.CLICK, this.EVENT_Help_Click);
            var _local1:Object = stage.getChildByName("mcTileCandidateBar");
            if (_local1){
                stage.removeChild(MovieClip(_local1));
            };
            stage.addChild(mcContainerHowTo);
            var _local2:Object = stage.getChildByName("btnBack");
            if (_local2){
                _local3 = stage.numChildren;
                stage.setChildIndex(FishEyeButtonSidebar(_local2), (_local3 - 1));
                _local2.width = 120;
                _local2.x = 10;
                _local2.y = 15;
                _local2.visible = true;
            };
        }
        private function ShowRulesPage():void{
            var _local3:uint;
            mcContainerRules.addEventListener(MouseEvent.CLICK, this.EVENT_Help_Click);
            var _local1:Object = stage.getChildByName("mcTileCandidateBar");
            if (_local1){
                stage.removeChild(MovieClip(_local1));
            };
            stage.addChild(mcContainerRules);
            var _local2:Object = stage.getChildByName("btnBack");
            if (_local2){
                _local3 = stage.numChildren;
                stage.setChildIndex(FishEyeButtonSidebar(_local2), (_local3 - 1));
                _local2.visible = true;
            };
        }
        private function ShowMenu():void{
            stage.addChild(mcContainerMenu);
        }
        private function ShowPuzzle():void{
            stage.addChild(this.mcPauseScreen);
            stage.addChild(mcContainerTiles);
            stage.addChild(this.mcPuzzleNumber);
            stage.addChild(this.mcPrintPuzzleBtn);
            stage.addChild(this.mcPausePuzzleBtn);
            stage.addChild(this.mcUnPausePuzzleBtn);
            stage.addChild(this.mcKenKenTimerDisplay);
            stage.addChild(this.mcCopyrightFooter);
        }
        private function ShowValueBar(_arg1:Tile):void{
            var _local2:MovieClip = _arg1.valueBar;
            _local2.x = ((_arg1.x + mcContainerTiles.x) + (_arg1.width / 2));
            _local2.y = ((_arg1.y + mcContainerTiles.y) + (_arg1.height / 2));
            stage.addChild(_local2);
        }
        private function ShowCandidateBar(_arg1:Tile):void{
            var _local2:MovieClip = _arg1.candidateBar;
            _local2.x = (this.mcCandidatesControl.x + 42);
            _local2.y = (this.mcCandidatesControl.y + 40);
            stage.addChild(_local2);
        }
        private function ShowCandidateAutoremove():void{
        }
        private function ShowHoverBar():void{
            var _local1:TextField;
            var _local2:Array;
            var _local3:uint;
            var _local4:TextField;
            if (!this.candidateTile){
                return;
            };
            this.hoverBar = new MovieClip();
            this.hoverBar.name = "mcHoverBar";
            this.hoverBar.graphics.lineStyle(1, 0);
            this.hoverBar.graphics.beginFill(0xFFFFFF, 1);
            this.hoverBar.graphics.drawRect(-17, -34, 34, 34);
            this.hoverBar.mouseEnabled = false;
            this.hoverBar.visible = true;
            if (this.candidateTile.GetSingle() != -1){
                _local1 = new TextField();
                _local1.x = -5;
                _local1.y = -25;
                _local1.defaultTextFormat = this.textHoverSelStyle;
                _local1.text = String(this.candidateTile.GetSingle());
                _local1.mouseEnabled = false;
                _local1.selectable = false;
                this.hoverBar.addChild(_local1);
            } else {
                _local2 = this.candidateTile.GetHoverCandidatesArray();
                _local3 = 0;
                while (_local3 < _local2.length) {
                    _local4 = new TextField();
                    _local4.x = (((_local3 % 3) * 10) - 14);
                    _local4.y = ((int((_local3 / 3)) * 10) - 35);
                    if (_local2[_local3]){
                        _local4.defaultTextFormat = this.textHoverSelStyle;
                    } else {
                        _local4.defaultTextFormat = this.textHoverStyle;
                    };
                    _local4.text = String((_local3 + 1));
                    _local4.mouseEnabled = false;
                    _local4.selectable = false;
                    this.hoverBar.addChild(_local4);
                    _local3++;
                };
            };
            stage.addChild(this.hoverBar);
        }
        private function ShowCheckButton():void{
            var _local1:Object = stage.getChildByName("btnCheck");
            if (_local1){
                _local1.visible = true;
            };
        }
        private function ShowDoneButton():void{
            var _local1:Object = stage.getChildByName("btnDone");
            if (_local1){
                _local1.visible = true;
            };
        }
        private function HideHowToPage():void{
            if (stage.getChildByName("ContainerHowTo")){
                stage.removeChild(mcContainerHowTo);
            };
            var _local1:Object = stage.getChildByName("btnBack");
            if (_local1){
                _local1.visible = false;
            };
        }
        private function HideRulesPage():void{
            if (stage.getChildByName("ContainerRules")){
                stage.removeChild(mcContainerRules);
            };
            var _local1:Object = stage.getChildByName("btnBack");
            if (_local1){
                _local1.visible = false;
            };
        }
        private function HideCheckButton():void{
            var _local1:Object = stage.getChildByName("btnCheck");
            if (_local1){
                _local1.visible = false;
            };
        }
        private function HideDoneButton():void{
            var _local1:Object = stage.getChildByName("btnDone");
            if (_local1){
                _local1.visible = false;
            };
        }
        private function HideButton(_arg1:String):void{
            var _local2:Object = stage.getChildByName(_arg1);
            if (_local2){
                _local2.visible = false;
            };
        }
        private function ShowButton(_arg1:String):void{
            var _local2:Object = stage.getChildByName(_arg1);
            if (_local2){
                _local2.visible = true;
            };
        }
        private function HideHoverBar():void{
            var _local3:int;
            var _local4:Object;
            if (!this.hoverBar){
                return;
            };
            var _local1:Object = stage.getChildByName("mcHoverBar");
            if (!_local1){
                return;
            };
            stage.removeChild(MovieClip(_local1));
            this.hoverBar.graphics.clear();
            var _local2:uint = this.hoverBar.numChildren;
            _local3 = (_local2 - 1);
            while (_local3 >= 0) {
                _local4 = this.hoverBar.getChildAt(_local3);
                this.hoverBar.removeChildAt(_local3);
                _local3--;
            };
            this.hoverBar = null;
        }
        public function RemoveWinScreen():void{
        }
        private function RemoveWinText():void{
            if (stage.getChildByName("WinScreen")){
                stage.removeChild(this.mcCongratulations);
            };
        }
        private function RemoveLoseText():void{
            if (stage.getChildByName("LoseScreen")){
                stage.removeChild(this.mcTryAgain);
            };
        }
        private function RemoveMenu():void{
            var _local2:int;
            var _local5:Object;
            var _local1:uint = mcContainerMenu.numChildren;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local5 = mcContainerMenu.getChildAt(_local2);
                if ((_local5 is FishEyeButton)){
                    mcContainerMenu.removeChildAt(_local2);
                };
                _local2--;
            };
            this.RemoveSideBar();
            if (mcContainerMenu.getChildByName("txtMainMenu")){
                mcContainerMenu.removeChild(this.textMainMenuTitle);
            };
            var _local3:Object = mcContainerMenu.getChildByName(this.lang.mcMenu.name);
            if (_local3){
                mcContainerMenu.removeChild(DisplayObject(_local3));
            };
            var _local4:Object = mcContainerMenu.getChildByName(this.mcCopyrightFooter.name);
            if (_local4){
                mcContainerMenu.removeChild(DisplayObject(_local4));
            };
            if (stage.getChildByName("MainMenu") != null){
                stage.removeChild(mcContainerMenu);
            };
        }
        private function RemoveCage():void{
            mcContainerCage.graphics.clear();
            if (stage.getChildByName("ContainerCage") != null){
                stage.removeChild(mcContainerCage);
            };
        }
        private function RemoveTiles():void{
            var _local2:int;
            var _local3:Object;
            var _local4:Object;
            this.UnselectAllTiles();
            var _local1:uint = mcContainerTiles.numChildren;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = mcContainerTiles.getChildAt(_local2);
                if ((_local3 is Tile)){
                    _local4 = _local3.getChildByName("mcOperator");
                    if (_local4){
                        _local3.removeChild(_local4);
                    };
                    mcContainerTiles.removeChildAt(_local2);
                };
                _local2--;
            };
            if (stage.getChildByName("ContainerTiles") != null){
                stage.removeChild(mcContainerTiles);
            };
            if (stage.getChildByName("PuzzleFooter") != null){
                stage.removeChild(this.mcPuzzleFooter);
            };
            if (stage.getChildByName("PuzzleNumber") != null){
                stage.removeChild(this.mcPuzzleNumber);
            };
            if (stage.getChildByName("PrintPuzzleBtn") != null){
                stage.removeChild(this.mcPrintPuzzleBtn);
            };
            if (stage.getChildByName("PausePuzzleBtn") != null){
                stage.removeChild(this.mcPausePuzzleBtn);
            };
            if (stage.getChildByName("UnPausePuzzleBtn") != null){
                stage.removeChild(this.mcUnPausePuzzleBtn);
            };
            if (stage.getChildByName("KenKenTimerDisplay") != null){
                stage.removeChild(this.mcKenKenTimerDisplay);
            };
            if (stage.getChildByName("CopyrightFooter") != null){
                stage.removeChild(this.mcCopyrightFooter);
            };
        }
        private function RemoveCandidatesAutoremove():void{
        }
        private function RemoveCandidatesAutoremoveButtons():void{
        }
        private function RemoveSideBar():void{
            var _local2:int;
            var _local3:Object;
            if (stage.getChildByName(this.mcSidebarBackground.name)){
                stage.removeChild(this.mcSidebarBackground);
            };
            if (stage.getChildByName(this.bmpPuzzleImage.name)){
                stage.removeChild(this.bmpPuzzleImage);
            };
            if (stage.getChildByName(this.mcCandidatesControl.name)){
                stage.removeChild(this.mcCandidatesControl);
            };
            if (stage.getChildByName(this.mcNotesControl.name)){
                stage.removeChild(this.mcNotesControl);
            };
            if (stage.getChildByName(this.mcLevelDisplay.name)){
                stage.removeChild(this.mcLevelDisplay);
            };
            var _local1:uint = this.fishSideBarArray.length;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = stage.getChildByName(this.fishSideBarArray[_local2].name);
                if ((_local3 is FishEyeButtonSidebar)){
                    stage.removeChild(FishEyeButtonSidebar(_local3));
                };
                _local2--;
            };
            this.fishSideBarArray.splice(0, this.fishSideBarArray.length);
        }
        private function HideSideBar():void{
            var _local2:int;
            var _local3:Object;
            _local3 = stage.getChildByName(this.mcSidebarBackground.name);
            if (_local3){
                _local3.visible = false;
            };
            _local3 = stage.getChildByName(this.bmpPuzzleImage.name);
            if (_local3){
                _local3.visible = false;
            };
            _local3 = stage.getChildByName(this.mcCandidatesControl.name);
            if (_local3){
                _local3.visible = false;
            };
            _local3 = stage.getChildByName(this.mcNotesControl.name);
            if (_local3){
                _local3.visible = false;
            };
            _local3 = stage.getChildByName(this.mcLevelDisplay.name);
            if (_local3){
                _local3.visible = false;
            };
            var _local1:uint = this.fishSideBarArray.length;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = stage.getChildByName(this.fishSideBarArray[_local2].name);
                if ((_local3 is FishEyeButtonSidebar)){
                    _local3.visible = false;
                };
                _local2--;
            };
        }
        private function ShowSideBar():void{
            var _local2:int;
            var _local3:Object;
            _local3 = stage.getChildByName(this.mcSidebarBackground.name);
            if (_local3){
                _local3.visible = true;
            };
            _local3 = stage.getChildByName(this.bmpPuzzleImage.name);
            if (_local3){
                _local3.visible = true;
            };
            _local3 = stage.getChildByName(this.mcCandidatesControl.name);
            if (_local3){
                _local3.visible = true;
            };
            _local3 = stage.getChildByName(this.mcNotesControl.name);
            if (_local3){
                _local3.visible = true;
            };
            _local3 = stage.getChildByName(this.mcLevelDisplay.name);
            if (_local3){
                _local3.visible = true;
            };
            var _local1:uint = this.fishSideBarArray.length;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = stage.getChildByName(this.fishSideBarArray[_local2].name);
                if ((_local3 is FishEyeButtonSidebar)){
                    if (((this._bGuestPlay) && ((_local3.name == "btnSave")))){
                    } else {
                        _local3.visible = true;
                    };
                };
                _local2--;
            };
        }
        private function AddValueBarEventListeners(_arg1:Tile):void{
            var _local3:uint;
            var _local4:FishEyeSmallButton;
            var _local2:MovieClip = _arg1.valueBar;
            _local3 = 0;
            while (_local3 < _local2.numChildren) {
                _local4 = FishEyeSmallButton(_local2.getChildAt(_local3));
                _local4.addEventListener(MouseEvent.CLICK, this.EVENT_ValueButtonBar_Click);
                _local4.addEventListener(MouseEvent.MOUSE_UP, this.EVENT_ValueButtonBar_MouseUp);
                _local3++;
            };
        }
        private function AddCandidateAutoremoveButtonBarListeners():void{
        }
        private function AddCandidateBarEventListeners(_arg1:Tile):void{
            var _local3:uint;
            var _local4:Object;
            var _local2:MovieClip = _arg1.candidateBar;
            _local3 = 0;
            while (_local3 < _local2.numChildren) {
                _local4 = _local2.getChildAt(_local3);
                _local4.addEventListener(MouseEvent.CLICK, this.EVENT_CandidateButtonBar_Click);
                _local3++;
            };
        }
        private function GetPuzzleSize(_arg1:String){
            var rawData:* = null;
            var dataRow:* = null;
            var puzzleDescriptions:* = _arg1;
            try {
                rawData = puzzleDescriptions.split("\n");
                dataRow = this.StrTrim(rawData[1]);
            } catch(err:Error) {
                trace("Parser error (puzzle size).");
                return (0);
            };
            return (dataRow.length);
        }
        private function PuzzleDescriptionParser(_arg1:String):void{
            var _local2:uint;
            var _local3:uint;
            var _local4:uint;
            var _local5:Array;
            var _local6:uint;
            var _local7:String;
            var _local12:String;
            this.puzzleSize = this.GetPuzzleSize(_arg1);
            if (this.puzzleSize == 0){
                this.RestartKenKen();
                return;
            };
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                this.puzzleValueUndo.push(new Array(this.puzzleSize));
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                this.puzzleCandidatesUndo.push(new Array(this.puzzleSize));
                _local2++;
            };
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                this.puzzleCandidatesUndo[_local2].push(new Array(this.puzzleSize));
                _local2++;
            };
            var _local8:Array = new Array();
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local8.push(new Array(this.puzzleSize));
                _local2++;
            };
            var _local9:Array = new Array();
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local9.push(new Array((this.puzzleSize - 1)));
                _local2++;
            };
            var _local10:Array = _arg1.split("\n");
            var _local11 = -1;
            _local2 = 0;
            while (_local2 < _local10.length) {
                _local12 = this.StrTrim(_local10[_local2]);
                if (_local12 == "A"){
                    _local11++;
                    _local3 = 0;
                    while (_local3 < this.puzzleSize) {
                        _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                        _local6 = 0;
                        _local4 = 0;
                        while (_local4 < _local5.length) {
                            _local7 = this.StrTrim(_local5[_local4]);
                            if (_local7 != ""){
                                _local8[_local3][_local6] = _local7;
                                _local6++;
                            };
                            if (_local6 >= this.puzzleSize){
                                break;
                            };
                            _local4++;
                        };
                        _local3++;
                    };
                    this.puzzleSolution.push(this.CopyArray(_local8));
                    _local2 = (_local2 + _local3);
                } else {
                    if (_local12 == "T"){
                        _local3 = 0;
                        while (_local3 < this.puzzleSize) {
                            _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                            _local6 = 0;
                            _local4 = 0;
                            while (_local4 < _local5.length) {
                                _local7 = this.StrTrim(_local5[_local4]);
                                if (_local7 != ""){
                                    _local8[_local3][_local6] = _local7;
                                    _local6++;
                                };
                                if (_local6 >= this.puzzleSize){
                                    break;
                                };
                                _local4++;
                            };
                            _local3++;
                        };
                        this.puzzleCageTotal.push(this.CopyArray(_local8));
                        _local2 = (_local2 + _local3);
                    } else {
                        if (_local12 == "S"){
                            _local3 = 0;
                            while (_local3 < this.puzzleSize) {
                                _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                                _local6 = 0;
                                _local4 = 0;
                                while (_local4 < _local5.length) {
                                    _local7 = this.StrTrim(_local5[_local4]);
                                    if (_local7 != ""){
                                        _local8[_local3][_local6] = _local7;
                                        _local6++;
                                    };
                                    if (_local6 >= this.puzzleSize){
                                        break;
                                    };
                                    _local4++;
                                };
                                _local3++;
                            };
                            this.puzzleCageOperator.push(this.CopyArray(_local8));
                            _local2 = (_local2 + _local3);
                        } else {
                            if (_local12 == "SA"){
                                _local3 = 0;
                                while (_local3 < this.puzzleSize) {
                                    _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                                    _local6 = 0;
                                    _local4 = 0;
                                    while (_local4 < _local5.length) {
                                        _local7 = this.StrTrim(_local5[_local4]);
                                        if (_local7 != ""){
                                            _local8[_local3][_local6] = "";
                                            _local6++;
                                        };
                                        if (_local6 >= this.puzzleSize){
                                            break;
                                        };
                                        _local4++;
                                    };
                                    _local3++;
                                };
                                this.puzzleCageOperator.push(this.CopyArray(_local8));
                            } else {
                                if (_local12 == "V"){
                                    _local3 = 0;
                                    while (_local3 < this.puzzleSize) {
                                        _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                                        _local6 = 0;
                                        _local4 = 0;
                                        while (_local4 < _local5.length) {
                                            _local7 = this.StrTrim(_local5[_local4]);
                                            if (_local7 != ""){
                                                _local9[_local3][_local6] = _local7;
                                                _local6++;
                                            };
                                            if (_local6 >= (this.puzzleSize - 1)){
                                                break;
                                            };
                                            _local4++;
                                        };
                                        _local3++;
                                    };
                                    this.puzzleCageBarsV.push(this.CopyArray(_local9));
                                    _local2 = (_local2 + _local3);
                                } else {
                                    if (_local12 == "H"){
                                        _local3 = 0;
                                        while (_local3 < this.puzzleSize) {
                                            _local5 = _local10[((_local2 + _local3) + 1)].split(" ");
                                            _local6 = 0;
                                            _local4 = 0;
                                            while (_local4 < _local5.length) {
                                                _local7 = this.StrTrim(_local5[_local4]);
                                                if (_local7 != ""){
                                                    _local9[_local3][_local6] = _local7;
                                                    _local6++;
                                                };
                                                if (_local6 >= (this.puzzleSize - 1)){
                                                    break;
                                                };
                                                _local4++;
                                            };
                                            _local3++;
                                        };
                                        this.puzzleCageBarsH.push(this.CopyArray(_local9));
                                        _local2 = (_local2 + _local3);
                                    };
                                };
                            };
                        };
                    };
                };
                _local2++;
            };
        }
        private function LoadPuzzleDescriptions():void{
            try {
                trace((("Loading " + this.puzzleFilename) + " ..."));
                this.puzzleLoader = new URLLoader();
                this.puzzleLoader.addEventListener(Event.COMPLETE, this.EVENT_PuzzleLoaded);
                this.puzzleLoader.addEventListener(IOErrorEvent.IO_ERROR, this.EVENT_LoaderMissing);
                this.puzzleLoader.load(new URLRequest("http://localhost:3000/home/flash_test"));
            } catch(err:Error) {
                trace("Loader ... Exception caught.");
            };
        }
        private function EnableAvailableCandidates(_arg1:Tile):Boolean{
            var _local5:uint;
            var _local6:uint;
            var _local7:uint;
            var _local8:uint;
            var _local9:Tile;
            var _local10:Tile;
            if (!this.bCandidatesAutoremove){
                _arg1.EnableCandidate(_local5);
                return (true);
            };
            var _local2:Boolean;
            var _local3:uint = (_arg1.GetIndex() / this.puzzleSize);
            var _local4:uint = (_arg1.GetIndex() % this.puzzleSize);
            _local5 = 1;
            while (_local5 <= this.puzzleSize) {
                _local6 = 1;
                _local7 = 0;
                while (_local7 < this.puzzleSize) {
                    if (_local7 != _local3){
                        _local9 = Tile(mcContainerTiles.getChildByName((("Tile" + _local4) + _local7)));
                        _local6 = (_local6 & _local9.CheckCandidate(_local5));
                    };
                    _local7++;
                };
                _local8 = 0;
                while (_local8 < this.puzzleSize) {
                    if (_local8 != _local4){
                        _local10 = Tile(mcContainerTiles.getChildByName((("Tile" + _local8) + _local3)));
                        _local6 = (_local6 & _local10.CheckCandidate(_local5));
                    };
                    _local8++;
                };
                if (_local6){
                    _arg1.EnableCandidate(_local5);
                    _local2 = true;
                };
                _local5++;
            };
            return (_local2);
        }
        private function UpdateTileCandidates(_arg1:Tile, _arg2:uint):Boolean{
            var _local6:uint;
            var _local7:uint;
            var _local8:Tile;
            var _local9:Tile;
            if (_arg1.IsCandidateSelected(_arg2)){
                _arg1.DisableCandidate(_arg2);
                return (true);
            };
            if (!this.bCandidatesAutoremove){
                _arg1.EnableCandidate(_arg2);
                return (true);
            };
            var _local3:uint = (_arg1.GetIndex() / this.puzzleSize);
            var _local4:uint = (_arg1.GetIndex() % this.puzzleSize);
            var _local5:uint = 1;
            _local6 = 0;
            while (_local6 < this.puzzleSize) {
                if (_local6 != _local3){
                    _local8 = Tile(mcContainerTiles.getChildByName((("Tile" + _local4) + _local6)));
                    _local5 = (_local5 & _local8.CheckCandidate(_arg2));
                };
                _local6++;
            };
            _local7 = 0;
            while (_local7 < this.puzzleSize) {
                if (_local7 != _local4){
                    _local9 = Tile(mcContainerTiles.getChildByName((("Tile" + _local7) + _local3)));
                    _local5 = (_local5 & _local9.CheckCandidate(_arg2));
                };
                _local7++;
            };
            if (_local5){
                _arg1.EnableCandidate(_arg2);
                return (true);
            };
            return (false);
        }
        private function CorrectCandidates(_arg1:Tile, _arg2:uint):void{
            var _local5:uint;
            var _local6:uint;
            var _local7:Tile;
            var _local8:Tile;
            var _local3:uint = (_arg1.GetIndex() / this.puzzleSize);
            var _local4:uint = (_arg1.GetIndex() % this.puzzleSize);
            _local5 = 0;
            while (_local5 < this.puzzleSize) {
                if (_local5 != _local3){
                    _local7 = Tile(mcContainerTiles.getChildByName((("Tile" + _local4) + _local5)));
                    _local7.DisableCandidate(_arg2);
                    _local7.CreateCandidateBar(-1, this.puzzleSize);
                    _local7.RenderCandidates();
                    this.AddCandidateBarEventListeners(_local7);
                };
                _local5++;
            };
            _local6 = 0;
            while (_local6 < this.puzzleSize) {
                if (_local6 != _local4){
                    _local8 = Tile(mcContainerTiles.getChildByName((("Tile" + _local6) + _local3)));
                    _local8.DisableCandidate(_arg2);
                    _local8.CreateCandidateBar(-1, this.puzzleSize);
                    _local8.RenderCandidates();
                    this.AddCandidateBarEventListeners(_local8);
                };
                _local6++;
            };
        }
        private function CheckPuzzleFilled():void{
            var _local1:uint;
            var _local3:Object;
            this.SendAutoSave();
            var _local2:uint;
            _local1 = 0;
            while (_local1 < mcContainerTiles.numChildren) {
                _local3 = mcContainerTiles.getChildAt(_local1);
                if ((_local3 is Tile)){
                    if (_local3.GetValue() != ""){
                        _local2++;
                    };
                };
                _local1++;
            };
            if (_local2 == (this.puzzleSize * this.puzzleSize)){
                this.CheckPuzzleSolution(true);
            } else {
                this.HideDoneButton();
            };
        }
        private function CheckPuzzleSolution(_arg1:Boolean):void{
            var _local2:uint;
            var _local5:Object;
            var _local3:uint = 1;
            var _local4:uint;
            _local2 = 0;
            while (_local2 < mcContainerTiles.numChildren) {
                _local5 = mcContainerTiles.getChildAt(_local2);
                if ((_local5 is Tile)){
                    if (_local5.GetValue() != _local5.GetSolution()){
                        if (_local5.GetValue() == ""){
                            _local4++;
                        } else {
                            if (!_arg1){
                                _local5.Alert();
                            };
                        };
                        _local3 = 0;
                    } else {
                        if (!_arg1){
                            _local5.Approve();
                        };
                    };
                };
                _local2++;
            };
            if (_local3){
                this.mcKenKenTimerDisplay.Stop();
                this.StartWinSequence();
            } else {
                if (_local4 != 0){
                    this.HideDoneButton();
                };
            };
        }
        public function StartWinSequence():void{
            if (this.bSolutionUsed){
            };
            ExternalInterface.call("kenken.game.puzzleFinished", this.mcKenKenTimerDisplay.GetTime());
            stage.frameRate = 25;
            this.ShowWinText();
        }
        private function ShowLoseText():void{
        }
        private function SendAutoSave(){
            var _local1:Object = new Object();
            _local1.values = this.CollectValues();
            _local1.notes = this.CollectCandidates();
            var _local2:String = JSON.encode(_local1);
            ExternalInterface.call("kenken.game.autoSave", _local2);
        }
        private function SendSaveState(){
            var _local1:Object = new Object();
            _local1.values = this.CollectValues();
            _local1.notes = this.CollectCandidates();
            var _local2:String = JSON.encode(_local1);
            ExternalInterface.call("kenken.game.saveState", _local2);
        }
        private function CollectCandidates():Array{
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            var _local1:Array = new Array();
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local3 = 0;
                while (_local3 < this.puzzleSize) {
                    _local4 = (_local3.toString() + _local2.toString());
                    _local5 = this.GetTile(_local4);
                    if (_local5){
                        _local1.push(_local5.GetCandidates());
                    };
                    _local3++;
                };
                _local2++;
            };
            return (_local1);
        }
        private function CollectValues():String{
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            var _local6:String;
            var _local1 = "";
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local3 = 0;
                while (_local3 < this.puzzleSize) {
                    _local4 = (_local3.toString() + _local2.toString());
                    _local5 = this.GetTile(_local4);
                    if (_local5){
                        _local6 = _local5.GetValue();
                        if (_local6 == ""){
                            _local1 = (_local1 + "0");
                        } else {
                            _local1 = (_local1 + _local6);
                        };
                    };
                    if (_local3 < (this.puzzleSize - 1)){
                        _local1 = (_local1 + ",");
                    };
                    _local3++;
                };
                if (_local2 < (this.puzzleSize - 1)){
                    _local1 = (_local1 + ",");
                };
                _local2++;
            };
            return (_local1);
        }
        private function SendBoardState(){
            var _local1:String;
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            var _local6:String;
            _local1 = ("{\"size\": " + this.puzzleSize);
            _local1 = (_local1 + ", \"values\": [");
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local1 = (_local1 + "[ ");
                _local3 = 0;
                while (_local3 < this.puzzleSize) {
                    _local4 = (_local3.toString() + _local2.toString());
                    _local5 = this.GetTile(_local4);
                    if (_local5){
                        _local6 = _local5.GetValue();
                        if (_local6 == ""){
                            _local1 = (_local1 + "0");
                        } else {
                            _local1 = (_local1 + _local6);
                        };
                    };
                    if (_local3 < (this.puzzleSize - 1)){
                        _local1 = (_local1 + ",");
                    };
                    _local3++;
                };
                _local1 = (_local1 + " ]");
                if (_local2 < (this.puzzleSize - 1)){
                    _local1 = (_local1 + ",");
                };
                _local2++;
            };
            _local1 = (_local1 + "]");
            ExternalInterface.call("widgetBoardState", _local1);
        }
        private function CreateFriendlyTimeString(){
            var _local1 = "";
            var _local2:Boolean;
            var _local3:Boolean;
            if (this.mcKenKenTimerDisplay.GetHrs() > 0){
                if (this.mcKenKenTimerDisplay.GetHrs() == 1){
                    _local1 = ("1 " + this.lang.hour);
                } else {
                    _local1 = ((this.mcKenKenTimerDisplay.GetHrs().toString() + " ") + this.lang.hours);
                };
                _local2 = true;
            };
            if (this.mcKenKenTimerDisplay.GetMin() > 0){
                if (this.mcKenKenTimerDisplay.GetMin() == 1){
                    if (_local2){
                        _local1 = (_local1 + (", 1 " + this.lang.minute));
                    } else {
                        _local1 = ("1 " + this.lang.minute);
                    };
                } else {
                    if (_local2){
                        _local1 = (_local1 + (((", " + this.mcKenKenTimerDisplay.GetMin().toString()) + " ") + this.lang.minutes));
                    } else {
                        _local1 = ((this.mcKenKenTimerDisplay.GetMin().toString() + " ") + this.lang.minutes);
                    };
                };
                _local3 = true;
            };
            if (this.mcKenKenTimerDisplay.GetSec() > 0){
                if (this.mcKenKenTimerDisplay.GetSec() == 1){
                    if (((_local2) || (_local3))){
                        _local1 = (_local1 + (((" " + this.lang.and) + " 1 ") + this.lang.second));
                    } else {
                        _local1 = ("1 " + this.lang.second);
                    };
                } else {
                    if (((_local2) || (_local3))){
                        _local1 = (_local1 + (((((" " + this.lang.and) + " ") + this.mcKenKenTimerDisplay.GetSec().toString()) + " ") + this.lang.seconds));
                    } else {
                        _local1 = ((this.mcKenKenTimerDisplay.GetSec().toString() + " ") + this.lang.seconds);
                    };
                };
            };
            return (_local1);
        }
        private function ShowWinScreen():void{
            this.RemoveCage();
            this.RemoveTiles();
        }
        private function WarningRevealBox(){
            if (stage.getChildByName("Warning")){
                return;
            };
            this.mcWarning.title.text = "Reveal a random box?";
            this.CreateWarningRevealBoxButton();
            stage.addChild(this.mcWarning);
        }
        private function WarningSolveAnother(){
            if (stage.getChildByName("Warning")){
                return;
            };
            this.mcWarning.title.text = "Solve another puzzle?";
            this.CreateWarningSolveAnotherButton();
            stage.addChild(this.mcWarning);
        }
        private function WarningResetPuzzle(){
            if (stage.getChildByName("Warning")){
                return;
            };
            this.mcWarning.title.text = "Reset puzzle?";
            this.CreateWarningResetPuzzleButton();
            stage.addChild(this.mcWarning);
        }
        private function WarningShowSolution():void{
            if (stage.getChildByName("Warning")){
                return;
            };
            this.mcWarning.title.text = "See solution?";
            this.CreateWarningSolutionPuzzleButton();
            stage.addChild(this.mcWarning);
        }
        private function RemovePopups():void{
            if (stage.getChildByName("NotificationPopup")){
                stage.removeChild(this.mcNotificationPopup);
            };
            if (stage.getChildByName("Warning")){
                stage.removeChild(this.mcWarning);
            };
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
        }
        private function ShowNotification():void{
            if (stage.getChildByName("NotificationPopup")){
                return;
            };
            stage.addChild(this.mcNotificationPopup);
        }
        private function CreateWarningRevealBoxButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("OK");
            var _local2:Number = ((this.mcWarning.width - _local1.width) / 2);
            _local1.name = "mcWarningButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_WarningRevealBoxButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 60;
            this.RemoveWarningButtons();
            this.mcWarning.addChild(_local1);
        }
        private function CreateWarningSolveAnotherButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("OK");
            _local1.name = "mcWarningButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_WarningSolveAnotherButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 60;
            this.RemoveWarningButtons();
            this.mcWarning.addChild(_local1);
        }
        private function CreateWarningResetPuzzleButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("OK");
            _local1.name = "mcWarningButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_WarningResetButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 60;
            this.RemoveWarningButtons();
            this.mcWarning.addChild(_local1);
        }
        private function CreateWarningSolutionPuzzleButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("OK");
            _local1.name = "mcWarningButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_WarningSolutionButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 60;
            this.RemoveWarningButtons();
            this.mcWarning.addChild(_local1);
        }
        private function RemoveWarningButtons():void{
            var _local2:int;
            var _local3:Object;
            var _local1:uint = this.mcWarning.numChildren;
            _local2 = (_local1 - 1);
            while (_local2 >= 0) {
                _local3 = this.mcWarning.getChildAt(_local2);
                if ((_local3 is WinScreenButton)){
                    this.mcWarning.removeChildAt(_local2);
                };
                _local2--;
            };
        }
        private function CreateSolveAnotherButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("Learn More");
            _local1.name = "mcPurchasePuzzleButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_FreeSolveAnotherButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 100;
            this.mcPurchasePuzzle.title.text = "Play All You Want!";
            this.mcPurchasePuzzle.lead.text = "Use toKENs to play as often as you like!\nPlus: Select puzzle size, operations, and difficulty.";
            this.mcPurchasePuzzle.addChild(_local1);
        }
        private function CreatePurchasePuzzleButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle((("Use " + this.strRegularPuzzlePrice) + " toKENs"));
            _local1.name = "mcPurchasePuzzleButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_PurchasePuzzleButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 100;
            this.mcPurchasePuzzle.title.text = "USE TOKENS";
            this.mcPurchasePuzzle.lead.text = (("" + this.strRegularPuzzlePrice) + " toKENs will be deducted from your account");
            this.mcPurchasePuzzle.addChild(_local1);
        }
        private function CreateNotificationButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetTitle("Upgrade Play for 10 toKENs");
            _local1.name = "mcNotificationButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_NotificationButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = 0;
            _local1.y = 140;
            this.mcNotificationPopup.addChild(_local1);
        }
        private function CreateWinScreenButton(){
            var _local1:MovieClip;
            _local1 = new WinScreenButton();
            _local1.SetWidth(this.mcCongratulations.width);
            if (this.bFullFeatured){
                _local1.SetTitle("SOLVE ANOTHER PUZZLE");
            } else {
                if (((!(this.bFullFeatured)) && (!(this.bDemo)))){
                    _local1.SetTitle("Try Another Free Daily Puzzle");
                } else {
                    if (this.bDemo){
                        _local1.SetTitle("Solve Free Daily Puzzles");
                    };
                };
            };
            _local1.name = "mcWinScreenButton";
            _local1.addEventListener(MouseEvent.CLICK, this.EVENT_WinScreenButton_Click);
            _local1.buttonMode = true;
            _local1.useHandCursor = true;
            _local1.visible = true;
            _local1.x = -195;
            _local1.y = 520;
            this.mcCongratulations.addChild(_local1);
        }
        private function ShowFreeSolveAnother():void{
            this.CreateSolveAnotherButton();
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
            stage.addChild(this.mcPurchasePuzzle);
        }
        private function ShowPurchasePuzzle():void{
            this.CreatePurchasePuzzleButton();
            if (stage.getChildByName("PurchasePuzzle")){
                stage.removeChild(this.mcPurchasePuzzle);
            };
            stage.addChild(this.mcPurchasePuzzle);
        }
        private function CreateWinScreenText():void{
        }
        private function DisableTiles():void{
            var _local1:uint;
            var _local3:Object;
            var _local2:uint;
            _local1 = 0;
            while (_local1 < mcContainerTiles.numChildren) {
                _local3 = mcContainerTiles.getChildAt(_local1);
                if ((_local3 is Tile)){
                    _local3.DisableTile();
                    _local3.removeEventListener(MouseEvent.MOUSE_DOWN, this.EVENT_Tile_MouseDown);
                    _local3.removeEventListener(MouseEvent.MOUSE_UP, this.EVENT_Tile_MouseUp);
                };
                _local1++;
            };
        }
        private function EnableTiles():void{
            var _local1:uint;
            var _local3:Object;
            var _local2:uint;
            _local1 = 0;
            while (_local1 < mcContainerTiles.numChildren) {
                _local3 = mcContainerTiles.getChildAt(_local1);
                if ((_local3 is Tile)){
                    _local3.EnableTile();
                };
                _local1++;
            };
        }
        private function ShowWinText():void{
            ExternalInterface.call("kenken.game.puzzleSolved");
            this.mcCongratulations.timer.text = this.mcKenKenTimerDisplay.GetTime();
            this.DisableTiles();
            mcContainerTiles.x = 320;
            mcContainerTiles.y = 100;
            mcContainerTiles.scaleX = 0.84;
            mcContainerTiles.scaleY = 0.84;
            mcContainerCage.x = 320;
            mcContainerCage.y = 100;
            mcContainerCage.scaleX = 0.84;
            mcContainerCage.scaleY = 0.84;
            this.UnselectAllTiles();
            this.mcCongratulations.addChild(mcContainerTiles);
            this.mcCongratulations.addChild(mcContainerCage);
            stage.addChild(this.mcCongratulations);
            this._gameState = "kengratulations";
            ExternalInterface.call("kenken.game.widgetAdOnKengratulations");
        }
        private function ResetPuzzleArrays():void{
            this.puzzleSolution.splice(0, this.puzzleSolution.length);
            this.puzzleCageTotal.splice(0, this.puzzleCageTotal.length);
            this.puzzleCageOperator.splice(0, this.puzzleCageOperator.length);
            this.puzzleCageBarsV.splice(0, this.puzzleCageBarsV.length);
            this.puzzleCageBarsH.splice(0, this.puzzleCageBarsH.length);
            this.puzzleValueUndo.splice(0, this.puzzleValueUndo.length);
            this.puzzleCandidatesUndo.splice(0, this.puzzleCandidatesUndo.length);
            this.arrUndoValueStates.splice(0, this.arrUndoValueStates.length);
            this.arrUndoCandidateStates.splice(0, this.arrUndoCandidateStates.length);
            this.iUndoState = -1;
            this.fishArray.splice(0, this.fishArray.length);
        }
        private function ResetFinishedPuzzlesArray(){
            var _local1:* = 0;
            _local1 = 0;
            while (_local1 < 6) {
                this.arrFinishedPuzzles[_local1] = false;
                _local1++;
            };
        }
        private function HandleFish(_arg1:Point){
            var _local3:uint;
            var _local5:FishEyeButton;
            var _local2:uint = this.fishArray.length;
            var _local4:Number = 0;
            _local3 = 0;
            while (_local3 < _local2) {
                _local5 = this.fishArray[_local3];
                _local5.SetScale(_arg1);
                _local4 = (_local4 + _local5.GetWidth());
                _local3++;
            };
            if (this.targetTile){
                this.targetTile.UpdateFishButtons(_arg1);
            };
        }
        private function HandleSideBarFish(_arg1:Point){
            var _local3:uint;
            var _local5:FishEyeButtonSidebar;
        }
        private function HandleCandidateAutoremoveFish(_arg1:Point){
        }
        private function StrTrim(_arg1:String):String{
            var _local2:uint;
            var _local3:String;
            var _local4:String;
            _local3 = "";
            _local2 = 0;
            while (_local2 < _arg1.length) {
                _local4 = _arg1.charAt(_local2);
                if ((((_local4 > " ")) && ((_local4 < "~")))){
                    _local3 = (_local3 + _local4);
                };
                _local2++;
            };
            return (_local3);
        }
        private function CopyArray(_arg1:Object):Array{
            var _local2:ByteArray;
            _local2 = new ByteArray();
            _local2.writeObject(_arg1);
            _local2.position = 0;
            return (_local2.readObject());
        }
        private function RemoveValueBar():void{
            var _local1:Object;
            _local1 = stage.getChildByName("mcTileValueBar");
            if (_local1){
                stage.removeChild(this.targetTile.valueBar);
            };
        }
        private function UnselectAllTiles(){
            var _local1:Object;
            var _local2:Object;
            var _local3:uint;
            var _local4:uint;
            var _local5:Object;
            _local1 = stage.getChildByName("mcTileValueBar");
            if (_local1){
                stage.removeChild(this.targetTile.valueBar);
            };
            _local2 = stage.getChildByName("mcTileCandidateBar");
            if (_local2){
                stage.removeChild(MovieClip(_local2));
            };
            _local3 = mcContainerTiles.numChildren;
            _local4 = 0;
            while (_local4 < _local3) {
                _local5 = mcContainerTiles.getChildAt(_local4);
                if ((_local5 is Tile)){
                    _local5.Unselect();
                };
                _local4++;
            };
            if (this.targetTile){
                this.targetTile = null;
            };
            this.RemoveCandidatesAutoremove();
        }
        private function ProceedToNextPuzzle():void{
            this.puzzleIndex++;
            if (this.puzzleIndex >= this.puzzleSolution.length){
                this.RestartKenKen();
                return;
            };
            this.StartGame(true);
        }
        private function HideGame():void{
            var _local1:Object;
            if (mcContainerMenu != null){
                mcContainerMenu.visible = false;
            };
            if (mcContainerTiles != null){
                mcContainerTiles.visible = false;
            };
            this.HideSideBar();
            _local1 = stage.getChildByName("mcTileCandidateBar");
            if (_local1){
                _local1.visible = false;
            };
            if (this.mcKenKenTimerDisplay != null){
                this.mcKenKenTimerDisplay.visible = false;
            };
            if (this.mcPuzzleNumber != null){
                this.mcPuzzleNumber.visible = false;
            };
            if (this.mcPrintPuzzleBtn != null){
                this.mcPrintPuzzleBtn.visible = false;
            };
            if (this.mcPausePuzzleBtn != null){
                this.mcPausePuzzleBtn.visible = false;
            };
            if (this.mcUnPausePuzzleBtn != null){
                this.mcUnPausePuzzleBtn.visible = false;
            };
            if (mcContainerCage != null){
                mcContainerCage.visible = false;
            };
            if (this.mcPauseScreen != null){
                this.mcPauseScreen.visible = false;
            };
        }
        private function ShowGame():void{
            var _local1:Object;
            if (mcContainerMenu != null){
                mcContainerMenu.visible = true;
            };
            if (mcContainerTiles != null){
                mcContainerTiles.visible = true;
            };
            this.ShowSideBar();
            _local1 = stage.getChildByName("mcTileCandidateBar");
            if (_local1){
                _local1.visible = true;
            };
            if (this.mcKenKenTimerDisplay != null){
                this.mcKenKenTimerDisplay.visible = true;
            };
            if (this.mcPuzzleNumber != null){
                this.mcPuzzleNumber.visible = true;
            };
            if (this.mcPrintPuzzleBtn != null){
                this.mcPrintPuzzleBtn.visible = true;
            };
            if (mcContainerCage != null){
                mcContainerCage.visible = true;
            };
            this.iPuzzlePaused = (this.iPuzzlePaused ^ 1);
            this.HandlePuzzlePause();
        }
        private function RestartKenKen():void{
            trace("Restarting KenKen.");
            this.ResetPuzzleArrays();
            this.RemoveMenu();
            this.RemoveTiles();
            this.RemoveSideBar();
            this.RemoveCage();
            this.InitializeGame(false);
            this.puzzleIndex = 0;
            this.bSolutionUsed = false;
            this.mcKenKenTimerDisplay.Stop();
            this.iPuzzlePaused = 1;
            this.HandlePuzzlePause();
        }
        private function ResetPuzzle():void{
            trace("Resetting puzzle.");
            this.mcKenKenTimerDisplay.Reset();
            this.mcKenKenTimerDisplay.Start();
            this.ResetPuzzleArrays();
            this.ResetTiles();
        }
        private function RevealAll():void{
            var _local1:uint;
            var _local2:uint;
            var _local3:String;
            var _local4:Tile;
            var _local5:uint;
            _local1 = 0;
            while (_local1 < this.puzzleSize) {
                _local2 = 0;
                while (_local2 < this.puzzleSize) {
                    _local3 = (_local1.toString() + _local2.toString());
                    _local4 = this.GetTile(_local3);
                    if (_local4){
                        _local5 = _local4.GetSolution();
                        _local4.SetValue(String(_local5));
                    };
                    _local2++;
                };
                _local1++;
            };
            this.bSolutionUsed = true;
        }
        private function RevealTileSolution(_arg1:Tile){
            var _local2:*;
            _local2 = _arg1.GetSolution().toString();
            _arg1.SetValue(_local2);
            if (this.bCandidatesAutoremove){
                this.CorrectCandidates(_arg1, uint(_local2));
            };
            _arg1.HideCandidates();
            this.UndoSave();
        }
        private function RevealValue():void{
            var _local1:Array;
            var _local2:uint;
            var _local3:*;
            var _local4:Tile;
            var _local5:Beacon;
            var _local6:Object;
            _local1 = new Array();
            _local2 = 0;
            while (_local2 < mcContainerTiles.numChildren) {
                _local6 = mcContainerTiles.getChildAt(_local2);
                if ((_local6 is Tile)){
                    if (_local6.GetValue() == ""){
                        _local1.push(_local6);
                    };
                };
                _local2++;
            };
            if (_local1.length == 0){
                return;
            };
            _local3 = Math.round((Math.random() * (_local1.length - 1)));
            _local4 = _local1[_local3];
            _local1[_local3].SetValue(_local4.GetSolution().toString());
            _local4.HideCandidates();
            this.UndoSave();
            _local5 = new Beacon(this.sessionHash);
            _local5.MarkReveal(this.gaPuzzleDescription);
            this.CheckPuzzleFilled();
        }
        private function ResetTiles():void{
            var _local1:uint;
            var _local2:uint;
            var _local3:String;
            var _local4:Tile;
            _local1 = 0;
            while (_local1 < this.puzzleSize) {
                _local2 = 0;
                while (_local2 < this.puzzleSize) {
                    _local3 = (_local1.toString() + _local2.toString());
                    _local4 = this.GetTile(_local3);
                    if (_local4){
                        _local4.SetValue("");
                        _local4.ClearCandidatesArray();
                        _local4.DisableAllCandidates(this.puzzleSize);
                        _local4.CreateCandidateBar(-1, this.puzzleSize);
                        _local4.RenderCandidates();
                    };
                    _local2++;
                };
                _local1++;
            };
        }
        private function SetLoadedPuzzleState(){
            var _local1:Array;
            var _local2:Array;
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            var _local6:String;
            var _local7:String;
            var _local8:Tile;
            if (this.objLoadedPuzzleState == null){
                return;
            };
            if (this.objLoadedPuzzleState.values == ""){
                return;
            };
            _local1 = this.objLoadedPuzzleState.values.split(",");
            if (_local1.length != (this.puzzleSize * this.puzzleSize)){
                return;
            };
            if (this.objLoadedPuzzleState.notes == ""){
                return;
            };
            _local2 = this.objLoadedPuzzleState.notes;
            if (_local2.length != (this.puzzleSize * this.puzzleSize)){
                return;
            };
            _local3 = 0;
            while (_local3 < (this.puzzleSize * this.puzzleSize)) {
                _local4 = (_local3 / this.puzzleSize);
                _local5 = (_local3 % this.puzzleSize);
                _local6 = (_local5.toString() + _local4.toString());
                _local8 = this.GetTile(_local6);
                if (_local1[_local3] == 0){
                    _local7 = "";
                } else {
                    _local7 = _local1[_local3].toString();
                };
                _local8.SetValue(_local7);
                _local8.SetCandidates(_local2[_local3]);
                _local8.RenderCandidates();
                _local3++;
            };
        }
        private function SaveStatus(){
            var strFinishedPuzzles:* = null;
            try {
                this.soSavedStatus = SharedObject.getLocal("KenKen_finished_puzzles");
            } catch(error:Error) {
                if (CFG_DEBUG){
                };
                trace(error);
                return;
            };
            strFinishedPuzzles = this.soSavedStatus.data.finishedpuzzles;
            if (strFinishedPuzzles == null){
                this.soSavedStatus.data.finishedpuzzles = this.puzzleFilename;
                this.soSavedStatus.data.date = this.GetTodayDate();
                this.soSavedStatus.flush();
                this.soSavedStatus.close();
                return;
            };
            if (strFinishedPuzzles.search(this.puzzleFilename) != -1){
                return;
            };
            this.soSavedStatus.data.finishedpuzzles = (this.soSavedStatus.data.finishedpuzzles + ("," + this.puzzleFilename));
            this.soSavedStatus.data.date = this.GetTodayDate();
            this.soSavedStatus.flush();
            this.soSavedStatus.close();
        }
        private function LoadStatus(){
            var strFinishedPuzzles:* = null;
            var strSavedDate:* = undefined;
            var strTodayDate:* = undefined;
            var strCandidatePuzzle:* = null;
            var iSize:* = 0;
            this.ResetFinishedPuzzlesArray();
            try {
                this.soSavedStatus = SharedObject.getLocal("KenKen_finished_puzzles");
            } catch(error:Error) {
                if (CFG_DEBUG){
                };
                trace(error);
                return;
            };
            strFinishedPuzzles = this.soSavedStatus.data.finishedpuzzles;
            if (strFinishedPuzzles == null){
                return;
            };
            strSavedDate = this.soSavedStatus.data.date;
            strTodayDate = this.GetTodayDate();
            if (strSavedDate != strTodayDate){
                this.soSavedStatus.data.finishedpuzzles = "";
                this.soSavedStatus.data.date = strTodayDate;
                this.soSavedStatus.flush();
                this.soSavedStatus.close();
                return;
            };
            iSize = 4;
            while (iSize <= 9) {
                strCandidatePuzzle = this.CreatePuzzleFilename(iSize);
                if (strFinishedPuzzles.search(strCandidatePuzzle) != -1){
                    this.arrFinishedPuzzles[(iSize - 4)] = true;
                };
                iSize = (iSize + 1);
            };
        }
        private function GetTodayDate():String{
            var _local1:Date;
            var _local2:*;
            _local1 = new Date();
            _local2 = ((((_local1.getDate().toString() + ".") + (_local1.getMonth() + 1).toString()) + ".") + _local1.getFullYear().toString());
            return (_local2);
        }
        private function IsFinished(_arg1:uint):Boolean{
            return (this.arrFinishedPuzzles[(_arg1 - 4)]);
        }
        private function RestoreValues():void{
            var _local1:Array;
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            this.iUndoState--;
            if (this.iUndoState < 0){
                this.iUndoState++;
                return;
            };
            _local1 = this.arrUndoValueStates[this.iUndoState];
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local3 = 0;
                while (_local3 < this.puzzleSize) {
                    _local4 = (_local2.toString() + _local3.toString());
                    _local5 = this.GetTile(_local4);
                    if (_local5){
                        _local5.SetValue(_local1[_local3][_local2]);
                    };
                    _local3++;
                };
                _local2++;
            };
        }
        private function RestoreCandidates():void{
            var _local1:Array;
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            _local1 = this.arrUndoCandidateStates[this.iUndoState];
            _local2 = 0;
            while (_local2 < this.puzzleSize) {
                _local3 = 0;
                while (_local3 < this.puzzleSize) {
                    _local4 = (_local2.toString() + _local3.toString());
                    _local5 = this.GetTile(_local4);
                    if (((_local5) && (!((_local1[_local3][_local2] == ""))))){
                        _local5.SetCandidates(_local1[_local3][_local2]);
                        _local5.CreateCandidateBar(-1, this.puzzleSize);
                        if (_local5.GetValue() != ""){
                            _local5.HideCandidates();
                        } else {
                            _local5.RenderCandidates();
                        };
                    };
                    _local3++;
                };
                _local2++;
            };
        }
        private function SnapshotValues():void{
            var _local1:uint;
            var _local2:uint;
            var _local3:String;
            var _local4:Tile;
            _local1 = 0;
            while (_local1 < this.puzzleSize) {
                _local2 = 0;
                while (_local2 < this.puzzleSize) {
                    _local3 = (_local1.toString() + _local2.toString());
                    _local4 = this.GetTile(_local3);
                    if (_local4){
                        this.puzzleValueUndo[_local2][_local1] = _local4.GetValue();
                    };
                    _local2++;
                };
                _local1++;
            };
            this.iUndoState++;
            if (this.iUndoState == this.arrUndoValueStates.length){
                this.arrUndoValueStates.push(this.CopyArray(this.puzzleValueUndo));
            } else {
                this.arrUndoValueStates[this.iUndoState] = this.CopyArray(this.puzzleValueUndo);
            };
        }
        private function SnapshotCandidates():void{
            var _local1:uint;
            var _local2:uint;
            var _local3:uint;
            var _local4:String;
            var _local5:Tile;
            _local1 = 0;
            while (_local1 < this.puzzleSize) {
                _local2 = 0;
                while (_local2 < this.puzzleSize) {
                    _local4 = (_local1.toString() + _local2.toString());
                    _local5 = this.GetTile(_local4);
                    if (_local5){
                        this.puzzleCandidatesUndo[_local2][_local1] = this.CopyArray(_local5.GetCandidates());
                    };
                    _local2++;
                };
                _local1++;
            };
            if (this.iUndoState == this.arrUndoCandidateStates.length){
                this.arrUndoCandidateStates.push(this.CopyArray(this.puzzleCandidatesUndo));
            } else {
                this.arrUndoCandidateStates[this.iUndoState] = this.CopyArray(this.puzzleCandidatesUndo);
            };
        }
        private function UndoSave():void{
            var _local1:Object;
            var _local2:Object;
            if (this.iUndoState < (this.arrUndoValueStates.length - 1)){
                this.arrUndoValueStates.splice((this.iUndoState + 1), this.arrUndoValueStates.length);
                this.arrUndoCandidateStates.splice((this.iUndoState + 1), this.arrUndoCandidateStates.length);
                _local1 = stage.getChildByName("btnRedo");
                if (_local1){
                };
            };
            this.SnapshotValues();
            this.SnapshotCandidates();
            if (this.iUndoState > 0){
                _local2 = stage.getChildByName("btnUndo");
                if (_local2){
                };
            };
        }
        private function UndoRestore():void{
            var _local1:Object;
            var _local2:Object;
            this.RestoreValues();
            this.RestoreCandidates();
            _local1 = stage.getChildByName("btnUndo");
            if (_local1){
                if (this.iUndoState <= 0){
                    _local1.Unavailable();
                } else {
                    _local1.Available();
                };
            };
            _local2 = stage.getChildByName("btnRedo");
            if (_local2){
                if (this.iUndoState <= this.arrUndoValueStates.length){
                };
            };
            this.SendAutoSave();
        }
        private function RedoStates():void{
            var _local1:Object;
            var _local2:Array;
            var _local3:Array;
            var _local4:uint;
            var _local5:uint;
            var _local6:String;
            var _local7:Object;
            var _local8:Tile;
            this.iUndoState++;
            _local1 = stage.getChildByName("btnRedo");
            if (_local1){
                if (this.iUndoState >= (this.arrUndoValueStates.length - 1)){
                };
            };
            if (this.iUndoState >= this.arrUndoValueStates.length){
                this.iUndoState--;
                return;
            };
            _local7 = stage.getChildByName("btnUndo");
            if (_local7){
            };
            _local2 = this.arrUndoValueStates[this.iUndoState];
            _local3 = this.arrUndoCandidateStates[this.iUndoState];
            _local4 = 0;
            while (_local4 < this.puzzleSize) {
                _local5 = 0;
                while (_local5 < this.puzzleSize) {
                    _local6 = (_local4.toString() + _local5.toString());
                    _local8 = this.GetTile(_local6);
                    if (_local8){
                        _local8.SetValue(_local2[_local5][_local4]);
                        _local8.SetCandidates(_local3[_local5][_local4]);
                        if (_local8.GetValue() != ""){
                            _local8.HideCandidates();
                        } else {
                            _local8.RenderCandidates();
                        };
                    };
                    _local5++;
                };
                _local4++;
            };
            this.SendAutoSave();
        }
        private function AdsController(_arg1:Object):void{
            var objAdData:* = _arg1;
            try {
                if (this._afgAdsQueue == null){
                    this._afgAdsQueue = (objAdData as Array);
                };
                if (this._afgAdsQueue == null){
                    this._afgAdsQueue = null;
                    this.destroyAdsManager();
                    this.WidgetAdFinished();
                };
                if (this._afgAdsQueue.length == 0){
                    this._afgAdsQueue = null;
                    this.destroyAdsManager();
                    this.WidgetAdFinished();
                };
                if (this._afgAdsQueue[0].image_url != null){
                    this.HouseAdController();
                } else {
                    if (this._bPlayMoreVideo){
                        this.AFGKenKen(this._afgAdsQueue[0]);
                    } else {
                        this.AdsQueueHandler();
                    };
                };
            } catch(error:Error) {
                AdsQueueHandler();
            };
        }
        private function HouseAdController():void{
            try {
                if (this._afgHouseAdLoader == null){
                    this._afgHouseAdLoader = new Loader();
                };
                if ((((this._afgAdsQueue[0].image_url == null)) || ((this._afgAdsQueue[0].image_url == "")))){
                    this.AdsQueueHandler();
                };
                this._afgHouseAdLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.EVENT_ADS_HouseAdLoaded);
                this._afgHouseAdLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.EVENT_ADS_HouseAdLoadError);
                this._afgHouseAdLoader.load(new URLRequest(this._afgAdsQueue[0].image_url));
            } catch(err:Error) {
                AdsQueueHandler();
            };
        }
        private function EVENT_HouseAd_MouseClick(_arg1:Event):void{
            var url:* = null;
            var request:* = null;
            var event:* = _arg1;
            if (stage.getChildByName("image_house_ad")){
                stage.removeChild(this._afgHouseAdImage);
            };
            url = this._afgAdsQueue[0].link_url;
            request = new URLRequest(url);
            this._afgHouseAdImage = null;
            this._afgHouseAdLoader = null;
            this._afgAdsQueue = null;
            try {
                navigateToURL(request, "_self");
            } catch(e:Error) {
                destroyAdsManager();
                WidgetAdFinished();
            };
        }
        private function EVENT_ADS_HouseAdLoaded(_arg1:Event):void{
            this._afgHouseAdLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, this.EVENT_ADS_HouseAdLoaded);
            this._afgHouseAdLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.EVENT_ADS_HouseAdLoadError);
            this._afgHouseAdImage = new Sprite();
            this._afgHouseAdImage.addChild(this._afgHouseAdLoader);
            this._afgHouseAdImage.name = "image_house_ad";
            this._afgHouseAdImage.x = this._afgAdsQueue[0].container_x;
            this._afgHouseAdImage.y = this._afgAdsQueue[0].container_y;
            this._afgHouseAdImage.addEventListener(MouseEvent.CLICK, this.EVENT_HouseAd_MouseClick);
            this._afgHouseAdImage.buttonMode = true;
            this._afgHouseAdImage.useHandCursor = true;
            stage.addChild(this._afgHouseAdImage);
        }
        private function EVENT_ADS_HouseAdLoadError(_arg1:Event):void{
            this._afgHouseAdLoader.removeEventListener(Event.COMPLETE, this.EVENT_ADS_HouseAdLoaded);
            this._afgHouseAdLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.EVENT_ADS_HouseAdLoadError);
            this.AdsQueueHandler();
        }
        private function AFGKenKen(_arg1:Object):void{
            this.requestAds(_arg1.adTag, _arg1.container_width, _arg1.container_height, _arg1.container_x, _arg1.container_y);
        }
        private function requestAds(_arg1:String, _arg2:uint, _arg3:uint, _arg4:uint, _arg5:uint):void{
            var _local6:AdsRequest;
            if (this.adsLoader == null){
                this.adsLoader = new AdsLoader();
                this.adsLoader.addEventListener(AdsManagerLoadedEvent.ADS_MANAGER_LOADED, this.adsManagerLoadedHandler);
                this.adsLoader.addEventListener(AdErrorEvent.AD_ERROR, this.adsLoadErrorHandler);
            };
            this._afgContainerWidth = _arg2;
            this._afgContainerHeight = _arg3;
            this._afgContainerX = _arg4;
            this._afgContainerY = _arg5;
            _local6 = new AdsRequest();
            _local6.adTagUrl = _arg1;
            _local6.linearAdSlotWidth = _arg2;
            _local6.linearAdSlotHeight = _arg3;
            _local6.nonLinearAdSlotWidth = _arg2;
            _local6.nonLinearAdSlotHeight = _arg3;
            _local6.disableCompanionAds = true;
            this.adsLoader.requestAds(_local6);
        }
        private function adsManagerLoadedHandler(_arg1:AdsManagerLoadedEvent):void{
            var adsRenderingSettings:* = null;
            var contentPlayhead:* = null;
            var event:* = _arg1;
            adsRenderingSettings = new AdsRenderingSettings();
            contentPlayhead = {};
            contentPlayhead.time = function ():Number{
                return ((contentPlayheadTime * 1000));
            };
            this.adsManager = event.getAdsManager(contentPlayhead, adsRenderingSettings);
            if (this.adsManager){
                this.adsManager.addEventListener(AdEvent.ALL_ADS_COMPLETED, this.allAdsCompletedHandler);
                this.adsManager.addEventListener(AdEvent.CONTENT_PAUSE_REQUESTED, this.contentPauseRequestedHandler);
                this.adsManager.addEventListener(AdEvent.CONTENT_RESUME_REQUESTED, this.contentResumeRequestedHandler);
                this.adsManager.addEventListener(AdEvent.STARTED, this.startedHandler);
                this.adsManager.addEventListener(AdErrorEvent.AD_ERROR, this.adsManagerPlayErrorHandler);
                this.adsManager.addEventListener(AdEvent.COMPLETED, this.adCompletedHandler);
                this.adsManager.addEventListener(AdEvent.USER_CLOSED, this.adUserClosed);
                this.adsManager.addEventListener(AdEvent.EXPANDED_CHANGED, this.adExpandedChanged);
                this.adsManager.addEventListener(AdEvent.USER_MINIMIZED, this.adUserMinimizedChanged);
                this.adsManager.handshakeVersion("1.0");
                this.adsManager.init(this._afgContainerWidth, this._afgContainerHeight, ViewModes.NORMAL);
                this.adsManager.adsContainer.x = this._afgContainerX;
                this.adsManager.adsContainer.y = this._afgContainerY;
                stage.addChild(this.adsManager.adsContainer);
                this.adsManager.start();
            };
        }
        private function adCompletedHandler(_arg1:AdEvent):void{
        }
        private function adUserClosed(_arg1:AdEvent):void{
            this._bPlayMoreVideo = false;
            this.destroyAdsManager();
            this.AdsQueueHandler();
        }
        private function adExpandedChanged(_arg1:AdEvent):void{
            if (((!((this.adsManager == null))) && (!(this.adsManager.expanded)))){
                this._bPlayMoreVideo = false;
                this.destroyAdsManager();
                this.AdsQueueHandler();
            };
        }
        private function adUserMinimizedChanged(_arg1:AdEvent):void{
        }
        private function adsLoadErrorHandler(_arg1:AdErrorEvent):void{
            this._bPlayMoreVideo = true;
            this.destroyAdsManager();
            this.AdsQueueHandler();
        }
        private function adsManagerPlayErrorHandler(_arg1:AdErrorEvent):void{
            this.destroyAdsManager();
            this._bPlayMoreVideo = true;
            this.AdsQueueHandler();
        }
        private function contentPauseRequestedHandler(_arg1:AdEvent):void{
        }
        private function contentResumeRequestedHandler(_arg1:AdEvent):void{
            this._bPlayMoreVideo = false;
            this.destroyAdsManager();
            this.AdsQueueHandler();
        }
        private function startedHandler(_arg1:AdEvent):void{
        }
        private function allAdsCompletedHandler(_arg1:AdEvent):void{
            this.destroyAdsManager();
            this._bPlayMoreVideo = false;
            this.AdsQueueHandler();
        }
        private function enableContentControls():void{
        }
        private function destroyAdsManager():void{
            this.enableContentControls();
            if (this.adsManager){
                if (((this.adsManager.adsContainer.parent) && (this.adsManager.adsContainer.parent.contains(this.adsManager.adsContainer)))){
                    this.adsManager.adsContainer.parent.removeChild(this.adsManager.adsContainer);
                };
                this.adsManager.destroy();
            };
        }
        private function AdsQueueHandler():void{
            if (this._afgAdsQueue == null){
                this._afgAdsQueue = null;
                this._bPlayMoreVideo = true;
                this.destroyAdsManager();
                this.WidgetAdFinished();
            };
            try {
                this._afgAdsQueue.splice(0, 1);
            } catch(e:Error) {
                _afgAdsQueue = null;
                _bPlayMoreVideo = true;
                destroyAdsManager();
                WidgetAdFinished();
            };
            if (((!((this._afgAdsQueue == null))) && ((this._afgAdsQueue.length > 0)))){
                this.AdsController(this._afgAdsQueue);
            } else {
                this._afgAdsQueue = null;
                this._bPlayMoreVideo = true;
                this.destroyAdsManager();
                this.WidgetAdFinished();
            };
        }
        private function WidgetAdFinished():void{
            if (this._gameState == "start"){
                this.mcPreRollScreen.visible = false;
                this.ShowGame();
                if (this.DEVELOPMENT){
                    this.StartGame(true);
                } else {
                    this.JAVASCRIPT_StartGame(this._puzzleData);
                };
            } else {
                if (this._gameState == "print"){
                    this.ShowGame();
                    this.HandlePrinting();
                } else {
                    if (this._gameState == "pause"){
                        this.ShowGame();
                    } else {
                        if (this._gameState == "solution"){
                            this.ShowGame();
                            this.HandleSolution();
                        } else {
                            if (this._gameState == "kengratulations"){
                            };
                        };
                    };
                };
            };
        }

    }
}//package 
