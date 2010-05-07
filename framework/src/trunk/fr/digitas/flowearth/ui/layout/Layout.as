/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */


package fr.digitas.flowearth.ui.layout {
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.core.Pile;	
	import fr.digitas.flowearth.ui.utils.InvalidationManager;	
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
	 * @see Event#RESIZE 
	 */
	[Event(name="resize", type="flash.events.Event")]
	
	/**
	 * Gere le positionnement d'éléments (DisplayObject) dans un conteneur (Layout.container)
	 * 
	 * Les DisplayObject ajouté peuvent dispatcher un Event.RESIZE pour notifier le layout d'une mise a jour necessaire.
	 * 
	 * @author Pierre Lepers
	 */
	public class Layout extends Sprite implements IDisplayObjectContainer, ILayoutItem {

		public static const CHANGING : String = "_l_changing";
		
		/*
		 * Contient la liste des element a positionné.
		 * Si cette prop est null, la displayList est utilisé
		 * @deprecated 
		 */
		//public var itemList : Array;
		/**
		 * An Array of uint used to display item in a different order than displayList order.
		 * If set to null, the displayList order is used.
		 * 
		 * for a layout with 3 item  A, B, C )
		 * 
		 * to render item in this order B, C, A set the indexMap to [ 1, 2, 0 ]
		 * 
		 */
		public function get indexMap() : Pile {
			return _indexMap;
		}
		
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
			
			if( _container )
				while( _container.numChildren > 0 ) c.addChildAt( getChildAt( 0 ), 0 );	
			
			_container = c;
			
			while( newDl.length > 0 ) addChild( newDl.shift() );
			
			invalidateDl();
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
			if ( _padding.equals( p ) ) return;
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
			if (_margin.equals( m ) ) return;
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

		override public function get width ( ) : Number {
			return ( _width > -1 ) ? _width : getWidth();
		}

		override public function get height ( ) : Number {
			return ( _height > -1 ) ? _height : getHeight();
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
			_indexMap = new Pile();
			width = super.width;
			height = super.height;
			
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}


		//_____________________________________________________________________________
		//																	ILayoutItem
		
		public function getWidth() : Number {
			return renderer.renderWidth;
		}
		
		public function getHeight() : Number {
			return renderer.renderHeight;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
		
		public override function get numChildren() : int {
			return _container.numChildren;
		}
		

		public override function addChild ( child : DisplayObject ) : DisplayObject {
			register( child );
			invalidateDl();
			invalidate( );
			if( _indexMap.indexOf( child ) == -1 )
				_indexMap.addItem( child );
			return _container.addChild( child );
		}

		public override function addChildAt ( child : DisplayObject, index : int ) : DisplayObject {
			register( child );
			invalidateDl();
			invalidate();
			if( _indexMap.indexOf( child ) == -1 )
				_indexMap.addItemAt( child, index );
			return _container.addChildAt( child, index );
		}

		public override function removeChild ( child : DisplayObject ) : DisplayObject {
			unregister( child );
			invalidateDl();
			invalidate();
			_indexMap.removeItem( child );
			return _container.removeChild( child );
		}

		public override function removeChildAt ( index : int ) : DisplayObject {
			return removeChild( _container.getChildAt( index ) );
		}

		public override function swapChildren ( child1 : DisplayObject, child2 : DisplayObject ) : void {
			invalidateDl();
			invalidate();
			_container.swapChildren( child1, child2 );
		}

		public override function setChildIndex ( child : DisplayObject, index : int ) : void {
			invalidateDl();
			invalidate();
			_container.setChildIndex( child, index );
		}

		public override function swapChildrenAt ( index1 : int, index2 : int ) : void {
			invalidateDl();
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
		
				bi_internal function addChild ( child : DisplayObject ) : DisplayObject {
			return super.addChild( child );
		}

		bi_internal function addChildAt ( child : DisplayObject, index : int ) : DisplayObject {
			return super.addChildAt( child, index );
		}
		
		bi_internal function removeChild ( child : DisplayObject ) : DisplayObject {
			return super.removeChild( child );
		}

		bi_internal function removeChildAt ( index : int ) : DisplayObject {
			return super.removeChildAt( index );
		}

		bi_internal function swapChildren ( child1 : DisplayObject, child2 : DisplayObject ) : void {
			super.swapChildren( child1, child2 );
		}

		bi_internal function setChildIndex ( child : DisplayObject, index : int ) : void {
			super.setChildIndex( child, index );
		}

		bi_internal function swapChildrenAt ( index1 : int, index2 : int ) : void {
			super.swapChildrenAt( index1, index2 );
		}
		
		bi_internal function getChildByName (name : String) : DisplayObject {
			return super.getChildByName( name );
		}

		bi_internal function getChildIndex (child : DisplayObject) : int {
			return super.getChildIndex( child );
		}
		
		bi_internal function contains (child : DisplayObject) : Boolean {
			return super.contains ( child );
		}
		
		bi_internal function getChildAt (index : int) : DisplayObject {
			return super.getChildAt( index );
		}
		
		
		/**
		 * met a jour l'affichage ( range les items )
		 */
		public function update( e : Event = null ) : void {
			dispatchEvent( new Event( CHANGING ) );
			_renderer.init( _padding, _margin, _width, _height );
			
			if( ! _validDl ) _buildDl();
			
			var i : int;
			for ( i = 0; i < _displayList.length ; i += 1 )
				_renderer.render( _displayList[ i ] );
			
				
			_renderer.complete();
			if( stage )
				InvalidationManager.getManager( stage ).removeEventListener( Event.RENDER, update );
			_valid = true;
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		
		private function _buildDl() : void {
			_displayList = []/*ILayoutItem*/;
			var child : DisplayObject;
			var iter : IIterator = _indexMap.getIterator();
			
			while( iter.hasNext() ) {
				child = iter.next( ) as DisplayObject;
				_displayList.push( ( child is ILayoutItem ) ? child : new InternalLayoutItem( child ) );
			}
		}

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
			dispatchEvent( new Event( Event.RESIZE  ) );
		}
		
		private function onRemoved( e : Event ) : void {
			InvalidationManager.getManager( stage ).removeEventListener( Event.RENDER, update );
			removeEventListener( Event.ADDED_TO_STAGE , update );
		}
		
		protected function invalidate() : void {
			if( ! _valid ) return;
			_valid = false;
			if( stage ) {
				var im : InvalidationManager = InvalidationManager.getManager( stage );
				im.addEventListener( Event.RENDER, update );
				im.invalidate();
			} else 
				addEventListener( Event.ADDED_TO_STAGE , update );
			
		}

		protected function invalidateDl() : void {
			_validDl = false;
		}

		
		
		protected var _margin 		: Rectangle = new Rectangle();
		protected var _padding 		: Rectangle = new Rectangle();
		protected var _width 		: Number = -1;
		protected var _height 		: Number = -1;
		protected var _valid 		: Boolean = true;
		protected var _validDl 		: Boolean = false;
		protected var _align 		: String;
		protected var _renderer 	: IChildRenderer;
		protected var _container 	: DisplayObjectContainer;
		protected var _displayList 	: Array/*ILayoutItem*/;
		protected var _indexMap 	: Pile;
	}
}
