package fr.digitas.tutorial.batcher {
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	import fr.digitas.flowearth.ui.controls.ToggleButton;
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;	

	/**
	 * @author Pierre Lepers
	 */
	public class BatchableView extends Dragable implements ILayoutItem {
		private static var ID : int = 0;

		public var progress_tf : TextField;

		public var evtDeco : TextField;

		public var pause_btn : ToggleButton;

		public var dispose_btn : SimpleButton;

		public var label : TextField;

		public var bg : Sprite;
		public var pbar : Sprite;

		
		public function getBatchable() : IBatchable {
			return _batchable;
		}

		
		public function isBatcher() : Boolean {
			return _isBatcher;
		}

		public function BatchableView() {
			pbar.scaleX = 0;
			pause_btn.toggled = false;
			evtDeco.autoSize = "left";
			_buildLayout( );
			invalidate( );
			addEventListener( Event.ADDED_TO_STAGE , onAdded );
			addEventListener( Event.ADDED , onChildAdded );
		}

		private function onChildAdded(event : Event) : void {
			invalidate( );
		}

		private function onAdded( e : Event ) : void {
			invalidate( );
		}

		
		public function connect( batchable : IBatchable ) : void {
			_batchable = batchable;
			_batchable.addEventListener( BatchEvent.START , onItemStart );
			_batchable.addEventListener( BatchEvent.STOP , onItemStop );
//			
			//			_batchable.addEventListener( BatchEvent.ITEM_COMPLETE , onItemComplete );

			_batchable.addEventListener( BatchEvent.ADDED , onAdded2 );
			_batchable.addEventListener( BatchEvent.ITEM_ADDED , onItemAdded );
			_batchable.addEventListener( BatchEvent.ITEM_REMOVED , onItemRemoved );

			_batchable.addEventListener( ProgressEvent.PROGRESS , onProgress );

			_batchable.addEventListener( Event.COMPLETE , onComplete );

			
			
			
			_isBatcher = (_batchable is Batcher);
			
			setId( ID ++ );
			
			_initControls( );
		}

		private function onProgress(event : ProgressEvent) : void {
			progress_tf.text = Math.round( ( event.bytesLoaded / event.bytesTotal ) * 100 ) + "%";
			pbar.scaleX = event.bytesLoaded / event.bytesTotal;
		}

		public function getInsertionPoints() : Array {
			return _insertionPoints;
		}

		public function set eventDecoration( str : String ) : void {
			evtDeco.htmlText = str;
		}

		public function get eventDecoration() : String {
			return evtDeco.htmlText;
		}

		private var _parent : BatchableView;

		override protected function handleInsertion(ipoint : InsertionPoint) : void {
			if( ipoint == null ) {
				if( _parent ) ( _parent.getBatchable( ) as Batcher ).removeItem( this.getBatchable( ) );
				var pos : Point = localToGlobal( new Point );
				BatcherEventFlow.viewLayer.addChild( this );
				x=  pos.x;
				y = pos.y;
			}
			else if( ipoint.view != this ) {
				var b : Batcher = ipoint.view.getBatchable( ) as Batcher;
				if( b.indexOf( this.getBatchable( ) ) == ipoint.index ) 
					invalidate( );
				else
					b.addItemAt( this.getBatchable( ) , ipoint.index );
				
				_parent = ipoint.view;
			}
			
			updateInsertionPoints( );	
		}

		private function onAdded2(event : BatchEvent) : void {
			if( event.item == this )
				invalidate( );
			
			bg.alpha = label.alpha = 1;
		}

		private var _valid : Boolean = false;

		private function onItemAdded(event : BatchEvent) : void {
			var view : BatchableView = BatchableTree.instance.getView( event.item );
			var index : int = ( getBatchable( ) as Batcher ).indexOf( event.item );
			pendingContainer.addChildAt( view , index );
			invalidate( );
			event.item.addEventListener( Event.COMPLETE , onDirectItemComplete );
		}

		
		private function onItemRemoved(event : BatchEvent) : void {
		}

		
		private function onComplete(event : Event) : void {
			bg.alpha = label.alpha = 0.4;
		}

		
		private function onDirectItemComplete(event : Event) : void {
			var batchable : IBatchable = event.currentTarget as IBatchable;
			var view : BatchableView = BatchableTree.instance.getView( batchable );
			if( pendingContainer.contains( view ) )
				completeContainer.addChild( view );
			invalidate( );
			batchable.removeEventListener( Event.COMPLETE , onDirectItemComplete );
		}

		private function onItemStart(event : BatchEvent) : void {
			pause_btn.removeEventListener( ToggleButton.TOGGLED , onToggleRun );
			pause_btn.toggled = true;
			pause_btn.addEventListener( ToggleButton.TOGGLED , onToggleRun );
		}

		private function onItemStop(event : BatchEvent) : void {
			pause_btn.removeEventListener( ToggleButton.TOGGLED , onToggleRun );
			pause_btn.toggled = false;
			pause_btn.addEventListener( ToggleButton.TOGGLED , onToggleRun );
		}

		
		private function _initControls() : void {
			dispose_btn.addEventListener( MouseEvent.CLICK , onClickDispose );
			if( _batchable is Batcher )
				pause_btn.addEventListener( ToggleButton.TOGGLED , onToggleRun );
			else
				removeChild( pause_btn );
		}

		private function onClickDispose(event : MouseEvent) : void {
			_batchable.dispose( );
		}

		private function onToggleRun(event : BoolEvent) : void {
			if( event.flag ) {
				( _batchable as Batcher ).start( );
			}
			else
				( _batchable as Batcher ).stop( );
		}

		private function _buildLayout() : void {
			addChild( ippointContainer = new Sprite( ) );
			
			childContainer = new Layout( );
			childContainer.renderer = new TopRenderer( );
			childContainer.margin = new Rectangle( 0 , 0 , 0 , 0 );
			childContainer.x = childContainer.y = 25;
			addChild( childContainer );

			completeContainer = new ChildContainer( );
			completeContainer.renderer = new TopRenderer( );
			completeContainer.margin = new Rectangle( 0 , 0 , 0 , 0 );
			childContainer.addChild( completeContainer );

			pendingContainer = new ChildContainer( );
			pendingContainer.renderer = new TopRenderer( );
			pendingContainer.margin = new Rectangle( 0 , 0 , 0 , 0 );
			childContainer.addChild( pendingContainer );
		}

		public function invalidate() : void {
			//			Logger.log( "fr.digitas.tutorial.batcher.BatchableView - invalidate -- " , label.text );
			_valid = false;
			if( stage ) {
				var p : int = 0;
				var _do : DisplayObject = this;
				while( _do != stage) {
					p ++;	
					_do = _do.parent;
				}
				
				stage.removeEventListener( Event.RENDER , updateAll );
				stage.addEventListener( Event.RENDER , updateAll , false , p );
				stage.invalidate( );
			}
			
			var c : BatchableView;
			for (var i : int = 0; i < pendingContainer.numChildren ; i ++) {
				c = pendingContainer.getChildAt( i ) as BatchableView;
				c.invalidate( );	
			}
		}

		
		
		private function updateAll( e : Event ) : void {
			//			Logger.log( "fr.digitas.tutorial.batcher.BatchableView - updateall -- " , label.text );
			childContainer.update( );
			completeContainer.update( );
			pendingContainer.update( );
			updateInsertionPoints( );
			dispatchEvent( new Event( Event.RESIZE , true ) );
			stage.removeEventListener( Event.RENDER , updateAll );
			_valid = true;
		}

		
		
		private function updateInsertionPoints() : void {
			_insertionPoints = [];
			
			var c : DisplayObject;
			var ip : InsertionPoint;
			for (var i : int = 0; i < pendingContainer.numChildren ; i ++) {
				c = pendingContainer.getChildAt( i );
				ip = new InsertionPoint( new Point( childContainer.x , pendingContainer.y + childContainer.y + c.y ) , i , this );
				_insertionPoints.push( ip );
			}
			ip = new InsertionPoint( new Point( childContainer.x , + childContainer.y + pendingContainer.y + pendingContainer.height + 6 ) , i , this );
			_insertionPoints.push( ip );
			
			//updateIPointDisplay( );
		}

		private function updateIPointDisplay() : void {
			ippointContainer.graphics.clear( );
			ippointContainer.graphics.lineStyle( 1 , 0xFF0000 );
			
			for each (var ip : InsertionPoint in _insertionPoints) {
				ippointContainer.graphics.moveTo( ip.localPoint.x , ip.localPoint.y );
				ippointContainer.graphics.lineTo( ip.localPoint.x + 100 , ip.localPoint.y );
			}
		}

		
		private var ippointContainer : Sprite;

		private var _batchable : IBatchable;

		private var _isBatcher : Boolean;

		private var _insertionPoints : Array;

		internal var childContainer : Layout;

		internal var completeContainer : Layout;

		internal var pendingContainer : Layout;

		public function getWidth() : Number {
			return 0;
		}

		public function getHeight() : Number {
			return childContainer.height + childContainer.x;
		}

		public function setId(id : int) : void {
			if( ! isBatcher( ) )	label.text = "I" + id;
			else	label.text = "B" + id;
		}
		
//		private var 
	}
}

import fr.digitas.flowearth.ui.layout.ILayoutItem;
import fr.digitas.flowearth.ui.layout.Layout;
import fr.digitas.tutorial.batcher.BatchableView;

class ChildContainer extends Layout implements ILayoutItem {

	public function getWidth() : Number {
		return 0;
	}
	
	public function getHeight() : Number {
		if( numChildren == 0 ) return 0;
		var last : BatchableView = getChildAt( numChildren- 1 ) as BatchableView;
		return ( last.y + last.getHeight() );
	}
}

