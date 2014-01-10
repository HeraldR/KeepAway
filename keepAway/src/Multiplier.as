package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Multiplier extends Entity {
		private var sprite:Spritemap = new Spritemap(GC.MULTIPLIER, 32, 32);
		private var hud:HUD;
		private var hitTimer:uint = 0;
		private var tweenToWhite:ColorTween;
		private var tweenToOriginalColor:ColorTween;
		
		private var shakeTime:uint = 0;
		private var shakeAmount:uint = 0;
		private var shakeOrigin:Point = new Point(0, 0);
		
		public function Multiplier(xx:int, yy:int) {
			graphic = sprite;
			x = xx;
			y = yy;
			setHitbox(32, 32, 0, 0);
			sprite.color = 0xFFFF00;
		}
		
		override public function added():void {
			super.added();
		}
		
		override public function update():void {
			super.update();
			if (hud == null) { hud = HUD(world.classFirst(HUD)); }
			if (collide("ball", x, y)) {
				if(hitTimer == 0) {
					hud.multiplierHit();
					hitAnimations();
					shake(30, 4);
					hitTimer = 120;
				}
			}
			
			checkTweensForColorChange();
			if (hitTimer > 0) { hitTimer = hitTimer - 1; }
			
			if (shakeTime > 0) {
				shakeTime--;
				x = shakeOrigin.x;
				y = shakeOrigin.y;
				x = Math.round((x - shakeAmount) + shakeAmount * 2 * FP.random);
				y = Math.round((y - shakeAmount) + shakeAmount * 2 * FP.random);
				if (shakeTime == 0) { 
					x = shakeOrigin.x;
					y = shakeOrigin.y;
					if (shakeAmount > 0) { shake(30, (shakeAmount - 1)); }
				}
			}
		}
		
		private function checkTweensForColorChange():void {
			if (tweenToOriginalColor != null) { 
				if(tweenToOriginalColor.active) {
					sprite.color = tweenToOriginalColor.color; 
				}
			}
			if (tweenToWhite != null) {
				if(tweenToWhite.active) {
					sprite.color = tweenToWhite.color; 
				}
			}
		}
		
		private function hitAnimations():void { 
			sprite.color = 0xFFFF00;
			tweenToWhite = new ColorTween(transitionToOriginalColor);
			tweenToWhite.tween(30, 0xFFFF00, 0xFFFFFF, 1, 1, Ease.quadOut);
			addTween(tweenToWhite, true);
			var squishXY:MultiVarTween = new MultiVarTween(squishBackXY);	
			squishXY.tween(sprite, { scaleX:1.2, scaleY:1.2 }, 60,  Ease.quadOut);
			addTween(squishXY, true);	
		}
		
		private function transitionToOriginalColor():void {
			tweenToOriginalColor = new ColorTween();
			tweenToOriginalColor.tween(90, 0xFFFFFF, 0xFFFF00, 1, 1, Ease.quadOut);
			addTween(tweenToOriginalColor, true);
		}
		
		private function squishBackXY():void {
			var squishXY:MultiVarTween = new MultiVarTween(squishBackXY);
			squishXY.tween(sprite, { scaleX:1, scaleY:1 }, 60, Ease.quadOut);
			addTween(squishXY, true);
		}
		
		public function shake(time:int = 20, amount:Number = 4):void {
			shakeTime = time;
			shakeAmount = amount;
			shakeOrigin.x = x;
			shakeOrigin.y = y;
		}

	}

}