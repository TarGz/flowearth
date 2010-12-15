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


package fr.digitas.flowearth.media.player.controls 
{

	import flash.display.DisplayObject;
	import fr.digitas.flowearth.core.ISizable;
	import fr.digitas.flowearth.ui.controls.SeekBar;
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	import fr.digitas.flowearth.ui.controls.Slider;
	import fr.digitas.flowearth.ui.controls.ToggleButton;
	import fr.digitas.flowearth.ui.text.Label;

	
	/**
	 * IMediaControls ISizable pour le player ISizable, parce que je le vaut bien
	 * @see SizablePlayer;
	 * @author Pierre Lepers
	 */
	public class SizableControls extends BasicControls implements ISizable {

		
		/**
		 * replace les elements du Controls
		 */
		public function setSize(width : Number, height : Number) : void {
			if( background.width == width ) return;
			for each ( var zr : ZoningRegistering in _aZRegistering ) zr.setSize( width, height );
			background.width = width;
		}

		
		public function SizableControls() {
			super( );
		}

		override public function set playButton( pb : ToggleButton ) : void {
			super.playButton = pb;
			registerElement( pb );
		}

		override public function set rewindButton( rb : SimpleButton ) : void {
			super.rewindButton = rb;
			registerElement( rb );
		}

		/** @private */
		override public function set seekbar( sb : SeekBar ) : void {
			super.seekbar = sb;
			registerElement( sb );
		}

		/** @private */
		override public function set volumebar( vb : Slider ) : void {
			super.volumebar = vb;
			registerElement( vb );
		}
		
		/** @private */
		override public function set volumeButton( vb : ToggleButton ) : void {
			super.volumeButton = vb;
			registerElement( vb );
		}
		
		/** @private */
		override public function set timeInfoView(tiv : Label) : void {
			super.timeInfoView = tiv;
			registerElement( tiv );
		}
		
		/** @private */
		override public function set fullscreenButton( fs : ToggleButton) : void {
			super.fullscreenButton = fs;
			registerElement( fs );
		}

		
		public function registerElement( elem : DisplayObject ) : void {
			if( ! _aZRegistering ) _aZRegistering = new Array( );
			_aZRegistering.push( new ZoningRegistering( elem, background ) );
		}

		private var _aZRegistering : Array;
	}
}

import flash.display.DisplayObject;
import fr.digitas.flowearth.core.ISizable;


final class ZoningRegistering {

	
	public var margin : Number;
	
	public namespace leftalign 		= "fr.digitas.flowearth.media.player.controls.ZoningRegistering::leftalign";
	public namespace rightalign 	= "fr.digitas.flowearth.media.player.controls.ZoningRegistering::rightalign";
	public namespace centeralign 	= "fr.digitas.flowearth.media.player.controls.ZoningRegistering::centeralign";
	public namespace sizablealign 	= "fr.digitas.flowearth.media.player.controls.ZoningRegistering::sizablealign";

	public var alignNs : Namespace;

	function ZoningRegistering( elem : DisplayObject, ref : DisplayObject ) {
		
		if( ! ref ) throw new Error( "l'object SizableControls doit posseder un Sprite 'background' pour fonctionner" );
		
		_elem = elem; 
		
		if( elem is ISizable ) {
			margin = (elem.x + elem.width) - (ref.x + ref.width );
			alignNs = sizablealign;
		}
		
		//    |-------|-------|oooooo|
		else if(  elem.x > 2 * ref.width / 3 ) {
			margin = elem.x - ref.width;
			alignNs = rightalign;
		}
		//    |-------|oooooo|-------|
		else if (  elem.x > ref.width / 3 ) {
			margin = elem.x - ref.width / 2;
			alignNs = centeralign;
		}
		//    |oooooo|-------|-------|
		else {
			margin = 0;
			alignNs = leftalign;
		}
	}

	/**
	 * height non implementé
	 */
	public function setSize( width : Number, height : Number ) : void {
		alignNs::setSize( width );
	}

	leftalign 	 function setSize( width : Number ) : void {		
	}

	rightalign 	 function setSize( width : Number ) : void {		
		_elem.x = width + margin;
	}

	centeralign  function setSize( width : Number ) : void {		
		_elem.x = width / 2 + margin;
	}

	sizablealign function setSize( width : Number ) : void {
		(_elem as ISizable).setSize( width - _elem.x + margin, _elem.height );
	}

	
	private var _elem : DisplayObject;
}



