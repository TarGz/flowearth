package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.ui.toobar.ToolBar;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class EditorToolBar extends Sprite {
		
		public var bg : Sprite;
		
		public function EditorToolBar() {
			_build( );
		}

		override public function set width(value : Number) : void {
			_toolBar.width = 
			bg.width = value;
			if( bg.height != _toolBar.height+ 3 ) {
				bg.height = _toolBar.height+3;
				dispatchEvent( new Event( Event.RESIZE ) );
			}
		}

		override public function get height() : Number {
			return bg.height;
		}

		private function _build() : void {
			_toolBar = new ToolBar( );
			
			_toolBar.addButton( "addStyle", null , Picts.ADD_STYLE );
			_toolBar.addButton( "expand", null , Picts.EXPAND_ALL );
			_toolBar.addButton( "collapse", null , Picts.COLLAPSE_ALL );
			
			_toolBar.addEventListener( Event.SELECT , onItemSelect );
			
			_toolBar.width = 1000;
			_toolBar.x = 2;
			_toolBar.update();
			addChild( _toolBar );
		}
		
		private function onItemSelect(event : TextEvent) : void {
			dispatchEvent( event );
			
			switch ( event.text ) {
				
				case "addStyle" : 
					if( CSSProvider.instance.currentCss == null ) break;
					
					CSSProvider.instance.currentCss.datas.addNewStyle( );
					break;
			}
		}

		
		
		private var _toolBar : ToolBar;
	}
}
