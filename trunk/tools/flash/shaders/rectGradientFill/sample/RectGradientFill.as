package {
	import flash.geom.Matrix;	
	import flash.geom.Point;	

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

		private var canvas : Sprite; 
		private var shader : Shader; 
		private var loader : URLLoader; 

		private var size : Point = new Point( 200, 300 );
		private var b : Point = new Point( 128, 128 );

		public function RectGradientFill() {
		
			init( ); 
		} 

		private function init() : void { 
			canvas = new Sprite( ); 
			addChildAt( canvas, 0 );
			
            
            
			stage.align = StageAlign.TOP_LEFT;
             
			loader = new URLLoader( ); 
			loader.dataFormat = URLLoaderDataFormat.BINARY; 
			loader.addEventListener( Event.COMPLETE, onLoadComplete ); 
			loader.load( new URLRequest( "../RectGradientFill.pbj" ) ); 
		} 

		private function onLoadComplete(event : Event) : void { 
			shader = new Shader( loader.data ); 
             
			addEventListener( Event.ENTER_FRAME, updateShaderFill );
			updateShaderFill( null ); 
		} 

		private function updateShaderFill(event : Event) : void { 
        	
        	b.y = b.x = mouseX / 5;
        	
			//trace( "RectGradientFill - updateShaderFill -- " );
			//angle += .06;
			
			canvas.x = 100 - b.x/2;
			canvas.y = 130 - b.y/2;
			
			var s : Point = size.clone();
			s.offset( - b.x, - b.y );
            
            
            
            
            
             
			shader.data.size.value = [ s.x, s.y ];
          	
			shader.data.dist.value = [ b.x, b.y ]; 
           
          	
             
			canvas.graphics.clear( ); 
			var m : Matrix = new Matrix( 1, 0, 0, 1, b.x, b.y );
			canvas.graphics.beginShaderFill( shader, m );
			canvas.graphics.drawRect( 0, 0, stage.stageWidth, stage.stageHeight ); 
			canvas.graphics.endFill( ); 
		} 
	}
}
