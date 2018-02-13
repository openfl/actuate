package motion;

// import motion.actuators.SimpleActuator;
// import motion.easing.Expo;
// import haxe.ds.ObjectMap;
// import Type;
// import motion.actuators.MotionPathActuator;
// import Std;
// import motion.actuators.IGenericActuator;
// import Reflect;
// import js.Boot;
// import HxOverrides;
// import motion.actuators.MethodActuator;

@:jsRequire("motion/Actuate", "default")

extern class Actuate implements Dynamic {

	static var defaultActuator:Dynamic;
	static var defaultEase:Dynamic;
	static var targetLibraries:Dynamic;
	static function apply(target:Dynamic, properties:Dynamic, ?customActuator:Dynamic):Dynamic;
	static function effects(target:Dynamic, duration:Dynamic, ?overwrite:Dynamic):Dynamic;
	static function getLibrary(target:Dynamic, ?allowCreation:Dynamic):Dynamic;
	static function isActive():Dynamic;
	static function motionPath(target:Dynamic, duration:Dynamic, properties:Dynamic, ?overwrite:Dynamic):Dynamic;
	static function pause(target:Dynamic):Dynamic;
	static function pauseAll():Dynamic;
	static function reset():Dynamic;
	static function resume(target:Dynamic):Dynamic;
	static function resumeAll():Dynamic;
	static function stop(target:Dynamic, ?properties:Dynamic, ?complete:Dynamic, ?sendEvent:Dynamic):Dynamic;
	static function timer(duration:Dynamic, ?customActuator:Dynamic):Dynamic;
	static function transform(target:Dynamic, ?duration:Dynamic, ?overwrite:Dynamic):Dynamic;
	static function tween(target:Dynamic, duration:Dynamic, properties:Dynamic, ?overwrite:Dynamic, ?customActuator:Dynamic):Dynamic;
	static function unload(actuator:Dynamic):Dynamic;
	static function update(target:Dynamic, duration:Dynamic, ?start:Dynamic, ?end:Dynamic, ?overwrite:Dynamic):Dynamic;


}