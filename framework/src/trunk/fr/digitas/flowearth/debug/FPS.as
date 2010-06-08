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


package fr.digitas.flowearth.debug 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends Sprite
	{
		// - STATIC VARIABLES ------------------------------------------------------------
		
		// - PRIVATE VARIABLES -----------------------------------------------------------
		
		private var _width:Number;
		private var _height:Number;
		private var _showAll:Boolean;
		private var _interval:int;
		private var _scroll:int;
		private var _memMax:int;
		private var _graph:Sprite;
		private var _infos:Sprite;
		private var _curves:BitmapData;
		
		private const _MSMAX:int = 100;
		
		private var _graphicShown:Boolean;
		private var _isRunning:Boolean;
		
		private var _prevFps:int;
		private var _prevMem:int;
		private var _prevMoy:int;
		private var _prevMS:int;
		private var _rect:Rectangle;
		
		private var _tFps:TextField;
		private var _tMem:TextField;
		private var _tMoy:TextField;
		private var _tMs:TextField;
		private var _tIncrease:TextField;
		private var _tDecrease:TextField;
		
		private var _fps:int;
		private var _mem:int;
		private var _moy:int;
		private var _ms:int;
		
		private var _count:int;
		private var _currentTime:int;
		private var _prevIntervalTime:int;
		private var _prevTime:int;
		
		private var _moyValue:Number = 0;
		private var _moyCount:int;
		private var _moyRefresh:int = 20;
		
		//frame rate
		private var changeFrameRate:int = 0;
		private var _lastTickTime:int = 0;
		
		// - PUBLIC VARIABLES ------------------------------------------------------------
		
		// - CONSTRUCTOR -----------------------------------------------------------------
		
		/**
		 * Permet de suivre les performances de l'application.
		 * Les FPS correspondent au nombre d'images par secondes affichées.
		 * "MEM" correspond à la mémoire physique utilisée par l'application (en mo).
		 * Les MS correspondent au nombre de millisecondes entre chaque rafraichissement. Plus le nombre de MS est grand, plus les 
		 * FPS sont petits, et plus l'application est lente.
		 * @param	width	Number	La largeur de la fenêtre.
		 * @param	height	Number	La hauteur de la fenêtre.
		 * @param	Boolean	ShowAll	Rend partiellement ou totalement visible l'outil FPS. Revient à double cliquer sur la barre noire des infos.
		 * @param	interval	int	Correspond au nombre de seconde entre chaque rafraichissement du graphique.
		 * @param	scroll	int	Correspond au nombre de pixels scrollés sur le graphique.
		 * @param	memMax	int	Correspond à la hauteur maximale du graphique (si memMax = 100, le graphique atteindra son "sommet" avec 100mo de ram utilisé).
		 */
		public function FPS( width:Number = 245, height:Number = 50, showAll:Boolean = true, interval:int = 5, scroll:int = 2, memMax:int = 100 ) 
		{
			this._width = width >= 175 ? width : 175;
			this._height = height >= 20 ? height : 20;
			this._showAll = showAll;
			this._interval = interval;
			this._scroll = scroll;
			this._memMax = memMax;
			
			var head:Bitmap = new Bitmap( new BitmapData( _width + 1, 20, true, 0xEE111111 ) );
			addChild( head );
			
			var backgroundFrameRate:Bitmap = new Bitmap( new BitmapData( 30, 20, true, 0xEE111111 ) );
			backgroundFrameRate.x = _width +1
			addChild( backgroundFrameRate );
			
			_graph = new Sprite();
			_graph.mouseEnabled = false;
			addChild( _graph );
			
			var background:Bitmap = drawBackground();
			background.y = head.height;
			_graph.addChild( background );
			
			_infos = new Sprite();
			_infos.mouseEnabled = false;
			addChild( _infos );
			
			_curves = new BitmapData( _width - 10, _height - 10, true, 0x00 );
			var curvesHolder:Bitmap = new Bitmap( _curves );
			curvesHolder.x = 5; curvesHolder.y = 25;
			_graph.addChild( curvesHolder );
			
			_prevFps =
			_prevMem = 
			_prevMS = _curves.height;
			
			_rect = new Rectangle( _curves.width - _scroll, 0, _scroll, _curves.height );
			
			defineTexts();
			
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		}
		
		// - EVENTS HANDLERS -------------------------------------------------------------
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			if ( hasEventListener( Event.ENTER_FRAME ) ) removeEventListener( Event.ENTER_FRAME, renderCurves );
			removeEventListener( Event.DEACTIVATE, onDeactivate );
			removeEventListener( Event.ACTIVATE, onActivate );
			
			
			_tIncrease.removeEventListener(MouseEvent.MOUSE_DOWN, increaseDownHandler);
			_tIncrease.removeEventListener(MouseEvent.MOUSE_UP, frameRateUpHandler);
			_tIncrease.removeEventListener(MouseEvent.ROLL_OUT, frameRateUpHandler);
			_tDecrease.removeEventListener(MouseEvent.MOUSE_DOWN, decreaseDownHandler);
			_tDecrease.removeEventListener(MouseEvent.MOUSE_UP, frameRateUpHandler);
			_tDecrease.removeEventListener(MouseEvent.ROLL_OUT, frameRateUpHandler);
			
			_curves.dispose();
			_curves = null;
			
			while ( _graph.numChildren ) _graph.removeChildAt( 0 );
			while ( _infos.numChildren ) _infos.removeChildAt( 0 );
			while ( numChildren ) removeChildAt( 0 );
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );
			
			addEventListener( Event.DEACTIVATE, onDeactivate );
			addEventListener( Event.ACTIVATE, onActivate );
			
			var mouseZone:Sprite = new Sprite();
			mouseZone.addChild( new Bitmap( new BitmapData( _width + 1, 20, true, 0x00 ) ) );
			mouseZone.addEventListener( MouseEvent.MOUSE_DOWN, onDown );
			mouseZone.addEventListener( MouseEvent.MOUSE_UP, onUp );
			mouseZone.addEventListener( MouseEvent.DOUBLE_CLICK, onDoubleClick );
			addChild( mouseZone );
			
			_tIncrease.addEventListener(MouseEvent.MOUSE_DOWN, increaseDownHandler);
			_tIncrease.addEventListener(MouseEvent.MOUSE_UP, frameRateUpHandler);
			_tIncrease.addEventListener(MouseEvent.ROLL_OUT, frameRateUpHandler);
			_tDecrease.addEventListener(MouseEvent.MOUSE_DOWN, decreaseDownHandler);
			_tDecrease.addEventListener(MouseEvent.MOUSE_UP, frameRateUpHandler);
			_tDecrease.addEventListener(MouseEvent.ROLL_OUT, frameRateUpHandler);
			
			mouseZone.doubleClickEnabled =
			mouseZone.buttonMode =
			_graphicShown = true;
			
			if ( !_showAll ) onDoubleClick( null );
			
			addEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = true;
		}
		
		private function onDeactivate(e:Event):void 
		{
			pause();
		}
		
		private function onActivate(e:Event):void 
		{
			play();
		}
		
		private function onDown(e:MouseEvent):void 
		{
			startDrag();
		}
		
		private function onUp(e:MouseEvent):void 
		{
			stopDrag();
		}
		
		/** Affiche ou cache le graphique */
		private function onDoubleClick(e:MouseEvent):void 
		{
			_graph.visible =
			_graphicShown = !_graphicShown;	
		}
		
		/** Actualise les informations */
		private function renderCurves(e:Event):void 
		{
			_currentTime = getTimer();
			
			_ms = int( _currentTime - _prevTime );
			
			if ( ++_count >= _interval )
			{				
				_fps = int( ( 1000 * _count ) / ( _currentTime - _prevIntervalTime ) );
				if ( _fps > stage.frameRate ) _fps = stage.frameRate;
				
				_mem = int( System.totalMemory / 1048576 );
				
				_moyValue += _fps;
				if ( ( ++_moyCount % _moyRefresh ) == 0 )
				{
					_moy = int( ( _moy + _moyValue ) / ( _moyRefresh + 1 ) );
					_moyValue = 0;
				}
				
				_count = 0;
				_prevIntervalTime = _currentTime;
				
				if ( _graphicShown )
				{
					_curves.scroll( -_scroll, 0 );
					_curves.fillRect( _rect, 0x00 );
					
					var rf:Number = Math.min( 1, _fps / stage.frameRate );
					var nextFps:int = ( 1 - rf ) * ( _curves.height - 1 );
					drawLine( _curves.width - _scroll, _prevFps, _curves.width - 1, nextFps, 0xffff0000 );
					_prevFps = nextFps;
					
					var rm:Number = Math.min( 1, _mem / _memMax );
					var nextMem:int = ( 1 - rm ) * ( _curves.height - 1 );			
					drawLine( _curves.width - _scroll, _prevMem, _curves.width - 1, nextMem, 0xff00ff00 );
					_prevMem = nextMem;
					
					var rmf:Number = Math.min( 1, _moy / stage.frameRate );
					var nextMoy:int = ( 1 - rmf ) * ( _curves.height - 1 );
					drawLine( _curves.width - _scroll, _prevMoy, _curves.width - 1, nextMoy, 0xffff6600 );
					_prevMoy = nextMoy;
					
					var rms:Number = Math.min( 1, _ms / _MSMAX );
					var nextMs:int = ( 1 - rms ) * ( _curves.height - 1 );
					drawLine( _curves.width - _scroll, _prevMS, _curves.width - 1, nextMs, 0xff0099ff );
					_prevMS = nextMs;
				}
			}
			
			_prevTime = _currentTime;
			
			refreshTexts();
		}
		
		// - PRIVATE METHODS -------------------------------------------------------------
		
		/** Dessine le background */
		private function drawBackground():Bitmap
		{
			var bd:BitmapData = new BitmapData( _width + 1, _height + 1, true, 0x00 );
			
			var s:Shape = new Shape();
			var g:Graphics = s.graphics;
			g.lineStyle( 1, 0xe5e5e5 );
			g.beginFill( 0xffffff );
			g.drawRect( 0, 0, _width, _height );
			g.endFill();
			
			bd.draw( s );
			
			s = new Shape();
			g = s.graphics;
			g.beginGradientFill( GradientType.LINEAR, [ 0xffffff, 0xeeeeee ], [ 1, 1 ], [ 0, 255 ] );
			g.drawRect( 5, 5, _width - 10, _height - 10 );
			g.endFill();			
			
			bd.draw( s );
			g = null;
			s = null;
			
			return new Bitmap( bd );
		}
		
		/** Définit les différents champs de textes */
		private function defineTexts():void
		{
			var tf:TextFormat = new TextFormat( "_sans", 9 );
			
			_tFps = new TextField();
			_tFps.autoSize = TextFieldAutoSize.LEFT;
			_tFps.x = 5; _tFps.y = 2;
			_tMoy = new TextField();
			_tMoy.autoSize = TextFieldAutoSize.LEFT;
			_tMoy.x = 75; _tMoy.y = 2;			
			_tMem = new TextField();
			_tMem.autoSize = TextFieldAutoSize.LEFT;
			_tMem.x = 150; _tMem.y = 2;
			_tMs = new TextField();
			_tMs.autoSize = TextFieldAutoSize.LEFT;
			_tMs.x = _width-50; _tMs.y = 2;
			_tIncrease = new TextField();
			_tIncrease.autoSize = TextFieldAutoSize.LEFT;
			_tIncrease.x = _width+5; _tIncrease.y = 2;
			_tDecrease = new TextField();
			_tDecrease.autoSize = TextFieldAutoSize.LEFT;
			_tDecrease.x = _width+20; _tDecrease.y = 2;
			
			_tFps.textColor = 0xff0000;
			_tMem.textColor = 0x00ff00;
			_tMoy.textColor = 0xff6600;
			_tMs.textColor = 0x0099ff;
			_tIncrease.textColor = 0x0099ff;
			_tDecrease.textColor = 0x0099ff;
			
			_tFps.selectable = 
			_tMem.selectable =
			_tMoy.selectable =
			_tMs.selectable = 
			_tIncrease.selectable = 
			_tDecrease.selectable = false;
			
			_tFps.defaultTextFormat =
			_tMem.defaultTextFormat =
			_tMoy.defaultTextFormat =
			_tMs.defaultTextFormat = 
			_tIncrease.defaultTextFormat =
			_tDecrease.defaultTextFormat = tf;
			
			refreshTexts();
			
			_infos.addChild( _tFps );
			_infos.addChild( _tMem );
			_infos.addChild( _tMoy );
			_infos.addChild( _tMs );
			_infos.addChild( _tIncrease );
			_infos.addChild( _tDecrease );
		}
		
		private function frameRateUpHandler(e:Event):void 
		{
			changeFrameRate = 0;
		}
		
		private function increaseDownHandler(e:Event):void 
		{
			_lastTickTime = getTimer();
			changeFrameRate = 1;
		}
		
		private function decreaseDownHandler(e:Event):void 
		{
			_lastTickTime = getTimer();
			changeFrameRate = -1;
		}
		
		/** Rafraichit les textes FPS/MEM/MS */
		private function refreshTexts():void
		{
			if ( !_isRunning )
			{
				_tFps.text = "FPS : ...";
				_tMem.text = "MEM : ...";
				_tMs.text = "MS : ...";
				_tMoy.text = "MS : ...";
				
				changeFrameRate = 0;
				
				return;
			}
			_tFps.text = "FPS : " + _fps.toString() + " / " + stage.frameRate;
			_tMem.text = "MEM : " + _mem.toString();
			_tMs.text = "MS : " + _ms.toString();
			_tMoy.text = "MOY FPS : " + _moy.toString();
			_tIncrease.text = "+";
			_tDecrease.text = "-";
			
			if ( changeFrameRate != 0 && _currentTime - _lastTickTime > 50 ) { 
				_lastTickTime = _currentTime;
				stage.frameRate += changeFrameRate;
			}
		}
		
		/**
		 * Dessine une ligne bien pixelisée.
		 * @param	x0	int	Le point de départ sur l'axe des x.
		 * @param	y0	int	Le point de départ sur l'axe des y.
		 * @param	x1	int	Le point d'arrivée sur l'axe des x.
		 * @param	y1	int	Le point d'arrivée sur l'axe des y.
		 * @param	c	int	La couleur de la courbe à tracer.
		 */
		private function drawLine( x0:int, y0:int, x1:int, y1:int, c:uint = 0xff000000 ):void
		{
			var dx:int = x1 - x0;
			var dy:int = y1 - y0;
			var xinc:int = ( dx > 0 ) ? 1 : -1;
			var yinc:int = ( dy > 0 ) ? 1 : -1;
			dx = Math.abs( dx );
			dy = Math.abs( dy );
			
			_curves.setPixel32( x0, y0, c );
			
			var cumul:int;
			var i:int;
			if ( dx > dy )
			{
				cumul = dx >> 1;
				for ( i = 1; i <= dx; i++ )
				{
					x0 += xinc;
					cumul += dy;
					if ( cumul >= dx )
					{
						y0 += yinc;
						cumul -= dx;
					}
					_curves.setPixel32( x0, y0, c );
				}
			}
			else
			{
				cumul = dy >> 1;
				for ( i = 1; i <= dy; i++ )
				{
					y0 += yinc;
					cumul += dx;
					if ( cumul >= dy )
					{
						x0 += xinc;
						cumul -= dy;
					}
					_curves.setPixel32( x0, y0, c );
				}
			}
		}
		
		// - PUBLIC METHODS --------------------------------------------------------------
		
		/** Met le composant en pause */
		public function pause():void
		{
			if ( !_isRunning ) return;
			
			removeEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = false;
			
			refreshTexts();
		}
		
		/** Lance/relance le composant */
		public function play():void
		{
			if ( _isRunning ) return;
			
			addEventListener( Event.ENTER_FRAME, renderCurves );
			_isRunning = true;
		}
		
		/** Permet de savoir si le composant est actif ou non */
		public function isRunning():Boolean { return _isRunning; }
		
		/**
		 * Change le nombre de secondes entre chaque rafraichissement de la moyenne des FPS.
		 * @param	refreshTime	int	Temps entre chaque rafraichissement (en secondes).
		 */
		public function setMoyRefreshValue( refreshTime:int ):void
		{
			this._moyRefresh = refreshTime;
		}
		
		// - GETTERS & SETTERS -----------------------------------------------------------
		
		// - END CLASS -------------------------------------------------------------------
		
	}
	
}