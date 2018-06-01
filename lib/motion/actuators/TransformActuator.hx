package motion.actuators;


import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/TransformActuator", "default")


extern class TransformActuator extends SimpleActuator {
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic);
	
	
}