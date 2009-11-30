package fr.digitas.tutorial.batcher {
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.tutorial.batcher.BatchableView;
	import fr.digitas.tutorial.batcher.watch.EventList;
	
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class BatchableTree {

		
		
		
		public function BatchableTree( stage : Stage ) {
			_stage = stage;
			if( instance != null ) throw new Error( "fr.digitas.tutorial.batcher.BatchableTree est deja instancié" );
			
			views = new Array();
			batchers = new Array();
			_map = new Dictionary( );
			
			stage.addChild( debug = new Shape() );
		}
		
		public function empty() : Boolean {
			return(  views.length == 0 );
		}

		public function registerView( view : BatchableView ) : void {
			views.push( view );
			if( view.isBatcher() )
				batchers.push( view );
				
			_map[ view.getBatchable( ) ] = view;
			if( _evtList )
				_evtList.registerBatchable( view.getBatchable( ) );
			
		}

		public function getPositionNearPoint( point : Point ) : InsertionPoint {
			
			debug.graphics.clear( );
			debug.graphics.lineStyle( 2, 0x00FF00, 0.5);
			
			var item : BatchableView;
			var mdist : Number = Number.MAX_VALUE;
			var betterPoint : InsertionPoint;
			
			var  l : int = batchers.length;
			var  j : int;
			var iPoints : Array;
			var ipoint : InsertionPoint;
			var dist : Number;
			
			for (var i : int = 0; i < l; i++ ) {
				item = batchers[ i ];
				iPoints = item.getInsertionPoints();
				
				for ( j = 0; j < iPoints.length; j++) {
					ipoint = iPoints[j];

//					debug.graphics.moveTo(ipoint.globalPoint.x, ipoint.globalPoint.y);
//					debug.graphics.lineTo(ipoint.globalPoint.x + 100, ipoint.globalPoint.y);

					dist = Point.distance( ipoint.globalPoint, point );
					if( dist < mdist ) {
						mdist = dist;	
						betterPoint = ipoint;
					}
						
				}
				
			}
			if( betterPoint ) {
				if ( betterPoint.view.isBatcher() && mdist > 200 ) return null;
			}
			
			
			return betterPoint;
		}
		
		
		private var _stage : Stage;
		private var debug : Shape;
		private var _evtList : EventList;

		public function getView( batchable : IBatchable ) : BatchableView {
			return _map[ batchable ] ;
		}

		
		
		
		private var views : Array;

		private var batchers : Array;

		private var _map : Dictionary;

		
		public static var instance : BatchableTree;
		
		public static function start( stage : Stage ) : BatchableTree {
			if (instance == null)
				instance = new BatchableTree( stage );
			return instance;
		}
		
		public function connectWatcher(evtList  : EventList) : void {
			_evtList = evtList;
		}
	}
}
