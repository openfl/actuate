package motion;


class MotionPath {
	
	
	public var rotation (get, never):RotationPath;
	public var x (get, never):IComponentPath;
	public var y (get, never):IComponentPath;
	
	private var _rotation:RotationPath;
	private var _x:ComponentPath;
	private var _y:ComponentPath;
	
	
	#if commonjs
	private static function __init__ () {
		
		untyped Object.defineProperties (MotionPath.prototype, {
			"rotation": { get: untyped __js__ ("function () { return this.get_rotation (); }") },
			"x": { get: untyped __js__ ("function () { return this.get_x (); }") },
			"y": { get: untyped __js__ ("function () { return this.get_y (); }") },
		});
		
	}
	#end
	
	
	public function new () {
		
		_x = new ComponentPath ();
		_y = new ComponentPath ();
		
		_rotation = null;
		
	}
	
	
	/**
	 * Adds a quadratic (1 control point) bezier curve to the current motion path
	 * @param	x		The x position of the end point for the curve
	 * @param	y		The y position of the end point for the curve
	 * @param	controlX		The x position of the control point for the curve, which affects the angle and midpoint
	 * @param	controlY		The y position of the control point for the curve, which affects the angle and midpoint
	 * @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
	 * @return		The current motion path instance
	 */
	public function bezier (x:Float, y:Float, controlX:Float, controlY:Float, strength:Float = 1):MotionPath {
		
		return bezierN (x, y, [controlX], [controlY], strength);
		
	}
	
	
	/**
	 * Adds a bezier curve of arbitrary degree to the current motion path
	 * @param	x		The x position of the end point for the curve
	 * @param	y		The y position of the end point for the curve
	 * @param	controlX		The x positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
	 * @param	controlY		The y positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
	 * @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
	 * @return		The current motion path instance
	 */
	public function bezierN (x:Float, y:Float, controlX:Array<Float>, controlY:Array<Float>, strength:Float = 1):MotionPath {

		_x.addPath (new BezierPath (x, controlX, strength));
		_y.addPath (new BezierPath (y, controlY, strength));
		
		return this;
		
	}
	
	
	/**
	 * Adds a line to the current motion path
	 * @param	x		The x position of the end point for the line
	 * @param	x		The y position of the end point for the line
	 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
	 * @return		The current motion path instance
	 */
	public function line (x:Float, y:Float, strength:Float = 1):MotionPath {
		
		return bezierN (x, y, [], [], strength);
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function get_rotation ():RotationPath {
		
		if (_rotation == null) {
			
			_rotation = new RotationPath (_x, _y);
			
		}
		
		return _rotation;
		
	}
	
	
	private function get_x ():IComponentPath {
		
		return _x;
		
	}
	
	
	private function get_y ():IComponentPath {
		
		return _y;
		
	}
	
	
}


private class ComponentPath implements IComponentPath {
	
	
	public var start (get, set):Float;
	public var end (get, never):Float;
	public var strength:Float;
	
	private var paths:Array <IComponentPath>;
	
	
	public function new () {
		
		paths = new Array <IComponentPath> ();
		strength = 0;
		
	}
	
	
	public function addPath (path:IComponentPath):Void {

		// Avoid setting the first segment's start, which we don't really know yet.
		// It will be set later by our set_start.

		if (paths.length > 0) {

			path.start = paths[paths.length - 1].end;

		}

		paths.push (path);
		strength += path.strength;

	}
	
	
	public function calculate (k:Float):Float {
		
		if (paths.length == 1) {
			
			return paths[0].calculate (k);
			
		} else {
			
			var ratio = k * strength;
			
			for (path in paths) {
				
				if (ratio > path.strength) {
					
					ratio -= path.strength;
					
				} else {
					
					return path.calculate (ratio / path.strength);
					
				}
				
			}
			
		}
		
		return 0;
		
	}
	
	
	
	// Get & Set Methods
	
	
	private function get_start ():Float {
		
		return paths.length > 0 ? paths[0].start : 0;

	}

	
	public function set_start (value:Float):Float {

		if (paths.length > 0) {

			return paths[0].start = value;

		} else {

			return 0;

		}

	}
	
	
	private function get_end ():Float {
		
		if (paths.length > 0) {
			
			var path = paths[paths.length - 1];
			return path.end;
			
		} else {
			
			return start;
			
		}
		
	}
	
	
}


interface IComponentPath {
	
	
	var start (get, set):Float;
	var end (get, null):Float;
	public var strength:Float;
	
	function calculate (k:Float):Float;
	
	
}


private class BezierPath implements IComponentPath {
	
	
	public var control:Array<Float>;
	public var start (get, set):Float;
	public var end (get, null):Float;
	public var strength:Float;

	private var _start:Float;
	private var _end:Float;
	
	
	public function new (end:Float, control:Array<Float>, strength:Float) {
		
		this._end = end;
		this.control = control;
		this.strength = strength;
		
	}
	
	
	public function calculate (k:Float):Float {
		
		// use faster formulas for the common (linear, quadratic, cubic) cases

		var l = 1 - k;

		switch (control.length) {

			case 0:

				return l * _start + k * _end;

			case 1:

				return l*l * _start + 2*l*k * control[0] + k*k * _end;

			case 2:

				return l*l*l * _start + 3*l*l*k * control[0] + 3*l*k*k * control[1] + k*k*k * _end;

			default:

				// General explicit form (https://en.wikipedia.org/wiki/B%C3%A9zier_curve#General_definition)
				// To speed up we compute the coefficient (n i) l^(n-i) k^i from its previous value at every step.

				if(l < 1e-7) {
					return _end;						// avoid numerical issues
				}
				var r = k / l;

				var n = control.length + 1;			// degree
				var coeff = Math.pow(l, n);			// at each step i, coeff == binom(n,i) l^(n-i) k^i
				var res = coeff * _start;

				for (i in 1...n) {
					coeff *= r * (n + 1 - i) / i;	// compute coeff from its (i-1)-th value
					res += coeff * control[i-1];
				}
				coeff *= r / n;						// coeff now equals k^n
				return res + coeff * _end;

		}
		
	}
	
	
	// Get & Set Methods
	

	public function get_start ():Float {
		
		return _start;
		
	}

	
	public function set_start (value:Float):Float {
		
		return _start = value;
		
	}
	
	
	public function get_end ():Float {
		
		return _end;
		
	}
	
}


private class RotationPath implements IComponentPath {
	
	
	public var end (get, never):Float;
	public var start (get, set):Float;
	public var offset:Float;
	public var strength:Float;
	
	private var _start:Float;
	private var step = 0.01;
	private var _x:ComponentPath;
	private var _y:ComponentPath;
	
	
	public function new (x:ComponentPath, y:ComponentPath) {
		
		_x = x;
		_y = y;
		
		offset = 0;
		
		start = calculate (0.0);
		
	}
	
	
	public function calculate (k:Float):Float {
		
		var dX = _x.calculate (k) - _x.calculate (k + step);
		var dY = _y.calculate (k) - _y.calculate (k + step);
		
		var angle = Math.atan2(dY, dX) * (180 / Math.PI);
		angle = (angle + offset) % 360;
		
		return angle;
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	public function get_start ():Float {
		
		return _start;
		
	}

	
	public function set_start (value:Float):Float {
		
		return _start;	// not modifiable
		
	}

	
	public function get_end ():Float {
		
		return calculate (1.0);
		
	}
	
	
}