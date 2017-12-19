package motion.actuators;


import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/MotionPathActuator", "default")


extern class MotionPathActuator extends motion.actuators.SimpleActuator implements Dynamic {

	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	override function apply():Dynamic;
	override function initialize():Dynamic;
	override function update(currentTime:Dynamic):Dynamic;


}