
package flash.net {

	public final class URLRequest {

		private var _method : String;
		private var _digest : String;
		private var _data : Object;
		private var _url : String;

		public function URLRequest(url : String = null) {
			_url = url;
		}

		public function get method() : String {
			return _method;
		}

		public function set method(value : String) : void {
			_method = value;
		}

		public function get digest() : String {
			return _digest;
		}

		public function set contentType(value : String) : void {
		}

		public function set digest(value : String) : void {
			_digest = value;
		}

		public function get data() : Object {
			return _data;
		}

		public function set data(value : Object) : void {
			_data = value;
		}

		public function set requestHeaders(value : Array) : void {
		}

		public function get url() : String {
			return _url;
		}

		public function set url(value : String) : void {
			_url = value;
		}

		public function get requestHeaders() : Array {
			return null;
		}

		public function get contentType() : String {
			return null;
		}
	}
	
	public dynamic class URLVariables extends Object {
		
		public function URLVariables(source : String = null) {
			
		}

		public function toString() : String {
			return "";
		}

		public function decode(source : String) : void{}

	}
}
