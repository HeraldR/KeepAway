package 
{
	import bin.GameOver;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class HorizontalEnemy extends Entity
	{
		private var sprite:Spritemap = new Spritemap(GC.HORIZENEMY, 32, 32);
		private var xStart:int = 0;
		private var xEnd:int = 0;
		private var moveSpeed:int = 1;
		private var travelingRight:Boolean = true;
		
		public function HorizontalEnemy(xx:int, yy:int) 
		{
			sprite.add("move", [1, 0, 1, 3], 2, true);
			graphic = sprite;
			sprite.play("move");
			x = xx;
			y = yy;
			xStart = x;
			xEnd = x + 32 * 4;
			setHitbox(32, 32, 0, 0);
			collidable = true;
		}
		
		override public function update():void {
			if ((x < xEnd) && travelingRight) {
				moveBy(moveSpeed, 0);
			} else if ((x > xStart) && !travelingRight) {
				moveBy( -moveSpeed, 0);
			} else {
				travelingRight = !travelingRight;
			}
			if (collide("ball", x, y)) {
				FP.world.removeAll();
				FP.world = new Game(GC.LEVEL); // *price is wrong sound*
			}			
		}
		
	}

}