package com.adobe.serialization.json {

    public class JSONTokenizer {

        private const controlCharsRegExp:RegExp;

        private var strict:Boolean;
        private var obj:Object;
        private var jsonString:String;
        private var loc:int;
        private var ch:String;

        public function JSONTokenizer(_arg1:String, _arg2:Boolean){
            this.controlCharsRegExp = /[\x00-\x1F]/;
            super();
            this.jsonString = _arg1;
            this.strict = _arg2;
            this.loc = 0;
            this.nextChar();
        }
        public function getNextToken():JSONToken{
            var _local2:String;
            var _local3:String;
            var _local4:String;
            var _local5:String;
            var _local1:JSONToken;
            this.skipIgnored();
            switch (this.ch){
                case "{":
                    _local1 = JSONToken.create(JSONTokenType.LEFT_BRACE, this.ch);
                    this.nextChar();
                    break;
                case "}":
                    _local1 = JSONToken.create(JSONTokenType.RIGHT_BRACE, this.ch);
                    this.nextChar();
                    break;
                case "[":
                    _local1 = JSONToken.create(JSONTokenType.LEFT_BRACKET, this.ch);
                    this.nextChar();
                    break;
                case "]":
                    _local1 = JSONToken.create(JSONTokenType.RIGHT_BRACKET, this.ch);
                    this.nextChar();
                    break;
                case ",":
                    _local1 = JSONToken.create(JSONTokenType.COMMA, this.ch);
                    this.nextChar();
                    break;
                case ":":
                    _local1 = JSONToken.create(JSONTokenType.COLON, this.ch);
                    this.nextChar();
                    break;
                case "t":
                    _local2 = ((("t" + this.nextChar()) + this.nextChar()) + this.nextChar());
                    if (_local2 == "true"){
                        _local1 = JSONToken.create(JSONTokenType.TRUE, true);
                        this.nextChar();
                    } else {
                        this.parseError(("Expecting 'true' but found " + _local2));
                    };
                    break;
                case "f":
                    _local3 = (((("f" + this.nextChar()) + this.nextChar()) + this.nextChar()) + this.nextChar());
                    if (_local3 == "false"){
                        _local1 = JSONToken.create(JSONTokenType.FALSE, false);
                        this.nextChar();
                    } else {
                        this.parseError(("Expecting 'false' but found " + _local3));
                    };
                    break;
                case "n":
                    _local4 = ((("n" + this.nextChar()) + this.nextChar()) + this.nextChar());
                    if (_local4 == "null"){
                        _local1 = JSONToken.create(JSONTokenType.NULL, null);
                        this.nextChar();
                    } else {
                        this.parseError(("Expecting 'null' but found " + _local4));
                    };
                    break;
                case "N":
                    _local5 = (("N" + this.nextChar()) + this.nextChar());
                    if (_local5 == "NaN"){
                        _local1 = JSONToken.create(JSONTokenType.NAN, NaN);
                        this.nextChar();
                    } else {
                        this.parseError(("Expecting 'NaN' but found " + _local5));
                    };
                    break;
                case "\"":
                    _local1 = this.readString();
                    break;
                default:
                    if (((this.isDigit(this.ch)) || ((this.ch == "-")))){
                        _local1 = this.readNumber();
                    } else {
                        if (this.ch == ""){
                            _local1 = null;
                        } else {
                            this.parseError((("Unexpected " + this.ch) + " encountered"));
                        };
                    };
            };
            return (_local1);
        }
        final private function readString():JSONToken{
            var _local3:int;
            var _local4:int;
            var _local1:int = this.loc;
            do  {
                _local1 = this.jsonString.indexOf("\"", _local1);
                if (_local1 >= 0){
                    _local3 = 0;
                    _local4 = (_local1 - 1);
                    while (this.jsonString.charAt(_local4) == "\\") {
                        _local3++;
                        _local4--;
                    };
                    if ((_local3 & 1) == 0){
                        break;
                    };
                    _local1++;
                } else {
                    this.parseError("Unterminated string literal");
                };
            } while (true);
            var _local2:JSONToken = JSONToken.create(JSONTokenType.STRING, this.unescapeString(this.jsonString.substr(this.loc, (_local1 - this.loc))));
            this.loc = (_local1 + 1);
            this.nextChar();
            return (_local2);
        }
        public function unescapeString(_arg1:String):String{
            var _local4:int;
            var _local6:String;
            var _local7:String;
            var _local8:int;
            var _local9:int;
            var _local10:String;
            if (((this.strict) && (this.controlCharsRegExp.test(_arg1)))){
                this.parseError("String contains unescaped control character (0x00-0x1F)");
            };
            var _local2 = "";
            var _local3:int;
            _local4 = 0;
            var _local5:int = _arg1.length;
            do  {
                _local3 = _arg1.indexOf("\\", _local4);
                if (_local3 >= 0){
                    _local2 = (_local2 + _arg1.substr(_local4, (_local3 - _local4)));
                    _local4 = (_local3 + 2);
                    _local6 = _arg1.charAt((_local3 + 1));
                    switch (_local6){
                        case "\"":
                            _local2 = (_local2 + _local6);
                            break;
                        case "\\":
                            _local2 = (_local2 + _local6);
                            break;
                        case "n":
                            _local2 = (_local2 + "\n");
                            break;
                        case "r":
                            _local2 = (_local2 + "\r");
                            break;
                        case "t":
                            _local2 = (_local2 + "\t");
                            break;
                        case "u":
                            _local7 = "";
                            _local8 = (_local4 + 4);
                            if (_local8 > _local5){
                                this.parseError("Unexpected end of input.  Expecting 4 hex digits after \\u.");
                            };
                            _local9 = _local4;
                            while (_local9 < _local8) {
                                _local10 = _arg1.charAt(_local9);
                                if (!this.isHexDigit(_local10)){
                                    this.parseError(("Excepted a hex digit, but found: " + _local10));
                                };
                                _local7 = (_local7 + _local10);
                                _local9++;
                            };
                            _local2 = (_local2 + String.fromCharCode(parseInt(_local7, 16)));
                            _local4 = _local8;
                            break;
                        case "f":
                            _local2 = (_local2 + "\f");
                            break;
                        case "/":
                            _local2 = (_local2 + "/");
                            break;
                        case "b":
                            _local2 = (_local2 + "\b");
                            break;
                        default:
                            _local2 = (_local2 + ("\\" + _local6));
                    };
                } else {
                    _local2 = (_local2 + _arg1.substr(_local4));
                    break;
                };
            } while (_local4 < _local5);
            return (_local2);
        }
        final private function readNumber():JSONToken{
            var _local1 = "";
            if (this.ch == "-"){
                _local1 = (_local1 + "-");
                this.nextChar();
            };
            if (!this.isDigit(this.ch)){
                this.parseError("Expecting a digit");
            };
            if (this.ch == "0"){
                _local1 = (_local1 + this.ch);
                this.nextChar();
                if (this.isDigit(this.ch)){
                    this.parseError("A digit cannot immediately follow 0");
                } else {
                    if (((!(this.strict)) && ((this.ch == "x")))){
                        _local1 = (_local1 + this.ch);
                        this.nextChar();
                        if (this.isHexDigit(this.ch)){
                            _local1 = (_local1 + this.ch);
                            this.nextChar();
                        } else {
                            this.parseError("Number in hex format require at least one hex digit after \"0x\"");
                        };
                        while (this.isHexDigit(this.ch)) {
                            _local1 = (_local1 + this.ch);
                            this.nextChar();
                        };
                    };
                };
            } else {
                while (this.isDigit(this.ch)) {
                    _local1 = (_local1 + this.ch);
                    this.nextChar();
                };
            };
            if (this.ch == "."){
                _local1 = (_local1 + ".");
                this.nextChar();
                if (!this.isDigit(this.ch)){
                    this.parseError("Expecting a digit");
                };
                while (this.isDigit(this.ch)) {
                    _local1 = (_local1 + this.ch);
                    this.nextChar();
                };
            };
            if ((((this.ch == "e")) || ((this.ch == "E")))){
                _local1 = (_local1 + "e");
                this.nextChar();
                if ((((this.ch == "+")) || ((this.ch == "-")))){
                    _local1 = (_local1 + this.ch);
                    this.nextChar();
                };
                if (!this.isDigit(this.ch)){
                    this.parseError("Scientific notation number needs exponent value");
                };
                while (this.isDigit(this.ch)) {
                    _local1 = (_local1 + this.ch);
                    this.nextChar();
                };
            };
            var _local2:Number = Number(_local1);
            if (((isFinite(_local2)) && (!(isNaN(_local2))))){
                return (JSONToken.create(JSONTokenType.NUMBER, _local2));
            };
            this.parseError((("Number " + _local2) + " is not valid!"));
            return (null);
        }
        final private function nextChar():String{
            return ((this.ch = this.jsonString.charAt(this.loc++)));
        }
        final private function skipIgnored():void{
            var _local1:int;
            do  {
                _local1 = this.loc;
                this.skipWhite();
                this.skipComments();
            } while (_local1 != this.loc);
        }
        private function skipComments():void{
            if (this.ch == "/"){
                this.nextChar();
                switch (this.ch){
                    case "/":
                        do  {
                            this.nextChar();
                        } while (((!((this.ch == "\n"))) && (!((this.ch == "")))));
                        this.nextChar();
                        break;
                    case "*":
                        this.nextChar();
                        while (true) {
                            if (this.ch == "*"){
                                this.nextChar();
                                if (this.ch == "/"){
                                    this.nextChar();
                                    break;
                                };
                            } else {
                                this.nextChar();
                            };
                            if (this.ch == ""){
                                this.parseError("Multi-line comment not closed");
                            };
                        };
                        break;
                    default:
                        this.parseError((("Unexpected " + this.ch) + " encountered (expecting '/' or '*' )"));
                };
            };
        }
        final private function skipWhite():void{
            while (this.isWhiteSpace(this.ch)) {
                this.nextChar();
            };
        }
        final private function isWhiteSpace(_arg1:String):Boolean{
            if ((((((((_arg1 == " ")) || ((_arg1 == "\t")))) || ((_arg1 == "\n")))) || ((_arg1 == "\r")))){
                return (true);
            };
            if (((!(this.strict)) && ((_arg1.charCodeAt(0) == 160)))){
                return (true);
            };
            return (false);
        }
        final private function isDigit(_arg1:String):Boolean{
            return ((((_arg1 >= "0")) && ((_arg1 <= "9"))));
        }
        final private function isHexDigit(_arg1:String):Boolean{
            return (((((this.isDigit(_arg1)) || ((((_arg1 >= "A")) && ((_arg1 <= "F")))))) || ((((_arg1 >= "a")) && ((_arg1 <= "f"))))));
        }
        final public function parseError(_arg1:String):void{
            throw (new JSONParseError(_arg1, this.loc, this.jsonString));
        }

    }
}//package com.adobe.serialization.json 
