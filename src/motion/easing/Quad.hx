package motion.easing;


/**
 * @author Joshua Granick
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */
class Quad {
	
	
	public static var easeIn (default, null):IEasing = new QuadEaseIn ();
	public static var easeInOut (default, null):IEasing = new QuadEaseInOut ();
	public static var easeOut (default, null):IEasing = new QuadEaseOut ();
	
	
}


private class QuadEaseIn implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k;
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c * (t /= d) * t + b;
		
	}
	
	
}


private class QuadEaseInOut implements IEasing {
	
	
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


private class QuadEaseOut implements IEasing {
	
	
	public function new () {
		
		
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return -k * (k - 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return -c * (t /= d) * (t - 2) + b;
		
	}
	
	
}