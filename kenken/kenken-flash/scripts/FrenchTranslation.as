package scripts {

    public class FrenchTranslation extends Language {

        public function FrenchTranslation(){
            lang = "French";
            menu = "menu";
            reveal = "dévoiler";
            check = "vérifier";
            done = "terminé";
            help = "aide";
            rules = "règles";
            undo = "annuler";
            back = "retour";
            candidates = "candidats:";
            hour = "Heure";
            hours = "Heures";
            minute = "Minute";
            minutes = "Minutes";
            and = "Et";
            second = "Seconde";
            seconds = "Secondes";
            solved_in = "Vous avez résolu ce casse-tête en";
            mcMenu = new mcMenuFR();
            mcMenu.name = "mcMenu";
            mcHowTo = new mcHowToFR();
            mcRules = new mcRulesFR();
            mcCopyright = new mcCopyrightFR();
            mcCongratulations = new mcCongratulationsFR();
            mcCongratulations.name = "WinScreen";
            mcPrintPuzzleBtn = new mcPrintPuzzleBtnFR();
        }
    }
}//package scripts 
