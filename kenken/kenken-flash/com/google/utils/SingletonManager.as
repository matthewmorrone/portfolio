package com.google.utils {
    import flash.utils.*;

    public class SingletonManager {

        private var defaultClass:Class;
        private var baseClass:Class;
        private var instanceMap:Dictionary;

        public function SingletonManager(_arg1:Class){
            instanceMap = new Dictionary();
            super();
            baseClass = _arg1;
            defaultClass = baseClass;
        }
        public function getInstance(_arg1:Class=null):Object{
            _arg1 = (((_arg1 == null)) ? defaultClass : _arg1);
            var _local2:Object = instanceMap[_arg1];
            if (_local2 == null){
                _local2 = new (_arg1)();
                if (!(_local2 is baseClass)){
                    throw (new Error(((((_arg1 + " must extend ") + baseClass) + " in ") + "order to be accessed through the same SingletonManager.")));
                };
                if (_local2 != instanceMap[_arg1]){
                    throw (new Error(((("The constructor of " + _arg1) + " did not ") + "validate the new instance using validateAndStoreInstance.")));
                };
            };
            defaultClass = _arg1;
            return (_local2);
        }
        public function validateAndStoreInstance(_arg1:Object):void{
            var _local2:Class = (_arg1.constructor as Class);
            if (instanceMap[_local2] != null){
                throw (new Error(((_local2 + " is a singleton. Access it using the ") + "correct static method.")));
            };
            instanceMap[_local2] = _arg1;
        }

    }
}//package com.google.utils 
