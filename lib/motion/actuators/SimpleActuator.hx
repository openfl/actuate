package motion.actuators;


import motion.actuators.GenericActuator;

@:jsRequire("motion/actuators/SimpleActuator", "default")


extern class SimpleActuator extends motion.actuators.GenericActuator implements Dynamic {
	
	
	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	function setField_openfl_geom_Transform(target:Dynamic, propertyName:Dynamic, value:Dynamic):Dynamic;
	function setField_motion_actuators_TransformActuator_T(target:Dynamic, propertyName:Dynamic, value:Dynamic):Dynamic;
	function setField_motion_actuators_MotionPathActuator_T(target:Dynamic, propertyName:Dynamic, value:Dynamic):Dynamic;
	function setField_motion_actuators_SimpleActuator_T(target:Dynamic, propertyName:Dynamic, value:Dynamic):Dynamic;
	function setField_openfl_display_DisplayObject(target:Dynamic, propertyName:Dynamic, value:Dynamic):Dynamic;
	var timeOffset:Dynamic;
	var active:Dynamic;
	var cacheVisible:Dynamic;
	var detailsLength:Dynamic;
	var initialized:Dynamic;
	var paused:Dynamic;
	var pauseTime:Dynamic;
	var propertyDetails:Dynamic;
	var sendChange:Dynamic;
	var setVisible:Dynamic;
	var startTime:Dynamic;
	var toggleVisible:Dynamic;
	override function autoVisible(?value:Dynamic):Dynamic;
	override function delay(duration:Dynamic):Dynamic;
	function getField(target:Dynamic, propertyName:Dynamic):Dynamic;
	function initialize():Dynamic;
	override function move():Dynamic;
	override function onUpdate(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	override function pause():Dynamic;
	override function resume():Dynamic;
	function setProperty(details:Dynamic, value:Dynamic):Dynamic;
	override function stop(properties:Dynamic, complete:Dynamic, sendEvent:Dynamic):Dynamic;
	function update(currentTime:Dynamic):Dynamic;
	static var actuators:Dynamic;
	static var actuatorsLength:Dynamic;
	static var addedEvent:Dynamic;
	static function stage_onEnterFrame(event:Dynamic):Dynamic;
	
	
}