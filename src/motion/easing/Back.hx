package motion.easing;


/**
 * @author Joshua Granick
 * @author Zeh Fernando, Nate Chatellier
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */
class Back {
	
	
	public static var easeIn (default, null):IEasing = new BackEaseIn (1.70158);
	public static var easeInOut (default, null):IEasing = new BackEaseInOut (1.70158);
	public static var easeOut (default, null):IEasing = new BackEaseOut (1.70158);
	
	
	public static function easeInWith (s:Float):IEasing {
		
		return new BackEaseIn (s);
		
	}
	
	
	public static function easeInOutWith (s:Float):IEasing {
		
		return new BackEaseInOut (s);
		
	}
	
	
	public static function easeOutWith (s:Float):IEasing {
		
		return new BackEaseOut (s);
	
	}
	
	
}


private class BackEaseIn implements IEasing {
	
	
	public var s (default, null):Float;
	
	
	public function new (s:Float) {
		
		this.s = s;
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return k * k * ((s + 1) * k - s);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c*(t/=d)*t*((s+1)*t - s) + b;
		
	}
	
	
}


private class BackEaseInOut implements IEasing {
	
	
	public var s:Float;
	
	
	public function new (s:Float) {
		
		this.s = s;
		
	}
	
	
	public function calculate (k:Float):Float {
		
		if ((k /= 0.5) < 1) return 0.5 * (k * k * (((s *= (1.525)) + 1) * k - s));
		return 0.5 * ((k -= 2) * k * (((s *= (1.525)) + 1) * k + s) + 2);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
		return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		
	}
	
	
}


private class BackEaseOut implements IEasing {
	
	
	public var s:Float;
	
	
	public function new (s:Float) {
		
		this.s = s;
		
	}
	
	
	public function calculate (k:Float):Float {
		
		return ((k = k - 1) * k * ((s + 1) * k + s) + 1);
		
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		
	}
	
	
}