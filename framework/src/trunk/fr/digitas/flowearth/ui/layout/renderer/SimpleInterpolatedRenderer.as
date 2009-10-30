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
	import fr.digitas.flowearth.ui.layout.renderer.InterpolatedRenderer;
	import fr.digitas.flowearth.ui.layout.utils.AnimationHelper;
	import fr.digitas.flowearth.ui.layout.utils.IInterpolable;	

	/**
	 * class d'Exemple
	 * @author Pierre Lepers
	 */
	public class SimpleInterpolatedRenderer extends InterpolatedRenderer {

		
		public var xDecay : Number = 20;
		public var yDecay : Number = 20;

		public function SimpleInterpolatedRenderer (baseRenderer : ChildRenderer) {
			super( baseRenderer );
		}

		override protected function renderChildProgress ( proxy : AnimationHelper ) : void {
			var ownProgress : Number = proxy.getProgress();
			
			if( proxy.original is IInterpolable ) 
				if( ! ( proxy.original as IInterpolable ).setProgress( proxy ) ) return;
			
			proxy.original.y = ( yDecay == 0 ) ? proxy.y : easeOutQuad( ownProgress, proxy.y + yDecay, -yDecay, 1);
			proxy.original.x = ( xDecay == 0 ) ? proxy.x : easeOutQuad( ownProgress, proxy.x + xDecay, -xDecay, 1);
			proxy.original.alpha = ownProgress;
			
		}
		
		public static function easeOutQuad (t:Number, b:Number, c:Number, d:Number):Number {
			return -c *(t/=d)*(t-2) + b;
		}
	}
}

	