/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */


package fr.digitas.flowearth.utils {
	import flash.display.Graphics;
	import flash.geom.Point;	

	/**
	 * Methodes static pour tracer des arc de cercle et des arc de rectangle 
	 * 
	 * @author Pierre Lepers
	 */
	public class GraphicTools {

		
		public static function drawRectSegment( g : Graphics , w : Number, h : Number, startAngle : Number , endAngle : Number, x : Number = 0, y : Number = 0, unit : String = "radians") : void {
			
			
			while( startAngle < - Math.PI ) startAngle += Math.PI * 2;
			while( startAngle > Math.PI ) startAngle -= Math.PI * 2;
			
			while( endAngle < - Math.PI ) endAngle += Math.PI * 2;
			while( endAngle > Math.PI ) endAngle -= Math.PI * 2;
			
			if( unit == "degrees") {
				startAngle = startAngle / 180 * Math.PI ;
				endAngle = endAngle / 180 * Math.PI ;
			}
			
			var startPoint : Point = getRectPoint( startAngle , w , h );
			var endPoint : Point = getRectPoint( endAngle , w , h );
			
			var srtInd : Number = getRectCate( startAngle );
			var endInd : Number = getRectCate( endAngle );
			
			var anglesTblX : Array = new Array( w , - w , - w , w );
			var anglesTblY : Array = new Array( h , h , - h , - h );
			
			
			g.moveTo( startPoint.x + x , startPoint.y + y );
			
			for (var i : Number = srtInd; i < 10 ; i ++) {
				if( i == 4 ) i = 0 ;
				if(endInd == i) {
					g.lineTo( endPoint.x + x , endPoint.y + y );
					break;
				} else {
					g.lineTo( anglesTblX[i] / 2 + x , anglesTblY[i] / 2 + y );
				}
			}
		}

		public static function fillRoundedCircleSegment( g : Graphics, radius1 : Number, radius2 : Number, startAngle : Number, endAngle : Number, round : Number = 0, x : Number = 0, y : Number = 0 , unit : String = "radians") : void {
			
			
			
			var mra1 : Number = round / radius1;
			var mra2 : Number = round / radius2;
			
			if(unit == "degrees") {
				startAngle = startAngle / 180 * Math.PI ;
				endAngle = endAngle / 180 * Math.PI ;
			}
			
			var angle1 : Number = startAngle + mra1;
			var angle2 : Number = startAngle + mra2;
			var endAngle1 : Number = endAngle - mra1;
			var endAngle2 : Number = endAngle - mra2;
			var angleMid : Number;
			var arc1 : Number = endAngle1 - angle1;
			var arc2 : Number = endAngle2 - angle2;
			while( arc1 < 0 ) arc1 += Math.PI * 2;
			while( arc2 < 0 ) arc2 += Math.PI * 2;
			var segs1 : Number = Math.ceil( arc1 / ( Math.PI / 4 ) );
			var segs2 : Number = Math.ceil( arc2 / ( Math.PI / 4 ) );
			var segAngle1 : Number = - arc1 / segs1;
			var segAngle2 : Number = - arc2 / segs2;
			var theta1 : Number = - segAngle1 * .5;
			var theta2 : Number = - segAngle2 * .5;
			var cosTheta1 : Number = Math.cos( theta1 );
			var cosTheta2 : Number = Math.cos( theta2 );
			var bx : Number;
			var by : Number;
			var cx : Number;
			var cy : Number;
			var i : Number;

			var ax1a : Number = Math.cos( angle1 ) * radius1 ;
			var ay1a : Number = Math.sin( angle1 ) * radius1 ;
			var ax1c : Number = Math.cos( angle1 - mra1 ) * radius1 ;
			var ay1c : Number = Math.sin( angle1 - mra1 ) * radius1 ;
			var ax1b : Number = Math.cos( angle1 - mra1 ) * ( radius1 + round );
			var ay1b : Number = Math.sin( angle1 - mra1 ) * ( radius1 + round );
			
			var ax2a : Number = Math.cos( angle2 - mra2 ) * ( radius2 - round );
			var ay2a : Number = Math.sin( angle2 - mra2 ) * ( radius2 - round );
			var ax2c : Number = Math.cos( angle2 - mra2 ) * radius2 ;
			var ay2c : Number = Math.sin( angle2 - mra2 ) * radius2 ;
			var ax2b : Number = Math.cos( angle2 ) * radius2 ;
			var ay2b : Number = Math.sin( angle2 ) * radius2 ;
			
			g.moveTo( ax1a + x , ay1a + y );
			g.curveTo( ax1c + x , ay1c + y , ax1b + x , ay1b + y );
			
			g.lineTo( ax2a + x , ay2a + y );
			g.curveTo( ax2c + x , ay2c + y , ax2b + x , ay2b + y );
			
			
			for( i = 0 ; i < segs2 ; i ++ ) {
				angle2 += theta2 * 2;
				angleMid = angle2 - theta2;
				bx = x + Math.cos( angle2 ) * radius2;
				by = y + Math.sin( angle2 ) * radius2;
				cx = x + Math.cos( angleMid ) * ( radius2 / cosTheta2 );
				cy = y + Math.sin( angleMid ) * ( radius2 / cosTheta2 );
				g.curveTo( cx , cy , bx , by );
			}
			
			
			
			
			ax1a = Math.cos( endAngle1 ) * radius1 ;
			ay1a = Math.sin( endAngle1 ) * radius1 ;
			ax1c = Math.cos( endAngle1 + mra1 ) * radius1 ;
			ay1c = Math.sin( endAngle1 + mra1 ) * radius1 ;
			ax1b = Math.cos( endAngle1 + mra1 ) * ( radius1 + round );
			ay1b = Math.sin( endAngle1 + mra1 ) * ( radius1 + round );
			
			ax2a = Math.cos( endAngle2 + mra2 ) * ( radius2 - round );
			ay2a = Math.sin( endAngle2 + mra2 ) * ( radius2 - round );
			ax2c = Math.cos( endAngle2 + mra2 ) * radius2 ;
			ay2c = Math.sin( endAngle2 + mra2 ) * radius2 ;
			
			g.curveTo( ax2c + x , ay2c + y , ax2a + x , ay2a + y );
			g.lineTo( ax1b + x , ay1b + y );
			g.curveTo( ax1c + x , ay1c + y , ax1a + x , ay1a + y );
			
			angle1 = endAngle1;
			
			for( i = segs1 - 1 ; i > - 1 ; i -- ) {
				angle1 -= theta1 * 2;
				angleMid = angle1 + theta1;
				bx = x + Math.cos( angle1 ) * radius1;
				by = y + Math.sin( angle1 ) * radius1;
				cx = x + Math.cos( angleMid ) * ( radius1 / cosTheta1 );
				cy = y + Math.sin( angleMid ) * ( radius1 / cosTheta1 );
				g.curveTo( cx , cy , bx , by );
			}
		}

		
		
		public static function drawCircleSegment( g : Graphics, radius : Number, startAngle : Number, endAngle : Number, x : Number = 0, y : Number = 0, unit : String = "radians") : void {
			if(unit == "degrees") {
				startAngle = startAngle / 180 * Math.PI ;
				endAngle = endAngle / 180 * Math.PI ;
			}
			
			var segAngle : Number = Math.PI / 4;
			var angle : Number = startAngle;
			var angleMid : Number;
			var arc : Number = endAngle - angle;
			if( arc == 0 ) return;
			while( arc < 0 ) arc += Math.PI * 2;
			var segs : Number = Math.ceil( arc / segAngle );
			var rest : Number = segAngle - ( segs * segAngle ) + arc;
			var theta : Number = segAngle * .5;
			var cosTheta : Number = Math.cos( theta );
			var ax : Number = Math.cos( angle ) * radius;
			var ay : Number = Math.sin( angle ) * radius;
			var bx : Number, by : Number, cx : Number, cy : Number;
			
			g.moveTo( ax + x , ay + y );
			for( var i : Number = 0 ; i < segs - 1 ; i ++ ) {
				angle += theta * 2;
				angleMid = angle - theta;
				bx = x + Math.cos( angle ) * radius;
				by = y + Math.sin( angle ) * radius;
				cx = x + Math.cos( angleMid ) * ( radius / cosTheta );
				cy = y + Math.sin( angleMid ) * ( radius / cosTheta );
				g.curveTo( cx , cy , bx , by );
			}
			angle += rest;
			angleMid = angle - rest / 2;
			bx = x + Math.cos( angle ) * radius;
			by = y + Math.sin( angle ) * radius;
			cx = x + Math.cos( angleMid ) * ( radius / Math.cos( rest / 2 )  );
			cy = y + Math.sin( angleMid ) * ( radius / Math.cos( rest / 2 ) );
			g.curveTo( cx , cy , bx , by );
		}

		public static function fillCircleSegment( g : Graphics, radius1 : Number, radius2 : Number, startAngle : Number, endAngle : Number, x : Number = 0, y : Number = 0) : void {
			var segAngle : Number = Math.PI / 4;
			var angle : Number = startAngle;
			var angleMid : Number, bx : Number, by : Number, cx : Number, cy : Number, i : Number;
			var arc : Number = endAngle - angle;
			if( arc == 0 ) return;
			while( arc < 0 ) arc += Math.PI * 2;
			var segs : Number = Math.ceil( arc / segAngle );
			var rest : Number = segAngle - ( segs * segAngle ) + arc;
			var theta : Number = segAngle * .5;
			var cosTheta : Number = Math.cos( theta );
			var ax1 : Number = Math.cos( angle ) * radius1;
			var ay1 : Number = Math.sin( angle ) * radius1;
			var ax2 : Number = Math.cos( angle ) * radius2;
			var ay2 : Number = Math.sin( angle ) * radius2;
			g.moveTo( ax1 + x , ay1 + y );
			g.lineTo( ax2 + x , ay2 + y );
			
			for( i = 0 ; i < segs - 1 ; i ++ ) {
				angle += segAngle;
				angleMid = angle - theta;
				bx = x + Math.cos( angle ) * radius2;
				by = y + Math.sin( angle ) * radius2;
				cx = x + Math.cos( angleMid ) * ( radius2 / cosTheta );
				cy = y + Math.sin( angleMid ) * ( radius2 / cosTheta );
				g.curveTo( cx , cy , bx , by );
			}
			
			angle += rest;
			angleMid = angle - rest / 2;
			bx = x + Math.cos( angle ) * radius2;
			by = y + Math.sin( angle ) * radius2;
			cx = x + Math.cos( angleMid ) * ( radius2 / Math.cos( rest / 2 )  );
			cy = y + Math.sin( angleMid ) * ( radius2 / Math.cos( rest / 2 ) );
			g.curveTo( cx , cy , bx , by );
			
			ax1 = Math.cos( endAngle ) * radius1;
			ay1 = Math.sin( endAngle ) * radius1;
			g.lineTo( ax1 + x , ay1 + y );
			
			angle -= rest;
			bx = x + Math.cos( angle ) * radius1;
			by = y + Math.sin( angle ) * radius1;
			cx = x + Math.cos( angleMid ) * ( radius1 / Math.cos( rest / 2 )  );
			cy = y + Math.sin( angleMid ) * ( radius1 / Math.cos( rest / 2 ) );
			g.curveTo( cx , cy , bx , by );
			
			for( i = segs - 2 ; i > - 1 ; i -- ) {
				angle -= theta * 2;
				angleMid = angle + theta;
				bx = x + Math.cos( angle ) * radius1;
				by = y + Math.sin( angle ) * radius1;
				cx = x + Math.cos( angleMid ) * ( radius1 / cosTheta );
				cy = y + Math.sin( angleMid ) * ( radius1 / cosTheta );
				g.curveTo( cx , cy , bx , by );
			}
		}

		
		private static function getRectPoint(angle : Number, w : Number, h : Number) : Point {
			var point : Point = new Point( );
			var absangle : Number = ( angle < 0 ) ? - angle : angle;
			var sign : Number = angle / absangle;
			
			if(absangle >= Math.PI / 4 && absangle <= 3 * (Math.PI / 4)) {
				point.y = h / 2 * sign;
				point.x = ( point.y / Math.sin( angle ) ) * Math.cos( angle ) / (h / w);
			}
			else if (absangle < Math.PI / 4) {
				point.x = w / 2;
				point.y = ( point.x / Math.cos( angle ) ) * Math.sin( angle ) / (w / h);
			} else {
				point.x = - w / 2;
				point.y = ( point.x / Math.cos( angle ) ) * Math.sin( angle ) / (w / h);
			}
			
			return point;
		}

		private static function getRectCate(angle : Number) : Number {
			angle = (angle > 0 ) ? angle : 2 * Math.PI + angle;
			var n : Number = Math.floor( (angle + Math.PI / 4 ) / (Math.PI * .5) ) ;
			if( n == 4) n = 0;
			return n;
		}
	}
}
