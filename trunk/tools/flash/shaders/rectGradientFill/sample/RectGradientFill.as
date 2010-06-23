package {
	import fr.digitas.flowearth.shaders.ShaderUtils;
	
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;	

	/**
	 * @author Pierre Lepers
	 */
	public class RectGradientFill extends Sprite {
		
		private var canvas:Sprite; 
        private var shader:Shader; 
        private var loader:URLLoader; 
         
         
		public function RectGradientFill() {
		
            init(); 
        } 
         
        private function init():void 
        { 
            canvas = new Sprite(); 
            addChild(canvas);
            
            
            stage.align = StageAlign.TOP_LEFT;
             
            loader = new URLLoader(); 
            loader.dataFormat = URLLoaderDataFormat.BINARY; 
            loader.addEventListener(Event.COMPLETE, onLoadComplete); 
            loader.load(new URLRequest("../RectGradientFill.pbj")); 
        } 
         
        private function onLoadComplete(event:Event):void 
        { 
            shader = new Shader(loader.data); 
             
            addEventListener( Event.ENTER_FRAME, updateShaderFill);
            updateShaderFill( null ); 
        } 
         
        private function updateShaderFill(event:Event):void 
        { 
        	
        	//trace( "RectGradientFill - updateShaderFill -- " );
            //angle += .06; 
             
          	shader.data.rect.value= [ 12, 12, 150, 100 ];
          	
			shader.data.dist.value = [ 12, 12 ]; 
           
          	
             
            canvas.graphics.clear(); 
            canvas.graphics.beginShaderFill(shader); 
            canvas.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight ); 
            canvas.graphics.endFill(); 
        } 
	}
}
