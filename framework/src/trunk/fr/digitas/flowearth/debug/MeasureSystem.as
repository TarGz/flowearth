package fr.digitas.flowearth.debug 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;
	/*FDT_IGNORE*/
	/*-FP10*/
	import flash.ui.MouseCursor;
	/*FP10-*/ 
	/*FDT_IGNORE*/
	
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Fazermokeur
	 */
	public class MeasureSystem extends Sprite
	{
		public static const TOP_LEFT:int = 0;
		public static const TOP_RIGHT:int = 1;
		public static const BOTTOM_LEFT:int = 2;
		public static const BOTTOM_RIGHT:int = 3;
		
		public static var onStage:Boolean = false;
		
		private const STEP:int = 50;
		private var contact:Sprite;
		private var INITIAL_POS:Point = new Point();
		private var CURRENT_POS:Point = new Point();
		private var SPACE_INIT_POS:Point = new Point();
		private var SPACE_INIT_MOUSE:Point = new Point();
		private var BOUNDS:Rectangle = new Rectangle();
		private var pressed:Boolean = false;
		private var space_pressed:Boolean = false;
		private var shifted:Boolean = false;
		private var zoneDragged:Boolean = false;
		
		/*	Direction du mouvement	*/
		private var orientation:int;
		
		/*	corners	*/
		private var c_TOP_LEFT:Sprite;
		private var c_TOP_RIGHT:Sprite;
		private var c_BOTTOM_LEFT:Sprite;
		private var c_BOTTOM_RIGHT:Sprite;
		private var canva:Sprite;
		private var cursor:Sprite;
		private var dragableZone:Sprite;
		private var console:MeasureConsole;
		private var _stage:Stage;
		private var angle:Number;
		private var initSpaceOrientation:int;
		
		public function MeasureSystem()
		{
			if (onStage)
				return;
			if (stage)
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			onStage = true;
			_stage = stage;
			
			Mouse.hide();
			cursor = getCrossCursor();
			cursor.startDrag(true);
			cursor.blendMode = BlendMode.INVERT;
			_stage.addChild(cursor);
			
			contact = new Sprite();
			contact.graphics.beginFill(0xff0000, 0);
			contact.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			contact.graphics.endFill();
			addChild(contact);
			
			canva = new Sprite();
			addChild(canva);
			dragableZone = new Sprite();
			dragableZone.buttonMode = true;
			canva.addChild(dragableZone);
			
			_stage.addEventListener(Event.RESIZE, handleResize);
			contact.addEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			_stage.addEventListener(MouseEvent.MOUSE_UP, handleUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			dragableZone.addEventListener(MouseEvent.MOUSE_OVER, handleCanvaOver);
			dragableZone.addEventListener(MouseEvent.MOUSE_OUT, handleCanvaOut);
			c_BOTTOM_LEFT = getCorner();
			c_BOTTOM_RIGHT = getCorner();
			c_TOP_LEFT = getCorner();
			c_TOP_RIGHT = getCorner();
			
			if (!canva.contains(c_TOP_LEFT))
			{
				canva.addChild(c_TOP_RIGHT);
				canva.addChild(c_BOTTOM_LEFT);
				canva.addChild(c_BOTTOM_RIGHT);
				canva.addChild(c_TOP_LEFT);
				
				c_BOTTOM_LEFT.alpha = 0;
				c_BOTTOM_RIGHT.alpha = 0;
				c_TOP_LEFT.alpha = 0;
				c_TOP_RIGHT.alpha = 0;
			}
			
			dragableZone.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			console = new MeasureConsole();
			console.x = stage.stageWidth * .75;
			console.x = ((console.x + console.width + 10) < stage.stageWidth) ? console.x : stage.stageWidth - console.width - 10;
			console.y = stage.stageHeight * .1;
			console.addEventListener(Event.CLOSE, close);
			console.addEventListener(MouseEvent.ROLL_OVER, overConsole);
			console.addEventListener(MouseEvent.ROLL_OUT, outConsole);
			console.filters = [new DropShadowFilter(1, 45, 0, .1, 4, 4, 1, 3)];
			addChild(console);
			
			handleResize(null);
			
			addEventListener(Event.ENTER_FRAME, _oef);
		}
		
		private function _oef(e:Event):void 
		{
			/*______________________________________________________________________
			/*													C H E C K   C O L O R	*/
			var bmpd:BitmapData = new BitmapData(1, 1, false, 0);
			bmpd.draw(_stage.loaderInfo.content, new Matrix(1, 0, 0, 1, -mouseX, -mouseY));
			var pixelValue:uint = bmpd.getPixel32(0, 0); 
			var alpha:uint = pixelValue >> 24 & 0xFF; 
			var red:uint = pixelValue >> 16 & 0xFF; 
			var green:uint = pixelValue >> 8 & 0xFF; 
			var blue:uint = pixelValue & 0xFF; 
			
			console.feedColors(alpha, red, green, blue);
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			zoneDragged = true;
			canva.startDrag();
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
		}
		
		private function overConsole(e:MouseEvent):void
		{
			if (console.free)
			{
				cursor.stopDrag();
				if (_stage.contains(cursor))
					_stage.removeChild(cursor);
				Mouse.show();
				/*FDT_IGNORE*/
				/*-FP10*/
				Mouse.cursor = MouseCursor.AUTO;
				/*FP10-*/ 
				/*FDT_IGNORE*/
			}
		}
		
		private function outConsole(e:MouseEvent):void
		{
			if (console.free)
			{
				Mouse.hide();
				cursor.startDrag(true);
				_stage.addChild(cursor);
			}
		}
		
		private function handleCanvaOut(e:MouseEvent):void
		{
			if (zoneDragged)
				return;
			if (!console.free)
				return;
			Mouse.hide();
			cursor.startDrag(true);
			_stage.addChild(cursor);
		}
		
		private function handleCanvaOver(e:MouseEvent):void
		{
			if (!console.free)
				return;
			cursor.stopDrag();
			if (_stage.contains(cursor))
				_stage.removeChild(cursor);
			Mouse.show();
			/*FDT_IGNORE*/
			/*-FP10*/
			Mouse.cursor = MouseCursor.HAND;
			/*FP10-*/ 
			/*FDT_IGNORE*/
		}
		
		private function handleKeyUp(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.SPACE: 
					space_pressed = false;
					if (orientation == TOP_LEFT)
					{
						INITIAL_POS.x = BOUNDS.x + BOUNDS.width;
						INITIAL_POS.y = BOUNDS.y + BOUNDS.height;
					}
					else if (orientation == TOP_RIGHT)
					{
						INITIAL_POS.x = BOUNDS.x;
						INITIAL_POS.y = BOUNDS.y + BOUNDS.height;
					}
					else if (orientation == BOTTOM_LEFT)
					{
						INITIAL_POS.x = BOUNDS.x + BOUNDS.width;
						INITIAL_POS.y = BOUNDS.y;
					}
					break;
				case Keyboard.SHIFT: 
					shifted = false;
					break;
			}
		}
		
		private function handleKeyDown(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.SPACE: 
					if (pressed)
					{
						if (!space_pressed)
						{
							SPACE_INIT_POS = new Point(BOUNDS.x, BOUNDS.y);
							SPACE_INIT_MOUSE = new Point(mouseX, mouseY);
							initSpaceOrientation = orientation;
						}
						space_pressed = true;
					}
					break;
				case Keyboard.SHIFT: 
					if (pressed)
					{
						shifted = true;
						handleMove(null);
					}
					break;
				case 68: 
					if (e.ctrlKey)
						removeSelection();
					break;
			}
		}
		
		private function handleUp(e:MouseEvent):void
		{
			pressed = false;
			if (zoneDragged)
			{
				zoneDragged = false;
				canva.stopDrag();
			}
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMove);
		}
		
		private function handleDown(e:MouseEvent):void
		{
			pressed = true;
			INITIAL_POS = new Point(int(mouseX), int(mouseY));
			CURRENT_POS = new Point();
			BOUNDS = new Rectangle(mouseX, mouseY, 0, 0);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			
			draw();
		}
		
		private function handleMove(e:MouseEvent):void
		{
			if (zoneDragged)
			{
				BOUNDS.x = canva.x;
				BOUNDS.y = canva.y;
				console.feedInfos(BOUNDS, angle, orientation);
				if (checkValidBounds())
					draw();
				return;
			}
			
			CURRENT_POS.x = int(mouseX);
			CURRENT_POS.y = int(mouseY);
			
			/*_______________________________________________________________________
			/*											C H E C K   D I R E C T I O N	 */
			if (mouseX > INITIAL_POS.x && mouseY > INITIAL_POS.y)
				orientation = BOTTOM_RIGHT;
			else if (mouseX > INITIAL_POS.x && mouseY < INITIAL_POS.y)
				orientation = TOP_RIGHT;
			else if (mouseX < INITIAL_POS.x && mouseY < INITIAL_POS.y)
				orientation = TOP_LEFT;
			else
				orientation = BOTTOM_LEFT;
			
			if (shifted && !space_pressed)
			{ /*	S Q U A R E  M O D E 	*/
				BOUNDS.width = CURRENT_POS.x - INITIAL_POS.x;
				BOUNDS.height = CURRENT_POS.y - INITIAL_POS.y;
				
				BOUNDS.width = (BOUNDS.width < 0) ? -BOUNDS.width : BOUNDS.width;
				BOUNDS.height = (BOUNDS.height < 0) ? -BOUNDS.height : BOUNDS.height;
				
				BOUNDS.width = (BOUNDS.width > BOUNDS.height) ? BOUNDS.height : BOUNDS.width;
				BOUNDS.height = (BOUNDS.height > BOUNDS.width) ? BOUNDS.width : BOUNDS.height;
				if (orientation == TOP_LEFT)
				{
					BOUNDS.x = INITIAL_POS.x - BOUNDS.width;
					BOUNDS.y = INITIAL_POS.y - BOUNDS.height;
				}
				if (orientation == TOP_RIGHT)
				{
					BOUNDS.y = INITIAL_POS.y - BOUNDS.height;
				}
				if (orientation == BOTTOM_LEFT)
				{
					BOUNDS.x = INITIAL_POS.x - BOUNDS.width;
				}
			}
			
			if (space_pressed)
			{ /*	D I S P L A C E M E N T 	*/
				
				orientation = initSpaceOrientation;
				if (orientation == TOP_LEFT)
				{
					BOUNDS.x = mouseX;
					BOUNDS.y = mouseY;
				}
				else if (orientation == TOP_RIGHT)
				{
					BOUNDS.x = mouseX - BOUNDS.width;
					BOUNDS.y = mouseY;
				}
				else if (orientation == BOTTOM_LEFT)
				{
					BOUNDS.x = mouseX;
					BOUNDS.y = mouseY - BOUNDS.height;
				}
				else
				{
					BOUNDS.x = mouseX - BOUNDS.width;
					BOUNDS.y = mouseY - BOUNDS.height;
				}
				
				INITIAL_POS.x = BOUNDS.x;
				INITIAL_POS.y = BOUNDS.y;
				
			}
			
			if (!shifted && !space_pressed)
			{ /*	U S A L    C A S E	*/
				BOUNDS.x = (CURRENT_POS.x < INITIAL_POS.x) ? CURRENT_POS.x : INITIAL_POS.x;
				BOUNDS.y = (CURRENT_POS.y < INITIAL_POS.y) ? CURRENT_POS.y : INITIAL_POS.y;
				
				BOUNDS.width = CURRENT_POS.x - INITIAL_POS.x;
				BOUNDS.height = CURRENT_POS.y - INITIAL_POS.y;
				
				BOUNDS.width = (BOUNDS.width < 0) ? -BOUNDS.width : BOUNDS.width;
				BOUNDS.height = (BOUNDS.height < 0) ? -BOUNDS.height : BOUNDS.height;
			}
			
			checkValidBounds();
			
			draw();
		}
		
		private function draw():void
		{
			canva.x = BOUNDS.x;
			canva.y = BOUNDS.y;
			
			c_BOTTOM_RIGHT.x = BOUNDS.width - c_BOTTOM_RIGHT.width;
			c_BOTTOM_RIGHT.y = BOUNDS.height - c_BOTTOM_RIGHT.width;
			
			c_TOP_LEFT.x = BOUNDS.width - c_TOP_LEFT.width;
			c_BOTTOM_LEFT.y = BOUNDS.height - c_BOTTOM_LEFT.height;
			
			canva.graphics.clear();
			
			/*_______________________________________________________________________
			/*															G R I D 	 */
			
			var cols:int = BOUNDS.width / STEP;
			var rows:int = BOUNDS.height / STEP;
			canva.graphics.lineStyle(1, 0, .5);
			for (var i:int = 0; i < cols; i++)
			{
				canva.graphics.moveTo(STEP + i * STEP, 1);
				canva.graphics.lineTo(STEP + i * STEP, BOUNDS.height);
			}
			for (i = 0; i < rows; i++)
			{
				canva.graphics.moveTo(1, STEP + i * STEP);
				canva.graphics.lineTo(BOUNDS.width, STEP + i * STEP);
			}
			canva.graphics.endFill();
			
			/*___________________________________________________________________________
			/*													O R I E N T A T I O N 	 */
			canva.graphics.lineStyle(1, 0x55dd55, .6);
			switch (orientation)
			{
				case BOTTOM_RIGHT: 
					angle = Math.atan2(BOUNDS.height, BOUNDS.width);
					canva.graphics.moveTo(0, 0);
					canva.graphics.lineTo(BOUNDS.width, BOUNDS.height);
					break;
				case BOTTOM_LEFT: 
					angle = Math.atan2(BOUNDS.height, -BOUNDS.width);
					canva.graphics.moveTo(BOUNDS.width, 0);
					canva.graphics.lineTo(0, BOUNDS.height);
					break;
				case TOP_LEFT: 
					angle = Math.atan2(-BOUNDS.height, -BOUNDS.width);
					canva.graphics.moveTo(0, 0);
					canva.graphics.lineTo(BOUNDS.width, BOUNDS.height);
					break;
				case TOP_RIGHT: 
					angle = Math.atan2(-BOUNDS.height, BOUNDS.width);
					canva.graphics.moveTo(0, BOUNDS.height);
					canva.graphics.lineTo(BOUNDS.width, 0);
					break;
			}
			canva.graphics.moveTo(BOUNDS.width * .5 + 5 * Math.cos(angle + .75 * Math.PI), BOUNDS.height * .5 + 5 * Math.sin(angle + .75 * Math.PI));
			canva.graphics.lineTo(BOUNDS.width * .5, BOUNDS.height * .5);
			canva.graphics.lineTo(BOUNDS.width * .5 + 5 * Math.cos(angle - .75 * Math.PI), BOUNDS.height * .5 + 5 * Math.sin(angle - .75 * Math.PI));
			canva.graphics.moveTo(BOUNDS.width * .5 + 5 * Math.cos(angle + .75 * Math.PI), BOUNDS.height * .5 + 5 * Math.sin(angle + .75 * Math.PI));
			canva.graphics.lineTo(BOUNDS.width * .5 + 5 * Math.cos(angle), BOUNDS.height * .5 + 5 * Math.sin(angle));
			canva.graphics.lineTo(BOUNDS.width * .5 + 5 * Math.cos(angle - .75 * Math.PI), BOUNDS.height * .5 + 5 * Math.sin(angle - .75 * Math.PI));
			canva.graphics.endFill();
			
			/*_______________________________________________________________________
			/*															B O R D E R 	 */
			with (canva.graphics)
			{
				beginFill(0xffffff, .1);
				lineStyle(1, 0xe33333, .5);
				drawRect(0, 0, BOUNDS.width, BOUNDS.height);
				endFill();
			}
			
			/*_______________________________________________________________________
			/*													I N T E R A C T I O N 	 */
			with (dragableZone.graphics)
			{
				clear();
				beginFill(0xff0000, 0);
				drawRect(1, 1, BOUNDS.width - 2, BOUNDS.height - 2);
				endFill();
			}
			
			if ((BOUNDS.width < c_BOTTOM_LEFT.width * 2) || (BOUNDS.height < c_BOTTOM_LEFT.height * 2))
			{
				c_BOTTOM_LEFT.alpha = 0;
				c_TOP_LEFT.alpha = 0;
				c_BOTTOM_RIGHT.alpha = 0;
				c_TOP_RIGHT.alpha = 0;
			}
			else if (c_BOTTOM_LEFT.alpha == 0)
			{
				c_BOTTOM_LEFT.alpha = 1;
				c_TOP_LEFT.alpha = 1;
				c_BOTTOM_RIGHT.alpha = 1;
				c_TOP_RIGHT.alpha = 1;
			}
			
			console.feedInfos(BOUNDS, angle, orientation);
		}
		
		private function removeSelection():void
		{
			canva.graphics.clear();
			c_BOTTOM_RIGHT.alpha = c_TOP_RIGHT.alpha = c_TOP_LEFT.alpha = c_BOTTOM_LEFT.alpha = 0;
			handleCanvaOut(null);
			BOUNDS = new Rectangle();
			console.feedInfos(BOUNDS, 0);
		}
		
		private function checkValidBounds():Boolean
		{
			var change:Boolean = false;
			if (BOUNDS.x < 0)
			{
				BOUNDS.width += BOUNDS.x;
				BOUNDS.x = 0;
				change = true;
			}
			if (BOUNDS.y < 0)
			{
				BOUNDS.height += BOUNDS.y;
				BOUNDS.y = 0;
				change = true;
			}
			if ((BOUNDS.x + BOUNDS.width) > stage.stageWidth)
			{
				BOUNDS.width = stage.stageWidth - BOUNDS.x;
				change = true;
			}
			if ((BOUNDS.y + BOUNDS.height) > stage.stageHeight)
			{
				BOUNDS.height = stage.stageHeight - BOUNDS.y;
				change = true;
			}
			return change;
		}
		
		private function handleResize(e:Event):void
		{
			contact.width = stage.stageWidth;
			contact.height = stage.stageHeight;
		}
		
		/*	Dispose	*/
		private function close(e:Event):void
		{
			_stage.removeEventListener(Event.RESIZE, handleResize);
			contact.removeEventListener(MouseEvent.MOUSE_DOWN, handleDown);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, handleUp);
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_stage.removeEventListener(KeyboardEvent.KEY_UP, handleKeyUp);
			dragableZone.removeEventListener(MouseEvent.MOUSE_OVER, handleCanvaOver);
			dragableZone.removeEventListener(MouseEvent.MOUSE_OUT, handleCanvaOut);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMove);
			dragableZone.removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			removeEventListener(Event.ENTER_FRAME, _oef);
			
			console.removeEventListener(Event.CLOSE, close);
			console.removeEventListener(MouseEvent.ROLL_OVER, overConsole);
			console.removeEventListener(MouseEvent.ROLL_OUT, outConsole);
			removeChild(console);
			console = null;
			
			if (_stage.contains(cursor))
			{
				_stage.removeChild(cursor);
				cursor.stopDrag();
			}
			cursor = null;
			Mouse.show();
			
			canva.removeChild(c_TOP_LEFT);
			c_TOP_LEFT = null;
			canva.removeChild(c_TOP_RIGHT);
			c_TOP_RIGHT = null;
			canva.removeChild(c_BOTTOM_LEFT);
			c_BOTTOM_LEFT = null;
			canva.removeChild(c_BOTTOM_RIGHT);
			c_BOTTOM_RIGHT = null;
			canva.removeChild(dragableZone);
			dragableZone = null;
			removeChild(canva);
			canva = null;
			_stage = null;
			
			removeChild(contact);
			contact = null;
			parent.removeChild(this);
			
			INITIAL_POS = null;
			CURRENT_POS = null;
			SPACE_INIT_POS = null;
			SPACE_INIT_MOUSE = null;
			BOUNDS = null;
			
			onStage = false;
		}
		
		private function getCorner():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.beginFill(0x656565, .6);
			sp.graphics.lineStyle(1, 0xe33333, .5);
			sp.graphics.drawRect(0, 0, 10, 10);
			sp.graphics.endFill();
			
			return sp;
		}
		
		private function getCrossCursor():Sprite
		{
			var sp:Sprite = new Sprite();
			sp.graphics.lineStyle(1, 0);
			sp.graphics.moveTo(-6, 0);
			sp.graphics.lineTo(6.5, 0);
			sp.graphics.moveTo(0, -6);
			sp.graphics.lineTo(0, 6.5);
			sp.graphics.endFill();
			sp.mouseEnabled = false;
			
			return sp;
		}
	}

}
import flash.display.BlendMode;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

class MeasureConsole extends Sprite
{
	public static const TOP_LEFT:int = 0;
	public static const TOP_RIGHT:int = 1;
	public static const BOTTOM_LEFT:int = 2;
	public static const BOTTOM_RIGHT:int = 3;
	
	private var bodyInfo:Sprite;
	private var bodyColors:Sprite;
	private var headInfo:Sprite;
	private var headColors:Sprite;
	private var _stage:Stage;
	private var _free:Boolean = true;
	private var memPos:Point = new Point();
	private var title:TextField;
	private var degLabel:TextField;
	private var radLabel:TextField;
	private var heightLabel:TextField;
	private var widthLabel:TextField;
	private var yToLabel:TextField;
	private var xToLabel:TextField;
	private var yLabel:TextField;
	private var xLabel:TextField;
	private var angleLabel:TextField;
	private var sizeLabel:TextField;
	private var targetPosLabel:TextField;
	private var initPosLabel:TextField;
	private var cross:Sprite;
	private var diagonalLabel:TextField
	private var titleColors:TextField;;
	private var RLabel:TextField;
	private var BLabel:TextField;
	private var GLabel:TextField;
	private var hexaLabel:TextField;
	
	public function MeasureConsole()
	{
		addEventListener(Event.ADDED_TO_STAGE, init);
	}
	
	private function init(e:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, init);
		
		this.blendMode = BlendMode.LAYER;
		_stage = stage;
		_build();
		
		headInfo.addEventListener(MouseEvent.MOUSE_DOWN, handleDrag);
		headInfo.addEventListener(MouseEvent.CLICK, switchInfosView);
		headColors.addEventListener(MouseEvent.CLICK, switchInfosView);
		
		memPos = new Point(x, y);
	}
	
	private function handleDrag(e:MouseEvent):void
	{
		_free = false;
		_stage.addEventListener(MouseEvent.MOUSE_UP, handleUp);
		this.startDrag();
	}
	
	private function handleUp(e:MouseEvent):void
	{
		_free = true;
		this.stopDrag();
		_stage.removeEventListener(MouseEvent.MOUSE_UP, handleUp);
	}
	
	private function _build():void
	{
		/*_____________________________________________________________________
		/*												P O S I T I O N S   I N F O S 	*/
		headInfo = new Sprite();
		
		headInfo.graphics.lineStyle(1, 0xe3e4e5, 1, true);
		headInfo.graphics.beginFill(0xfff9ff);
		headInfo.graphics.drawRoundRectComplex(0, 0, 160, 14, 4, 4, 0, 0);
		headInfo.graphics.endFill();
		
		title = getTextField();
		title.text = "Informations";
		headInfo.addChild(title);
		cross = getCloseCross();
		cross.addEventListener(MouseEvent.CLICK, handleCloseMeasurement);
		headInfo.addChild(cross);
		addChild(headInfo);
		
		bodyInfo = new Sprite();
		bodyInfo.graphics.lineStyle(1, 0xe3e4e5, 1, true);
		bodyInfo.graphics.beginFill(0xfbfbf6);
		bodyInfo.graphics.drawRect(0, 0, 160, 175);
		bodyInfo.graphics.endFill();
		bodyInfo.y = 14;
		addChildAt(bodyInfo, 0);
		bodyInfo.visible = true;
		
		bodyInfo.graphics.lineStyle(1, 0xe8e8e8, .5);
		initPosLabel = getTextField();
		initPosLabel.text = "starting position";
		initPosLabel.x = 3;
		bodyInfo.addChild(initPosLabel);
		xLabel = getTextField();
		xLabel.y = initPosLabel.height;
		xLabel.x = 3;
		xLabel.text = "X : ";
		bodyInfo.addChild(xLabel);
		yLabel = getTextField();
		yLabel.y = xLabel.y;
		yLabel.x = 80;
		yLabel.text = "Y : ";
		bodyInfo.addChild(yLabel);
		
		bodyInfo.graphics.moveTo(8, xLabel.y + xLabel.height + 8);
		bodyInfo.graphics.lineTo(150, xLabel.y + xLabel.height + 8);
		
		targetPosLabel = getTextField();
		targetPosLabel.text = "final position";
		targetPosLabel.y = yLabel.y + yLabel.height + 8;
		targetPosLabel.x = 3;
		bodyInfo.addChild(targetPosLabel);
		xToLabel = getTextField();
		xToLabel.y = targetPosLabel.y + targetPosLabel.height;
		xToLabel.x = 3;
		xToLabel.text = "X : ";
		bodyInfo.addChild(xToLabel);
		yToLabel = getTextField();
		yToLabel.y = targetPosLabel.y + targetPosLabel.height;
		yToLabel.x = 80;
		yToLabel.text = "Y : ";
		bodyInfo.addChild(yToLabel);
		
		bodyInfo.graphics.moveTo(8, xToLabel.y + xToLabel.height + 8);
		bodyInfo.graphics.lineTo(150, xToLabel.y + xToLabel.height + 8);
		
		sizeLabel = getTextField();
		sizeLabel.text = "Size";
		sizeLabel.y = yToLabel.y + yToLabel.height + 8;
		sizeLabel.x = 3;
		bodyInfo.addChild(sizeLabel);
		widthLabel = getTextField();
		widthLabel.y = sizeLabel.y + sizeLabel.height;
		widthLabel.x = 3;
		widthLabel.text = "W : ";
		bodyInfo.addChild(widthLabel);
		heightLabel = getTextField();
		heightLabel.y = sizeLabel.y + sizeLabel.height;
		heightLabel.x = 80;
		heightLabel.text = "H : ";
		bodyInfo.addChild(heightLabel);
		diagonalLabel = getTextField();
		diagonalLabel.y = heightLabel.y + heightLabel.height;
		diagonalLabel.x = 3;
		diagonalLabel.text = "Diagonal : ";
		bodyInfo.addChild(diagonalLabel);
		
		bodyInfo.graphics.moveTo(8, diagonalLabel.y + diagonalLabel.height + 8);
		bodyInfo.graphics.lineTo(150, diagonalLabel.y + diagonalLabel.height + 8);
		
		angleLabel = getTextField();
		angleLabel.text = "Rotation";
		angleLabel.y = diagonalLabel.y + diagonalLabel.height + 8;
		angleLabel.x = 3;
		bodyInfo.addChild(angleLabel);
		radLabel = getTextField();
		radLabel.y = angleLabel.y + angleLabel.height;
		radLabel.x = 3;
		radLabel.text = "rad : ";
		bodyInfo.addChild(radLabel);
		degLabel = getTextField();
		degLabel.y = angleLabel.y + angleLabel.height;
		degLabel.x = 80;
		degLabel.text = "deg : ";
		bodyInfo.addChild(degLabel);
		
		/*_____________________________________________________________________
		/*												C O L O R S   I N F O S 		*/
		headColors = new Sprite();
		
		headColors.graphics.lineStyle(1, 0xe3e4e5, 1, true);
		headColors.graphics.beginFill(0xfff9ff);
		headColors.graphics.drawRect(0, 0, 160, 14);
		headColors.graphics.endFill();
		headColors.y = bodyInfo.y + bodyInfo.height;
		
		titleColors = getTextField();
		titleColors.text = "Colors";
		headColors.addChild(titleColors);
		addChild(headColors);
		
		bodyColors = new Sprite();
		bodyColors.graphics.lineStyle(1, 0xe3e4e5, 1, true);
		bodyColors.graphics.beginFill(0xfbfbf6);
		bodyColors.graphics.drawRoundRectComplex(0, 0, 160, 55, 0, 0, 4, 4);
		bodyColors.graphics.endFill();
		bodyColors.y = headColors.y + 14;
		addChildAt(bodyColors, 0);
		bodyColors.visible = true;
		
		
		RLabel = getTextField();
		RLabel.x = 3;
		RLabel.text = "R : ";
		bodyColors.addChild(RLabel);
		GLabel = getTextField();
		GLabel.x = 80;
		GLabel.text = "G : ";
		bodyColors.addChild(GLabel);
		BLabel= getTextField();
		BLabel.y = RLabel.y + RLabel.height;
		BLabel.x = 3;
		BLabel.text = "G : ";
		bodyColors.addChild(BLabel);
		hexaLabel = getTextField();
		hexaLabel.y = BLabel.y + BLabel.height;
		hexaLabel.x = 3;
		hexaLabel.text = "hex : 0x";
		hexaLabel.type = TextFieldType.INPUT;
		bodyColors.addChild(hexaLabel);
		bodyColors.visible = false;
	}
	
	public function feedInfos(data:Rectangle, angle:Number, orientation:int = 0):void
	{
		xLabel.text = (orientation == TOP_LEFT || orientation == BOTTOM_LEFT) ? "X : " + (data.x + data.width) : "X : " + data.x;
		yLabel.text = (orientation == TOP_LEFT || orientation == TOP_RIGHT) ? "Y : " + (data.y + data.height) : "Y : " + data.y;
		xToLabel.text = (orientation == TOP_LEFT || orientation == BOTTOM_LEFT) ? "X : " + data.x : "X : " + (data.x + data.width);
		yToLabel.text = (orientation == TOP_LEFT || orientation == TOP_RIGHT) ? "Y : " + data.y : "Y : " + (data.y + data.height);
		widthLabel.text = "W : " + data.width;
		heightLabel.text = "H : " + data.height;
		diagonalLabel.text = "Diagonal : " + (Point.distance(new Point(), new Point(data.width, data.height))).toFixed(1);
		radLabel.text = "rad : " + (angle / Math.PI).toFixed(2);
		degLabel.text = "deg : " + (angle / Math.PI * 180).toFixed(1) + "°";
	}
	
	public function feedColors(a:uint, r:uint, g:uint, b:uint):void
	{
		RLabel.text = "R : "+r;
		GLabel.text = "G : " + g;
		BLabel.text = "G : " + b;
		
		//var alph:String = (a.toString(16).length > 1)?a.toString(16):"0" + a.toString(16);
		var red:String = (r.toString(16).length > 1)?r.toString(16):"0" + r.toString(16);
		var green:String = (g.toString(16).length > 1)?g.toString(16):"0" + g.toString(16);
		var blue:String = (b.toString(16).length > 1)?b.toString(16):"0" + b.toString(16);
		
		hexaLabel.text = "hex : 0x"+red+green+blue;
	}
	
	
	private function switchInfosView(e:MouseEvent):void
	{
		if (e.currentTarget == headInfo)
		{
			if (x != memPos.x || y != memPos.y)
			{
				memPos = new Point(x, y);
			}
			else
			{
				bodyInfo.visible = !bodyInfo.visible;
				headColors.y = (bodyInfo.visible) ? bodyInfo.y + bodyInfo.height : headInfo.y + headInfo.height;
				bodyColors.y = headColors.y + 14;
			}
		}
		else
		{
			bodyColors.visible = !bodyColors.visible;
		}
	}
	
	private function getTextField(left:Boolean = true):TextField
	{
		var tf:TextField = new TextField();
		tf.multiline = false;
		tf.wordWrap = false;
		tf.autoSize = (left) ? TextFieldAutoSize.LEFT : TextFieldAutoSize.RIGHT;
		//tf.selectable = false;
		tf.mouseEnabled = false;
		
		var format:TextFormat = new TextFormat();
		format.font = "Verdana";
		format.color = 0x000000;
		format.size = 10;
		
		tf.defaultTextFormat = format;
		
		return tf;
	}
	
	private function getCloseCross():Sprite
	{
		var sp:Sprite = new Sprite();
		sp.graphics.beginFill(0xff0000, 0);
		sp.graphics.drawRect(0, 0, 10, 10);
		sp.graphics.endFill();
		
		sp.graphics.lineStyle(0, 0);
		sp.graphics.moveTo(2, 2);
		sp.graphics.lineTo(8, 8);
		sp.graphics.moveTo(8, 2);
		sp.graphics.lineTo(2, 8);
		sp.graphics.endFill();
		
		sp.x = 148;
		sp.y = 2;
		
		sp.buttonMode = true;
		
		return sp;
	}
	
	private function handleCloseMeasurement(e:MouseEvent):void
	{
		cross.removeEventListener(MouseEvent.CLICK, handleCloseMeasurement);
		
		bodyInfo.removeChild(initPosLabel);
		initPosLabel = null;
		bodyInfo.removeChild(xLabel);
		xLabel = null;
		bodyInfo.removeChild(yLabel);
		yLabel = null;
		bodyInfo.removeChild(targetPosLabel);
		targetPosLabel = null;
		bodyInfo.removeChild(xToLabel);
		xToLabel = null;
		bodyInfo.removeChild(yToLabel);
		yToLabel = null;
		bodyInfo.removeChild(sizeLabel);
		sizeLabel = null;
		bodyInfo.removeChild(widthLabel);
		widthLabel = null;
		bodyInfo.removeChild(heightLabel);
		heightLabel = null;
		bodyInfo.removeChild(diagonalLabel);
		diagonalLabel = null;
		bodyInfo.removeChild(angleLabel);
		angleLabel = null;
		bodyInfo.removeChild(radLabel);
		radLabel = null;
		bodyInfo.removeChild(degLabel);
		degLabel = null;
		removeChild(bodyInfo);
		bodyInfo = null;
		
		headInfo.removeChild(title);
		title = null;
		headInfo.removeChild(cross);
		cross = null;
		headInfo.removeEventListener(MouseEvent.MOUSE_DOWN, handleDrag);
		headInfo.removeEventListener(MouseEvent.CLICK, switchInfosView);
		removeChild(headInfo);
		headInfo = null;
		
		headColors.removeChild(titleColors);
		titleColors = null;
		headColors.removeEventListener(MouseEvent.CLICK, switchInfosView);
		removeChild(headColors);
		headColors = null;
		
		bodyColors.removeChild(RLabel);
		RLabel = null;
		bodyColors.removeChild(GLabel);
		GLabel = null;
		bodyColors.removeChild(BLabel);
		BLabel = null;
		bodyColors.addChild(hexaLabel);
		hexaLabel = null;
		removeChild(bodyColors);
		bodyColors = null;
		
		_stage.removeEventListener(MouseEvent.MOUSE_UP, handleUp);
		_stage = null;
		
		dispatchEvent(new Event(Event.CLOSE));
	}
	
	public function get free():Boolean	{		return _free;	}
}