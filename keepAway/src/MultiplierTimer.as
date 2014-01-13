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
		private var hud:HUD;
		
		public function MultiplierTimer(xx:int, yy:int, parentHud:HUD) 
		{
			graphic = multiplierTimerText;
			multiplierTimerText.color = 0xFF11FF;
			x = xx;
			y = yy;
			hud = parentHud;
		}
		
		override public function update():void {
			if (timer > 0) { 
				timer = timer - 1; 
			} else {
				hud.clearMultiplierDisplay();
			}
			multiplierTimerText.text = String(timer);
		}
		
		public function addTime(amount:uint):void { 
			timer = timer + amount;
		}
		
		public function clear():void {
			timer = 0;
		}
		
	}

}