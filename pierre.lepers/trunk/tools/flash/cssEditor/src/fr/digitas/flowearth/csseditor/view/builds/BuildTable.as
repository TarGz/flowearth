package fr.digitas.flowearth.csseditor.view.builds {
	import fr.digitas.flowearth.csseditor.data.compiler.buildsProvider;
	import fr.digitas.flowearth.process.BuildInfos;
	import fr.digitas.flowearth.process.BuildInfosEvent;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class BuildTable extends Sprite {

		public var bg : Sprite;

		public function BuildTable() {
			_buildLayout( );
			
			addEventListener( Event.ADDED_TO_STAGE , onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
		}

		private function onAdded( e : Event ) : void {
			
			_itemMap = new Dictionary( );
			buildsProvider.getHistory( ).addEventListener( BuildInfosEvent.BUILD_ADDED , onBuildAdded );
			buildsProvider.getHistory( ).addEventListener( BuildInfosEvent.BUILD_REMOVED , onBuildRemoved );
			_initialBuild( );
		}

		
		private function onRemoved( e : Event ) : void {
			buildsProvider.getHistory( ).removeEventListener( BuildInfosEvent.BUILD_ADDED , onBuildAdded );
			buildsProvider.getHistory( ).removeEventListener( BuildInfosEvent.BUILD_REMOVED , onBuildRemoved );
			_itemMap = null;
			while( _layout.numChildren > 0 )
				_layout.removeChildAt( 0 );
		}

		private function _initialBuild() : void {	
			var builds : Vector.<BuildInfos> = buildsProvider.getHistory( ).getBuilds( );
			var renderer : BuildItem;
			
			for each (var item : BuildInfos in builds) {
				
				if( _itemMap[ item ] != undefined ) continue;
				
				renderer = new BuildItem( );
				renderer.init( item );
				_itemMap[ item ] = renderer;
				_layout.addChild( renderer );
			}
			_layout.update( );
		}

		
		override public function set width(value : Number) : void {
			_layout.width = value;
			_layout.update( );
		}

		override public function set height(value : Number) : void {
			_layout.height = value;
			_layout.update( );
		}

		private function onBuildAdded(event : BuildInfosEvent) : void {
			
			var item : BuildInfos = event.infos;
			var renderer : BuildItem = new BuildItem( );
			renderer.init( item );
			_itemMap[ item ] = renderer;
			_layout.addChild( renderer );
			
		}

		
		private function onBuildRemoved(event : BuildInfosEvent) : void {
			var item : BuildInfos = event.infos;
			var renderer : BuildItem = _itemMap[ item ] as BuildItem;
			if( renderer ) {
				delete _itemMap[ item ];
				_layout.removeChild( renderer );
			}
		}

		
		
		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new TopJustifyRenderer( );
			addChild( _layout );
		}

		
		private var _itemMap : Dictionary;

		private var _layout : Layout;
	}
}
