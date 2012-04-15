/**
 * @author Joshua Granick
 * @author Philippe / http://philippe.elsass.me
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package com.eclecticdesignstudio.motion.easing;
	
	
class Cubic {
	
	
	static public var easeIn (getEaseIn, never):IEasing;
	static public var easeInOut (getEaseInOut, never):IEasing;
	static public var easeOut (getEaseOut, never):IEasing;
	
	
	private static function getEaseIn ():IEasing {
		
		return new CubicEaseIn ();
		
	}
	
	
	private static function getEaseInOut ():IEasing {
		
		return new CubicEaseInOut ();
		
	}
	
	
	private static function getEaseOut ():IEasing {
		
		return new CubicEaseOut ();
		
	}
	
	
}


class CubicEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t * t + b;
		
	}
	
	
}


class CubicEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return ((k /= 1 / 2) < 1) ? 0.5 * k * k * k : 0.5 * ((k -= 2) * k * k + 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return ((t /= d / 2) < 1) ? c / 2 * t * t * t + b : c / 2 * ((t -= 2) * t * t + 2) + b;
		
	}
	
	
}


class CubicEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return --k * k * k + 1;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * ((t = t / d - 1) * t * t + 1) + b;
		
	}
	
	
}