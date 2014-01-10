package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class MultiplierDisplay extends Entity
	{
		public var multiplierText:Text = new Text("x1");
		public var multiplierNumber:uint = 1;
		
		public function MultiplierDisplay(xx:int, yy:int) 
		{
			multiplierText.color = 0xFF11FF;
			graphic = multiplierText;
			x = xx;
			y = yy;
		}
		
		public function increment():void {
			multiplierNumber = multiplierNumber + 1;
			multiplierText.text = "x" + String(multiplierNumber);
		}
		
	}

}