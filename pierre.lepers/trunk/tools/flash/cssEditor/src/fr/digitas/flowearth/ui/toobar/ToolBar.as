package fr.digitas.flowearth.ui.toobar {
	import flash.geom.Rectangle;	
	
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.LayoutAlign;
	import fr.digitas.flowearth.ui.layout.renderer.HBlockRenderer;
	import fr.digitas.flowearth.ui.layout.renderer.VBlockRenderer;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class ToolBar extends Sprite {
		
		public function ToolBar() {
			_idMap = new Dictionary();
			_buildLayout();
		}
		
		public function addButton( id : String, label : String = null, icon : BitmapData = null ):  void {
			
			var btn : ToolBarButton = new ToolBarButton_FC();
			if( icon )
				btn.setIcon( icon );
			if( label )
				btn.setLabel( label );
				
			_layout.addChild( btn );
			btn.addEventListener( MouseEvent.CLICK , onClickBtn );
			_idMap[ btn ] = id;
		}

		private function onClickBtn(event : MouseEvent) : void {
			var id  : String = _idMap[ event.currentTarget ];
			dispatchEvent( new TextEvent( Event.SELECT , false, false, id ) );
		}

		
		public function update() : void {
			_layout.update();
		}
		
		
		
		
		public function set align ( val : String ) : void {
			if( val == LayoutAlign.LEFT || val == LayoutAlign.RIGHT )
				_layout.renderer = new HBlockRenderer();
			else
				_layout.renderer = new VBlockRenderer();
		}

		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.margin = new Rectangle( 2,2 );
			_layout.renderer = new HBlockRenderer();
			addChild( _layout );
		}


		override public function set width(value : Number) : void {
			_layout.width = value;
		}

		override public function set height(value : Number) : void {
			_layout.height = value;
		}
		
		private var _layout : Layout;
		
		private var _idMap : Dictionary;
	}
}
