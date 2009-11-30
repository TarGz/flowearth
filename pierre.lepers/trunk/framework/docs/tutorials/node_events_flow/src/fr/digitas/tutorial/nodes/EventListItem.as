package fr.digitas.tutorial.nodes {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;	

	/**
	 * @author Pierre Lepers
	 */
	public class EventListItem extends Sprite implements ILayoutItem {
		
		
		public static const ACTION : String = "onAction";
		
		
		public var etf : TextField;
		
		
		public function get watcherItem() : EventWatcherItem {
			return _ewi;
		}
		
		public function EventListItem() {
			addEventListener( MouseEvent.ROLL_OVER , onOver );
			addEventListener( MouseEvent.ROLL_OUT , onOut );
		}
		

		private function onOver(event : MouseEvent) : void {
			_ewi.decorateNode();
			_ewi.decorateTarget();
			dispatchEvent( new Event( ACTION ) );
			etf.htmlText = "<font color='#008000'>"+_ewi.getString()+"</font>";
		}

		private function onOut(event : MouseEvent) : void {
			_ewi.clearDecorations();
			dispatchEvent( new Event( ACTION ) );
			etf.htmlText = _ewi.getString();
		}

		public function init( ewi : EventWatcherItem ) : void {
			_ewi = ewi;
			etf.htmlText = ewi.getString();
		}

		
		
		public function getWidth() : Number {
			return width;
		}
		
		public function getHeight() : Number {
			return 14;
		}

		private var _ewi : EventWatcherItem;
		
	}

}
