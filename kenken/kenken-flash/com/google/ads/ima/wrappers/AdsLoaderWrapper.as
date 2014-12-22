package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;

    public class AdsLoaderWrapper extends EventDispatcherWrapper implements AdsLoaderInterface {

        public function AdsLoaderWrapper(_arg1:Wrappers, _arg2:Object, _arg3:Object=null){
            super(_arg1, _arg2, _arg3);
        }
        public function contentComplete(_arg1:String=null):void{
            remoteInstance.contentComplete(_arg1);
        }
        public function requestAds(_arg1:AdsRequest, _arg2:Object=null):void{
            remoteInstance.requestAds(wrappers.localToRemote(_arg1), _arg2);
        }
        public function destroy():void{
            remoteInstance.destroy();
        }
        public function get settings():ImaSdkSettings{
            var _local1:AdsLoaderInterface = (localInstance as AdsLoaderInterface);
            return ((wrappers.remoteToLocal(remoteMethodResultsStore, remoteInstance.settings, ((_local1)!=null) ? _local1.settings : null) as ImaSdkSettings));
        }

    }
}//package com.google.ads.ima.wrappers 
