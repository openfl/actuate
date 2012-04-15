/**
 * @author Joshua Granick
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package com.eclecticdesignstudio.motion.easing;
	
	
class Sine {
	
	
	static public var easeIn (getEaseIn, never):IEasing;
	static public var easeInOut (getEaseInOut, never):IEasing;
	static public var easeOut (getEaseOut, never):IEasing;
	
	
	private static function getEaseIn ():IEasing {
		
		return new SineEaseIn ();
		
	}
	
	
	private static function getEaseInOut ():IEasing {
		
		return new SineEaseInOut ();
		
	}
	
	
	private static function getEaseOut ():IEasing {
		
		return new SineEaseOut ();
		
	}
	
	
}


class SineEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return 1 - Math.cos(k * (Math.PI / 2));
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
		
	}
	
	
}


class SineEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return - (Math.cos(Math.PI * k) - 1) / 2;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c / 2 * (Math.cos(Math.PI * t / d) - 1) + b;
		
	}
	
	
}


class SineEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return Math.sin(k * (Math.PI / 2));
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * Math.sin(t / d * (Math.PI / 2)) + b;
		
	}
	
	
}