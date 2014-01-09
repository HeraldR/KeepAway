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
		public var multiplierTimer:MultiplierTimer;
		
		public function MultiplierDisplay() 
		{
			multiplierText.color = 0xFF11FF;
			graphic = multiplierText;
			multiplierText.x = FP.width - 256;
			multiplierText.y = 16;
			type = "md";
		}
		
		override public function update():void { 
			if (multiplierTimer == null) { multiplierTimer = MultiplierTimer(world.classFirst(MultiplierTimer)); }
		}
		
		public function increment():void {
			multiplierNumber = multiplierNumber + 1;
			multiplierText.text = "x" + String(multiplierNumber);
			multiplierTimer.addTime(60);
		}
		
	}

}