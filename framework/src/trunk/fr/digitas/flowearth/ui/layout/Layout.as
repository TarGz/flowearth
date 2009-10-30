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


package fr.digitas.flowearth.ui.layout {
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.core.IDisplayObjectContainer;
	import fr.digitas.flowearth.ui.layout.renderer.RendererFactory;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;	

	/**
	 * dispatché lorsque les item ont été reordonné
	 * @see Event#CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * Gere le positionnement d'éléments (DisplayObject) dans un conteneur (Layout.container)
	 * 
	 * Les DisplayObject ajouté peuvent dispatcher un Event.RESIZE pour notifier le layout d'une mise a jour necessaire.
	 * 
	 * @author Pierre Lepers
	 */
	public class Layout extends Sprite implements IDisplayObjectContainer {
		
		/**
		 * Contient la liste des element a positionné.
		 * Si cette prop est null, la displayList est utilisé
		 */
		public var itemList : Array;
		
		/**
		 * defini un conteneur specifique pour le layout.
		 * tout les enfant existant sont transferé dans le nouveau conteneur.
		 * 
		 * @exemple
		 * pour rendre le contenu scrolable, container est un scroller
		 * <pre>
		 * 		var scroll : Scroller ;
		 * 		//...
		 * 		layout.container = scroll;
		 * </pre>
		 * 
		 */
		public function set container ( c : DisplayObjectContainer ) : void {
			var newDl : Array = new Array();
			while( c.numChildren > 0 ) newDl.push( c.removeChildAt(0) );
			
//			var oldContainer : DisplayObjectContainer = _container;
			if( _container )
				while( _container.numChildren > 0 ) c.addChildAt( getChildAt( 0 ), 0 );	
			
			_container = c;
			
			while( newDl.length > 0 ) addChild( newDl.shift() );
			
			invalidate();
		}
		/** @private */
		public function get container () : DisplayObjectContainer {
			return _container;
		}
				
		/**
		 * marges globales du layout
		 */
		public function set padding( p : Rectangle ) : void {
			_padding = p;
			invalidate();
		}
		/** @private */
		public function get padding( ) : Rectangle {
			return _padding;
		}
		
		/**
		 * marges autour de chaque enfants
		 */
		public function set margin( m : Rectangle ) : void {
			_margin = m;
			invalidate();
		}
		/** @private */
		public function get margin( ) : Rectangle {
			return _margin;
		}

		/**
		 * type d'alignement du layout, left par defaut
		 * @default String "TOP"
		 * @deprecated use renderer property instead
		 */
		public function set align ( val : String ) : void {
			_renderer = RendererFactory.getRenderer( val );
			invalidate();
		}
		/** @private */
		public function get align () : String {
			return _renderer.getType();
		}
		
		/**
		 * defini le <code>IChildRenderer</code> chargé de placer les enfant lors du rendu
		 */
		public function set renderer( r : IChildRenderer ) : void {
			if( _renderer ) _renderer.removeEventListener( Event.CHANGE, onRendererUpdate );
			_renderer = r;
			if( _renderer ) _renderer.addEventListener( Event.CHANGE, onRendererUpdate );
			invalidate( );
		}
		

		/** @private */
		public function get renderer () : IChildRenderer {
			return _renderer;
		}
		
		/**
		 * defini la largeur maximal pour l'alignement des item
		 */
		override public function set width ( value : Number ) : void {
			_width = value;
			invalidate();
		}

		override public function set height ( value : Number ) : void {
			_height = value;
			invalidate();
		}

		bi_internal function set width ( value : Number ) : void {
			super.width = value;
		}

		bi_internal function set height ( value : Number ) : void {
			super.height = value;
		}

		
		public function Layout () {
			if( _container == null ) super.addChild( _container = new Sprite() );
			renderer = RendererFactory.getRenderer( LayoutAlign.TOP );
			width = super.width;
			height = super.height;
		}
		
		public override function get numChildren() : int {
			return _container.numChildren;
		}

		public override function addChild ( child : DisplayObject ) : DisplayObject {
			register( child );
			invalidate();
			return _container.addChild( child );
		}

		public override function addChildAt ( child : DisplayObject, index : int ) : DisplayObject {
			register( child );
			invalidate();
			return _container.addChildAt( child, index );
		}

		public override function removeChild ( child : DisplayObject ) : DisplayObject {
			unregister( child );
			invalidate();
			return _container.removeChild( child );
		}

		public override function removeChildAt ( index : int ) : DisplayObject {
			var child : DisplayObject = _container.removeChildAt( index );
			unregister( child );
			invalidate();
			return child;
		}

		public override function swapChildren ( child1 : DisplayObject, child2 : DisplayObject ) : void {
			invalidate();
			_container.swapChildren( child1, child2 );
		}

		public override function setChildIndex ( child : DisplayObject, index : int ) : void {
			invalidate();
			_container.setChildIndex( child, index );
		}

		public override function swapChildrenAt ( index1 : int, index2 : int ) : void {
			invalidate( );
			_container.swapChildrenAt( index1, index2 );
		}
		
		
		public override function getChildByName (name : String) : DisplayObject {
			return _container.getChildByName( name );
		}

		public override function getChildIndex (child : DisplayObject) : int {
			return _container.getChildIndex( child );
		}
		
		public override function contains (child : DisplayObject) : Boolean {
			return _container.contains ( child );
		}
		
		public override function getChildAt (index : int) : DisplayObject {
			return _container.getChildAt( index );
		}
		
		/**
		 * met a jour l'affichage ( range les items )
		 */
		public function update( e : Event = null ) : void {
			_renderer.init( _padding, _margin, _width, _height );
			var i : int;
			if( itemList ) {
				for ( i = 0; i < itemList.length; i += 1 )
					_renderer.render( itemList[ i ] );
			} else 
				for ( i = 0; i < _container.numChildren; i += 1 )
					_renderer.render( _container.getChildAt( i ) );
				
			_renderer.complete();
			removeEventListener( Event.RENDER, update );
			_valid = true;
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		
		//_____________________________________________________________________________
		//																	   PRIVATES

		
		private function register ( child : DisplayObject ) : void {
			child.addEventListener( Event.RESIZE, onChildUpdate );
		}

		private function unregister (child : DisplayObject) : void {
			child.removeEventListener( Event.RESIZE, onChildUpdate );
		}

		private function onChildUpdate (event : Event) : void {
			invalidate();
		}
		
		private function onRendererUpdate (event : Event) : void {
			dispatchEvent( new Event( Event.CHANGE  ) );
		}
		
		protected function invalidate() : void {
			if( _valid ) addEventListener( Event.RENDER, update );
			if( stage ) stage.invalidate();
			_valid = false;
		}

		
		
		protected var _margin 		: Rectangle = new Rectangle();
		protected var _padding 		: Rectangle = new Rectangle();
		protected var _width 		: Number = 0;
		protected var _height 		: Number = 0;
		protected var _valid 		: Boolean = true;
		protected var _align 		: String;
		protected var _renderer 	: IChildRenderer;
		protected var _container 	: DisplayObjectContainer;
		
		
	}
}
