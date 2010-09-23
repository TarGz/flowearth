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
	import flash.net.URLVariables;

	/**
	 * Provide tools for URLVariables
	 * 
	 * @author Pierre Lepers
	 */
	public class VariablesTools
	{
		/**
		 * check if to URLVariables have strictely same values
		 * @return Boolean true if variables are equals.
		 */
		public static function equals( v1 : URLVariables, v2 : URLVariables ) : Boolean
		{
			if( v1 && v2 )
			{
				var c : int = 0;
				for (var p : String in v1)
				{
					c++;
					if( v2[ p ] != v1[ p ] )
					{
						return false;
					}
				}
				for ( p in v2 )
				{
					c--;
				}
				return c == 0;
			}
			else
			{
				if( v1 || v2 ) return false;
				else return true;
			}
		}

		/**
		 * concat values of 2 URLVAriables.
		 * note that if a variable exist in the 2 given URLVariables, the value of the first param is keep.
		 */
		public static function concat( v1 : URLVariables, v2 : URLVariables ) : URLVariables
		{
			if( !v1 && !v2 )
				return null;
			var res : URLVariables = new URLVariables();
			var p : String;
			if( v2 )
				for ( p in v2 )
					res[p] = v2[p];
			if( v1 )
				for ( p in v1 )
					res[p] = v1[p];
			return res;
		}
	}
}
