package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class TitleScreen extends World
	{
		private var keep:Entity;
		private var away:Entity;
		private var keepSprite:Spritemap;
		private var awaySprite:Spritemap;
		private var slideRight:VarTween = new VarTween(completeSlideRight);
		private var slideLeft:VarTween = new VarTween();
		private var keepMouse:Boolean = false;
		private var vx:Number = 0;
		private var vy:Number = 0;

		
		public function TitleScreen() 
		{
			keepSprite = new Spritemap(GC.TITLEIMAGE, 200, 128);
			awaySprite = new Spritemap(GC.TITLEIMAGE, 200, 128);
			keepSprite.add("keep", [0], 1, true);
			awaySprite.add("away", [1], 1, true);
			keep = new Entity(-keepSprite.width, FP.halfHeight, keepSprite);
			away = new Entity(FP.width, FP.halfHeight, awaySprite);
			keepSprite.play("keep", true, 0);
			awaySprite.play("away", true, 0);
			add(keep);
			add(away);
		}
		
		override public function update():void {
			super.update();
			if (Input.mousePressed) {
				if (!slideLeft.active  && (slideLeft.percent != 1)) {
					keep.y = Input.mouseY;
					away.y = Input.mouseY;
					var xx:Number = Input.mouseX;
					slideRight.tween(keep, "x", xx - 200, 1, Ease.quadOut);
					slideLeft.tween(away, "x", xx, 1, Ease.backOut);
					addTween(slideLeft, true);
					addTween(slideRight, true);
				} else {
					FP.world = new Game(GC.LEVEL7);
				}
				
			}		

			if (keepMouse) {
				keep.x = mouseX;
				keep.y = mouseY;
				updateMagnet();
				away.moveBy(vx, vy);
			}
		}
					
		private function completeSlideRight():void {
			keepMouse = true;
		}
		
		private function updateMagnet():void {
			var dx:Number = Input.mouseX - away.x;
			var dy:Number = Input.mouseY - away.y;
			var maxforce:Number = 50;
			
			var distance:Number = Math.sqrt (dx * dx + dy * dy);
			var force:Number = Math.floor(maxforce / distance);
			
			var angle:Number = Math.atan2(dy, dx);
			var speed:Point = new Point(0, 0);
			speed.x = force * Math.cos(angle);
			speed.y = force * Math.sin(angle);
			
			vx -= speed.x;
			vy -= speed.y;
		}
		
		
	}

}