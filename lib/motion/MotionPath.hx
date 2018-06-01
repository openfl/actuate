package motion;


@:jsRequire("motion/MotionPath", "default")


extern class MotionPath {
	
	
	public var rotation (get, never):RotationPath;
	public var x (get, never):IComponentPath;
	public var y (get, never):IComponentPath;
	
	public function new () {}
	
	/**
		* Adds a quadratic (1 control point) bezier curve to the current motion path
		* @param	x		The x position of the end point for the curve
		* @param	y		The y position of the end point for the curve
		* @param	controlX		The x position of the control point for the curve, which affects the angle and midpoint
		* @param	controlY		The y position of the control point for the curve, which affects the angle and midpoint
		* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		* @return		The current motion path instance
		*/
	public function bezier (x:Float, y:Float, controlX:Float, controlY:Float, strength:Float = 1):MotionPath { return null; }
	
	
	/**
		* Adds a bezier curve of arbitrary degree to the current motion path
		* @param	x		The x position of the end point for the curve
		* @param	y		The y position of the end point for the curve
		* @param	controlX		The x positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
		* @param	controlY		The y positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
		* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		* @return		The current motion path instance
		*/
	public function bezierN (x:Float, y:Float, controlX:Array<Float>, controlY:Array<Float>, strength:Float = 1):MotionPath { return null; }
	
	
	/**
		* Adds a smooth bezier spline that passes through a given set of points
		* @param	x		The x positions of the points to pass through
		* @param	y		The y positions of the points to pass through
		* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		* @return		The current motion path instance
		*/
	public function bezierSpline (x:Array<Float>, y:Array<Float>, strength:Float = 1):MotionPath { return null; }
	
	
	/**
		* Adds a line to the current motion path
		* @param	x		The x position of the end point for the line
		* @param	x		The y position of the end point for the line
		* @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		* @return		The current motion path instance
		*/
	public function line (x:Float, y:Float, strength:Float = 1):MotionPath { return null; }
	
}


interface IComponentPath {
	
	
	var start (get, set):Float;
	var end (get, null):Float;
	public var strength:Float;
	
	function calculate (k:Float):Float;
	
	
}


private extern class RotationPath implements IComponentPath {
	
	
	public var end (get, never):Float;
	public var start (get, set):Float;
	public var offset:Float;
	public var strength:Float;
	
	public function calculate (k:Float):Float;
	
	@:noCompletion private function get_end ():Float;
	@:noCompletion private function get_start ():Float;
	@:noCompletion private function set_start (value:Float):Float;
	
}