package {
	import fr.digitas.flowearth.ui.text.StyledLabel;	
	
	import flash.net.URLRequest;	
	import flash.events.Event;
	import flash.net.URLLoader;
	
	import fr.digitas.flowearth.text.styles.styleManager;		

	public class StyledLabelSample extends BasicExample {
		
		public function StyledLabelSample() {
			super( );
			loadStyles();
		}
		
		private function createLabel() : void {
			
			var label : StyledLabel = new StyledLabel( );
			
			label.styleName = ".my_style";
			label.text = "A multiline text <br/>render in a StyledLabel <br/><span class='title'>With red big text from another style</span>";
			
			addChild( label );
		}

		//_____________________________________________________________________________
		//															  Load external CSS
		
		private function loadStyles() : void {
			var l : URLLoader = new URLLoader();
			l.addEventListener( Event.COMPLETE , stylesLoaded );
			l.load( new URLRequest( baseUrl+"/styles.css" ) );
		}
		
		private function stylesLoaded(event : Event) : void {
			styleManager.addCss( event.target.data );
			createLabel();
		}
		
	}
}
