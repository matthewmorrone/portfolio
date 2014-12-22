package scripts {

    public class ArabicTranslation extends Language {

        public function ArabicTranslation(){
            lang = "Arabic";
            menu = "لقائمة";
            reveal = "الكشف";
            check = "التحقق";
            done = "إنتهاء";
            undo = "إبطال";
            rules = "القواعد";
            help = "مساعدة";
            back = "العودة";
            candidates = "الأرقام المحتملة:";
            hour = "ساعة ";
            hours = "ساعات ";
            minute = "دقيقة ";
            minutes = "دقائق ";
            and = "و";
            second = "ثانية ";
            seconds = "ثوان";
            solved_in = "تمكّنت من حلّ هذه الأحجية خلال ";
            mcMenu = new mcMenuAE();
            mcMenu.name = "mcMenu";
            mcHowTo = new mcHowToAE();
            mcRules = new mcRulesAE();
            mcCopyright = new mcCopyrightAE();
            mcCongratulations = new mcCongratulationsAE();
            mcCongratulations.name = "WinScreen";
            mcPrintPuzzleBtn = new mcPrintPuzzleBtnAE();
        }
    }
}//package scripts 
