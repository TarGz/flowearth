package fr.digitas.flowearth.media.player.caption.data {

	
	/**
	 * @author vanneaup
	 */
	public class CaptionData {

		
		public function get id () : Number {
			return _id;
		}

		public function set id (s : Number) : void {
			_id = s;
		}

		public function get beginTimeMilliSecond () : Number {
			return _beginTimeMilliSecond;
		}

		public function set beginTimeMilliSecond (s : Number) : void {
			_beginTimeMilliSecond = s;
		}

		public function get endTimeMilliSecond () : Number {
			return _endTimeMilliSecond;
		}

		public function set endTimeMilliSecond (s : Number) : void {
			_endTimeMilliSecond = s;
		}

		public function get htmlData () : String {
			return _htmlData;
		}

		public function set htmlData (s : String) : void {
			_htmlData = s;
		}
		
		
		private var _id : Number;
		private var _beginTimeMilliSecond : Number;
		private var _endTimeMilliSecond : Number;
		private var _htmlData : String;
		
	}
}
