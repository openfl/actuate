package motion.actuators;



@:jsRequire("motion/actuators/IGenericActuator", "default")

extern class IGenericActuator implements Dynamic {

	
	function autoVisible(?value:Dynamic):Dynamic;
	function delay(duration:Dynamic):Dynamic;
	function ease(easing:Dynamic):Dynamic;
	function onComplete(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onRepeat(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onUpdate(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function reflect(?value:Dynamic):Dynamic;
	function repeat(?times:Dynamic):Dynamic;
	function reverse(?value:Dynamic):Dynamic;
	function smartRotation(?value:Dynamic):Dynamic;
	function snapping(?value:Dynamic):Dynamic;
	function onPause(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function onResume(handler:Dynamic, ?parameters:Dynamic):Dynamic;
	function apply():Dynamic;
	function move():Dynamic;
	function pause():Dynamic;
	function resume():Dynamic;
	function stop(properties:Dynamic, complete:Dynamic, sendEvent:Dynamic):Dynamic;


}