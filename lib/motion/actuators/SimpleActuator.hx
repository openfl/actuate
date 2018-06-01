package motion.actuators;


import motion.actuators.GenericActuator;

@:jsRequire("motion/actuators/SimpleActuator", "default")


extern class SimpleActuator extends GenericActuator {
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic);
	
	
}