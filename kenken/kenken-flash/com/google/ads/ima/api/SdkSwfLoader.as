package com.google.ads.ima.api {
    import flash.system.*;
    import com.google.ads.ima.apidependency.*;

    class SdkSwfLoader extends TimedLoader {

        private var publisherApplicationDomainValue:ApplicationDomain;

        public function SdkSwfLoader(_arg1:ApplicationDomain){
            publisherApplicationDomainValue = _arg1;
        }
        public function get publisherApplicationDomain():ApplicationDomain{
            return (publisherApplicationDomainValue);
        }

    }
}//package com.google.ads.ima.api 
