package  
{
	/**
	 * ...
	 * @author HeraldR
	 */
	public class GC 
	{
		[Embed(source = "assets/levels/testlevel1.oel", mimeType = "application/octet-stream")] public static const LEVEL:Class;
		[Embed(source = "assets/levels/testlevel2.oel", mimeType = "application/octet-stream")] public static const LEVEL2:Class;
		[Embed(source = "assets/levels/testlevel4.oel", mimeType = "application/octet-stream")] public static const LEVEL3:Class;
		[Embed(source = "assets/levels/testlevel5.oel", mimeType = "application/octet-stream")] public static const LEVEL4:Class;
		[Embed(source = "assets/levels/testlevel6.oel", mimeType = "application/octet-stream")]	public static const LEVEL6:Class;
		[Embed(source = "assets/graphics/youWin.png")] public static const WINNER:Class;
		[Embed(source = "assets/graphics/youLose.png")] public static const LOSER:Class;
		[Embed(source = "assets/graphics/goal.png")] public static const GOAL:Class;
		[Embed(source = "assets/graphics/verticalEnemy.png")] public static const VERTENEMY:Class;
		[Embed(source = "assets/graphics/horizontalEnemy.png")] public static const HORIZENEMY:Class;
		[Embed(source = "assets/graphics/pulsingEnemy.png")] public static const PULSEENEMY:Class;
		[Embed(source = "assets/graphics/titleimage.png")] public static const TITLEIMAGE:Class;
		[Embed(source = "assets/graphics/ball.png")] public static const BALL:Class;
		[Embed(source = "assets/graphics/ballmask.png")] public static const BALLMASK:Class;
		[Embed(source = "assets/graphics/Multiplier.png")] public static const MULTIPLIER:Class;
		
		[Embed(source = "assets/graphics/blueEnemy.png")] public static const BLUEENEMY:Class;
		public static const BLUE_DELAY:int = 5;
		
		[Embed(source = "assets/graphics/greenEnemy.png")] public static const GREENENEMY:Class;
		public static const GREEN_DELAY:int = 10;
		
		[Embed(source = "assets/graphics/redEnemy.png")] public static const REDENEMY:Class;
		public static const RED_DELAY:int = 1;
		
		//public static var globalBall:Ball;
		public static const GRID_TILE_WIDTH:uint = 32;
	}


}