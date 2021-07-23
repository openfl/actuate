package motion.actuators;
#if (flash || nme || openfl)


import flash.display.DisplayObject;
import Reflect;
import flash.geom.Matrix;
import flash.geom.Point;


class TransformAroundPointActuator<T, U> extends SimpleActuator<T, U> {
	
	
	private var transformMatrix:Matrix;
	private var transformPoint:Point;
	private var initialTransformPoint:Point;
	private var transformedPoint:Point;
	private var originX:Float;
	private var originY:Float;
	private var tweenedOffsetX:Float;
	private var tweenedOffsetY:Float;
	
	
	public function new (target:T, duration:Float, properties:Dynamic) {
		
		super (target, duration, properties);
		transformedPoint = new Point ();
		transformMatrix = new Matrix ();
		originX = getField (target, "x");
		originY = getField (target, "y");
		
		var transformAroundPointProps = Reflect.field (properties, "transformAroundPoint");
		for (propertyName in Reflect.fields (transformAroundPointProps)) {
			
			switch (propertyName) {
				case "point": 
						var point = Reflect.field (transformAroundPointProps, "point");
						var isLocal = Reflect.hasField (transformAroundPointProps, "pointIsLocal") && Reflect.field (transformAroundPointProps, "pointIsLocal");
						if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (target, DisplayObject) && !isLocal) {
						
							transformPoint = Reflect.callMethod (target,  Reflect.field (target, "globalToLocal"), [point]);
							
						} else {
						
							transformPoint = point;
							
						}
				case "scale":
						var value = Reflect.field (transformAroundPointProps, "scale");
						Reflect.setField (properties, "scaleX", value);
						Reflect.setField (properties, "scaleY", value);
						
				case "rotation" | "scaleX" | "scaleY":
						var value = Reflect.field (transformAroundPointProps, propertyName);
						Reflect.setField (properties, propertyName, value);
				default:
			}
			
		}
		
		Reflect.deleteField (properties, "transformAroundPoint");
		
		initialTransformPoint = new Point();
		getTransformedPoint (initialTransformPoint);
		
		tweenedOffsetX = tweenedOffsetY = 0;
	}
	
	
	private override function apply ():Void {
		
		for (propertyName in Reflect.fields (properties)) {
			
			var value = Reflect.field (properties, propertyName);
			setField(target, propertyName, value);
			
			if (propertyName == "x") {
			
				tweenedOffsetX = value - originX;
			
			} else if (propertyName == "y") {
				
				tweenedOffsetY = value - originY;
				
			}
			
		}
		
		updatePosition ();
	}
	
	
	private override function setProperty (details:PropertyDetails<U>, value:Dynamic):Void {
		
		var propertyName = details.propertyName;
		if (propertyName == "x") {
			
			tweenedOffsetX = value - originX;
			
		} else if (propertyName == "y") {
			
			tweenedOffsetY = value - originY;
			
		} else {
		
			super.setProperty (details, value);
		}
		
	}
	
	
	private override function update (currentTime:Float):Void {
		
		super.update (currentTime);
		
		if (active && !paused) {
			
			updatePosition ();
			
		}
		
	}
	
	
	private inline function getTransformedPoint (result:Point): Void {
		
			transformMatrix.identity ();
			var scaleX = getField (target, "scaleX");
			var scaleY = getField (target, "scaleY");
			var rotation = getField (target, "rotation");
			transformMatrix.scale (scaleX, scaleY);
			transformMatrix.rotate (rotation * Math.PI / 180);
			
			result.copyFrom (transformPoint);
			transform (result, transformMatrix);
	}
	
	
	private function updatePosition ():Void {
			
			getTransformedPoint (transformedPoint);
			subtract (initialTransformPoint, transformedPoint, transformedPoint);
			
			setField (target, "x", originX + transformedPoint.x + tweenedOffsetX);
			setField (target, "y", originY + transformedPoint.y + tweenedOffsetY);
			
	}
	
	
	private inline function transform (point:Point, matrix: Matrix):Void {
		
		var px = point.x;
		var py = point.y;
		
		point.x = px * matrix.a + py * matrix.c + matrix.tx;
		point.y = px * matrix.b + py * matrix.d + matrix.ty;
		
	}
	
	
	private inline function subtract (p1:Point, p2:Point, ?result:Point):Point {
		
		if (result == null) result = new Point ();
		
		result.x = p1.x - p2.x;
		result.y = p1.y - p2.y;
		
		return result;
		
	}
	
	
}
#end