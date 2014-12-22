package scripts {
    import flash.net.*;

    public class Beacon {

        private var sessionHash:String;
        private var beaconURL:String = "http://ken.applnk.com/statistics/beacon";
        private var moveTracerURL:String = "http://ken.applnk.com/statistics/tracer";

        public function Beacon(_arg1:String){
            this.sessionHash = _arg1;
        }
        public function MarkStarted(_arg1:String):void{
            var puzzleDescription:* = _arg1;
            var strVars:* = ((("p1=KenKen.com&p2=" + this.sessionHash) + "&p3=14&p4=") + puzzleDescription);
            var outgoing_vars:* = new URLVariables(strVars);
            var request:* = new URLRequest();
            request.url = this.beaconURL;
            request.method = URLRequestMethod.POST;
            request.data = outgoing_vars;
            try {
                sendToURL(request);
            } catch(error:Error) {
                trace("A challenge arised.");
            };
        }
        public function MarkFinished(_arg1:String):void{
            var puzzleDescription:* = _arg1;
            var outgoing_vars:* = new URLVariables(((((("p1=KenKen.com&p2=" + this.sessionHash) + "&p3=") + (Math.floor((Math.random() * 100)) + 15)) + "&p4=") + puzzleDescription));
            var request:* = new URLRequest();
            request.url = this.beaconURL;
            request.method = URLRequestMethod.POST;
            request.data = outgoing_vars;
            try {
                sendToURL(request);
            } catch(error:Error) {
                trace("A challenge arised.");
            };
        }
        public function MarkReveal(_arg1:String):void{
            var puzzleDescription:* = _arg1;
            var strVars:* = ((("p1=KenKen.com&p2=" + this.sessionHash) + "&p3=12&p4=") + puzzleDescription);
            var outgoing_vars:* = new URLVariables(strVars);
            var request:* = new URLRequest();
            request.url = this.beaconURL;
            request.method = URLRequestMethod.POST;
            request.data = outgoing_vars;
            try {
                sendToURL(request);
            } catch(error:Error) {
                trace("A challenge arised.");
            };
        }
        public function SendMovesTrace(_arg1:String):void{
            var strPayload:* = _arg1;
            var outgoing_vars:* = new URLVariables(("payload=" + strPayload));
            var request:* = new URLRequest();
            request.url = this.moveTracerURL;
            request.method = URLRequestMethod.POST;
            request.data = outgoing_vars;
            try {
                sendToURL(request);
            } catch(error:Error) {
                trace("A challenge arised.");
            };
        }

    }
}//package scripts 
