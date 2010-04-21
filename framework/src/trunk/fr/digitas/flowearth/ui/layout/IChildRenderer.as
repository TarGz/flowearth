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


package fr.digitas.flowearth.ui.layout {
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;	

	/**
	 * Interface des objects qui gerent le placement des childrens dans un Layout
	 * 
	 * Peut dispatcher Event.CHANGE qui sera transféré au Layout (qui redispatch le CHANGE )
	 * 
	 * @author Pierre Lepers
	 */
	public interface IChildRenderer extends IEventDispatcher {

		
		function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void;

		function render( child : ILayoutItem ) : void;

		function getType( ) : String;
		
		function complete () : void;
		
		function get renderWidth() : Number;
		
		function get renderHeight() : Number;
		
	}
}
