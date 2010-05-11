package fr.digitas.tutorial.tlf {
	import fr.digitas.flowearth.text.styles.TlfSupport;	
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.net.BatchURLLoaderItem;
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import fr.digitas.flowearth.text.styles.styleManager;
	import fr.digitas.tutorials.fonts.Times;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.Font;	

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {
		
		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			// initialize some important stuff
			boot();
		}
		
		private function boot() : void {
			
			// init support of Tlf by styles api
			TlfSupport.init();
			
			// register fonts libraries (libs/times_fonts.swc)
			// note that font lib can also be compiled in swf and loaded at runtime
			var fp : IFontsProvider = new Times();
			for each (var f : Class in fp.getFonts() ) {
				Font.registerFont( f );
			}
			
			
			// Load styles (styles.css)
			var req : URLRequest = new URLRequest( "styles.css" );
			var stylesLoader : BatchURLLoaderItem = new BatchURLLoaderItem( req );
			stylesLoader.addEventListener( Event.COMPLETE, stylesLoaded );

			// Load a text file (text.txt)
			req = new URLRequest( "text.txt" );
			var textLoader : BatchURLLoaderItem = new BatchURLLoaderItem( req );
			textLoader.addEventListener( Event.COMPLETE, textLoaded );
			
			// batch these loaders
			var b : Batcher = new Batcher();
			b.addItem( stylesLoader );
			b.addItem( textLoader );
			b.addEventListener( Event.COMPLETE, bootComplete );
			b.start();
		}

		private function textLoaded(event : Event) : void {
			articleText = event.currentTarget.data;
		}

		private function stylesLoaded(event : Event) : void {
			styleManager.addCss( event.currentTarget.data );
		}

		private function bootComplete(event : Event) : void {
			addChild( new Test( articleText ) );
		}
		
		private var articleText : String;
	}
}
