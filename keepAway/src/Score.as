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
		private var scoreText:Text = new Text("0", 0, 0);
		private var total:int = 1;
		
		public function Score(xx:int, yy:int) 
		{
			x = xx;
			y = yy;
			scoreText.color = 0x000000;
			scoreText.size = 16;
			scoreText.align = "right";
			scoreText.width = 256;
			graphic = scoreText;
		}
		
	}

}