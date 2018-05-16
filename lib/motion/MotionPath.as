package motion {
	
	
	/**
	 * @externs
	 */
	public class MotionPath {
		
		
		public function get rotation ():RotationPath { return null; }
		public function get x ():IComponentPath { return null; }
		public function get y ():IComponentPath { return null; }
		
		public function MotionPath () {}
		
		/**
		 * Adds a quadratic (1 control point) bezier curve to the current motion path
		 * @param	x		The x position of the end point for the curve
		 * @param	y		The y position of the end point for the curve
		 * @param	controlX		The x position of the control point for the curve, which affects the angle and midpoint
		 * @param	controlY		The y position of the control point for the curve, which affects the angle and midpoint
		 * @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function bezier (x:Number, y:Number, controlX:Number, controlY:Number, strength:Number = 1):MotionPath { return null; }
		
		
		/**
		 * Adds a bezier curve of arbitrary degree to the current motion path
		 * @param	x		The x position of the end point for the curve
		 * @param	y		The y position of the end point for the curve
		 * @param	controlX		The x positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
		 * @param	controlY		The y positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
		 * @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function bezierN (x:Number, y:Number, controlX:Array, controlY:Array, strength:Number = 1):MotionPath { return null; }
		
		
		/**
		 * Adds a smooth bezier spline that passes through a given set of points
		 * @param	x		The x positions of the points to pass through
		 * @param	y		The y positions of the points to pass through
		 * @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function bezierSpline (x:Array, y:Array, strength:Number = 1):MotionPath { return null; }
		
		
		/**
		 * Adds a line to the current motion path
		 * @param	x		The x position of the end point for the line
		 * @param	x		The y position of the end point for the line
		 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function line (x:Number, y:Number, strength:Number = 1):MotionPath { return null; }
		
		
	}
	
	
	/**
	 * @externs
	 */
	internal interface IComponentPath {
		
		
		function get start ():Number;
		function set start (value:Number):void;
		function get end ():Number;
		function get strength ():Number;
		function set strength (value:Number):void;
		
		function calculate (k:Number):Number;
		
		
	}
	
	
	/**
	 * @externs
	 */
	internal class RotationPath implements IComponentPath {
		
		
		public function get start ():Number { return 0; }
		public function set start (value:Number):void {}
		public function get end ():Number { return 0; }
		public function get strength ():Number { return 0; }
		public function set strength (value:Number):void {}
		public var offset:Number;
		
		public function calculate (k:Number):Number { return 0; }
		
		
	}
	
	
}