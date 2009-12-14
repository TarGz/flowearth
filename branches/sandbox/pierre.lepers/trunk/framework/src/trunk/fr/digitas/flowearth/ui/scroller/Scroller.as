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


package fr.digitas.flowearth.ui.scroller {
	import fr.digitas.flowearth.bi_internal;	import fr.digitas.flowearth.core.IDisposable;	import fr.digitas.flowearth.event.BoolEvent;		import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.geom.Rectangle;		/**
	 * dispatché lorsque la taile de la zone de scroll change
	 * @see Event#RESIZE
	 */
	[Event(name="resize", type="flash.events.Event")]

	/**
	 * dispatché lorsque la scrollbar à été affiché ou supprimé
	 * @see Scroller#DISPLAY_SCROLL
	 */
	[Event(name="dispayScroll", type="fr.digitas.flowearth.event.BoolEvent")]
	

	/**
	 * Composant de scroll, éoè
	 */
	public class Scroller extends Sprite implements IDisposable
	{
		
		public static const SCROLL_CHANGE : String = "scroll_change";

		public static const DISPLAY_SCROLL : String = "dispayScroll";
		
		/**
		 * amplitude du scroll du contenu en pixel a chaque mouseWheel ou click sur une des fleche de la scroll bar
		 */
		public var deltaPx : Number = 54;
		
		/**
		 * @private
		 */
		public var scrollBar : ScrollBar;
		
		/**
		 * @private
		 */
		public var zone : Sprite;
		
		
		/**
		 * defini comment l'affichage de la scrollBar est gerée
		 * @see ScrollBarPolicy#AUTO_HIDE
		 * @see ScrollBarPolicy#AUTO_ACTIVATE
		 * @see ScrollBarPolicy#NEVER
		 */
		public function set scrollPolicy( str : String ) : void {
			if( _scrollPolicy == str ) return;
			_scrollPolicy = str;
			if( _scrollPolicy == ScrollPolicy.NEVER && contains( scrollBar )) bi_internal::removeChild( scrollBar );
			else if( _scrollPolicy == ScrollPolicy.ALWAYS && !contains( scrollBar )) bi_internal::addChild( scrollBar );
		}
		
		/**
		 * Met le conteneur en cacheAsBitmap, optimize le scrollRect
		 */
		public function set contentCache( flag : Boolean ) : void {
			_content.cacheAsBitmap = flag;
		}
		/** @private */
		public function get contentCache(  ) : Boolean {
			return _content.cacheAsBitmap;
		}
		
		
		/**
		 * active ou non la detection automatiqe du changement de taille du contenu
		 * 
		 * @default false
		 */
		public function set watchResize(watchResize : Boolean) : void {
			if( _watchResize == watchResize ) return;
			_subContent.notifyResize( _watchResize = watchResize );
		}

		public function get watchResize() : Boolean {
			return _watchResize;
		}
		
		/**
		 * verouille la hauteur du contenu ( vis a vis de la scrollbar) 
		 */
		public var lockedHeight : Number = -1;
		
		public function Scroller() {
			
			bi_internal::removeChild( zone );
			
			_content 	= new Sprite();
			_subContent = new ScrollerContent();
			_content.addChild( _subContent );

			_scrollRect = new Rectangle();
			_content.scrollRect = _scrollRect;
			
			_width = zone.width;
			
			bi_internal::addChild( _content );
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );

			update();
			
			needScroll = true;
		}
		
		/**
		 * Renvoi le <code>ScrolerContent</code> (qui contient les objet a scoller
		 */
		public function get container () : DisplayObject {
			return _subContent;	
		}

		
		/**
		 * position vertical en pourcentage du contenu
		 * @param val - valeur entre 0 et 1
		 */
		public function set position( val : Number ) : void {
			_position = Math.min( Math.max( 0, val ), _needScroll ? 1 : 0 );
			update();
		}
		
		/**
		 * renvoi la position vertical en pourcentage du contenu
		 * @return val - la position entre 0 et 1
		 */
		public function get position(  ) : Number {
			return _position;
		}
		
		

		
		/**
		 * renvoi une copie du scrollRect du conteneur (zone visible du contenu )
		 * @return scrollRect du contenu
		 */
		public function get bounds( ) : Rectangle {
			return _scrollRect.clone();
		}
		
		/**
		 * defini la hauteur du scroller
		 */
		override public function set height( val : Number ) : void {
			visible = ( val > 0 );
			zone.height = val;
			update();
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		/**
		 * defini la largeur du scroller
		 */
		override public function set width( val : Number ) : void {
			visible = ( val > 0 );
			_width = val;
			update();
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		override public function get width( ) : Number {
			return zone.width;
			
		}
		
		override public function get height( ) : Number {
			return zone.height;
		}
		
		
		/**
		 * ajoute un DisplayObject au contenu scrollable, joue le role de addChild
		 */
		public override function addChild( child:DisplayObject ) : DisplayObject {
			_subContent.addChild( child );
			invalidate();
			return child;
		}
		/**
		 * supprime de DisplayObject des la displaylist du contenu scrollable
		 */
		public override function removeChild( child:DisplayObject ) : DisplayObject {
			_subContent.removeChild( child );
			invalidate();
			return child;
		}
		
		public override function removeChildAt( index : int ) : DisplayObject {
			var child : DisplayObject = _subContent.removeChildAt( index );
			invalidate();
			return child;
		}
		
		public override function getChildAt( index : int ) : DisplayObject {
			return _subContent.getChildAt( index );
		}
		public override function get numChildren() : int {
			return _subContent.numChildren;
		}
		public override function addChildAt ( child : DisplayObject, index : int ) : DisplayObject {
			return _subContent.addChildAt( child, index );
		}
		public override function swapChildren ( child1 : DisplayObject, child2 : DisplayObject ) : void {
			_subContent.swapChildren( child1, child2 );
		}
		public override function setChildIndex ( child : DisplayObject, index : int ) : void {
			_subContent.setChildIndex( child, index );
		}
		public override function swapChildrenAt ( index1 : int, index2 : int ) : void {
			_subContent.swapChildrenAt( index1, index2 );
		}
		public override function getChildByName (name : String) : DisplayObject {
			return _subContent.getChildByName( name );
		}
		public override function getChildIndex (child : DisplayObject) : int {
			return _subContent.getChildIndex( child );
		}
		public override function contains (child : DisplayObject) : Boolean {
			return _subContent.contains ( child );
		}
		
		
		
		
		//_____________________________________________________________________________
		//									 Methode originale de DisplayObjectContainer
		
		bi_internal function get numChildren() : int {
			return super.numChildren;
		}

		bi_internal function addChild( child:DisplayObject ) : DisplayObject {
			return super.addChild( child );
		}

		bi_internal function removeChild( child:DisplayObject ) : DisplayObject {
			return super.removeChild( child );
		}

		bi_internal function getChildAt( index : int ) : DisplayObject {
			return super.getChildAt( index );
		}
		
		/**
		 * vide le contenu du scroller
		 */
		public function clearContent() : void {
			while( _subContent.numChildren > 0 ) _subContent.removeChildAt( 0 );
			invalidate();
		}
		
		
		public function dispose () : void {
			clearContent();
			_subContent.removeEventListener( Event.RESIZE, invalidate );
			_content.removeEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
		}
		
		public function invalidate( e : Event = null ) : void {
			if( ! _valid ) addEventListener( Event.RENDER, update );
			if( stage ) stage.invalidate();
			_valid = false;
		}

		
		public function update( e : Event = null ) : void {
			removeEventListener( Event.RENDER, update );

			var realHeight : Number = ( lockedHeight > 0 ) ? lockedHeight : _subContent.height;
			needScroll = ( zone.height < realHeight );
			
			_scrollRect.y =  _position * ( realHeight - zone.height );
			zone.width = _scrollRect.width = _width - ( ( super.contains( scrollBar ) ) ? scrollBar.width : 0 ) ;
			scrollBar.x = _width;
			_scrollRect.height = zone.height;
			
			
			_content.scrollRect = _scrollRect;
			

			scrollBar.update( _position, realHeight, zone.height );
			_valid = true;
			dispatchEvent( new Event( SCROLL_CHANGE ) );
		}

		//_____________________________________________________________________________
		//																		 PRIVATES
		
		
		protected function set needScroll( flag : Boolean ) : void {
			if( _needScroll == flag ) return;
			_needScroll = flag;
			if( _scrollPolicy == ScrollPolicy.AUTO_HIDE ) {
				if( flag ) 	
					bi_internal::addChild( scrollBar );
				else 
					bi_internal::removeChild( scrollBar );
				
				dispatchEvent( new BoolEvent( DISPLAY_SCROLL, flag ) );
			}
			else if ( _scrollPolicy == ScrollPolicy.AUTO_ACTIVATE ) {
				scrollBar.activate( flag );
			}
			if( !flag ) position = 0;
		}
		
		protected function onAdded( e : Event ) : void {
			scrollBar.addEventListener	( Event.CHANGE	, onScrollBarChange );
			scrollBar.addEventListener	( ScrollBar.UP	, onScrollBarUp );
			scrollBar.addEventListener	( ScrollBar.DOWN, onScrollBarDown );
			_subContent.addEventListener( Event.RESIZE	, invalidate );
			_content.addEventListener	( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			invalidate();
		}
		
		protected function onRemoved( e : Event ) : void {
			scrollBar.removeEventListener	( Event.CHANGE		, onScrollBarChange );
			scrollBar.removeEventListener	( ScrollBar.UP		, onScrollBarUp );
			scrollBar.removeEventListener	( ScrollBar.DOWN	, onScrollBarDown );
			_subContent.removeEventListener	( Event.RESIZE		, invalidate );
			_content.removeEventListener	( MouseEvent.MOUSE_WHEEL, onMouseWheel );
		}
		
		protected function onMouseWheel( e : MouseEvent ) : void {
			var dir : int = ( e.delta > 0 ) ? -1 : 1;
			scroll( dir * deltaPx );
		}
		
		protected function scroll( px : Number ) : void {
			position += px / ( _subContent.height - zone.height );
			
		}
		
		protected function onScrollBarChange( e : Event ) : void {
			position = scrollBar.ownPosition;
		}
		protected function onScrollBarUp( e : Event ) : void {
			scroll( -deltaPx );
		}
		protected function onScrollBarDown( e : Event ) : void {
			scroll( deltaPx );
		}
		
		
		protected var _content 		: Sprite;
		protected var _subContent 	: ScrollerContent;
		protected var _scrollRect 	: Rectangle;
		protected var _position 	: Number = 0;
		protected var _valid 		: Boolean = false;
		protected var _watchResize 	: Boolean = false;
		protected var _width 		: Number;
		protected var _needScroll 	: Boolean;
		
		private var _scrollPolicy : String = "autoHide";
		
	}
}