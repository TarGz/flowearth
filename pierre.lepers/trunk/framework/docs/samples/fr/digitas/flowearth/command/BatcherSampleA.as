package {
	import fr.digitas.flowearth.event.BatchErrorEvent;	
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.net.BatchLoaderItem;
	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;		

	public class BatcherSampleA extends BasicExample {
		
		private var batcher : Batcher;
		
		function BatcherSampleA() {
			
			buildBatcher();
			
			trace( "click to start" );
			stage.addEventListener( MouseEvent.CLICK , onStart );
			
		}
		
		//_____________________________________________________________________________
		//														  Build loading process

		private function buildBatcher() : void {
			batcher = new Batcher();
			
			loadPicture( baseUrl+"/pict_01.jpg" );
			loadPicture( baseUrl+"/pict_02.jpg" );
			loadPicture( baseUrl+"/missing_file.jpg" );
			loadPicture( baseUrl+"/pict_03.jpg" );
			
			batcher.addEventListener( Event.COMPLETE , onBatcherComplete );
			batcher.addEventListener( ErrorEvent.ERROR, onBatcherError );

			batcher.addEventListener( BatchEvent.ITEM_START , onItemStart );
			batcher.addEventListener( BatchEvent.ITEM_COMPLETE , onItemComplete );
			batcher.addEventListener( BatchErrorEvent.ITEM_ERROR , onItemError );
		}
		
		private function loadPicture( url : String ) : void {
			
			var request : URLRequest = new URLRequest( url );
			var item : BatchLoaderItem = new BatchLoaderItem( request );
			batcher.addItem( item );
		}
		
		//_____________________________________________________________________________
		//																Events Handling
		
		
		private function onBatcherError(event : ErrorEvent) : void {
			trace( "Batcher Error " + event.text );
		}


		private function onBatcherComplete(event : Event) : void {
			trace( "Batcher Complete " );
		}

		
		private function onItemStart(event : BatchEvent) : void {
			var item : BatchLoaderItem = event.item as BatchLoaderItem;
			trace( "Start loading picture : "+item.request.url );
		}
		
		private function onItemComplete(event : BatchEvent) : void {
			var item : BatchLoaderItem = event.item as BatchLoaderItem;
			trace( "Picture loaded : "+item.request.url );
			var loader : Loader = item.loader;
			loader.y = Y;
			loader.x = - loader.width - 10;
			Y += 110;
			rightSide.addChild( loader );
		}
		
		private function onItemError(event : BatchErrorEvent ) : void {
			trace( "Batcher Item Error : " + event.text );
		}
		
		//_____________________________________________________________________________
		//																		   Misc
		private function onStart(event : MouseEvent) : void {
			batcher.start();
			stage.removeEventListener( MouseEvent.CLICK , onStart );
		}
		
		private var Y : int = 10;

	}
	
}