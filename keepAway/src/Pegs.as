package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Pegs extends Entity {

		
		public function Pegs(xx:int, yy:int) {
			graphic = new Image(GC.PEG);
			x = xx;
			y = yy;
			setHitbox(4, 4, 0, 0);
			type = "peg";
		}
		
		override public function update():void {
			
		}
		
	}

}