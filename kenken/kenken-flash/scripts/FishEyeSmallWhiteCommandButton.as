package scripts {
    import flash.display.*;

    public class FishEyeSmallWhiteCommandButton extends FishEyeSmallButton {

        public function FishEyeSmallWhiteCommandButton(){
            textTitleStyle.color = 0xFF0000;
            textTitle.defaultTextFormat = textTitleStyle;
        }
        public function AddMovieClip(_arg1:MovieClip):void{
            this.addChild(_arg1);
        }

    }
}//package scripts 
