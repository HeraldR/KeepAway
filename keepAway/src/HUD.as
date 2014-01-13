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
		private var additionPendingDisplay:AdditionPendingDisplay;
		
		public function HUD() 
		{
			
		}
		
		override public function added():void {
			timerAddition = new TimerAddition(FP.width - 32, 16);
			world.add(timerAddition);
			
			multiplierDisplay = new MultiplierDisplay(FP.width - 256, 16);
			world.add(multiplierDisplay);
			
			multiplierTimer = new MultiplierTimer(FP.width - 64, 16, this);
			world.add(multiplierTimer);
			
			score = new Score(FP.width - 256, FP.height - 32);
			world.add(score);
			
			additionPendingDisplay = new AdditionPendingDisplay(FP.width -256, FP.height - 72);
			world.add(additionPendingDisplay);
		}
		
		public function multiplierHit():void {
			multiplierDisplay.increment();
			multiplierTimer.addTime(60);
			timerAddition.addColorTimer(60);
		}
		
		public function adderHit(amount:uint):void {
			multiplierTimer.addTime(10);
			additionPendingDisplay.addPoints(amount);
		}
		
		public function clearMultiplierDisplay():void {
			multiplierDisplay.clear();
		}
		
		public function tally():void {
			score.total = (additionPendingDisplay.total * multiplierDisplay.multiplierNumber) + score.total;
			additionPendingDisplay.clear();
			multiplierDisplay.clear();
			score.newTotal();
			multiplierTimer.clear();
		}
		
	}

}