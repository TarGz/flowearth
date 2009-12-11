package fr.digitas.tutorial.text {
	import flash.display.StageScaleMode;	
	import flash.display.StageAlign;	
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;	
	import fr.digitas.flowearth.event.BatchEvent;	
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.conf.Conf;
	import fr.digitas.flowearth.net.BatchLoaderItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import fr.digitas.flowearth.text.fonts.fontsManager;
	import fr.digitas.flowearth.text.styles.styleManager;		

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {
		
		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			runConf();
		}
		
		private function runConf() : void {
			
			Conf.setProperty( "confFile" , "conf_FR.xml" );
			Conf.grabParam( loaderInfo );
			
			Conf.addEventListener( Event.COMPLETE , onConfLoaded );
			Conf.loadXml( new URLRequest( Conf.confFile ) );
		}
		
		private function onConfLoaded(event : Event) : void {
			registerCss( );
			loadFonts( );
		}
		
		private function registerCss() : void {
			var cssString : String = Conf.getString( "css" );
			trace( cssString );
			styleManager.addCss( cssString );
		}

		private function loadFonts() : void {
			
			var fontList : XML = Conf.getDatas( "fontFiles" );
			
			var fontBatcher : Batcher = new Batcher();
			var fontItem : BatchLoaderItem ;
			
			for each (var fontSource : XML in fontList.source ) {
				fontItem = new BatchLoaderItem( new URLRequest( fontSource.text() ) );
				fontBatcher.addItem( fontItem );
			}
			
			fontBatcher.addEventListener( BatchEvent.ITEM_COMPLETE , onFontItemComplete );
			fontBatcher.addEventListener( Event.COMPLETE , onAllFontsComplete );
			fontBatcher.start();
		}

		private function onFontItemComplete(event : BatchEvent) : void {
			var fontItem : BatchLoaderItem = event.item as BatchLoaderItem;
			fontsManager.registerFonts( fontItem.loader.content as IFontsProvider );
		}

		private function onAllFontsComplete(event : Event) : void {
			displayTexts( );
		}
		
		private function displayTexts() : void {
			
			var content : StyledContent = new StyledContent();
			addChild( content );
			
		}
	}
}
