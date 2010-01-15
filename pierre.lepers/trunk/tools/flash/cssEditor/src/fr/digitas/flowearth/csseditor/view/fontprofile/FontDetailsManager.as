package fr.digitas.flowearth.csseditor.view.fontprofile {
	import flash.display.StageAlign;	
	import flash.display.StageScaleMode;	
	
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.FontDetails;	
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.FontDetails_FC;	
	
	import flash.display.NativeWindowInitOptions;	
	import flash.display.NativeWindow;	
	import flash.text.Font;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontDetailsManager {

		public function FontDetailsManager(  ) {
			if( instance != null ) throw new Error( "fr.digitas.flowearth.csseditor.view.fontprofile.FontDetailsManager est deja instancié" );
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

		
		
		public static var instance : FontDetailsManager;
		
		
		public static function start( ) : FontDetailsManager {
			if (instance == null)
				instance = new FontDetailsManager();
			return instance;
		}
		
		
	}
}
