package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class MultiplierTimer extends Entity
	{
		private var multiplierTimerText:Text = new Text("60");
		private var timer:uint = 0;
		
		public function MultiplierTimer(xx:int, yy:int) 
		{
			graphic = multiplierTimerText;
			multiplierTimerText.color = 0xFF11FF;
			x = xx;
			y = yy;
		}
		
		override public function update():void {
			if (timer > 0) { timer = timer - 1; }
			multiplierTimerText.text = String(timer);
		}
		
		public function addTime(amount:uint):void { 
			timer = timer + amount;
		}
		
	}

}