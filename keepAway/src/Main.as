package 
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	[SWF(width = "960", height = "640")]
	public class Main extends Engine
	{
		public function Main()
		{
			super(960, 640, 60, true);
			FP.world = new Game(GC.LEVEL13);
			// uncomment to enable to debug console
			//FP.console.enable();
		}

		override public function init():void
		{
			trace("FlashPunk has started successfully!");
		}
	}
}