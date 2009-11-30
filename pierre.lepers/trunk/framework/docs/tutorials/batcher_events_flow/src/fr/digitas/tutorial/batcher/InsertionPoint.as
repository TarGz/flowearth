package fr.digitas.tutorial.batcher {
	import flash.geom.Point;		

	/**
	 * @author Pierre Lepers
	 */
	public class InsertionPoint {

		
		
		public function InsertionPoint( localPoint : Point, index : int , view : BatchableView ) {
			_view = view;
			_localPoint = localPoint;
			_index = index;
			_globalPoint = _view.localToGlobal( _localPoint );
		}
		
		public var distance : Number;

		private var _index : int;
		
		private var _view : BatchableView;

		private var _localPoint : Point;

		private var _globalPoint : Point;
		
		
		public function get globalPoint() : Point {
			return _globalPoint;
		}
		
		public function get view() : BatchableView {
			return _view;
		}
		
		public function get index() : int {
			return _index;
		}
		
		public function get localPoint() : Point {
			return _localPoint;
		}
	}
}
