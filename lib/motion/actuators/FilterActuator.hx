package motion.actuators;


import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/FilterActuator", "default")


extern class FilterActuator extends SimpleActuator {
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic);
	
	
}