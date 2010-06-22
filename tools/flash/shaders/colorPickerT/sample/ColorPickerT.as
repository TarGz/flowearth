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
	public class ColorPickerT extends Sprite {
		
		private var canvas:Sprite; 
        private var shader:Shader; 
        private var loader:URLLoader; 
         
         
		public function ColorPickerT() {
		
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
            loader.load(new URLRequest("../ColorPickerT.pbj")); 
        } 
         
        private function onLoadComplete(event:Event):void 
        { 
            shader = new Shader(loader.data); 
             
            addEventListener( Event.ENTER_FRAME, updateShaderFill);
            updateShaderFill( null ); 
        } 
         
        private function updateShaderFill(event:Event):void 
        { 
        	
             
          	shader.data.color.value = ShaderUtils.colorToVector( ShaderUtils.getTint( stage.mouseY / stage.stageHeight * 360 ) );
          	
			shader.data.size.value = [ stage.stageWidth, stage.stageHeight ]; 
           
          	
             
            canvas.graphics.clear(); 
            canvas.graphics.beginShaderFill(shader); 
            canvas.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight ); 
            canvas.graphics.endFill(); 
        } 
	}
}
