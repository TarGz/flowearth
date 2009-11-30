package fr.digitas.flowearth.ui.form {
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class CompletionList extends Sprite {
		
		public var bg : MovieClip;

		public function CompletionList() {
			build( );
		}
		
		

		override public function set width(value : Number) : void {
			bg.width = value;
			list.width = value - 6;
			scroller.width = value - 6;
		}

		override public function set height(value : Number) : void {
			bg.height = value;
			scroller.height = value - 6;
		}
		
		public function getFocusedItem() : CompletionListItem {
			return ( list.getChildAt( _focusIndex ) as CompletionListItem);
		}

		
		
		public function populate(results : Array) : void {
			var oldData : CompletionData;
			if( _focusIndex > -1 )
				oldData = ( list.getChildAt( _focusIndex ) as CompletionListItem )._cdata;
				
			clear( );
			if( results.length == 0 ) return;
			
			var item : CompletionListItem;
			for each (var data : CompletionData in results) {
				item = new CompletionListItem_FC();
				item.setDatas( data );
				list.addChild( item );
				if( oldData == data ) _focusIndex = list.numChildren - 1;
			}
			
			( list.getChildAt( _focusIndex ) as CompletionListItem).focus = true;
			
			list.update( );
			scroller.invalidate();
		}

		private function clear() : void {
			_focusIndex = 0;
			while( list.numChildren > 0 )
				list.removeChildAt( 0 );
		}

		private function build() : void {
			scroller = new Scroller_FC();
			scroller.x = scroller.y = 3;
			addChild( scroller );
			
			list = new Layout();
			list.renderer = new TopJustifyRenderer( );
			scroller.addChild( list );
		}

		private var list : Layout;

		private var scroller : Scroller;
		
		private var _focusIndex : int = -1;
		
		public function get focusIndex() : int {
			return _focusIndex;
		}
		
		public function set focusIndex(focusIndex : int) : void {
			while( focusIndex > list.numChildren - 1 )
				focusIndex -= list.numChildren;
			while( focusIndex < 0 )
				focusIndex += list.numChildren;
				
			( list.getChildAt( _focusIndex ) as CompletionListItem).focus = false;
			_focusIndex = focusIndex;
			( list.getChildAt( _focusIndex ) as CompletionListItem).focus = true;
		}
	}
}
