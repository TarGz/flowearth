package fr.digitas.flowearth.ui.form {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.geom.ColorTransform;	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class CompletionListItem extends Sprite implements ILayoutItem {

		public var bg : MovieClip;
		public var tf : TextField;

		public function CompletionListItem() {
			tf.autoSize = "left";
		}
		
		internal var _cdata : CompletionData;

		override public function set width(value : Number) : void {
			bg.width = value;
		}
		
		public function setDatas(data : CompletionData) : void {
			_cdata = data;
			tf.text = data.label;
		}
		
		
		private var _focus : Boolean = false;
		
		public function get focus() : Boolean {
			return _focus;
		}
		
		public function set focus(focus : Boolean) : void {
			_focus = focus;
			bg.transform.colorTransform = _focus ? new ColorTransform( .8,.8,.8 ) : new ColorTransform( );
		}
		
		public function getWidth() : Number {
			return 0;
		}
		
		public function getHeight() : Number {
			return bg.height;
		}
	}
}
