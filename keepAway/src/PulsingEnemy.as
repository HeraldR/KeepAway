package 
{
	import bin.GameOver;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Grid;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class PulsingEnemy extends Entity
	{
		private var sprite:Spritemap = new Spritemap(GC.PULSEENEMY, 32, 32);
		public var targetBall:Ball;
		
		public function PulsingEnemy(xx:int, yy:int) 
		{
			sprite.add("move", [0], .25, true);
			graphic = sprite;
			sprite.play("move");
			x = xx;
			y = yy;
			setHitbox(32, 32, 0, 0);
			collidable = true;
			type = "pulsingenemy";
		}
		
		override public function update():void {
			if(targetBall != null) {
				moveTowards(targetBall.x, targetBall.y, 1, "grid", true );
				if (collide("ball", x, y)) {
				//FP.world.removeAll();
			//	FP.world = new Game(GC.LEVEL);// *price is wrong sound*
				}
			}
		}
		
		
	}

}