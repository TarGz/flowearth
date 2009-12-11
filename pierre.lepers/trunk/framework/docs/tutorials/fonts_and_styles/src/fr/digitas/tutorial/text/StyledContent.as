package fr.digitas.tutorial.text {
	import fr.digitas.flowearth.ui.text.StyledLabel;	
	import fr.digitas.flowearth.conf.Conf;
	import fr.digitas.flowearth.text.styles.styleManager;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	
	import flash.display.Sprite;
	import flash.text.TextField;	

	/**
	 * @author Pierre Lepers
	 */
	public class StyledContent extends Sprite {
		
		public function StyledContent() {
			buildLayout();
			buildLabels();	
		}

		private function buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new TopRenderer( );
			_layout.x = _layout.y = 20;
			addChild( _layout );
		}

		private function buildLabels() : void {
			
			// TITLE
			// using basic TextField
			
			var title : TextField = new TextField();
			var title_text : String = Conf.title;
			var title_style : String = ".titleh1";
			styleManager.apply( title , title_style , title_text );	

			// TITLE
			// using StyledLabel
			
			var subtitle : StyledLabel = new StyledLabel( );
			subtitle.styleName = ".titleh2";
			subtitle.text = Conf.subtitle;

			// desc
			// using StyledLabel
			
			var desc : StyledLabel = new StyledLabel( );
			desc.styleName = ".description";
			desc.text = Conf.desc;
			
			_layout.addChild( title );
			_layout.addChild( subtitle );
			_layout.addChild( desc );
			
		}

		
		
		private var _layout : Layout;
	}
}
