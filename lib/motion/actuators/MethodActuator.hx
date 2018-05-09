package motion.actuators;

import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/MethodActuator", "default")

extern class MethodActuator extends motion.actuators.SimpleActuator implements Dynamic {

	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	var currentParameters:Dynamic;
	
	override function apply():Dynamic;
	override function complete(?sendEvent:Dynamic):Dynamic;
	override function initialize():Dynamic;
	override function update(currentTime:Dynamic):Dynamic;


}