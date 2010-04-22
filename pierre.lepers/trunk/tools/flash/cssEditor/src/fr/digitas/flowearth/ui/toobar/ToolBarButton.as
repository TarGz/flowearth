package fr.digitas.flowearth.ui.toobar {
	import flash.filters.ColorMatrixFilter;	
	
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.DisplayObject;		

	/**
	 * @author Pierre Lepers
	 */
	public class ToolBarButton extends Sprite implements ILayoutItem {
		
		public var bg : MovieClip;
		public var label : TextField;

		public function ToolBarButton(  ) {
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
			addEventListener( MouseEvent.MOUSE_DOWN , down );
			addEventListener( MouseEvent.MOUSE_UP , over );
		}
		
		private function over(event : MouseEvent) : void {
			bg.gotoAndPlay( "over" );
		}

		private function out(event : MouseEvent) : void {
			bg.gotoAndPlay( "out" );
		}

		private function down(event : MouseEvent) : void {
			bg.gotoAndPlay( "down" );
		}

		public function setLabel( lbl : String ) : void {
			if( label == null && lbl != null ) {
				label = new TextField();
				label.autoSize = "left";
				label.defaultTextFormat = new TextFormat( "Arial", 12 );
				label.x = label.y = 2;
				addChild( label );
			}
			if( lbl != null )
				label.text = lbl;
			else if ( label ) {
				removeChild( label );
				label = null;
			}
			
		}
		
		public function setIcon( ico : BitmapData ) : void {
			if( icon ) removeChild( icon );
			icon = new Bitmap( ico );
			icon.x = icon.y = 2;
			addChild( icon );
			update( );
		}
		
		private function update() : void {
			if( label == null && icon == null ) return;
			if( label ) {
				if( icon ) 	label.x = icon.width + 4;
				else		label.x = 2;
				
				bg.height = ( ( icon != null ) ? icon.height : label.height ) + 4;
				bg.width = label.x + label.width + 2;
			} else {
				bg.height = icon.height + 4;
				bg.width = icon.width + 4;
			}
			
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		override public function set mouseEnabled(enabled : Boolean) : void {
			super.mouseEnabled = enabled;
			
			if( enabled )
				filters = [ ];
			else
				filters = [ greyCMF ];
		}

		
		
		public function getWidth() : Number {
			return bg.width;
		}
		
		public function getHeight() : Number {
			return bg.height;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
		
		private var icon : Bitmap;
		
		private static const greyCMF : ColorMatrixFilter = new ColorMatrixFilter([ 	.3 ,.3 ,.3 ,0 ,0 ,
																					.3, .3 ,.3 ,0 ,0 ,
																					.3, .3 ,.3 ,0 ,0 ,
																					0, 0, 0 ,1 ,0 ] );
	}
}
