package {
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**
	 * @author Pierre Lepers
	 */
	public class MappedAngularGradientFill extends Sprite {
		
		private var canvas:Sprite; 
        private var shader:Shader; 
        private var loader:URLLoader; 
         
        private var angle:Number = 5.0; 
        
        private var map : BitmapData;
        
        public var mapMc : Sprite;
         
		public function MappedAngularGradientFill() {
		
            init(); 
        } 
         
        private function init():void 
        { 
        	map = new BitmapData( mapMc.width, mapMc.height, true );
        	map.draw( mapMc );
        	
            canvas = new Sprite(); 
            addChild(canvas); 
             
             
            loader = new URLLoader(); 
            loader.dataFormat = URLLoaderDataFormat.BINARY; 
            loader.addEventListener(Event.COMPLETE, onLoadComplete); 
            loader.load(new URLRequest("../MappedAngularGradientFill.pbj")); 
        } 
         
        private function onLoadComplete(event:Event):void 
        { 
            shader = new Shader(loader.data); 
             
            addEventListener(Event.ENTER_FRAME, updateShaderFill); 
        } 
         
        private function updateShaderFill(event:Event):void 
        { 
        	
        	
            //angle += .06; 
             
          	shader.data.map.input = map; 
          	shader.data.mapsize.value = [ map.width ]; 
           
          	var m : Matrix = new Matrix();
          	
          	m.rotate( angle );
          	m.translate( mouseX, mouseY );
             
            canvas.graphics.clear(); 
            canvas.graphics.beginShaderFill(shader, m); 
             
            canvas.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight ); 
             
            canvas.graphics.endFill(); 
        } 
	}
}
