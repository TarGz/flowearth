package fr.digitas.flowearth.csseditor.view.builds {
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.process.BuildInfos;
	import fr.digitas.flowearth.ui.tree.TreeItem;
	import fr.digitas.flowearth.ui.tree.TreeItem_FC;
	
	import flash.events.Event;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class BuildItem extends TreeItem {

		private var _infos : BuildInfos;
		
		public function BuildItem() {
			super( );
			collapse( false );
		}

		
		public function init( infos : BuildInfos ) : void {
			
			label.text = infos.getLabel();
			icon.bitmapData = Picts.BUILD_RUN;
			
			_infos = infos;
			
			_infos.process.addEventListener( NativeProcessExitEvent.EXIT, onExit );
			_infos.process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData, false, -100 );
            _infos.process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData, false, -100 );
		}
		
		private function onErrorData(event : ProgressEvent) : void {
			if( _errItem == null ) buildErrorItem( );
			_errItem.label.text = _infos.errors;
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		private function onOutputData(event : ProgressEvent) : void {
			if( _outItem == null ) buildOutputItem();
			_outItem.label.text = _infos.logs;
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		public function release() : void {
			_infos.process.removeEventListener( NativeProcessExitEvent.EXIT, onExit );
			_infos.process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            _infos.process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData );
			_infos = null;
			
		}

		
		
		override public function dispose() : void {
			super.dispose();
			release();
		}

		private function onExit(event : NativeProcessExitEvent) : void {
			icon.bitmapData = Picts.BUILD_STOP;
			label.text = "<terminated>"+_infos.getLabel();
			if( _infos.hasFailed() )
				label.textColor = 0xFF0000;
			dispose();
		}

		private function buildErrorItem() : void {
			_errItem = new TreeItem( );
			_errItem.setIcon( Picts.ERROR_ICO );
			_errItem.label.multiline = true;
			addSubitem( _errItem );
		}

		private function buildOutputItem() : void {
			_outItem = new TreeItem( );
			_outItem.setIcon( Picts.INFO_ICO );
			_outItem.label.multiline = true;
			addSubitem( _outItem );
		}
		
		private var _errItem : TreeItem;
		private var _outItem : TreeItem;
	}
}
