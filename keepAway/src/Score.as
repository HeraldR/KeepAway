package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Score extends Entity
	{
		public var scoreText:Text = new Text("0", 0, 0);
		public var total:int = 1;
		
		public function Score(xx:int, yy:int) 
		{
			x = xx;
			y = yy;
			scoreText.color = 0x000000;
			scoreText.size = 32;
			scoreText.align = "right";
			scoreText.width = 256;
			graphic = scoreText;
		}
		
		public function newTotal():void {
			scoreText.text = String(total);
		}
		
	}

}