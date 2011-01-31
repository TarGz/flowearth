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


package fr.digitas.flowearth.utils
{
	/**
	 * outils pour manipuler des Array!
	 */
	public class ArrayTools
	{
		
		public static function duplicateArray( ar:Array ):Array{
			return new Array().concat( ar );
		}
		
		public static function getRandomElement( ar : Array ) : Object{
			return ar [ Random.range( 0 ,   ar.length - 1  ) ];
		}
		
		/**
		 * renvoi une copy inversée du tableau
		 */
		public static function revertArray( ar : Array ) : Array {
			var res : Array = new Array();
			var  l : int = ar.length;
			while( --l > -1 ) res.push( ar[l] );
			return res;
		}

		
		
		public static function shuffleArray(ar : Array) : Array {		
			var temp:Array = ArrayTools.duplicateArray(ar);
			var a:Array = new Array();
			
			while(temp.length > 0) a.push( temp.splice( Random.range(0, temp.length-1), 1)[0] );
			
			return a;
		}
		
	}
}
