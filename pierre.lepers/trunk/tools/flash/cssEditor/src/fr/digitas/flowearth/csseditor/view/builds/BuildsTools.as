package fr.digitas.flowearth.csseditor.view.builds {
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.ui.toobar.ToolBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	
	import fr.digitas.flowearth.csseditor.data.compiler.buildsProvider;	

	/**
	 * @author Pierre Lepers
	 */
	public class BuildsTools extends Sprite {

		public function BuildsTools() {
			_build( );
		}

		public var bg : Sprite;

		
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
			
			_leftTb.addButton( "clear" , null , Picts.REMOVE );
			
			_leftTb.addEventListener( Event.SELECT , onClick );
		}

		private function onClick(event : TextEvent ) : void {
			switch ( event.text ) {
				case "clear": 
					buildsProvider.getHistory().clear();
					break;
			}
		}

		private var _leftTb : ToolBar;

	}
}
