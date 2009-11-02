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
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.ui.layout.renderer.ChildRenderer;
	import fr.digitas.flowearth.ui.layout.utils.AnimationHelper;
	import fr.digitas.flowearth.ui.layout.utils.IInterpolable;
	import fr.digitas.flowearth.utils.motion.psplitter.ProgressionSplitter;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Rectangle;	

	/**
	 * Kit de Renderer animé à monter soi même.
	 * @author Pierre Lepers
	 */
	public class InterpolatedRenderer extends ChildRenderer {

		public function get size() : Number {
			return _pSplitter.size;	
		}
		
		public function InterpolatedRenderer ( baseRenderer : ChildRenderer ) {
			_baseRenderer = baseRenderer;
		}
		
		/**
		 * progression de l'animation
		 */
		public function set progress (progress : Number) : void {
			_progress = progress;
			complete();
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		/** @private */
		public function get progress () : Number {
			return _progress;
		}
		
		/**
		 * pourcentage de chevauchement d'un animation d'un item sur le suivant ( j'me comprend )
		 */
		public var decay : Number = 0;

		/**
		 * lance l'interpolation en partantdu dernier enfant
		 */
		public var revert : Boolean = false;
		

		public override function init ( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			_baseRenderer.init( padding, margin, w, h );
			super.init( _baseRenderer._padding, _baseRenderer._margin, w, h );
			_offset = _baseRenderer._offset;
			_pSplitter = new ProgressionSplitter( );
		}

		public override function render ( child : DisplayObject ) : void {
			var ah : AnimationHelper = new AnimationHelper( child );
			_pSplitter.push( ah );
			_baseRenderer.render( ah );
		}
		
		
		override public function complete () : void {
			if( ! _pSplitter ) return;
			_pSplitter.progress = _progress;
			var iterator : IIterator = _pSplitter.getIterator();
			while ( iterator.hasNext() )
				renderChildProgress( iterator.next( ) as AnimationHelper );
			
			
			super.complete( );
		}
		
		protected function renderChildProgress( proxy : AnimationHelper ) : void {
			if( proxy.original is IInterpolable )
				( proxy.original as IInterpolable ).setProgress( proxy );
		}


		protected var _baseRenderer : ChildRenderer;
		protected var _pSplitter : ProgressionSplitter;
		protected var _progress : Number = 0;
		
	}
}



