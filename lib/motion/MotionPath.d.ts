declare namespace motion {
	
	
	export class MotionPath {
		
		public readonly rotation:RotationPath;
		public readonly x:IComponentPath;
		public readonly y:IComponentPath;
		
		public constructor ();
		
		/**
		* Adds a quadratic (1 control point) bezier curve to the current motion path
		* @param	x		The x position of the end point for the curve
		* @param	y		The y position of the end point for the curve
		* @param	controlX		The x position of the control point for the curve, which affects the angle and midpoint
		* @param	controlY		The y position of the control point for the curve, which affects the angle and midpoint
		* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
		* @return		The current motion path instance
		*/
		public bezier (x:number, y:number, controlX:number, controlY:number, strength:number = 1):MotionPath { return null; }
		
		
		/**
			* Adds a bezier curve of arbitrary degree to the current motion path
			* @param	x		The x position of the end point for the curve
			* @param	y		The y position of the end point for the curve
			* @param	controlX		The x positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
			* @param	controlY		The y positions of the control points for the curve, which affects the angle and midpoint. The number of control points determines the degree of the curve
			* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
			* @return		The current motion path instance
			*/
		public bezierN (x:number, y:number, controlX:Array<number>, controlY:Array<number>, strength:number = 1):MotionPath { return null; }
		
		
		/**
			* Adds a smooth bezier spline that passes through a given set of points
			* @param	x		The x positions of the points to pass through
			* @param	y		The y positions of the points to pass through
			* @param	strength		The degree of emphasis that should be placed on this segment. If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
			* @return		The current motion path instance
			*/
		public bezierSpline (x:Array<number>, y:Array<number>, strength:number = 1):MotionPath { return null; }
		
		
		/**
			* Adds a line to the current motion path
			* @param	x		The x position of the end point for the line
			* @param	x		The y position of the end point for the line
			* @param	strength		The degree of emphasis that should be placed on this segment . If a motion path contains multiple segments with the same strength, they all receive equal emphasis (Default is 1)
			* @return		The current motion path instance
			*/
		public line (x:number, y:number, strength:number = 1):MotionPath { return null; }
		
		
	}
	
	
	class IComponentPath {
		
		public start:number;
		public readonly end:number;
		public strength:number;
		
		public calculate (k:number):number;
		
	}
	
	
	class RotationPath implements IComponentPath {
		
		public readonly end:number;
		public start:number;
		public offset:number;
		public strength:number;
		
		public calculate (k:number):number;
		
	}
	
	
}


export default motion.MotionPath;