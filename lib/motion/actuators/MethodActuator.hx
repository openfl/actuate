package motion.actuators;

import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/MethodActuator", "default")


extern class MethodActuator extends SimpleActuator {
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic);
	
	
}