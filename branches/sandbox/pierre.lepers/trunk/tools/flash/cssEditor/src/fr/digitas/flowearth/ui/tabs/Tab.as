package fr.digitas.flowearth.ui.tabs {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class Tab extends Sprite implements ILayoutItem {

		public var label : TextField;
		public var bg : MovieClip;

		
		public function Tab() {
			label.autoSize = "left";
			label.wordWrap = false;
			
			addEventListener( MouseEvent.CLICK , onClick );
		}
		
		private function onClick(event : MouseEvent) : void {
			dispatchEvent( new Event( Event.SELECT ) );
		}

		public function getWidth() : Number {
			return bg.width;
		}
		
		public function getHeight() : Number {
			return 0;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
		
		internal function set selected( flag : Boolean ) : void {
			bg.transform.colorTransform = flag ? selCt : nullCt;
		}
		
		internal function setData(tdata : TabData) : void {
			_tdata = tdata;
			_tdata.addEventListener( Event.CHANGE , onDataChange );
			
			onDataChange();
		}
		
		internal function get tabData() : TabData {
			return _tdata;
		}

		internal function dispose() : void {
			_tdata.removeEventListener( Event.CHANGE , onDataChange );
			_tdata = null;
		}

		private function onDataChange(event : Event = null ) : void {
			label.text = _tdata.label;
			bg.width = Math.round( label.width + label.x * 2 );
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		private var _tdata : TabData;
		
		private static const nullCt : ColorTransform = new ColorTransform();
		
		private static const selCt : ColorTransform = new ColorTransform(1,1,1,1,50, 50 , 50 );
	}
}
