package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.tweens.motion.LinearPath;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class PathfindingEnemy extends Entity
	{
		//private var sprite:Spritemap = new Spritemap(GC.PULSEENEMY, 32, 32);
		private var sprite:Spritemap;
		private var targetBall:Ball;
		private var pathGrid:Grid;
		private const moveSpeed:int = 1;
		private var pathDelay:int = 0; // how long until a new path is set
		private var pathfinderAStar:PathfinderAStar;
		private var tweening:Boolean = false;
		private var currentPath:LinearPath = new LinearPath();
		private var nextWayPoint:LinearMotion = new LinearMotion();
		
		public function PathfindingEnemy(xx:int, yy:int, pathFindingGrid:Grid, newPathDelay:int, color:Class) 
		{
			sprite = new Spritemap(color, 32, 32);
			sprite.add("move", [0], .25, true);
			graphic = sprite;
			sprite.play("move");
			x = xx;
			y = yy;
			setHitbox(32, 32, 0, 0);
			collidable = true;
			type = "pathfindingenemy";
			pathGrid = pathFindingGrid;
			pathfinderAStar = new PathfinderAStar(pathFindingGrid);
			pathDelay = newPathDelay;
		}
		
		override public function update():void {	
			if(currentPath != null){
				if (currentPath.pointCount < pathDelay) { // current path is shorter than the delay, so finish path before finding new one
				} else {
					if ((currentPath.percent > ( (pathDelay - 1) / currentPath.pointCount )) && (!nextWayPoint.active)) {
						tweenToNextWayPoint();
					}
				}
			}
		}
		
		override public function added():void {
			super.added();
			targetBall = world.typeFirst("ball") as Ball;
			newPath();
		}
		
		private function tweenToNextWayPoint():void {
			nextWayPoint = new LinearMotion(newPath);
			var p:Point = currentPath.getPoint(pathDelay);
			nextWayPoint.setMotionSpeed(x, y, p.x, p.y, moveSpeed);
			nextWayPoint.object = this;
			addTween(nextWayPoint, true);
			currentPath.cancel();
		}
		
		private function newPath():void {
			currentPath = pathfinderAStar.findPath(x, y, targetBall.x, targetBall.y);
			if (currentPath != null) {
				currentPath.complete = newPath;
				currentPath.setMotionSpeed(moveSpeed);
				currentPath.object = this;
				addTween(currentPath, true);
			}
		}
	}

}