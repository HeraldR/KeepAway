package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class TimerAddition extends Entity
	{
		private var timerAdditionText:Text = new Text("0", 0, 0);
		private var alphaTween:VarTween;
		
		public function TimerAddition() 
		{
			graphic = timerAdditionText;
			timerAdditionText.color = 0x7FFF00;
		}
		
		public function addColorTimer(amount:uint):void {
			timerAdditionText.text = "+" + String(amount);
			timerAdditionText.alpha = 1;
			if ((alphaTween != null) && alphaTween.active) { alphaTween.cancel(); }
			alphaTween = new VarTween();
			alphaTween.tween(timerAdditionText, "alpha", .0, 45, Ease.quadIn);
			addTween(alphaTween, true);
		}
	}

}