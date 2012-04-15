package com.eclecticdesignstudio.motion {
	
	
	import com.eclecticdesignstudio.motion.actuators.MotionInternal;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class MotionPath {
		
		
		public var start:Number;
		
		protected var paths:Array;
		protected var totalStrength:Number;
		
		
		public function MotionPath () {
			
			paths = new Array ();
			start = 0;
			totalStrength = 0;
			
		}
		
		
		protected function addPath (path:BezierPath):void {
			
			paths.push (path);
			totalStrength += path.strength;
			
		}
		
		
		/**
		 * Creates a motion path using a bezier curve
		 * @param	end		The position of the end point for the curve
		 * @param	control		The position of the control point for the curve, which affects its angle and midpoint
		 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The new motion path instance
		 */
		public static function bezier (end:Number, control:Number, strength:Number = 1):MotionPath {
			
			return new MotionPath ().bezier (end, control, strength);
			
		}
		
		
		/**
		 * Adds a bezier curve to the current motion path
		 * @param	end		The position of the end point for the curve
		 * @param	control		The position of the control point for the curve, which affects its angle and midpoint
		 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function bezier (end:Number, control:Number, strength:Number = 1):MotionPath {
			
			addPath (new BezierPath (end, control, strength));
			
			return this;
			
		}
		
		
		MotionInternal function calculate (k:Number):Number {
			
			if (paths.length === 1) {
				
				return (paths[0] as Object).calculate (start, k);
				
			} else {
				
				var ratio:Number = k * totalStrength;
				var lastEnd:Number = start;
				
				for each (var path:BezierPath in paths) {
					
					if (ratio > path.strength) {
						
						ratio -= path.strength;
						lastEnd = path.end;
						
					} else {
						
						return path.calculate (lastEnd, ratio / path.strength);
						
					}
					
				}
				
			}
			
			return 0;
			
		}
		
		
		/**
		 * Creates a motion path using a line
		 * @param	end		The position of the end point for the line
		 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The new motion path instance
		 */
		public static function line (end:Number, strength:Number = 1):MotionPath {
			
			return new MotionPath ().line (end, strength);
			
		}
		
		
		/**
		 * Adds a line to the current motion path
		 * @param	end		The position of the end point for the line
		 * @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		 * @return		The current motion path instance
		 */
		public function line (end:Number, strength:Number = 1):MotionPath {
			
			addPath (new LinearPath (end, strength));
			
			return this;
			
		}
		
		
		
		
		// Get & Set Methods
		
		
		
		
		MotionInternal function get end ():Number {
			
			if (paths.length > 0) {
				
				var path:BezierPath = paths[paths.length - 1];
				return path.end;
				
			} else {
				
				return NaN;
				
			}
			
		}
		
	}
	

}




class BezierPath {
	
	
	public var control:Number;
	public var end:Number;
	public var strength:Number;
	
	
	public function BezierPath (end:Number, control:Number, strength:Number) {
		
		this.end = end;
		this.control = control;
		this.strength = strength;
		
	}
	
	
	public function calculate (start:Number, k:Number):Number {
		
		return (1 - k) * (1 - k) * start + 2 * (1 - k) * k * control + k * k * end;
		
	}
	
	
}


class LinearPath extends BezierPath {
	
	
	public function LinearPath (end:Number, strength:Number) {
		
		super (end, 0, strength);
		
	}
	
	
	public override function calculate (start:Number, k:Number):Number {
		
		return start + k * (end - start);
		
	}
	
	
}