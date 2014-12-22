package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;

    public class AdPodInfoWrapper extends AdPodInfo {

        private var localInstance:Object;
        private var wrappersValue:Wrappers;
        private var remoteInstance:Object;

        public function AdPodInfoWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            this.remoteInstance = _arg2;
            this.localInstance = _arg3;
            wrappersValue = _arg1;
            totalAds = _arg2.totalAds;
            adPosition = _arg2.adPosition;
            isBumper = _arg2.isBumper;
        }
    }
}//package com.google.ads.ima.wrappers 
