package fr.digitas.tutorial.nodes {	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;	
	/**	 * @author Pierre Lepers	 */	public class Main extends Sprite {
		public function Main() {						stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;						addChild( new NodeEventsFlow_FC () );		}
	}}