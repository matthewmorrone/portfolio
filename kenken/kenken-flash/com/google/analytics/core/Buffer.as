package com.google.analytics.core {
    import com.google.analytics.v4.*;
    import com.google.analytics.debug.*;
    import flash.net.*;
    import flash.events.*;
    import com.google.analytics.data.*;

    public dynamic class Buffer {

        private var _SO:SharedObject;
        private var _OBJ:Object;
        private var _utma:UTMA;
        private var _utmb:UTMB;
        private var _utmc:UTMC;
        private var _debug:DebugConfiguration;
        private var _utmk:UTMK;
        private var _config:Configuration;
        private var _utmv:UTMV;
        private var _utmz:UTMZ;
        private var _volatile:Boolean;

        public function Buffer(_arg1:Configuration, _arg2:DebugConfiguration, _arg3:Boolean=false, _arg4:Object=null){
            var _local5:Boolean;
            var _local6:String;
            super();
            _config = _arg1;
            _debug = _arg2;
            UTMB.defaultTimespan = _config.sessionTimeout;
            UTMZ.defaultTimespan = _config.conversionTimeout;
            if (!_arg3){
                _SO = SharedObject.getLocal(_config.cookieName, _config.cookiePath);
                _local5 = false;
                if (_SO.data.utma){
                    if (!hasUTMA()){
                        _createUMTA();
                    };
                    _utma.fromSharedObject(_SO.data.utma);
                    if (_debug.verbose){
                        _debug.info(("found: " + _utma.toString(true)), VisualDebugMode.geek);
                    };
                    if (_utma.isExpired()){
                        if (_debug.verbose){
                            _debug.warning("UTMA has expired", VisualDebugMode.advanced);
                        };
                        _clearUTMA();
                        _local5 = true;
                    };
                };
                if (_SO.data.utmb){
                    if (!hasUTMB()){
                        _createUMTB();
                    };
                    _utmb.fromSharedObject(_SO.data.utmb);
                    if (_debug.verbose){
                        _debug.info(("found: " + _utmb.toString(true)), VisualDebugMode.geek);
                    };
                    if (_utmb.isExpired()){
                        if (_debug.verbose){
                            _debug.warning("UTMB has expired", VisualDebugMode.advanced);
                        };
                        _clearUTMB();
                        _local5 = true;
                    };
                };
                if (_SO.data.utmc){
                    delete _SO.data.utmc;
                    _local5 = true;
                };
                if (_SO.data.utmk){
                    if (!hasUTMK()){
                        _createUMTK();
                    };
                    _utmk.fromSharedObject(_SO.data.utmk);
                    if (_debug.verbose){
                        _debug.info(("found: " + _utmk.toString()), VisualDebugMode.geek);
                    };
                };
                if (_SO.data.utmv){
                    if (!hasUTMV()){
                        _createUMTV();
                    };
                    _utmv.fromSharedObject(_SO.data.utmv);
                    if (_debug.verbose){
                        _debug.info(("found: " + _utmv.toString(true)), VisualDebugMode.geek);
                    };
                    if (_utmv.isExpired()){
                        if (_debug.verbose){
                            _debug.warning("UTMV has expired", VisualDebugMode.advanced);
                        };
                        _clearUTMV();
                        _local5 = true;
                    };
                };
                if (_SO.data.utmz){
                    if (!hasUTMZ()){
                        _createUMTZ();
                    };
                    _utmz.fromSharedObject(_SO.data.utmz);
                    if (_debug.verbose){
                        _debug.info(("found: " + _utmz.toString(true)), VisualDebugMode.geek);
                    };
                    if (_utmz.isExpired()){
                        if (_debug.verbose){
                            _debug.warning("UTMZ has expired", VisualDebugMode.advanced);
                        };
                        _clearUTMZ();
                        _local5 = true;
                    };
                };
                if (_local5){
                    save();
                };
            } else {
                _OBJ = new Object();
                if (_arg4){
                    for (_local6 in _arg4) {
                        _OBJ[_local6] = _arg4[_local6];
                    };
                };
            };
            _volatile = _arg3;
        }
        public function clearCookies():void{
            utma.reset();
            utmb.reset();
            utmc.reset();
            utmz.reset();
            utmv.reset();
            utmk.reset();
        }
        public function save():void{
            var flushStatus:* = null;
            if (!isVolatile()){
                flushStatus = null;
                try {
                    flushStatus = _SO.flush();
                } catch(e:Error) {
                    _debug.warning("Error...Could not write SharedObject to disk");
                };
                switch (flushStatus){
                    case SharedObjectFlushStatus.PENDING:
                        _debug.info("Requesting permission to save object...");
                        _SO.addEventListener(NetStatusEvent.NET_STATUS, _onFlushStatus);
                        break;
                    case SharedObjectFlushStatus.FLUSHED:
                        _debug.info("Value flushed to disk.");
                        break;
                };
            };
        }
        public function get utmv():UTMV{
            if (!hasUTMV()){
                _createUMTV();
            };
            return (_utmv);
        }
        public function get utmz():UTMZ{
            if (!hasUTMZ()){
                _createUMTZ();
            };
            return (_utmz);
        }
        public function hasUTMA():Boolean{
            if (_utma){
                return (true);
            };
            return (false);
        }
        public function hasUTMB():Boolean{
            if (_utmb){
                return (true);
            };
            return (false);
        }
        public function hasUTMC():Boolean{
            if (_utmc){
                return (true);
            };
            return (false);
        }
        public function isGenuine():Boolean{
            if (!hasUTMK()){
                return (true);
            };
            return ((utmk.hash == generateCookiesHash()));
        }
        public function resetCurrentSession():void{
            _clearUTMB();
            _clearUTMC();
            save();
        }
        public function hasUTMK():Boolean{
            if (_utmk){
                return (true);
            };
            return (false);
        }
        public function generateCookiesHash():Number{
            var _local1 = "";
            _local1 = (_local1 + utma.valueOf());
            _local1 = (_local1 + utmb.valueOf());
            _local1 = (_local1 + utmc.valueOf());
            _local1 = (_local1 + utmz.valueOf());
            _local1 = (_local1 + utmv.valueOf());
            return (Utils.generateHash(_local1));
        }
        private function _createUMTB():void{
            _utmb = new UTMB();
            _utmb.proxy = this;
        }
        private function _createUMTC():void{
            _utmc = new UTMC();
        }
        private function _createUMTA():void{
            _utma = new UTMA();
            _utma.proxy = this;
        }
        public function hasUTMV():Boolean{
            if (_utmv){
                return (true);
            };
            return (false);
        }
        private function _createUMTK():void{
            _utmk = new UTMK();
            _utmk.proxy = this;
        }
        public function hasUTMZ():Boolean{
            if (_utmz){
                return (true);
            };
            return (false);
        }
        private function _createUMTV():void{
            _utmv = new UTMV();
            _utmv.proxy = this;
        }
        private function _onFlushStatus(_arg1:NetStatusEvent):void{
            _debug.info("User closed permission dialog...");
            switch (_arg1.info.code){
                case "SharedObject.Flush.Success":
                    _debug.info("User granted permission -- value saved.");
                    break;
                case "SharedObject.Flush.Failed":
                    _debug.info("User denied permission -- value not saved.");
                    break;
            };
            _SO.removeEventListener(NetStatusEvent.NET_STATUS, _onFlushStatus);
        }
        private function _createUMTZ():void{
            _utmz = new UTMZ();
            _utmz.proxy = this;
        }
        public function updateUTMA(_arg1:Number):void{
            if (_debug.verbose){
                _debug.info((("updateUTMA( " + _arg1) + " )"), VisualDebugMode.advanced);
            };
            if (!utma.isEmpty()){
                if (isNaN(utma.sessionCount)){
                    utma.sessionCount = 1;
                } else {
                    utma.sessionCount = (utma.sessionCount + 1);
                };
                utma.lastTime = utma.currentTime;
                utma.currentTime = _arg1;
            };
        }
        private function _clearUTMA():void{
            _utma = null;
            if (!isVolatile()){
                _SO.data.utma = null;
                delete _SO.data.utma;
            };
        }
        private function _clearUTMC():void{
            _utmc = null;
        }
        private function _clearUTMB():void{
            _utmb = null;
            if (!isVolatile()){
                _SO.data.utmb = null;
                delete _SO.data.utmb;
            };
        }
        public function update(_arg1:String, _arg2):void{
            if (isVolatile()){
                _OBJ[_arg1] = _arg2;
            } else {
                _SO.data[_arg1] = _arg2;
            };
        }
        private function _clearUTMZ():void{
            _utmz = null;
            if (!isVolatile()){
                _SO.data.utmz = null;
                delete _SO.data.utmz;
            };
        }
        private function _clearUTMV():void{
            _utmv = null;
            if (!isVolatile()){
                _SO.data.utmv = null;
                delete _SO.data.utmv;
            };
        }
        public function isVolatile():Boolean{
            return (_volatile);
        }
        public function get utma():UTMA{
            if (!hasUTMA()){
                _createUMTA();
            };
            return (_utma);
        }
        public function get utmb():UTMB{
            if (!hasUTMB()){
                _createUMTB();
            };
            return (_utmb);
        }
        public function get utmc():UTMC{
            if (!hasUTMC()){
                _createUMTC();
            };
            return (_utmc);
        }
        public function get utmk():UTMK{
            if (!hasUTMK()){
                _createUMTK();
            };
            return (_utmk);
        }

    }
}//package com.google.analytics.core 
