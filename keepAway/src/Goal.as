package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Goal extends Entity
	{
		public var goals:int = 0;
		
		public function Goal(xx:int, yy:int) 
		{
			graphic = new Image(GC.GOAL);
			x = xx;
			y = yy;
			setHitbox(32, 32, 0, 0);
			collidable = true;
		}
		
		override public function update():void {
			super.update();
			if (collide("ball", x, y)) {
				trace("collision!");
				FP.world = new ChickenDinner(); // winner winner
			}
		}
		
	}

}