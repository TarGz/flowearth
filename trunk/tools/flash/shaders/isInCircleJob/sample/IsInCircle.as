package {
	import fr.digitas.flowearth.debug.FPS;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display.ShaderJob;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author plepers
	 */
	public class IsInCircle extends Sprite {

//		private static const MAX_PARTICLES : int = 500000;
		private static const MAX_PARTICLES : int = 10000;

		public function IsInCircle () {
			
			
			_buildParticles( );
			_initPArticles( );
			_pDatas = _createPbData( );
			_result = new ByteArray();
			_loadShader();
			
			addChild( _debugdisplay = new Bitmap( new BitmapData( 800, 800, false, 0 ) ) );
			addChild( new FPS );
			
			dShape = new Shape();
			addChild( dShape );
		}

		
		
		//_____________________________________________________________________________
		//																		LOADING
		private function _loadShader () : void {
			var loader : URLLoader = new URLLoader( ); 
			loader.dataFormat = URLLoaderDataFormat.BINARY; 
			loader.addEventListener( Event.COMPLETE, onLoadComplete ); 
			loader.load( new URLRequest( "../IsInCircleJobF.pbj" ) ); 
		} 

		private function onLoadComplete (event : Event) : void { 
			var loader : URLLoader = event.currentTarget as URLLoader;
			loader.removeEventListener( Event.COMPLETE, onLoadComplete ); 
			shader = new Shader( loader.data );
			shader.data.src.width = dims.x;
			shader.data.src.height = dims.y;
			shader.data.src.input = _pDatas;
             
			addEventListener( Event.ENTER_FRAME, compute ); 
			stage.addEventListener( MouseEvent.CLICK, compute ); 
		} 


		//_____________________________________________________________________________
		//																  RUN SHADERJOB
		
		private function compute (event : Event) : void {
			shader.data.center.value = [ mouseX, mouseY ];
			shader.data.radius.value = [ 100.0 ];
			
			_result.position = 0;
			var job : ShaderJob = new ShaderJob( shader, _result, dims.x, dims.y );
			job.start( true );
			handleResults( );
		}

		private function handleResults () : void {
			
			var bmp:  BitmapData = _debugdisplay.bitmapData;
			bmp.fillRect( bmp.rect, 0xFFFFFF);
			dShape.graphics.clear( );
			dShape.graphics.lineStyle( 1, 0xAAAAAA, .1 );
			
			_result.position = 0;
//			trace( _pDatas.length );
//			trace( _result.bytesAvailable );
			var dist : Number;
			var angle : Number;
			var isInRadius : Number;
			var c : int = 0;
			
			while( c < MAX_PARTICLES-1 ) {
				
//				trace( "---part---"+c );
//				trace(  _particles[c].x, _particles[c].y );
//				
				angle = _result.readFloat( );
				isInRadius = _result.readFloat( );
				dist = _result.readFloat();
				
				
				
				_result.readFloat();
//				trace( "dist	: " + dist );
//				trace( "angle	: " + angle );
//				trace( "isInval	: " + isInRadius );
//				trace( _result.bytesAvailable );
				bmp.lock();
				
				if( isInRadius > 0 ) {
					dShape.graphics.moveTo( mouseX, mouseY );
					dShape.graphics.lineTo( mouseX + dist *Math.sin( angle ), mouseY+ dist *Math.cos( angle ) );
					bmp.setPixel( _particles[c].x, _particles[c].y, 0 );
				}
				
				bmp.unlock();
					
				c++;
			}
		}

		
		
		
		//_____________________________________________________________________________
		//																	  PARTICLES


		private function getSize ( num : uint ) : Point {
			var sqrt : Number = Math.sqrt( num );
			sqrt = Math.ceil( sqrt );
			return new Point( sqrt, sqrt );
			//return new Point( Math.ceil( num/2 ), 2 );
		}


		private function _buildParticles () : void {
			_particles = new Vector.<Particle>( MAX_PARTICLES, true );
			
			var numParticles : int = MAX_PARTICLES;
			
			while( --numParticles > -1 ) {
				_particles[ numParticles ] = new Particle( );
			}
		}

		private function _initPArticles () : void {
			var scale : Number = 800;
			
			var numParticles : int = MAX_PARTICLES;
			
			while( --numParticles > -1 ) {
				_particles[ numParticles ].x = Math.random( ) * scale;
				_particles[ numParticles ].y = Math.random( ) * scale;
			}
			
		}

		private function _createPbData () : ByteArray {
			var ba : ByteArray = new ByteArray( );
			
			
			var numParticles : int = MAX_PARTICLES;
			
			for (var i : int = 0; i < numParticles; i++) {
				//ba.writeFloat( _particles[ i ].x );
				ba.writeFloat( _particles[ i ].x ); //--
				ba.writeFloat( _particles[ i ].y ); //--
				//ba.writeFloat( _particles[ i ].x );
			}

			dims = getSize( MAX_PARTICLES );
			
			var rest : int = dims.x * dims.y - MAX_PARTICLES;
			trace( rest );
			while( --rest > -1 ){
				//trace( "mlk" );
				//ba.writeFloat( 0.0 );
				ba.writeFloat( 0.0 );
				ba.writeFloat( 0.0 );
				//ba.writeFloat( 0.0 );
			}
			
			
			return ba;
		}
		
		
		private var dims : Point;

		private var shader : Shader;
		
		private var _pDatas : ByteArray;

		private var _result : ByteArray;

		private var _particles : Vector.<Particle>;
		
		private var _debugdisplay : Bitmap;
		
		
		private var dShape : Shape;
	}
}

class Particle {

	internal var x : Number;
	internal var y : Number;

}
