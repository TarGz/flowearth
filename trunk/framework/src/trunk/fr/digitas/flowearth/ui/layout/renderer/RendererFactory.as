////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.IChildRenderer;							

	/**
	 * @author Pierre Lepers
	 */
	public class RendererFactory {
	
		public static function getRenderer( type : String ) : IChildRenderer {
			var renderer : ChildRenderer =	new RendererFactory[ type+"_RendererClass" ]( ) as ChildRenderer;
			renderer._type = type;
			return renderer;
		}
	
		
		private static const LEFT_RendererClass 	: Class = LeftRenderer;
		private static const RIGHT_RendererClass 	: Class = RightRenderer;
		private static const TOP_RendererClass		: Class = TopRenderer;
		private static const BOTTOM_RendererClass 	: Class = BottomRenderer;
	}
}
