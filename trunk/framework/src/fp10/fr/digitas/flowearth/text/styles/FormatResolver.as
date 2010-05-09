package fr.digitas.flowearth.text.styles {
	import flashx.textLayout.elements.FlowElement;
	import flashx.textLayout.elements.IFormatResolver;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.formats.ITextLayoutFormat;

	/**
	 * @author plepers
	 */
	public class FormatResolver implements IFormatResolver {

		private var _css : AdvancedStyleSheet;
		
		public function FormatResolver ( css : AdvancedStyleSheet ) {
			
			_css = css;
		}

		
		public function invalidateAll (textFlow : TextFlow) : void {
			
		}
		
		public function invalidate (target : Object) : void {
			trace( "invalidate  "+ target );
		}
		
		public function resolveFormat (target : Object) : ITextLayoutFormat {
			
			if( target is FlowElement ) {
				var styleName : String = target.styleName;
				if( styleName == null ) return null;
				return _css.getStyle( styleName ).getTlfFormat();
			}
			
			// TODO: handle Containers
			return null;
		}
		
		public function resolveUserFormat (target : Object, userFormat : String) : * {
			trace( "resolveUserFormat  "+target );
			return null;
		}
		
		public function getResolverForNewFlow (oldFlow : TextFlow, newFlow : TextFlow) : IFormatResolver {
			return this;
		}
	}
}
