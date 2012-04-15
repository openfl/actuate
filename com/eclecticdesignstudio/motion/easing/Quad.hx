/**
 * @author Joshua Granick
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package com.eclecticdesignstudio.motion.easing;



class Quad {
	
	
	static public var easeIn (getEaseIn, never):IEasing;
	static public var easeInOut (getEaseInOut, never):IEasing;
	static public var easeOut (getEaseOut, never):IEasing;
	
	
	private static function getEaseIn ():IEasing {
		
		return new QuadEaseIn ();
		
	}
	
	
	private static function getEaseInOut ():IEasing {
		
		return new QuadEaseInOut ();
		
	}
	
	
	private static function getEaseOut ():IEasing {
		
		return new QuadEaseOut ();
		
	}
	
	
}


class QuadEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t + b;
		
	}
	
	
}


class QuadEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		if ((k *= 2) < 1) {
			return 1 / 2 * k * k;
		}
		return -1 / 2 * ((--k) * (k - 2) - 1);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t /= d / 2) < 1) {
			return c / 2 * t * t + b;
		}
		return -c / 2 * ((--t) * (t - 2) - 1) + b;
		
	}
	
	
}


class QuadEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return -k * (k - 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c * (t /= d) * (t - 2) + b;
		
	}
	
	
}