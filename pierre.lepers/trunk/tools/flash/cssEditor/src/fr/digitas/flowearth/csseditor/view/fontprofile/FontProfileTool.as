package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.ui.toobar.ToolBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontProfileTool extends Sprite {

		public function FontProfileTool() {
			_build( );
		}

		public var bg : Sprite;

		public function setCss( css : CSS ) : void {
			_css = css;
		}

		
		override public function set width(value : Number) : void {
			bg.width = value;
		}

		override public function get height() : Number {
			return bg.height;
		}

		private function _build() : void {
			_leftTb = new ToolBar( );
			
			addChild( _leftTb );
			_leftTb.y = -2;
			
			_leftTb.addButton( "addfontfile" , null , Picts.ADD_STYLE );
			
			_leftTb.addEventListener( Event.SELECT , onClick );
		}

		private function onClick(event : TextEvent ) : void {
			if( _css == null ) return;
			switch ( event.text ) {
				case "addfontfile": 
					_css.fontProfile.addNewFont();
					break;
			}
		}

		private var _leftTb : ToolBar;

		private var _css : CSS;
	}
}
