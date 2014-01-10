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
		private var multiplierTimerText:Text = new Text("60", 128, 64);
		private var timerAddition:TimerAddition; // yadda yadda score hud
		private var timer:uint = 0;
		
		public function MultiplierTimer() 
		{
			graphic = multiplierTimerText;
			multiplierTimerText.color = 0xFF11FF;
			multiplierTimerText.x = FP.width - 64;
			multiplierTimerText.y = 16;
			timerAddition = new TimerAddition();  
			timerAddition.x = multiplierTimerText.x + 32;
			timerAddition.y = multiplierTimerText.y;
		}
		
		override public function added():void {
			world.add(timerAddition);
		}
		
		override public function update():void {
			if (timer > 0) { timer = timer - 1; }
			multiplierTimerText.text = String(timer);
		}
		
		public function addTime(amount:uint):void { 
			timer = timer + amount;
			timerAddition.addColorTimer(amount);
		}
		
	}

}