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


package fr.digitas.flowearth.ui.layout.utils {

	
	/**
	 * Fourni des option supplementaire a l'interpolation des item d'un Layout, lors de l'utilisation d'un InterpolatedRenderer.
	 * Doit (ou peut) etre implementé par un displayObject ajouté au Layout.
	 * 
	 * @author Pierre Lepers
	 * @see ILayoutItem
	 */
	public interface IInterpolable {
		
		/**
		 * pondere la durée de l'interpolation pour cet objet (peut etre 1 par defaut du coup)
		 */
		function get timeStretch() : Number;
		
		/**
		 * facultatif
		 * pour gerer specifiquement la progression de cet objet
		 */
		function setProgress( helper : AnimationHelper ) : Boolean;
	}
}
