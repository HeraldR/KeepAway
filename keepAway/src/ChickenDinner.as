package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class ChickenDinner extends World
	{
		private var sprite:Spritemap = new Spritemap(GC.WINNER, 128, 32);
		private var winEntity:Entity = new Entity(FP.halfWidth, FP.halfHeight, sprite);
		
		public function ChickenDinner() 
		{
			winEntity.graphic = sprite;
			add(winEntity);
		}
		
	}

}