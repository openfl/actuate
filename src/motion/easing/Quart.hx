package motion.easing;


/**
 * @author Joshua Granick
 * @author Philippe / http://philippe.elsass.me
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */
class Quart {
	
	
	public static var easeIn (default, null):IEasing = new QuartEaseIn ();
	public static var easeInOut (default, null):IEasing = new QuartEaseInOut ();
	public static var easeOut (default, null):IEasing = new QuartEaseOut ();
	
	
}


private class QuartEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k * k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t * t * t + b;
		
	}
	
	
}


private class QuartEaseInOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		if ((k *= 2) < 1) return 0.5 * k * k * k * k;
		return -0.5 * ((k -= 2) * k * k * k - 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t /= d / 2) < 1) {
			return c / 2 * t * t * t * t + b;
		}
		return -c / 2 * ((t -= 2) * t * t * t - 2) + b;
		
	}
	
	
}


private class QuartEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return -(--k * k * k * k - 1);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c * ((t = t / d - 1) * t * t * t - 1) + b;
		
	}
	
	
}