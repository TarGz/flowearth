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


package fr.digitas.flowearth.ui.scroller {
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;	

	/**
	 * Element Ascensceur d'un scrollBar
	 * 
	 * @see ScrollBar
	 * @author Pierre Lepers
	 */	public class Ascenseur extends SimpleButton
	{
		
		public var ico : Sprite;
		
		public function Ascenseur()
		{
			super();
			if( scale9Grid == null )
				setScale9( );
		}
		
		public function setHeight( val : Number ) : void {
			realHeight = val;
			val = Math.max( val, 8 );
			height = val;
			if( ico ) {
				ico.scaleY = 1/scaleY;
				ico.visible = ( val > 12 );
			}
		}

		public var realHeight : Number; 
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function setScale9() : void {
			var x : Number = Math.min( width/3 , 3 );
			var y : Number = Math.min( height/3 , 3 );
			var b : Rectangle = getBounds( this );
			b.inflate( -x, -y );
			scale9Grid = b;				
		}
		
	}
}