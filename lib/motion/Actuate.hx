package motion;


import motion.actuators.IGenericActuator;
import motion.actuators.GenericActuator;
import motion.easing.IEasing;

@:jsRequire("motion/Actuate", "default")


extern class Actuate {
	
	
	public static var defaultActuator:Class<IGenericActuator>;
	public static var defaultEase:IEasing;
	
	
	/**
	 * Copies properties from one object to another. Conflicting tweens are stopped automatically
	 * @example		<code>Actuate.apply (MyClip, { alpha: 1 } );</code>
	 * @param	target		The object to copy to
	 * @param	properties		The object to copy from
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or onUpdate handlers
	 */
	public static function apply<T> (target:T, properties:Dynamic, customActuator:Class<GenericActuator> = null):GenericActuator;
	
	
	/**
	 * Creates a new effects tween 
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		An EffectsOptions instance, which is used to select the kind of effect you would like to apply to the target
	 */
	public static function effects (target:Dynamic, duration:Float, overwrite:Bool = true):EffectsOptions;
	
	
	/**
	 * Checks if Actuate has any active tweens 
	 * @return		Whether Actuate is active
	 */
	public static function isActive ():Bool;
	
	
	/**
	 * Creates a new MotionPath tween
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	properties		An object containing a motion path for each property you wish to tween
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public static function motionPath<T> (target:T, duration:Float, properties:Dynamic, overwrite:Bool = true):GenericActuator;
	
	
	/**
	 * Pauses tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens paused. Passing no value pauses tweens for all objects
	 */
	public static function pause<T> (target:T):Void;
	
	
	public static function pauseAll ():Void;
	
	
	/**
	 * Resets Actuate by stopping and removing tweens for all objects
	 */
	public static function reset ():Void;
	
	
	/**
	 * Resumes paused tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens resumed. Passing no value resumes tweens for all objects
	 */
	public static function resume<T> (target:T):Void;
	
	
	public static function resumeAll ():Void;
	
	
	/**
	 * Stops all tweens for an individual object
	 * @param	target		The target object which will have its tweens stopped, or a generic actuator instance
	 * @param	properties		A string, array or object which contains the properties you wish to stop, like "alpha", [ "x", "y" ] or { alpha: null }. Passing no value removes all tweens for the object (Optional)
	 * @param	complete		If tweens should apply their final target values before stopping. Default is false (Optional) 
	 * @param	sendEvent	If a complete() event should be dispatched for the specified target. Default is true (Optional)
	 */
	public static function stop<T> (target:T, properties:Dynamic = null, complete:Bool = false, sendEvent:Bool = true):Void;
	
	
	
	/**
	 * Creates a tween-based timer, which is useful for synchronizing function calls with other animations
	 * @example		<code>Actuate.timer (1).onComplete (trace, [ "Timer is now complete" ]);</code>
	 * @param	duration		The length of the timer in seconds
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or to gain a reference to the target timer object
	 */
	public static function timer (duration:Float, customActuator:Class<GenericActuator> = null):GenericActuator;
	
	
	/**
	 * Creates a new transform tween
	 * @example		<code>Actuate.transform (MyClip, 1).color (0xFF0000);</code>
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		A TransformOptions instance, which is used to select the kind of transform you would like to apply to the target
	 */
	public static function transform<T> (target:T, duration:Float = 0, overwrite:Bool = true):TransformOptions<T>;
	
	
	/**
	 * Creates a new tween
	 * @example		<code>Actuate.tween (MyClip, 1, { alpha: 1 } ).onComplete (trace, [ "MyClip is now visible" ]);</code>
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	properties		The end values to tween the target to
	 * @param	overwrite			Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */ 
	public static function tween<T> (target:T, duration:Float, properties:Dynamic, overwrite:Bool = true, customActuator:Class<GenericActuator> = null):GenericActuator;
	
	
	public static function unload<T> (actuator:GenericActuator):Void;
	
	
	/**
	 * Creates a new tween that updates a method rather than setting the properties of an object
	 * @example		<code>Actuate.update (trace, 1, ["Value: ", 0], ["", 1]).onComplete (trace, [ "Finished tracing values between 0 and 1" ]);</code>
	 * @param	target		The method to update		
	 * @param	duration		The length of the tween in seconds
	 * @param	start		The starting parameters of the method call. You may use both numeric and non-numeric values
	 * @param	end		The ending parameters of the method call. You may use both numeric and non-numeric values, but the signature should match the start parameters
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public static function update<T> (target:T, duration:Float, start:Array <Dynamic> = null, end:Array <Dynamic> = null, overwrite:Bool = true):GenericActuator;
	
	
}


private extern class EffectsOptions {
	
	
	// public function new (target:DisplayObject, duration:Float, overwrite:Bool) {
	
	
	/**
	 * Creates a new BitmapFilter tween
	 * @param	reference		A reference to the target's filter, which can be an array index or the class of the filter
	 * @param	properties		The end properties to use for the tween
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function filter (reference:Dynamic, properties:Dynamic):IGenericActuator;
	
	
}


private extern class TransformOptions<T> {
	
	
	// public function new (target:T, duration:Float, overwrite:Bool) {
	
	
	/**
	 * Creates a new ColorTransform tween
	 * @param	color		The color value
	 * @param	strength		The percentage amount of tint to apply (Default is 1)
	 * @param	alpha		The end alpha of the target. If you wish to tween alpha and tint simultaneously, you must do them both as part of the ColorTransform. A value of null will make no change to the alpha of the object (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function color (value:Int = 0x000000, strength:Float = 1, alpha:Null <Float> = null):IGenericActuator;
	
	
	/**
	 * Creates a new SoundTransform tween
	 * @param	volume		The end volume for the target, or null if you would like to ignore this property (Default is null)
	 * @param	pan		The end pan for the target, or null if you would like to ignore this property (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function sound (volume:Null <Float> = null, pan:Null <Float> = null):IGenericActuator;
	
	
}