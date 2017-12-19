package motion.actuators;

// import motion.actuators.IGenericActuator;

@:jsRequire("motion/actuators/GenericActuator", "default")

extern class GenericActuator implements Dynamic {

	function new(target:Dynamic, duration:Dynamic, properties:Dynamic);
	var duration:Dynamic;
	var id:Dynamic;
	
	var target:Dynamic;
	var _autoVisible:Dynamic;
	var _delay:Dynamic;
	var _ease:Dynamic;
	
	var _onCompleteParams:Dynamic;
	
	var _onRepeatParams:Dynamic;
	
	var _onUpdateParams:Dynamic;
	
	var _onResumeParams:Dynamic;
	
	var _onPauseParams:Dynamic;
	var _reflect:Dynamic;
	var _repeat:Dynamic;
	var _reverse:Dynamic;
	var _smartRotation:Dynamic;
	var _snapping:Dynamic;
	var special:Dynamic;
	function apply():Dynamic;
	function autoVisible(?value:Dynamic):Dynamic;
	function callMethod(method:Dynamic, ?params:Dynamic):Dynamic;
	function change():Dynamic;
	function complete(?sendEvent:Dynamic):Dynamic;
	function delay(duration:Dynamic):Dynamic;
	function ease(easing:Dynamic):Dynamic;
	function move():Dynamic;
	function onComplete(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onRepeat(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onUpdate(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onPause(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onResume(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function pause():Dynamic;
	function reflect(?value:Dynamic):Dynamic;
	function repeat(?times:Dynamic):Dynamic;
	function resume():Dynamic;
	function reverse(?value:Dynamic):Dynamic;
	function smartRotation(?value:Dynamic):Dynamic;
	function snapping(?value:Dynamic):Dynamic;
	function stop(properties:Dynamic, complete:Dynamic, sendEvent:Dynamic):Dynamic;


}