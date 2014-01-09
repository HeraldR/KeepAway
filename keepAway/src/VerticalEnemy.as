package  
{
	import bin.GameOver;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class VerticalEnemy extends Entity
	{
		private var sprite:Spritemap = new Spritemap(GC.VERTENEMY, 32, 32);
		private var yStart:int = 0;
		private var yEnd:int = 0;
		private var moveSpeed:int = 1;
		private var travelingDown:Boolean = true;
		
		public function VerticalEnemy(xx:int, yy:int) 
		{
			sprite.add("move", [1, 0, 1, 3], 2, true);
			graphic = sprite;
			sprite.play("move");
			x = xx;
			y = yy;
			yStart = y;
			yEnd = y + 32 * 4;
			setHitbox(32, 32, 0, 0);
			collidable = true;
		}
		
		override public function update():void {
			if ((y < yEnd) && travelingDown) {
				moveBy(0, moveSpeed);
			} else if ((y > yStart) && !travelingDown) {
				moveBy(0, -moveSpeed);
			} else {
				travelingDown = !travelingDown;
			}
			
			if (collide("ball", x, y)) {
				FP.world.removeAll();
				FP.world = new Game(GC.LEVEL); // *price is wrong sound*
			}
		}
		
	}

}