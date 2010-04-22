package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.FontDetails;
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.FontDetails_FC;
	import fr.digitas.flowearth.font.FontBuilder;
	import fr.digitas.flowearth.font.FontFileConfig;
	
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontDetailsManager {

		public function FontDetailsManager(  ) {
			if( instance != null ) throw new Error( "fr.digitas.flowearth.csseditor.view.fontprofile.FontDetailsManager est deja instancié" );
			_configs = new Dictionary();
			_aconfigs = new Array();
		}

		public function openDetails( font : Font ) : void {
			
			var nwio : NativeWindowInitOptions = new NativeWindowInitOptions( );
			var detailWindow : NativeWindow = new NativeWindow( nwio );
			detailWindow.activate();
			detailWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			detailWindow.stage.align = StageAlign.TOP_LEFT;
			
			var fd : FontDetails = new FontDetails_FC();
			detailWindow.stage.addChild( fd );
			fd.init( font );
		}

		public function openConfig( config : FontFileConfig ) : void {
			var currentWindow : NativeWindow = _configs[ config ];
			if( currentWindow ) {
				currentWindow.orderToFront();
				return;
			}
			
			var W : int = 438;
			
			var nwio : NativeWindowInitOptions = new NativeWindowInitOptions( );
			var detailWindow : NativeWindow = new NativeWindow( nwio );
			_configs[ config ] = detailWindow;
			_aconfigs.push( config );
			detailWindow.activate();
			detailWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			detailWindow.stage.align = StageAlign.TOP_LEFT;
			detailWindow.width = W;
			detailWindow.minSize = new Point( W, 100 );
			detailWindow.maxSize = new Point( W, 3000 );
			detailWindow.addEventListener( Event.CLOSE , onConfigWindowClosed );
			
			var fontBuilder : FontBuilder = new FontBuilder( config );
			detailWindow.stage.addChild( fontBuilder );
		}
		
		private function onConfigWindowClosed(event : Event) : void {
			var window : NativeWindow = event.currentTarget as NativeWindow;
			window.removeEventListener( Event.CLOSE , onConfigWindowClosed );
			( window.stage.getChildAt( 0 ) as FontBuilder ).dispose();
			while( window.stage.numChildren > 0 )
				window.stage.removeChildAt( 0 );
				
			var config : FontFileConfig;
			for (var i : int = 0; i < _aconfigs.length; i++) {
				config = _aconfigs[ i ];
				if( _configs[config] == window ) {
					delete _configs[config];
					_aconfigs.splice( i , 1 );
					return;
				}
			}
			
		}

		private var _configs : Dictionary;
		private var _aconfigs : Array;
				
		
		public static var instance : FontDetailsManager;
		
		
		public static function start( ) : FontDetailsManager {
			if (instance == null)
				instance = new FontDetailsManager();
			return instance;
		}
		
		
	}
}
