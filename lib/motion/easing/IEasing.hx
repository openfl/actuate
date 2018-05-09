package motion.easing;


interface IEasing {
	
	
	private function calculate (k:Float):Float;
	private function ease (t:Float, b:Float, c:Float, d:Float):Float;
	
	
}