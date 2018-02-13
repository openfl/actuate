package motion.actuators;


import motion.actuators.SimpleActuator;

@:jsRequire("motion/actuators/FilterActuator", "default")


extern class FilterActuator extends motion.actuators.SimpleActuator implements Dynamic {

	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	
	var filterClass:Dynamic;
	var filterIndex:Dynamic;
	override function apply():Dynamic;
	override function initialize():Dynamic;
	function setFilter():Dynamic;
	override function update(currentTime:Dynamic):Dynamic;


}