package  
{
	import flash.geom.Point;
	import net.flashpunk.FP;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.motion.LinearPath;
	/**
	 * ...
	 * @author HeraldR
	 */
	public class PathfinderAStar 
	{
		private var currentPath:LinearPath = new LinearPath();
		private var nodeList:Array = [];
		private var openList:Array = [];
		private var closedList:Array = [];
		private var grid:Grid;
		private var sX:int; // X and Y coordinates of the selected node. Selected X & Y shortened to sX and sY
		private var sY:int; 
		private var selectedNode:Node = new Node(999,999);
		private var target:Point = new Point(0, 0);
		private var targetNode:Node;
		private const SIDEWAYS_MOVEMENT_COST:int = 10;
		private const DIAGONAL_MOVEMENT_COST:int = 14;
		
		public function PathfinderAStar(collisionGrid:Grid) 
		{
			grid = collisionGrid;
			nodeList = new Array();
			nodeList.length = grid.columns;
			for (var i:uint = 0; i < nodeList.length; i++) {
				nodeList[i] = new Array(grid.rows);
				for (var j:uint = 0; j < grid.rows; j ++) {
					nodeList[i][j] = new Node(i, j);
				}
			}
		}
		
		public function findPath(currentX:int, currentY:int, targetX:int, targetY:int):LinearPath {
			// intialize everything
			closedList = new Array();
			openList = new Array();
			selectedNode = new Node(Math.round(currentX  / GC.GRID_TILE_WIDTH), Math.round(currentY / GC.GRID_TILE_WIDTH));
			selectedNode = nodeList[Math.round(currentX / GC.GRID_TILE_WIDTH)][Math.round(currentY / GC.GRID_TILE_WIDTH)];
			target.x = Math.round(targetX / GC.GRID_TILE_WIDTH);
			target.y = Math.round(targetY / GC.GRID_TILE_WIDTH);
			targetNode = new Node(target.x, target.y);
			selectedNode.parent = null;
			selectedNode.G = 0;
			selectedNode.F = selectedNode.H = getHeurestic(selectedNode.xCoordinate, selectedNode.yCoordinate);
			
			//look for path
			do {
				closedList.push(selectedNode);
				sX = selectedNode.xCoordinate;  
				sY = selectedNode.yCoordinate;
				addToOpenList(sX, sY - 1);
				addToOpenList(sX +1, sY - 1, true);
				addToOpenList(sX + 1, sY);
				addToOpenList(sX + 1, sY + 1, true);
				addToOpenList(sX, sY + 1);
				addToOpenList(sX - 1, sY + 1, true);
				addToOpenList(sX - 1, sY);
				addToOpenList(sX - 1, sY - 1, true);
				
				if (openList.length != 0) {
					selectedNode = openList[0]; 
				} else {
					return null;
				}
				
				for (var i:uint = 1; i < openList.length; i++) {
					if (openList[i].F <= selectedNode.F) {
						selectedNode = openList[i];
					}
				}
				
				openList.splice(openList.indexOf(selectedNode), 1);
			} while ( (selectedNode.xCoordinate != target.x) || (selectedNode.yCoordinate != target.y) );
			
			// loop backwards from target to the start, adding every connection to a LinearPath
			currentPath = new LinearPath();
			currentPath.addPoint(selectedNode.xCoordinate * GC.GRID_TILE_WIDTH, selectedNode.yCoordinate * GC.GRID_TILE_WIDTH);
			while (selectedNode.parent != null) {
				currentPath.addPoint(selectedNode.parent.xCoordinate * GC.GRID_TILE_WIDTH, selectedNode.parent.yCoordinate * GC.GRID_TILE_WIDTH);
				selectedNode = selectedNode.parent;
			}
			
			var reversePath:LinearPath = new LinearPath();
			var p:Point = new Point(0, 0);
			for (var j:int = currentPath.pointCount - 1; j > -1; j--) {
					p = currentPath.getPoint(j);
					//trace("p: (", p.x, ",", p.y, ")");
					reversePath.addPoint(p.x, p.y);
			}
			return reversePath;
		}
		
		// XC and YC stand for xCoordinate and yCoordinate
		public function getHeurestic(XC:int, YC:int):int {
			return ((Math.abs(target.x - XC) + Math.abs(target.y - YC)) * SIDEWAYS_MOVEMENT_COST);
		}
		
		public function addToOpenList(XC:int, YC:int, diagonal:Boolean = false):void {
			if (closedList.indexOf(nodeList[XC][YC]) == -1) {
				if(diagonal){
					if (!isCollidable(XC, sY) && !isCollidable(sX, YC) && !isCollidable(XC, YC)) {
						setUpNode(XC, YC, DIAGONAL_MOVEMENT_COST);
					}
				} else {
					if (!isCollidable(XC, YC)) {
						setUpNode(XC, YC, SIDEWAYS_MOVEMENT_COST);
					}
				}
			}
		}
		
		public function setUpNode(XC:int, YC:int, movementCost:int):void {
			if (openList.indexOf(nodeList[XC][YC]) == -1) { 
				nodeList[XC][YC].H = getHeurestic(XC, YC);
				nodeList[XC][YC].G = nodeList[sX][sY].G + movementCost;
				nodeList[XC][YC].F = nodeList[XC][YC].H + nodeList[XC][YC].G;
				nodeList[XC][YC].parent = nodeList[sX][sY];
				nodeList[XC][YC].target = targetNode;
				openList.push(nodeList[XC][YC]);
			} else {
				if(nodeList[XC][YC].target == targetNode) {
					if ( (nodeList[sX][sY].G + movementCost) < (nodeList[XC][YC].G) ) {
						nodeList[XC][YC].G = nodeList[sX][sY].G + movementCost;
						nodeList[XC][YC].F = nodeList[XC][YC].H + nodeList[XC][YC].G;
						nodeList[XC][YC].parent = nodeList[sX][sY];
					}
				} else {
						nodeList[XC][YC].G = nodeList[sX][sY].G + movementCost;
						nodeList[XC][YC].F = nodeList[XC][YC].H + nodeList[XC][YC].G;
						nodeList[XC][YC].parent = nodeList[sX][sY];
						nodeList[XC][YC].target = targetNode;
				}
			}
		}
		
		public function isCollidable(xCoordinate:int, yCoordinate:int):Boolean {	
			return grid.getTile(xCoordinate, yCoordinate);
		}
		
	}

}