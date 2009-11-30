package fr.digitas.flowearth.csseditor.view.editor {
	import flash.display.Bitmap;	
	
	import fr.digitas.flowearth.csseditor.view.picts.Picts;	
	
	import flash.utils.Dictionary;	
	
	import fr.digitas.flowearth.csseditor.data.errors.ValidityState;	
	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class ErrorField extends Sprite {

		
		public function ErrorField() {
			addChild( _bmp = new Bitmap( ) );
			clear();
		}
		
		public function clear() : void {
			_bmp.bitmapData = null;
			_states = [];
			_maxLevel = -1;
		}
		
		public function addState( vs : ValidityState ) : void {
			_maxLevel = Math.max( _maxLevel, vs.level );
			_updateIco( );
		}
		
		private function _updateIco() : void {
			_bmp.bitmapData = _icoMap[ _maxLevel ];
		}

		private var _states : Array;
		
		private var _maxLevel : int;

		private var _bmp : Bitmap;
		
		private static const _icoMap : Dictionary = _buildIcoMap();
		private static function _buildIcoMap() : Dictionary {
			var res : Dictionary = new Dictionary();
			res[ ValidityState.WARN_LEVEL ] = Picts.WARN_ICO;
			res[ ValidityState.ERROR_LEVEL ] = Picts.ERROR_ICO;
			return res;
		}
	}
}
