package fr.digitas.flowearth.csseditor.view.preview {
	import fr.digitas.flowearth.csseditor.view.console.Console;	
	
	import flash.text.Font;	
	
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class RenderSide extends Sprite {
		
		public function RenderSide() {
			addChild( bg = new Shape() );
			bg.graphics.beginFill( 0x808080 );
			bg.graphics.drawRect(0, 0, 100, 100);
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
		
		public function update() : void {
			if( _valid ) return;
			
			if( !_styleName ) return ;
			
			styleManager.apply( _tf, _styleName , _text );
			
			_valid = true;
			
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			Console.log( "PREVIEW APPLY" );
			for (var i:Number = 0; i < n; i++) {
				Console.log( "-----------> "+(list[i] as Font).fontName );
			}
			Console.log( "PREVIEW APPLY" );
		}

		
		override public function set width(value : Number) : void {
			bg.width = value;
		}

		override public function set height(value : Number) : void {
			bg.height = value;
		}

		
		private function _invalidate() : void {
			_valid = false;
			// TODO debug line (update after)
			update();
		}
		
		

		private var _tf : TextField;
		
		private var _text : String;

		private var _styleName : QName;


		private var _valid : Boolean = false;
		
		private var bg : Shape;
		
	}
}
