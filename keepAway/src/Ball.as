package  
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Ball extends Entity {
		private var gravity:Number = 0.25;
		private var friction:Number = .05;
		private const MAX_SPEED:Number = 10;
		
		private var timer:uint = 0;
		private var collisionYTime:uint = 0;
		private var collisionXTime:uint = 0;
		private var tick1x:Number = 0;
		private var tick2x:Number = 0;
		private var tick3x:Number = 0;
		private var tick4x:Number = 0;
		private var tick5x:Number = 0;
		
		private var tick1y:Number = 0;
		private var tick2y:Number = 0;
		private var tick3y:Number = 0;
		private var tick4y:Number = 0;
		private var tick5y:Number = 0;
		
		public var vx:Number = 0;
		public var vy:Number = 0;
		private var maxForce:Number = 150;
		private var squishXY:MultiVarTween = new MultiVarTween(squishBackXY);
		private var ballSpriteMap:Spritemap = new Spritemap(GC.BALL, 32, 32);
		private var ballPixelMask:Spritemap = new Spritemap(GC.BALLMASK, 32, 32);
		public var ballImpactEmitter:ImpactEmitter;

		
		public function Ball(xx:int, yy:int) {
			super(x, y, ballSpriteMap);
			graphic = ballSpriteMap;
			setHitbox(32, 32, 0, 0);
			x = xx;
			y = yy;
			mask = new Pixelmask(ballPixelMask.getBuffer());
			type = "ball";

			addTween(squishXY, false);		
		}
		
		override public function update():void {
			timer = timer + 1;
			tick5x = tick4x;
			tick4x = tick3x;
			tick3x = tick2x;
			tick2x = tick1x;
			tick1x = x;

			tick5y = tick4y;
			tick4y = tick3y;
			tick3y = tick2y;
			tick2y = tick1y;
			tick1y = y;
			
			
			updateMagnet();
			
			vy += gravity;
			
			// slows the ball down in every direction it is going
			if (vx > 0) { vx -= friction; }
			else { vx += friction; }
			if (vy > 0) { vy -= friction; }
			else { vy += friction; }
			
			// Prevents the ball from going too fast
			if (Math.abs(vx) > Math.abs(MAX_SPEED)) { 
				if (vx > 0) { vx = MAX_SPEED; }
				else { vx = -MAX_SPEED; }
			}
			if (Math.abs(vy) > Math.abs(MAX_SPEED)) { 
				if (vy > 0) { vy = MAX_SPEED; }
				else { vy = -MAX_SPEED; }
			}
			
			moveBy(vx, vy, "grid", true);		
			
			if ( (tick1x == tick5x) && (tick1y == tick5y)) {
				var a:Number = FP.angle(x, y, Input.mouseX, Input.mouseY);
				if ( (a >= 225) && (a < 270) ) {
					if (!collide("grid", x - 5, y - 5) ) {
						x = x - 5;
						y = y - 5;
					}
				} else if ( (a >= 270) && (a <= 315) ) {
					if (!collide("grid", x + 5, y - 5) ) {
						x = x + 5;
						y = y - 5;
					}
				}
			}
		}
		
		override public function moveCollideX(e:Entity):Boolean {
			collisionXTime = timer;
			vx = -vx * .5;
			squishXY.tween(ballSpriteMap, { scaleX:.8, scaleY:1.2 }, .1, Ease.quadOut);
			squishXY.start();
			ballImpactEmitter.xImpact();
			return true;
		}
		
		override public function moveCollideY(e:Entity):Boolean {
			if ((collisionXTime == timer) && (vy < 0)) {
				trace("vx: ", vx);
				trace("vy: ", vy);
			} else {
				vy = -vy * .5;
			}
		//	vy = -vy * .5;
			ballSpriteMap.scaleX = 1.1;
			ballSpriteMap.scaleY = .9;
			squishXY.tween(ballSpriteMap, { scaleX:1.2, scaleY:.8 }, .1, Ease.quadOut);
			squishXY.start();
			ballImpactEmitter.yImpact();
			
			collisionYTime = timer;
			return true;
		}
		
		// moveCollidetweens the ball back to it's original shape after it has finished stretching it
		private function squishBackXY():void {
			squishXY.tween(ballSpriteMap, { scaleX:1, scaleY:1 }, .1, Ease.quadOut);
		}
		
		// this is straight from a stackexchange thread
		private function updateMagnet():void {
			var dx:Number = Input.mouseX - x;
			var dy:Number = Input.mouseY - y;
			var distance:Number = Math.sqrt (dx * dx + dy * dy);
			var force:Number = Math.floor(maxForce / distance);

			var angle:Number = Math.atan2(dy, dx);
			var speedx:Number = force * Math.cos(angle);
			var speedy:Number = force * Math.sin(angle);
			
			vx -= speedx;
			vy -= speedy;
		}
		
	}

}