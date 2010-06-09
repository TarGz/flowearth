package {
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
	public class AngularGradientFill extends Sprite {
		
		private var canvas:Sprite; 
        private var shader:Shader; 
        private var loader:URLLoader; 
         
        private var topMiddle:Point; 
        private var bottomLeft:Point; 
        private var bottomRight:Point; 
         
        private var colorAngle:Number = 0.0; 
        private const d120:Number = 120 / 180 * Math.PI; // 120 degrees in radians 
         
         
		public function AngularGradientFill() {
		
            init(); 
        } 
         
        private function init():void 
        { 
            canvas = new Sprite(); 
            addChild(canvas); 
             
            var size:int = 400; 
            topMiddle = new Point(size / 2, 10); 
            bottomLeft = new Point(0, size - 10); 
            bottomRight = new Point(size, size - 10); 
             
            loader = new URLLoader(); 
            loader.dataFormat = URLLoaderDataFormat.BINARY; 
            loader.addEventListener(Event.COMPLETE, onLoadComplete); 
            loader.load(new URLRequest("../AngularGradientFill.pbj")); 
        } 
         
        private function onLoadComplete(event:Event):void 
        { 
            shader = new Shader(loader.data); 
             
            addEventListener(Event.ENTER_FRAME, updateShaderFill); 
        } 
         
        private function updateShaderFill(event:Event):void 
        { 
            colorAngle += .06; 
             
            var c1:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle); 
            var c2:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle + d120); 
            var c3:Number = 1 / 3 + 2 / 3 * Math.cos(colorAngle - d120); 
             
          	shader.data.color1.value = [1.0, 0, 0, 1.0]; 
          	shader.data.color2.value = [0, 1.0, 0, 1.0]; 
            shader.data.center.value = [mouseX, mouseY]; 
             
            canvas.graphics.clear(); 
            canvas.graphics.beginShaderFill(shader); 
             
            canvas.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight ); 
             
            canvas.graphics.endFill(); 
        } 
	}
}
