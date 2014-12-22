package com.google.ads.ima.wrappers {
    import com.google.ads.ima.api.*;
    import flash.utils.*;
    import flash.system.*;

    public class Wrappers {

        private static const INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES:Object = {};
        private static const WRAPPED_INTERFACES:Object = {
            Ad:AdWrapper,
            AdError:AdErrorWrapper,
            AdsManager:AdsManagerWrapper,
            CompanionAd:CompanionAdWrapper,
            FlashCompanionAd:FlashCompanionAdWrapper,
            HtmlCompanionAd:HtmlCompanionAdWrapper,
            ImaSdkSettings:ImaSdkSettingsWrapper
        };
        private static const API_NAMESPACE:String = "com.google.ads.ima.api";
        private static const WRAPPED_CLASSES:Object = {
            AdEvent:AdEventWrapper,
            AdErrorEvent:AdErrorEventWrapper,
            AdPodInfo:AdPodInfoWrapper,
            AdsManagerLoadedEvent:AdsManagerLoadedEventWrapper,
            CustomContentLoadedEvent:CustomContentLoadedEventWrapper,
            NetStreamReadyEvent:NetStreamReadyEventWrapper
        };
        private static const LOCAL_TO_REMOTE_CLASSES:Object = {
            AdsRequest:AdsRequest,
            CompanionAdSelectionSettings:CompanionAdSelectionSettings,
            AdsRenderingSettings:AdsRenderingSettings
        };

        private var remoteApplicationDomainValue:ApplicationDomain;

        public function Wrappers(_arg1:ApplicationDomain){
            remoteApplicationDomainValue = _arg1;
        }
        private function getTypeNameFromFullyQualifiedName(_arg1:String):String{
            var _local2:Array = _arg1.split("::");
            var _local3:String;
            if (_local2.length == 2){
                _local3 = _local2[1];
            } else {
                _local3 = _local2[0];
            };
            return (_local3);
        }
        private function filterByNamespace(_arg1:XML, _arg2:String):Boolean{
            return ((_arg1.@type.indexOf(_arg2) == 0));
        }
        private function getApiInterfaces(_arg1:Object):XMLList{
            var interfacesSource:* = _arg1;
            return (interfacesSource.implementsInterface.(filterByNamespace(valueOf(), API_NAMESPACE)).@type);
        }
        public function getLocalDefinition(_arg1:String):Object{
            var fullyQualifiedName:* = _arg1;
            var applicationDomain:* = ApplicationDomain.currentDomain;
            if (applicationDomain.hasDefinition(fullyQualifiedName)){
                try {
                    return (applicationDomain.getDefinition(fullyQualifiedName));
                } catch(error:Error) {
                };
            };
            return (null);
        }
        private function getImplementedInterfacesCount(_arg1:Object):uint{
            var _local2:XML;
            var _local3:XMLList;
            if (!INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[_arg1]){
                _local2 = describeType(_arg1);
                _local3 = getApiInterfaces(_local2.factory);
                INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[_arg1] = _local3.length();
            };
            return (INTERFACE_IMPLEMENTS_NUM_OF_INTERFACES[_arg1]);
        }
        private function getWrapperTypeByClass(_arg1:String):Object{
            return (WRAPPED_CLASSES[_arg1]);
        }
        private function getQualifiedClassNameHelper(_arg1):String{
            return (getQualifiedClassName(_arg1));
        }
        public function localToRemote(_arg1:Object):Object{
            var _local3:Object;
            var _local4:Object;
            var _local2:String = getTypeName(_arg1);
            if (LOCAL_TO_REMOTE_CLASSES[_local2] != null){
                _local3 = getDefinition(((API_NAMESPACE + ".") + _local2), remoteApplicationDomain);
                _local4 = new (_local3)();
                copy(_arg1, _local4);
                return (_local4);
            };
            return (_arg1);
        }
        private function getInstanceProperties(_arg1:Object):Array{
            var node:* = null;
            var instance:* = _arg1;
            var typeXml:* = describeType(instance);
            var propertyNames:* = [];
            for each (node in typeXml..variable) {
                propertyNames.push(node.@name);
            };
            for each (node in typeXml..accessor.(@access == "readwrite")) {
                propertyNames.push(node.@name);
            };
            return (propertyNames);
        }
        private function get remoteApplicationDomain():ApplicationDomain{
            return (remoteApplicationDomainValue);
        }
        private function getDefinition(_arg1:String, _arg2:ApplicationDomain):Object{
            var fullyQualifiedName:* = _arg1;
            var applicationDomain:* = _arg2;
            if (applicationDomain.hasDefinition(fullyQualifiedName)){
                try {
                    return (applicationDomain.getDefinition(fullyQualifiedName));
                } catch(error:Error) {
                };
            };
            return (null);
        }
        public function remoteToLocal(_arg1:Dictionary, _arg2:Object, _arg3:Object=null):Object{
            var _local4:XML;
            var _local5:String;
            var _local6:Object;
            var _local7:Class;
            var _local8:Object;
            var _local9:Object;
            if (_arg2 == null){
                return (null);
            };
            if (!_arg1[_arg2]){
                _local4 = describeType(_arg2);
                _local5 = getTypeName(_arg2);
                _local6 = getWrapperType(_local4, _local5);
                if (_local6 != null){
                    _arg1[_arg2] = ((_arg3)!=null) ? _arg3 : new _local6(this, _arg2, _arg3);
                } else {
                    _local7 = (getLocalDefinition(getQualifiedClassName(_arg2)) as Class);
                    if (_local7 === Array){
                        _local8 = new (_local7)();
                        for each (_local9 in _arg2) {
                            _local8.push(remoteToLocal(_arg1, _local9, _arg3));
                        };
                        _arg1[_arg2] = _local8;
                    } else {
                        _arg1[_arg2] = _arg2;
                    };
                };
            };
            return (_arg1[_arg2]);
        }
        private function getWrapperTypeByInterface(_arg1:XML):Object{
            var _local4:XML;
            var _local5:Object;
            var _local6:uint;
            var _local7:String;
            var _local8:String;
            var _local9:String;
            var _local10:Object;
            var _local11:uint;
            var _local2:Array = [];
            var _local3:XMLList = getApiInterfaces(_arg1);
            for each (_local4 in _local3) {
                _local8 = getTypeNameFromFullyQualifiedName(_local4);
                if (WRAPPED_INTERFACES[_local8]){
                    _local2.push(_local8);
                };
            };
            _local5 = null;
            _local6 = 0;
            for each (_local7 in _local2) {
                _local9 = ((API_NAMESPACE + ".") + _local7);
                _local10 = getLocalDefinition(_local9);
                _local11 = getImplementedInterfacesCount(_local10);
                if (((!(_local5)) || ((_local11 > _local6)))){
                    _local5 = _local10;
                    _local6 = _local11;
                };
            };
            if (_local5){
                return (WRAPPED_INTERFACES[getTypeName(_local5)]);
            };
            return (null);
        }
        public function copy(_arg1:Object, _arg2:Object):void{
            var _local3:String;
            for each (_local3 in getInstanceProperties(_arg1)) {
                if (_arg2.hasOwnProperty(_local3)){
                    _arg2[_local3] = localToRemote(_arg1[_local3]);
                } else {
                    trace("warning: mismatch between swc code and implementation swfs.");
                };
            };
        }
        private function getWrapperType(_arg1:XML, _arg2:String):Object{
            var _local3:Object = getWrapperTypeByClass(_arg2);
            if (!_local3){
                _local3 = getWrapperTypeByInterface(_arg1);
            };
            return (_local3);
        }
        private function getTypeName(_arg1:Object):String{
            var _local2:String = getQualifiedClassNameHelper(_arg1);
            return (getTypeNameFromFullyQualifiedName(_local2));
        }
        public function unwrappedRemoteToLocal(_arg1:Dictionary, _arg2:Object, _arg3:Object=null):Object{
            return (remoteToLocal(_arg1, _arg2, _arg3));
        }

    }
}//package com.google.ads.ima.wrappers 
