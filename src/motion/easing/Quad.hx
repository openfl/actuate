/**
 * @author Joshua Granick
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package motion.easing;


class Quad {
	
	
	static public var easeIn (get, never):IEasing;
	static public var easeInOut (get, never):IEasing;
	static public var easeOut (get, never):IEasing;
	
	
	#if commonjs
	private static function __init__ () {
		
		untyped Object.defineProperties (Quad, {
			"easeIn": { get: function () { return Quad.get_easeIn (); } },
			"easeInOut": { get: function () { return Quad.get_easeInOut (); } },
			"easeOut": { get: function () { return Quad.get_easeOut (); } }
		});
		
	}
	#end
	
	
	private static function get_easeIn ():IEasing {
		
		return new QuadEaseIn ();
		
	}
	
	
	private static function get_easeInOut ():IEasing {
		
		return new QuadEaseInOut ();
		
	}
	
	
	private static function get_easeOut ():IEasing {
		
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
		return -1 / 2 * ((k - 1) * (k - 3) - 1);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t /= d / 2) < 1) {
			return c / 2 * t * t + b;
		}
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b;
		
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