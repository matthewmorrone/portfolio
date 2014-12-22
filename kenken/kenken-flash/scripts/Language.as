package scripts {
    import flash.display.*;

    public class Language {

        public var lang:String = "English";
        public var menu:String = "Menu";
        public var solve_another:String = "Solve Another";
        public var choose_another:String = "Puzzle Menu";
        public var save:String = "Save";
        public var reveal:String = "Reveal";
        public var check:String = "Check";
        public var done:String = "Done";
        public var help:String = "Help";
        public var rules:String = "Rules";
        public var reset:String = "Reset";
        public var solution:String = "Solution";
        public var undo:String = "Undo";
        public var redo:String = "Redo";
        public var back:String = "Return to puzzle";
        public var candidates:String = "candidates:";
        public var hour:String = "hour";
        public var hours:String = "hours";
        public var minute:String = "minute";
        public var minutes:String = "minutes";
        public var and:String = "and";
        public var second:String = "second";
        public var seconds:String = "seconds";
        public var solved_in:String = "You have solved this puzzle in";
        public var mcMenu:MovieClip;
        public var mcHowTo:MovieClip;
        public var mcRules:MovieClip;
        public var mcCopyright:MovieClip;
        public var mcCongratulations:MovieClip;
        public var mcPrintPuzzleBtn:MovieClip;

        public function Language(){
            this.mcMenu = new mcMenuEN();
            this.mcHowTo = new mcHowToEN();
            this.mcRules = new mcRulesEN();
            this.mcCopyright = new mcCopyrightEN();
            this.mcCongratulations = new mcCongratulationsEN();
            this.mcPrintPuzzleBtn = new mcPrintPuzzleBtnEN();
            super();
            this.mcMenu.name = "mcMenu";
            this.mcCongratulations.name = "WinScreen";
        }
    }
}//package scripts 
