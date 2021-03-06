package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearPath;
	import net.flashpunk.World;

	/**
	 * Most of the XML and Particle Emitter stuff comes from Zachary Lewis video tutorials for Flashpunk
	 * and also his video tutorials for Ogmo. They were enormously helpful this weekend and today as I cleaned things up. 
	 * I am very grateful. 
	 * 
	 * I plan to post updates to this to the useflashpunk.net forums so I'd suggest looking there for improved code.
	 * @author HeraldR
	 */
	public class Game extends World
	{
		protected var map:Entity;
		protected var _mapGrid:Grid;
		protected var _mapImage:Image;
		protected var _mapData:Class;
		protected var impact:ImpactEmitter;
		protected var goal:Goal;
		protected var ball:Ball;
		
		
		public function Game(mapData:Class = null) 
		{
			
			_mapData = mapData;
			loadMap(_mapData);
			
			// create an image of the grid and scale it the size of each grid tile
			_mapImage = new Image(_mapGrid.data);
			_mapImage.scale = 16;
			// assign this image to an entity and give it a type so that objects can check to collide with it
			map = new Entity(0, 0, _mapImage, _mapGrid);
			map.type = "grid";
			add(map);
			
			//add(new PathfindingEnemy((32 * 3), (32 * 2), _mapGrid, 5, GC.PULSEENEMY));
			add(new HUD);
		}
		
		/* Reads the data from my levels created in Ogmo 2. It's a free, open source level editor: 
			 * www.ogmoeditor.com
		 * The Ogmo project file is in assets/levels if you want to create levels.
		 * */
		public function loadMap(mapData:Class):void {
			var mapXML:XML = FP.getXML(mapData);
			var e:XML;
			
			_mapGrid = new Grid(uint(mapXML.@width), uint(mapXML.@height), 16, 16, 0, 0);
			_mapGrid.loadFromString(String(mapXML.collisionLayer), "", "\n");
			
			//There is nothing magic here. Open up the level file and you can see that it's plain text. It makes this code pretty easy to understand.
			ball = new Ball(int(mapXML.entities.playerStart.@x), int(mapXML.entities.playerStart.@y));
			add(ball);
			
			for each(e in  mapXML.entities.rowEnemy) {
				add(new HorizontalEnemy(int(e.@x), int(e.@y)));
			}
			
			for each(e in mapXML.entities.columnEnemy) {
				add(new VerticalEnemy(int(e.@x), int(e.@y)));
			}
			
			for each(e in mapXML.entities.scoreMultiplier) {
				add(new Multiplier(int(e.@x), int(e.@y)));
			}
			
			for each(e in mapXML.entities.scoreAddition) {
				add(new Adder(int(e.@x), int(e.@y)));
			}
			
			for each(e in mapXML.entities.scoreTally) {
				add(new Tally(int(e.@x), int(e.@y)));
			}
			
			for each (e in mapXML.entities.blueAStar) {
				add(new PathfindingEnemy(int(e.@x), int(e.@y), _mapGrid, GC.BLUE_DELAY, GC.BLUEENEMY));
			}
			
			for each (e in mapXML.entities.redAStar) {
				add(new PathfindingEnemy(int(e.@x), int(e.@y), _mapGrid, GC.RED_DELAY, GC.REDENEMY));
			}
			
			for each (e in mapXML.entities.GreenAStar) {
				add(new PathfindingEnemy(int(e.@x), int(e.@y), _mapGrid, GC.GREEN_DELAY, GC.GREENENEMY));
			}
		}
	}

}