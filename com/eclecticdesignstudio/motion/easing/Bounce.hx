
/**
 * @author Erik Escoffier
 * @author Robert Penner / http://www.robertpenner.com/easing_terms_of_use.html
 */


package com.eclecticdesignstudio.motion.easing;
	
import com.eclecticdesignstudio.motion.easing.IEasing;
	
class Bounce {

	static public var easeIn (getEaseIn, never):IEasing;
	static public var easeInOut (getEaseInOut, never):IEasing;
	static public var easeOut (getEaseOut, never):IEasing;
	
	
	private static function getEaseIn ():IEasing {
		
		return new BounceEaseIn ();
		
	}
	
	
	private static function getEaseInOut ():IEasing {
		
		return new BounceEaseInOut ();
		
	}
	
	
	private static function getEaseOut ():IEasing {
		
		return new BounceEaseOut ();
		
	}
	
	
}







class BounceEaseIn implements IEasing {
	
		
	public function new () {
		
			
	}
	
	
	public function calculate (k:Float):Float {
		return BounceEaseIn._ease(k,0,1,1);
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		return BounceEaseIn._ease(t,b,c,d);
	}

	public static inline function _ease  (t:Float, b:Float, c:Float, d:Float):Float {
		return c - BounceEaseOut._ease (d-t, 0, c, d) + b;
	}
}
	


class BounceEaseInOut implements IEasing {
	
		
	public function new () {
		
			
	}
	
	
	public function calculate (k:Float):Float {
		
		if (k < .5) {
			return BounceEaseIn._ease(k*2, 0, 1, 1) * .5;
		} else {
			return BounceEaseOut._ease(k*2-1, 0, 1, 1) * .5 + 1*.5; 
		}
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {

		if (t < d/2) {
			return BounceEaseIn._ease(t*2, 0, c, d) * .5 + b;
		} else {
			return BounceEaseOut._ease(t*2-d, 0, c, d) * .5 + c*.5 + b; 
		}
		
	}
}
	




class BounceEaseOut implements IEasing {
	
		
	public function new () {
		
			
	}
	
	
	public function calculate (k:Float):Float {
		
		return BounceEaseOut._ease(k,0,1,1);
				
	}
	
	
	public function ease (t:Float, b:Float, c:Float, d:Float):Float {
		
		return BounceEaseOut._ease(t,b,c,d);
		
	}

	public static inline function _ease(t:Float, b:Float, c:Float, d:Float):Float 	{
		if ((t/=d) < (1/2.75)) {
			return c*(7.5625*t*t) + b;
		} else if (t < (2/2.75)) {
			return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
		} else if (t < (2.5/2.75)) {
			return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
		} else {
			return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
		}
	}

}
	
