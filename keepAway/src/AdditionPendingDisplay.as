package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class AdditionPendingDisplay extends Entity
	{
		public var additionText:Text = new Text("0", 0, 0);
		public var total:int = 0;
		
		public function AdditionPendingDisplay(xx:int, yy:int) 
		{
			x = xx;
			y = yy;
			additionText.color = 0x000000;
			additionText.size = 32;
			additionText.align = "right";
			additionText.width = 256;
			graphic = additionText;
		}
		
		public function addPoints(amount:uint):void {
			total = amount + total;
			additionText.text = String(total);
		}
		
		public function clear():void {
			total = 0;
			additionText.text = "0";
		}
	}
	
}
