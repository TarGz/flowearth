package {
	import flash.events.MouseEvent;	
	import flash.display.BlendMode;	
	import flash.display.MovieClip;	
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;	

	/**
	 * @author Pierre Lepers
	 */
	public class ReduceBlend extends Sprite {
		
        private var shader:Shader; 
        private var loader:URLLoader;
        
		public var blendMc : MovieClip; 

		
		
		public function ReduceBlend() {
		
            init(); 
        } 
         
        private function init():void 
        { 
            loader = new URLLoader(); 
            loader.dataFormat = URLLoaderDataFormat.BINARY; 
            loader.addEventListener(Event.COMPLETE, onLoadComplete); 
            loader.load(new URLRequest("../ReduceBlend.pbj")); 
        } 
         
        private function onLoadComplete(event:Event):void 
        { 
            shader = new Shader(loader.data); 
             
            blendMc.blendMode = BlendMode.SHADER;
            blendMc.blendShader = shader;
            
			blendMc.addEventListener( MouseEvent.MOUSE_DOWN, dragMc );
		}
		
		private function dragMc(event : MouseEvent) : void {
			stage.addEventListener( MouseEvent.MOUSE_UP, stopD );
			blendMc.startDrag();
		}

		private function stopD(event : MouseEvent) : void {
			blendMc.stopDrag();
		} 
	}
}
