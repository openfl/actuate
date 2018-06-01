package motion.easing;


import motion.easing.IEasing;

@:jsRequire("motion/easing/Back", "default")


extern class Back {
	
	
	public static var easeIn (default, null):IEasing;
	public static var easeInOut (default, null):IEasing;
	public static var easeOut (default, null):IEasing;
	
	public static function easeInWith (s:Float):IEasing;
	public static function easeInOutWith (s:Float):IEasing;
	public static function easeOutWith (s:Float):IEasing;
	
	
}