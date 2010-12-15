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

package fr.digitas.flowearth.media.player.display {
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import fr.digitas.flowearth.media.player.event.MetaDataEvent;
	
	import fr.digitas.flowearth.core.ISizable;
	import fr.digitas.flowearth.media.player.display.MediaDisplay;	

	
	/**
	 * Sizable player display
	 * Background is requested for resize
	 * 
	 * @author Pierre Lepers, Romain Prache
	 */
	public class SizableDisplay extends MediaDisplay implements ISizable {


		public var background 		: Sprite;
		
		private var _mediaWidth		: Number;
		private var _mediaHeight	: Number;
		
		private var _width 			: Number;
		private var _height 		: Number;
		
		private var _aspectRatio 	: String = AspectRatio.NONE;
		
		
		public function get aspectRatio () : String {
			return _aspectRatio;
		}
		
		public function set aspectRatio (aspectRatio : String) : void {
			_aspectRatio = aspectRatio;
		}
		
		/**
		 * redefini la taille d'affichage en gardant les marge initiale 
		 */
		public function setSize(width : Number, height : Number) : void {
			getVideoHolder().width = width - videoMargins.th;
			getVideoHolder().height = height - videoMargins.tv;
			if( contentHolder ) contentHolder.width = width - containerMargins.th;
			if( contentHolder ) contentHolder.height = height - containerMargins.tv;
			if( background ) _width = background.width = width;
			if( background ) _height = background.height = height;
		}

		public function SizableDisplay() {
			super( );
			videoMargins = new Margins();
			containerMargins = new Margins( );			
			videoMargins.compute(background, videoHolder );
			videoMargins.compute(background, contentHolder );
			
			if(background)
			{
				_width 	= background.width;
				_height	= background.height;
			}
		}
		
		
		public function resize( evt : MetaDataEvent ) : void
		{			
			if ( !background ) return;
			
			_mediaWidth 	= evt.metadata.width;
			_mediaHeight	= evt.metadata.height;
			
			_width 			= background.width;
			_height			= background.height;
			
			scrollRect = new Rectangle( 0, 0, _width, _height );
			var w : Number, h : Number;
			
			var ratio : Number = _mediaWidth / _mediaHeight; 
			var RATIO : Number = _width / _height; 
			
			// NO RESIZE
			if ( aspectRatio == AspectRatio.NONE )
			{
				
				if ( videoHolder )
				{
					videoHolder.x = ( _width 	- _mediaWidth ) 	>> 1;
					videoHolder.y = ( _height 	- _mediaHeight ) 	>> 1;
				}
				
				if (contentHolder )
				{
					contentHolder.x = ( _width 	- _mediaWidth ) 	>> 1;
					contentHolder.y = ( _height 	- _mediaHeight ) 	>> 1;
				}
				
				
			// RESIZE & REPLACE	
			} else {
			
				var b : Boolean = ( _aspectRatio != AspectRatio.OUTSET );
			
				if( ratio > RATIO )
				{
					w = b ? _width : _height * ratio ;
					h = b ? _width / ratio : _height ;
					
				} else {
					
					w = b ? _height * ratio : _width;
					h = b ? _height : _width / ratio  ;
				}
				
				if ( videoHolder )
				{
					videoHolder.width 	= w;
					videoHolder.height 	= h;
					videoHolder.x = ( _width - w ) >> 1;
					videoHolder.y = ( _height - h ) >> 1;
				}
				
				if ( contentHolder ) 
				{
					contentHolder.width 	= w;
					contentHolder.height	= h;
					contentHolder.x = ( _width - w ) >> 1;
					contentHolder.y = ( _height - h ) >> 1
				}
			}
			
			
		
		}
		
		private var videoMargins 		: Margins;
		private var containerMargins 	: Margins;
	}
}

import flash.display.DisplayObject;
import flash.display.Sprite;

final class Margins {
	
	public var t : Number = 0;	
	public var l : Number = 0;	
	public var b : Number = 0;	
	public var r : Number = 0;
	
	public var th : Number = 0;
	public var tv : Number = 0;
	
	public function compute( bg : Sprite, subject : DisplayObject ) : void {
		if( ! bg || ! subject ) return;
		t = subject.y - bg.y;
		b = (subject.y+subject.height ) - ( bg.y + bg.height );
		l = subject.x - bg.x;
		b = (subject.x+subject.width ) - ( bg.x + bg.width );
		
		th = l + r;
		tv = t + b;
	}
}
