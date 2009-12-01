package fr.digitas.flowearth.ui.colorpicker {
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class TilesCanvas extends Sprite {
		
		public function TilesCanvas() {
			_build( );
		}
		
		private function _build() : void {
			_tiles = _buildTiles();
			
			var tile : Tile;
			var col : Array;
			for (var x : int = 0; x < 21; x++) {
				col = _tiles[ x ];
				for (var y : int = 0; y < 12; y++) {
					tile = col[y];
					tile.x = x*10;
					tile.y = y*10;
					addChild(tile);
				}
				
			}
		}

		private function _buildTiles() : Array {
			var res : Array = [];
			var i : int;
			
			for ( i = 0; i < 21; i++) 
				res.push( new Array( 12 ) );
			
			// left part, black and basics
			var bt1 : Array = res[0];
			var gs : Array = res[1];
			var bt2 : Array = res[2];
			
			var grey : Number;
			for ( i = 0; i < 12; i++) {
				grey = 25.5 * i;
				bt1[i] = new Tile( 0 );
				bt2[i] = new Tile( 0 ) ;
				gs[i] = new Tile( ColorUtils.getColor( grey , grey , grey ) );
			}
			
			
			// colors tiles
			var step : uint = 0x33;
			var r : uint, g : uint, b : uint, x : uint, y : uint, binc : uint;
			for ( i = 0; i < 216; i++) {
				binc = Math.floor( i/6 )%6;
				g = i%6 * step; 
				b = binc * step; 
				r = Math.floor( i/36 ) * step;
				x = i%6 + 6*( Math.floor( i/36 )%3 );
				y = binc + 6 * Math.floor( i/108 );
				res[ x + 3 ][ y ] = new Tile( ColorUtils.getColor( r , g , b ) );
			}
			
			return res;
		}
		
		private var _tiles : Array;
		
	}
}
