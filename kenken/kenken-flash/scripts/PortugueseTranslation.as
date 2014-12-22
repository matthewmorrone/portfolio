package scripts {

    public class PortugueseTranslation extends Language {

        public function PortugueseTranslation(){
            lang = "Portuguese";
            menu = "menu";
            reveal = "revelar";
            check = "verificar";
            done = "pronto";
            undo = "desfazer";
            rules = "regras";
            help = "ajuda";
            back = "anterior";
            candidates = "candidatos:";
            hour = "Hora";
            hours = "Horas";
            minute = "Minuto";
            minutes = "Minutos";
            and = "E";
            second = "Segundo";
            seconds = "Segundos";
            solved_in = "Completou este puzzle em";
            mcMenu = new mcMenuPT();
            mcMenu.name = "mcMenu";
            mcHowTo = new mcHowToPT();
            mcRules = new mcRulesPT();
            mcCopyright = new mcCopyrightPT();
            mcCongratulations = new mcCongratulationsPT();
            mcCongratulations.name = "WinScreen";
            mcPrintPuzzleBtn = new mcPrintPuzzleBtnPT();
        }
    }
}//package scripts 
