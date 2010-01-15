package fr.digitas.flowearth.csseditor.view.preview {
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class RenderSide extends Sprite {
		
		public function RenderSide() {
			addChild( bg = new Shape() );
			addChild( grid = new GridLines( ) );
			bg.graphics.beginFill( 0xffffff );
			bg.graphics.drawRect(0, 0, 100, 100);
			addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
		}
		
		public function get tf() : TextField {
			return _tf;
		}
		

		public function set tf(tf : TextField) : void {
			if( _tf ) removeChild( _tf );
			_tf = tf;
			if( _tf ) addChild( _tf );
			_invalidate();
		}
		
		public function setStyle( stQn : QName ) : void {
			_styleName = stQn;
			_invalidate( );
		}

		public function setText( str : String ) : void {
			_text = str;
			_invalidate( );
		}
		
		public function update( e : Event = null ) : void {
			if( _valid ) return;
			_valid = true;
			onRemoved( null );
			
			if( !_styleName ) return ;
			
			styleManager.apply( _tf, _styleName , _text );
			
			_resize();
		}
		
		private function _resize() : void {
			_tf.x = ( bg.width - _tf.width ) >> 1;
			_tf.y = ( bg.height - _tf.height ) >> 1;
			
			grid.fit( _tf , bg.getBounds( this ) );
		}

		
		override public function set width(value : Number) : void {
			bg.width = value;
			_resize();
		}

		override public function set height(value : Number) : void {
			bg.height = value;
			_resize();
		}

		
		private function _invalidate() : void {
			if( ! _valid ) return;
			if( stage ) {
				stage.addEventListener( Event.RENDER , update );
				stage.invalidate();
			} else 
				addEventListener( Event.ADDED_TO_STAGE , update );
			
			_valid = false;
		}
		
		
		private function onRemoved(event : Event) : void {
			stage.removeEventListener( Event.RENDER , update );
		}
		
		

		private var _tf : TextField;
		
		private var _text : String;

		private var _styleName : QName;

		private var _valid : Boolean = true;
		
		private var bg : Shape;
		
		private var grid : GridLines;
	}
}
