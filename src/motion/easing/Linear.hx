/**
 * @author Joshua Granick
 * @author Philippe / http://philippe.elsass.me
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package motion.easing;


class Linear {
	
	
	static public var easeNone (get, never):IEasing;
	
	
	#if commonjs
	private static function __init__ () {
		
		untyped Object.defineProperties (Linear, {
			"easeNone": { get: function () { return Linear.get_easeNone (); } }
		});
		
	}
	#end
	
	
	private static function get_easeNone ():IEasing {
		
		return new LinearEaseNone ();
		
	}
	
	
}


class LinearEaseNone implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * t / d + b;
		
	}
	
	
}