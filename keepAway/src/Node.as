package  
{
	/**
	 * ...
	 * @author HeraldR
	 */
	public class Node
	{
		public var xCoordinate:int;
		public var yCoordinate:int;
		public var uniqueID:int;
		public var H:int; // Heuristic
		public var G:int; 
		public var F:int;
		public var parent:Node;
		public var target:Node;
		
		public function Node(xCoord:int, yCoord:int) 
		{
			xCoordinate = xCoord;
			yCoordinate = yCoord;
		}
		
		
	}

}