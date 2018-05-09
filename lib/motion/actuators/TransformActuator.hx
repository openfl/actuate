package motion.actuators;

import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/TransformActuator", "default")

extern class TransformActuator extends motion.actuators.SimpleActuator implements Dynamic {

	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	
	
	
	
	override function apply():Dynamic;
	override function initialize():Dynamic;
	function initializeColor():Dynamic;
	function initializeSound():Dynamic;
	override function update(currentTime:Dynamic):Dynamic;


}