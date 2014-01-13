package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Adder extends Entity
	{
		private var sprite:Spritemap = new Spritemap(GC.ADDER, 32 , 32);
		private var hud:HUD;
		private var hitTimer:uint = 0;
		
		public function Adder(xx:int, yy:int) 
		{
			x = xx;
			y = yy;
			graphic = sprite;
			setHitbox(32, 32, 0, 0);
		}
		
		override public function added():void {
			hud = world.classFirst(HUD) as HUD;
		}
		
		override public function update():void  {
			super.update();
			if (hud == null) { hud = HUD(world.classFirst(HUD)); }
			if (collide("ball", x, y)) {
				if(hitTimer == 0) {
				hitTimer = 120;
				hud.adderHit(5);
				}
			}
			if (hitTimer > 0) { hitTimer = hitTimer - 1; }
		}
	}

}