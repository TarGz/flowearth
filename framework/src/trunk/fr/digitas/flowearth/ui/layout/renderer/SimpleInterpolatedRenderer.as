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


package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.renderer.InterpolatedRenderer;
	import fr.digitas.flowearth.ui.layout.utils.AnimationHelper;
	import fr.digitas.flowearth.ui.layout.utils.IInterpolable;
	
	import flash.display.DisplayObject;	

	/**
	 * class d'Exemple
	 * @author Pierre Lepers
	 */
	public class SimpleInterpolatedRenderer extends InterpolatedRenderer {

		
		public var xDecay : Number = 20;
		public var yDecay : Number = 20;

		public function SimpleInterpolatedRenderer (baseRenderer : ChildRenderer) {
			super( baseRenderer );
		}

		override protected function renderChildProgress ( proxy : AnimationHelper ) : void {
			var ownProgress : Number = proxy.getProgress();
			var _do : DisplayObject = proxy.original.getDisplay();
			if( _do is IInterpolable ) 
				if( ! ( _do as IInterpolable ).setProgress( proxy ) ) return;
			
			_do.y = ( yDecay == 0 ) ? proxy.y : easeOutQuad( ownProgress, proxy.y + yDecay, -yDecay, 1);
			_do.x = ( xDecay == 0 ) ? proxy.x : easeOutQuad( ownProgress, proxy.x + xDecay, -xDecay, 1);
			_do.alpha = ownProgress;
			
		}
		
		public static function easeOutQuad (t:Number, b:Number, c:Number, d:Number):Number {
			return -c *(t/=d)*(t-2) + b;
		}
	}
}

	