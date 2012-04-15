/**
 * @author Joshua Granick
 * @author Philippe / http://philippe.elsass.me
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package com.eclecticdesignstudio.motion.easing;
	
	
class Quint {
	
	
	static public var easeIn (getEaseIn, never):IEasing;
	static public var easeInOut (getEaseInOut, never):IEasing;
	static public var easeOut (getEaseOut, never):IEasing;
	
	
	private static function getEaseIn ():IEasing {
		
		return new QuintEaseIn ();
		
	}
	
	
	private static function getEaseInOut ():IEasing {
		
		return new QuintEaseInOut ();
		
	}
	
	
	private static function getEaseOut ():IEasing {
		
		return new QuintEaseOut ();
		
	}
	
	
}


class QuintEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k * k * k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t * t * t * t + b;
		
	}
	
	
}


class QuintEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		if ((k *= 2) < 1) return 0.5 * k * k * k * k * k;
		return 0.5 * ((k -= 2) * k * k * k * k + 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t /= d / 2) < 1) {
			return c / 2 * t * t * t * t * t + b;
		}
		return c / 2 * ((t -= 2) * t * t * t * t + 2) + b;
		
	}
	
	
}


class QuintEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return --k * k * k * k * k + 1;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * ((t = t / d - 1) * t * t * t * t + 1) + b;
		
	}
	
	
}