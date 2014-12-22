package com.google.ads.ima.api {

    public class AdsRenderingSettings {

        public var allowUnrelatedCompanion:Boolean;
        public var allowCompanionBeforeMaster:Boolean;
        public var mimeTypes:Array;
        public var bitrate:int = -1;
        public var delivery:String;
        public var youTubeAdNamespace:uint = 0;
        public var autoAlign:Boolean = true;
        public var linearAdPreferred:Boolean = true;
        public var baseYouTubeUrl:String;

        public function AdsRenderingSettings(){
            mimeTypes = VideoMimeTypes.DEFAULT_MIMETYPES.concat(AudioMimeTypes.DEFAULT_MIMETYPES);
            delivery = VideoDeliveryTypes.DEFAULT;
            super();
        }
    }
}//package com.google.ads.ima.api 
