package motion.actuators;


import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/MotionPathActuator", "default")


extern class MotionPath extends SimpleActuator {
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic);
	
	
}