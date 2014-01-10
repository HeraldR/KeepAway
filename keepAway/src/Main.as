package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	public class Main extends Engine
	{
		public function Main()
		{
			super(800, 600, 60, true);
			FP.world = new TitleScreen();
			// uncomment to enable to debug console
			//FP.console.enable();
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}