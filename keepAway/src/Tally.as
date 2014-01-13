package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Tally extends Entity
	{
		private var sprite:Spritemap = new Spritemap(GC.TALLY, 32, 32);
		private var hud:HUD;
		
		public function Tally(xx:int, yy:int) 
		{
			x = xx;
			y = yy;
			graphic = sprite;
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void  {
			if (hud == null) { hud = HUD(world.classFirst(HUD)); }
			if (collide("ball", x, y)) {
				hud.tally();
			}
				
		}
	}

}