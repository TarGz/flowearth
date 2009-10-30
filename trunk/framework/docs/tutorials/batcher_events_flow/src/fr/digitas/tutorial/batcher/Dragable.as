package fr.digitas.tutorial.batcher {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;		

	/**
	 * @author Pierre Lepers
	 */
	public class Dragable extends Sprite {

		public static const STOP_DRAG : String = "stopdrag";
		public static const START_DRAG : String = "startdrag";
		public static const ADDED : String = "drgAdded";
		
		public var dragZone : DisplayObject;

		public function Dragable() {
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}


		private function onAdded( e : Event ) : void {
			dragZone.addEventListener( MouseEvent.MOUSE_DOWN , _onMouseDown );
		}

		private function onRemoved( e : Event ) : void {
			
		}
		
		private function _onMouseDown(event : MouseEvent) : void {
			event.stopImmediatePropagation();
			stage.addEventListener( MouseEvent.MOUSE_UP , _onMouseUp );
			stage.addEventListener( Event.ENTER_FRAME , _onMouseMove );
			startDrag( );
			dispatchEvent( new Event( START_DRAG  ) );
		}
		
		private function _onMouseMove(event : Event) : void {
//			Logger.log( "fr.digitas.tutorial.batcher.Dragable - _onMouseMove -- ", localToGlobal( new Point( )) );
			var ipoint : InsertionPoint = BatchableTree.instance.getPositionNearPoint( localToGlobal( new Point( ) ) );
			
			BatcherEventFlow.insertionGhost.visible = (ipoint != null);
			
			if( ipoint ) {
				BatcherEventFlow.insertionGhost.x = ipoint.globalPoint.x;
				BatcherEventFlow.insertionGhost.y = ipoint.globalPoint.y;
			} 
//			Logger.log( "fr.digitas.tutorial.batcher.Dragable - _onMouseMove -- " ,  );
		}

		private function _onMouseUp(event : MouseEvent) : void {
			BatcherEventFlow.insertionGhost.visible = false;
			stopDrag( );
			
			stage.removeEventListener( Event.ENTER_FRAME , _onMouseMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP , _onMouseUp );
			
			var ipoint : InsertionPoint = BatchableTree.instance.getPositionNearPoint( localToGlobal( new Point( ) ) );
			
			dispatchEvent( new Event( ADDED ) );
			handleInsertion( ipoint );
			
			
			
			
			dispatchEvent( new Event( STOP_DRAG ) );
		}
		
		protected function handleInsertion(ipoint : InsertionPoint) : void {
			// abstract
		}
	}
}
