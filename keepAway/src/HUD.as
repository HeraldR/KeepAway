package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class HUD extends Entity
	{
		private var timerAddition:TimerAddition;
		private var multiplierTimer:MultiplierTimer;
		private var multiplierDisplay:MultiplierDisplay;
		private var score:Score;
		
		public function HUD() 
		{
			
		}
		
		override public function added():void {
			timerAddition = new TimerAddition(FP.width - 32, 16);
			world.add(timerAddition);
			
			multiplierDisplay = new MultiplierDisplay(FP.width - 256, 16);
			world.add(multiplierDisplay);
			
			multiplierTimer = new MultiplierTimer(FP.width - 64, 16);
			world.add(multiplierTimer);
			
			score = new Score(FP.width - 256, FP.height - 48);
			world.add(score);
		}
		
		public function multiplierHit():void {
			multiplierDisplay.increment();
			multiplierTimer.addTime(60);
			timerAddition.addColorTimer(60);
		}
		
	}

}