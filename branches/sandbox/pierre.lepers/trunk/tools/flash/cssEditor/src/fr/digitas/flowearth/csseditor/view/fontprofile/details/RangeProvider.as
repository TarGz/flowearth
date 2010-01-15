package fr.digitas.flowearth.csseditor.view.fontprofile.details {
	import fr.digitas.flowearth.csseditor.App;	
	
	import flash.filesystem.FileMode;	
	import flash.filesystem.FileStream;	
	import flash.filesystem.File;
	import flash.text.Font;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class RangeProvider {

		private static const FULL_UNICODE : String = "full unicode";
		private static const AVAILABLE : String = "available";
		
		public function getRangesIds() : Array {
			return _aRange;
		}

		public function getPresetRangesIds() : Array {
			return _apRange;
		}
		
		

		public function RangeProvider( font : Font ) {
			_font = font;
		}
		
		
		public function getFullRange() : Vector.<uint> {
			return _fullRange;
		}
		
		public function getRange( id : String ) : Vector.<uint> {
			
			if( id == FULL_UNICODE )
				return _fullRange;
			else if( id == AVAILABLE )
				return getAvailableRange();
			else {
				return _dRange[ id ];
			}
			return null;
		}
		
		private function getAvailableRange() : Vector.<uint> {
			if( _availableRange == null )
				_availableRange = _buildAvailableRange( );
			return _availableRange;
		}

		private function _buildAvailableRange() : Vector.<uint> {
			var a : Vector.<uint> = new Vector.<uint>();
			for (var i : int = 0; i <= 0xFFFF; i++) {
				if( _font.hasGlyphs( String.fromCharCode( i ) ) )
					a.push( i );
			}
			return a;
		}
		
		
		
		private var _availableRange : Vector.<uint>;

		private var _font : Font;

		private static const _fullRange : Vector.<uint> = _getFullRange();
		
		private static const _apRange : Array = [];
		private static const _aRange : Array = [];
		private static const _dRange : Dictionary = _buildRanges();


		private static function _getFullRange() : Vector.<uint> {
			var a : Vector.<uint> = new Vector.<uint>( 0x10001, true );
			for (var i : uint = 0; i <= 0xFFFF; i++)
				a[i] = i;
			return a;
		}
		
		
		private static function _buildRanges() : Dictionary {
			var d : Dictionary = new Dictionary();

			_aRange.push( FULL_UNICODE , AVAILABLE );
			
			var xmlStr : String = App.getFileManager().loadTextFile( "app:/deploy/includes/UnicodeTable.xml" );
			
			var xml : XML = XML( xmlStr );
			
			var list : XMLList = xml.glyphRange;
			var rangeId : String;
			
			var rlist : XMLList;
			var min : int, max : int;
			var resRange : Vector.<uint>;
			for each (var rangeData : XML in list) {
				resRange = new Vector.<uint>();
				rangeId = rangeData.@name;
				
				rlist = rangeData.range;
				for each (var rangeItem : XML in rlist) {
					
					min = parseInt( rangeItem.@min );
					max = parseInt( rangeItem.@max );
					
					for (var j : int = min; j <= max; j++) {
						resRange.push( j );
					}
				}
				
				_aRange.push( rangeId );
				_apRange.push( rangeId );
				d[ rangeId ] = resRange;
			}
			
			
			return d;
		}
		
	}
}
