package fr.digitas.flowearth.ui.colorpicker {
	import flash.display.MovieClip;
	
	/**
	 * @author Pierre Lepers
	 */
	public class SelectorSkin extends MovieClip {

		public function set tiledView(iitiledView : TiledView) : void {
			_tiledView = iitiledView;
			removeChild( iitiledView );
		}

		public function SelectorSkin() {
			super();
			if( ! _isInit )	_init( this );
		}

		
		
		
		public static function getTiledView() : TiledView {
			return _tiledView;
		}
		
		private static function _init( inst : SelectorSkin ) : void {
			
			inst.gotoAndPlay( "build" );
			_isInit = true;
		}
		
		private static var _tiledView : TiledView;

		private static var _isInit : Boolean = false;

	}
}
