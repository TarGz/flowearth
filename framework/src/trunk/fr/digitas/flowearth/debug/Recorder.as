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


package fr.digitas.flowearth.debug {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;	

	/**
	 * Enregistre une sequence video d'un zone de l'ecran et la rejouer a differentes vitesses. Impec pour affiner les animations.
	 * 
	 * Recorder n'enregistre les images que si elles sont differente de la precedente.
	 * Ajouter simplement une instance sur la scene puis (ctrl+SPACE pour lancer, ENTER pour enregistrer, ESC pour sortir )
	 * 
	 * @author Pierre Lepers
	 */
	public class Recorder extends Sprite {
		
		private static const FRAME_SHORTCUT : int = Keyboard.SPACE;
		private static const REC_SHORTCUT 	: int = Keyboard.ENTER;
		private static const EXIT_SHORTCUT 	: int = Keyboard.ESCAPE;
		
		public static var BG_COLOR : uint;
		
		public function Recorder ( bgColor : uint = 0xffffff ) {
			BG_COLOR = bgColor;
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
		
		private function onAdded (e : Event) : void {
			_stage = stage;
			_stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown );
		}

		private function onRemoved (e : Event) : void {
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDown );
			_stage = null;
		}
		

		
		
		private function keyDown ( e : KeyboardEvent ) : void {
			switch ( e.keyCode ) {
				case FRAME_SHORTCUT :
					if( ! e.ctrlKey )  break;
					if( _recFrame ) killFrame();
					else startFraming();
					break;
				case REC_SHORTCUT :
					if( _readyToRec )
						startRecord();
					else if( _readyToPlay ) {
						playback();
					}
					break;
				case EXIT_SHORTCUT :
					killPrevious();
					if( _recFrame ) killFrame();
					break;
			}
		}
		
		//_____________________________________________________________________________
		//																	FRAME BUILD
		
		private function buildFrame() : void {
			if( _recFrame ) killFrame();
			addChild( _recFrame = new RectFrame( ) );
		}

		private function killFrame() : void {
			removeChild( _recFrame );
			_recFrame = null;
			_readyToRec = false;
		}
		
		private function startFraming () : void {
			killPrevious();
			buildFrame();
			_stage.addEventListener( MouseEvent.MOUSE_DOWN, fbMouseDown );
		}
		
		private function killPrevious () : void {
			if( _playback ) {
				removeChild( _playback );
				_playback = null;	
			}
			if( _camCorder ) {
				_camCorder.cancel();	
			}
		}

		private function fbMouseDown (event : MouseEvent) : void {
			_stage.removeEventListener( MouseEvent.MOUSE_DOWN, fbMouseDown );
			_stage.addEventListener( MouseEvent.MOUSE_MOVE, fbMouseMove );
			_stage.addEventListener( MouseEvent.MOUSE_UP, fbMouseUp );
			_recFrame.x1 = _stage.mouseX;
			_recFrame.y1 = _stage.mouseY;
			_recFrame.x2 = _stage.mouseX;
			_recFrame.y2 = _stage.mouseY;
		}
		
		private function fbMouseUp (event : MouseEvent) : void {
			_stage.removeEventListener( MouseEvent.MOUSE_MOVE, fbMouseMove );
			_stage.removeEventListener( MouseEvent.MOUSE_UP, fbMouseUp );
			_recFrame.x2 = _stage.mouseX;
			_recFrame.y2 = _stage.mouseY;
			_readyToRec = true;
		}

		private function fbMouseMove (event : MouseEvent) : void {
			_recFrame.x2 = _stage.mouseX;
			_recFrame.y2 = _stage.mouseY;
		}

		
		
		//_____________________________________________________________________________
		//																		 RECORD
		
		private function startRecord () : void {
			_readyToRec = false;
			_recFrame.setRecMode();
			_camCorder = new CamCorder( _recFrame.rect, _stage );
			_readyToPlay = true;
			_camCorder.startRecord();
			_readyToRec = false;
			_readyToPlay = true;
		}

		private function playback() : void {
			killFrame();
			_camCorder.stopRecord();
			addChild( _playback = new PlayBack( _camCorder ) );
			_camCorder.dispose();
			_camCorder = null;
			_readyToPlay = false;
			
		}
		
		private var _recFrame : RectFrame;
		private var _camCorder : CamCorder;
		private var _playback : PlayBack;

		private var _stage : Stage;
		private var _readyToPlay : Boolean = false;
		private var _readyToRec : Boolean = false;
	}
}

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFormat;

//_____________________________________________________________________________
//																		RECTFRAME

//		RRRRR   EEEEEEE  CCCCC  TTTTTT FFFFFF RRRRR     AAA   MM   MM EEEEEEE 
//		RR  RR  EE      CC   CC   TT   FF     RR  RR   AAAAA  MMM MMM EE      
//		RRRRR   EEEE    CC        TT   FFFF   RRRRR   AA   AA MMMMMMM EEEE    
//		RR  RR  EE      CC   CC   TT   FF     RR  RR  AAAAAAA MM M MM EE      
//		RR   RR EEEEEEE  CCCCC    TT   FF     RR   RR AA   AA MM   MM EEEEEEE



class RectFrame extends Sprite {
	

	public function set x1( val : Number ) : void {
		_recFrame.left = val;
		redraw();
	}
	public function get x1( ) : Number {
		return _recFrame.left;
	}

	public function set y1( val : Number ) : void {
		_recFrame.top = val;
		redraw();
	}
	public function get y1( ) : Number {
		return _recFrame.top;
	}

	public function set x2( val : Number ) : void {
		_recFrame.right = Math.max( x1 + 20, val );
		redraw();
	}
	public function get x2( ) : Number {
		return _recFrame.right;
	}

	public function set y2( val : Number ) : void {
		_recFrame.bottom = Math.max( y1+10, val );
		redraw();
	}
	public function get y2( ) : Number {
		return _recFrame.bottom;
	}

	public function get rect ( ) : Rectangle {
		return _recFrame;
	}
	

	public function RectFrame( ) {
		addChild( _fshape = new Shape() );
		addChild( _icon = new RecIcon( ) );
		addChild( _infoTf = new TextField() );
		_infoTf.defaultTextFormat = new TextFormat( "arial", 10, THEME_COLOR );
		_infoTf.selectable = false;
		_infoTf.width = 200;
		_infoTf.height = 20;
		_recFrame = new Rectangle();
		
		addEventListener( Event.ADDED_TO_STAGE, onAdded );
		addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
	}
	
	public function setRecMode () : void {
		removeChild( _icon );
		_infoTf.text = "REC - ENTER to stop";
		_fshape.graphics.clear( );
		_fshape.graphics.lineStyle( 1, THEME_COLOR );
		_fshape.graphics.drawRect( _recFrame.left-1, _recFrame.top-1, _recFrame.width+2, _recFrame.height+2 );
		_fshape.graphics.lineStyle( 4, 0, .2 );
		_fshape.graphics.drawRect( _recFrame.left-3, _recFrame.top-3, _recFrame.width+7, _recFrame.height+7 );
	}

	
	 
	private function onAdded (event : Event) : void {
		addEventListener( Event.ENTER_FRAME, _oef );
	}
		
	private function onRemoved (event : Event) : void {
		removeEventListener( Event.ENTER_FRAME, _oef );
	}
	
	private function _oef (event : Event) : void {
		_icon.x = stage.mouseX + 3;
		_icon.y = stage.mouseY - 10;
	}

	private function redraw() : void {
		_infoTf.text = ( _recFrame.width > 100 ) ? "ENTER to rec" : "";
		//_infoTf.width = _recFrame.width;
		_infoTf.x = _recFrame.left;
		_infoTf.y = _recFrame.top - 14 ;
		_fshape.graphics.clear( );
		_fshape.graphics.lineStyle( 1, THEME_COLOR );
		_fshape.graphics.drawRect( _recFrame.left, _recFrame.top, _recFrame.width, _recFrame.height );
		_fshape.graphics.lineStyle( 4, 0, .2 );
		_fshape.graphics.drawRect( _recFrame.left-2, _recFrame.top-2, _recFrame.width+5, _recFrame.height+5 );
	}

	
	private var _infoTf : TextField;
	private var _recFrame : Rectangle;
	private var _fshape : Shape;
	private var _icon 		: Sprite;
}
//_____________________________________________________________________________
//																		CAMCORDER
//		
//		 CCCCC    AAA   MM   MM  CCCCC   OOOO  RRRRR   DDDDDD  EEEEEEE RRRRR   
//		CC   CC  AAAAA  MMM MMM CC   CC OO  OO RR  RR  DD   DD EE      RR  RR  
//		CC      AA   AA MMMMMMM CC      OO  OO RRRRR   DD   DD EEEE    RRRRR   
//		CC   CC AAAAAAA MM M MM CC   CC OO  OO RR  RR  DD   DD EE      RR  RR  
//		 CCCCC  AA   AA MM   MM  CCCCC   OOOO  RR   RR DDDDDD  EEEEEEE RR   RR 




class CamCorder {
	
	public function CamCorder( rect : Rectangle, stage : Stage ) {
		_stage = stage;
		_rect = rect;
		_frames = new Array( );
		_efShape = new Shape();
		_mtrx = new Matrix( );
		_mtrx.translate( -_rect.left, -_rect.top );
	}

	public function get rect ( ) : Rectangle {
		return _rect;	
	}

	public function get frames( ) : Array {
		return _frames;	
	}

	public function startRecord() : void {
		_efShape.addEventListener( Event.ENTER_FRAME, _snap );
	}

	public function stopRecord() : void {
		_efShape.removeEventListener( Event.ENTER_FRAME, _snap );
	}

	public function dispose() : void {
		stopRecord();
		_frames = null;
		_efShape = null;
		_stage = null;
		_rect = null;
	}

	private function _snap (event : Event) : void {
		var bd : BitmapData = new BitmapData( _rect.width, _rect.height, false, fr.digitas.flowearth.debug.Recorder.BG_COLOR );
		bd.draw( _stage, _mtrx );
		if( _frames.length > 0 ) {
			var prev : BitmapData = _frames[ _frames.length-1 ];
			sameFrameCount = ( prev.compare( bd ) == 0 ) ? sameFrameCount+1 : 0;
		} 
		if (sameFrameCount < 3 ) _frames.push( bd );
		else bd.dispose();
	}

	
	
	
	private var sameFrameCount : int = 0;
	private var _stage 		: Stage;
	private var _efShape 	: Shape;
	private var _mtrx 		: Matrix;
	
	
	public function cancel () : void {
		stopRecord();
		dispose();
		while( _frames.length > 0 ) {
			_frames.shift().dispose();
		}
	}

	
	private var _rect 		: Rectangle;
	private var _frames 	: Array;	
}
//_____________________________________________________________________________
//																		PLAYBACK

//		PPPPPP  LL        AAA   YY  YY  BBBBBB    AAA    CCCCC  KK   KK 
//		PP   PP LL       AAAAA   YYYY   BB   BB  AAAAA  CC   CC KK KK   
//		PPPPPP  LL      AA   AA   YY    BBBBBB  AA   AA CC      KKKK    
//		PP      LL      AAAAAAA   YY    BB   BB AAAAAAA CC   CC KK  KK  
//		PP      LLLLLLL AA   AA   YY    BBBBBB  AA   AA  CCCCC  KK   KK 

class PlayBack extends Sprite {

	function PlayBack( camCorder : CamCorder ) {
		_frames = camCorder.frames;
		x = camCorder.rect.left;
		y = camCorder.rect.top;
		initControls( camCorder );
		addEventListener( Event.ADDED_TO_STAGE, onAdded );
		addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
	}
	
	private function initControls ( camCorder : CamCorder ) : void {
		addChild( _controls = new PlaybackControls( camCorder ) );
		_controls.addEventListener( PlaybackControls.P_CHANGE, onPchange);
		_controls.addEventListener( PlaybackControls.S_CHANGE, onSchange );
		_controls.addEventListener( PlaybackControls.CONTROL, onControled );
		_controls.addEventListener( PlaybackControls.UNCONTROL, onUncontroled );
		_controls.y = camCorder.rect.height;
		_controls.speed = _playRate;
		
	}

	private function onControled ( event : Event ) : void {
		removeEventListener( Event.ENTER_FRAME, _oef );
	}

	private function onUncontroled ( event : Event ) : void {
		addEventListener( Event.ENTER_FRAME, _oef );
	}

	private function onPchange (event : NumEvent) : void {
		_progress = event.value * _frames.length;
		_controls.progress = event.value;
		_oef( null );
	}
	
	
	
	
	private function onSchange (event : NumEvent) : void {
		_playRate = event.value;
		_controls.speed = _playRate;
	}

	private function onAdded (event : Event) : void {
		addChild( _bitmap = new Bitmap() );
		addEventListener( Event.ENTER_FRAME, _oef );
		
		addChild( _infoTf = new TextField() );
		_infoTf.defaultTextFormat = new TextFormat( "arial", 10, THEME_COLOR );
		_infoTf.selectable = false;
		_infoTf.width = 200;
		_infoTf.height = 18;
		_infoTf.y = -14;
		_infoTf.text = "ESC to close";
	}
		
	private function onRemoved (event : Event) : void {
		_controls.removeEventListener( PlaybackControls.P_CHANGE, onPchange);
		_controls.removeEventListener( PlaybackControls.S_CHANGE, onSchange );
		_controls.removeEventListener( PlaybackControls.CONTROL, onControled );
		_controls.removeEventListener( PlaybackControls.UNCONTROL, onUncontroled );
		removeEventListener( Event.ENTER_FRAME, _oef );
		dispose( );	
	}
	
	private function _oef (event : Event) : void {
		_bitmap.bitmapData = _frames[ Math.floor( _progress ) ];
		_progress += _playRate;
		var l : Number = _frames.length;
		if( _progress >= l ) _progress -= l;
		else if( _progress < 0 ) _progress += l	;
		_controls.progress = _progress / l;
	}

	
	
	
	private function dispose () : void {
		while( _frames.length > 0 ) {
			_frames.shift().dispose();
		}
		_frames = null;
	}

	private var _infoTf : TextField;
	
	private var _bitmap : Bitmap;
	private var _controls : PlaybackControls;
	private var _progress : Number = 0;
	private var _playRate : Number = .2;
	
	private var _frames : Array;
}
class PlaybackControls extends Sprite {
	
	public static const P_CHANGE : String = "pchange";
	public static const S_CHANGE : String = "schange";
	public static const CONTROL : String = "control";
	public static const UNCONTROL : String = "uncontrol";
	
	function PlaybackControls ( camCorder : CamCorder ) {
		nf = camCorder.frames.length;
		w = camCorder.rect.width;
		addEventListener( Event.ADDED_TO_STAGE, onAdded );
		addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		build( );
	}

	private function onAdded (event : Event) : void {
		_stage = stage;
		_trackP.addEventListener( MouseEvent.MOUSE_DOWN, onTpDown );
		_trackS.addEventListener( MouseEvent.MOUSE_DOWN, onTsDown );
	}
	
	// TrackP handle
	
	private function onTpDown (event : MouseEvent) : void {
		dispatchEvent( new Event( CONTROL ) );
		_stage.addEventListener( MouseEvent.MOUSE_MOVE, onTpMove );
		_stage.addEventListener( MouseEvent.MOUSE_UP, onTpUp );
		sendProgress( _trackP.mouseX / _trackP.width );
	}
	
	private function onTpUp (event : MouseEvent) : void {
		dispatchEvent( new Event( UNCONTROL ) );
		_stage.removeEventListener( MouseEvent.MOUSE_MOVE, onTpMove );
		_stage.removeEventListener( MouseEvent.MOUSE_UP, onTpUp );
	}

	private function onTpMove (event : MouseEvent) : void {
		sendProgress( _trackP.mouseX / _trackP.width );
	}

	// TrackS handle
	
	private function onTsDown (event : MouseEvent) : void {
		_stage.addEventListener( MouseEvent.MOUSE_MOVE, onTsMove );
		_stage.addEventListener( MouseEvent.MOUSE_UP, onTsUp );
		var s : Number =  (_trackS.mouseX - _trackS.width/2) / (_trackS.width /2) ;
		sendSpeed( Math.max( -1, Math.min( 1,s ) ) );
	}
	
	private function onTsUp (event : MouseEvent) : void {
		_stage.removeEventListener( MouseEvent.MOUSE_MOVE, onTsMove );
		_stage.removeEventListener( MouseEvent.MOUSE_UP, onTsUp );
	}

	private function onTsMove (event : MouseEvent) : void {
		var s : Number =  (_trackS.mouseX - _trackS.width/2) / (_trackS.width /2) ;
		sendSpeed( Math.max( -1, Math.min( 1,s ) ) );
	}
	
	private function onRemoved (event : Event) : void {
		_trackS.removeEventListener( MouseEvent.MOUSE_DOWN, onTsDown );
		_trackP.removeEventListener( MouseEvent.MOUSE_DOWN, onTpDown );
		_stage.removeEventListener( MouseEvent.MOUSE_MOVE, onTpMove );
		_stage.removeEventListener( MouseEvent.MOUSE_UP, onTpUp );
		_stage.removeEventListener( MouseEvent.MOUSE_MOVE, onTsMove );
		_stage.removeEventListener( MouseEvent.MOUSE_UP, onTsUp );
		_stage = null;
	}

	public function set progress( val  : Number ) : void {
		_progressP.scaleX = val;
	}
	public function set speed( val  : Number ) : void {
		_progressS.scaleX = val;
	}
	
	private function sendProgress( val : Number ) : void {
		val = Math.min( 1, Math.max( 0, val ) );
		dispatchEvent( new NumEvent( P_CHANGE, val ) );
	}
	private function sendSpeed( val : Number ) : void {
		dispatchEvent( new NumEvent( S_CHANGE, val ) );
	}

	private function build () : void {
		addChild( _trackP = new Sprite() );
		addChild( _progressP = new Sprite() );

		addChild( _trackS = new Sprite() );
		addChild( _progressS = new Sprite() );
		
		var tpw : Number = w-SW-10;
		
		graphics.beginFill( 0, .4 );
		graphics.drawRect(tpw, 0, 10, 10);
		
		_trackP.graphics.beginFill( 0, 0.2 );
		_trackP.graphics.drawRect( 0, 0, tpw, 10 );
		_trackP.graphics.endFill( );
		_trackP.graphics.lineStyle( 1, 0, 0.1 );
		
		if( 1/nf * tpw > 3 ) {
			for( var i : int = 0 ; i < nf; i ++ ) {
				_trackP.graphics.moveTo( i/nf * tpw, 0);
				_trackP.graphics.lineTo( i/nf * tpw, 10);
			}
		}

		_progressP.graphics.beginFill( THEME_COLOR );
		_progressP.graphics.drawRect( 0, 5, w-SW-10, 1 );

		_trackS.graphics.beginFill( 0, 0.2 );
		_trackS.graphics.drawRect( 0, 0, SW, 10 );

		_progressS.graphics.beginFill( THEME_COLOR );
		_progressS.graphics.drawRect( 0, 5, SW/2, 1 );
		
		_progressP.mouseEnabled = _progressS.mouseEnabled = false;
		
		_trackS.x = w-SW;
		_progressS.x = w-SW + SW/2;
	}
	
	private static const SW : int = 70;
	
	private var _stage : Stage;

	private var _trackP : Sprite;
	private var _progressP : Sprite;

	private var _trackS : Sprite;
	private var _progressS : Sprite;

	private var nf : int;
	private var w : Number;
}

class NumEvent extends Event {
	
	public var value : Number;
	
	function NumEvent ( type : String , val : Number ) {
		super( type, false, false );
		value = val;
	}	
}



//_____________________________________________________________________________
//																		RECICON

//		RRRRR   EEEEEEE  CCCCC  IIIIII  CCCCC   OOOO  NN  NN 
//		RR  RR  EE      CC   CC   II   CC   CC OO  OO NNN NN 
//		RRRRR   EEEE    CC        II   CC      OO  OO NNNNNN 
//		RR  RR  EE      CC   CC   II   CC   CC OO  OO NN NNN 
//		RR   RR EEEEEEE  CCCCC  IIIIII  CCCCC   OOOO  NN  NN 

class RecIcon extends Sprite {
	
	public function RecIcon() {
		draw( );
	}
	
	private function draw () : void {
		graphics.beginFill( THEME_COLOR );
		graphics.drawRect(0, 0, 16, 10 );
		graphics.beginFill( 0xffffff );
		graphics.drawCircle(8, 5, 3);
	}
}

const THEME_COLOR : uint = 0xff0000;
