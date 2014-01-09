package  
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class ImpactEmitter extends Entity
	{
		private var impactEmitter:Emitter;
		private const EXPLOSION_SIZE:uint = 5;
		public var impactBall:Ball;
		
		public function ImpactEmitter()
		{
			impactEmitter = new Emitter(new BitmapData(1, 1), 1, 1);
			impactEmitter.newType("impact", [0]);
			impactEmitter.setAlpha("impact", 1, 0);
			impactEmitter.setMotion("impact", 0, 50, 120, 360, -5, -.3, Ease.quadOut);
			impactEmitter.relative = false;
			impactEmitter.visible = true;
			graphic = impactEmitter;
		}
		
		public function xImpact():void {
				for (var i:uint = 0; i < EXPLOSION_SIZE; i++) {
				if (impactBall.vx < 0) {
					impactEmitter.emit("impact", impactBall.x + 32, impactBall.y + impactBall.halfHeight);
				} else {
					impactEmitter.emit("impact", impactBall.x, impactBall.y + impactBall.halfHeight);
				}
			}
		}
		
		public function yImpact():void {
			for (var i:uint = 0; i < EXPLOSION_SIZE; i++) {
				if (impactBall.vy < 0) {
					impactEmitter.emit("impact", impactBall.x + impactBall.halfHeight, impactBall.y + impactBall.height);
				} else {
					impactEmitter.emit("impact", impactBall.x + impactBall.halfHeight, impactBall.y);
				}
			}
		}
		
	}

}