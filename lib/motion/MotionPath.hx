package motion;


@:jsRequire("motion/MotionPath", "default")


extern class MotionPath implements Dynamic {
	
	
	function new();
	var rotation:Dynamic;
	var x:Dynamic;
	var y:Dynamic;
	var _rotation:Dynamic;
	var _x:Dynamic;
	var _y:Dynamic;
	function bezier(x:Dynamic, y:Dynamic, controlX:Dynamic, controlY:Dynamic, ?strength:Dynamic):Dynamic;
	function line(x:Dynamic, y:Dynamic, ?strength:Dynamic):Dynamic;
	function get_rotation():Dynamic;
	function get_x():Dynamic;
	function get_y():Dynamic;
	
	
}