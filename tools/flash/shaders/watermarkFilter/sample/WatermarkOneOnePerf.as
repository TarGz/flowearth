package {
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.filters.ShaderFilter;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;		

	/**
	 * @author Pierre Lepers
	 */
	public class WatermarkOneOnePerf extends Sprite {

		public var mc : Sprite;
		
		private var shader : Shader; 
		private var loader : URLLoader; 


		public function WatermarkOneOnePerf() {
			init( ); 
		} 

		private function init() : void { 
            
			stage.align = StageAlign.TOP_LEFT;
             
			loader = new URLLoader( ); 
			loader.dataFormat = URLLoaderDataFormat.BINARY; 
			loader.addEventListener( Event.COMPLETE, onLoadComplete ); 
			loader.load( new URLRequest( "../WatermarkOneOneFilter.pbj" ) ); 
		} 

		private function onLoadComplete(event : Event) : void { 
			shader = new Shader( loader.data ); 
             
			addEventListener( Event.ENTER_FRAME, updateShaderFill );
			updateShaderFill( null ); 
		} 

		private function updateShaderFill(event : Event) : void { 
        	mc.rotation += .5;
        	
        	var filter : ShaderFilter = new ShaderFilter( shader );
        	
        	mc.filters = [ filter ];
        	
		} 
	}
}
