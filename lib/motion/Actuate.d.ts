import GenericActuator from "./actuators/GenericActuator";
import IGenericActuator from "./actuators/IGenericActuator";
import IEasing from "./easing/IEasing";


declare namespace motion {
	
	
	export class Actuate {
		
		
		public static defaultActuator:any;
		public static defaultEase:IEasing;
		
		
		/**
		 * Copies properties from one object to another. Conflicting tweens are stopped automatically
		 * @example		<code>Actuate.apply (MyClip, { alpha: 1 } );</code>
		 * @param	target		The object to copy to
		 * @param	properties		The object to copy from
		 * @param	customActuator		A custom actuator to use instead of the default (Optional)
		 * @return		The current actuator instance, which can be used to apply properties like onComplete or onUpdate handlers
		 */
		public static apply (target:any, properties:Object, customActuator?:any):GenericActuator;
		
		
		/**
		 * Creates a new effects tween 
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		An EffectsOptions instance, which is used to select the kind of effect you would like to apply to the target
		 */
		public static effects (target:any, duration:number, overwrite?:boolean):EffectsOptions;
		
		
		/**
		 * Checks if Actuate has any active tweens 
		 * @return		Whether Actuate is active
		 */
		public static isActive ():boolean;
		
		
		/**
		 * Creates a new MotionPath tween
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	properties		An object containing a motion path for each property you wish to tween
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public static motionPath (target:any, duration:number, properties:Object, overwrite?:boolean):GenericActuator;
		
		
		/**
		 * Pauses tweens for the specified target objects
		 * @param	... targets		The target objects which will have their tweens paused. Passing no value pauses tweens for all objects
		 */
		public static pause (target:any):void;
		
		
		public static pauseAll ():void;
		
		
		/**
		 * Resets Actuate by stopping and removing tweens for all objects
		 */
		public static reset ():void;
		
		
		/**
		 * Resumes paused tweens for the specified target objects
		 * @param	... targets		The target objects which will have their tweens resumed. Passing no value resumes tweens for all objects
		 */
		public static resume (target:any):void;
		
		
		public static resumeAll ():void;
		
		
		/**
		 * Stops all tweens for an individual object
		 * @param	target		The target object which will have its tweens stopped, or a generic actuator instance
		 * @param	properties		A string, array or object which contains the properties you wish to stop, like "alpha", [ "x", "y" ] or { alpha: null }. Passing no value removes all tweens for the object (Optional)
		 * @param	complete		If tweens should apply their final target values before stopping. Default is false (Optional) 
		 * @param	sendEvent	If a complete() event should be dispatched for the specified target. Default is true (Optional)
		 */
		public static stop (target:any, properties?:Object, complete?:boolean, sendEvent?:boolean):void;
		
		
		
		/**
		 * Creates a tween-based timer, which is useful for synchronizing function calls with other animations
		 * @example		<code>Actuate.timer (1).onComplete (trace, [ "Timer is now complete" ]);</code>
		 * @param	duration		The length of the timer in seconds
		 * @param	customActuator		A custom actuator to use instead of the default (Optional)
		 * @return		The current actuator instance, which can be used to apply properties like onComplete or to gain a reference to the target timer object
		 */
		public static timer (duration:number, customActuator?:any):GenericActuator;
		
		
		/**
		 * Creates a new transform tween
		 * @example		<code>Actuate.transform (MyClip, 1).color (0xFF0000);</code>
		 * @param	target		The object to tween
		 * @param	duration		The length of the tween in seconds
		 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
		 * @return		A TransformOptions instance, which is used to select the kind of transform you would like to apply to the target
		 */
		public static transform (target:any, duration?:number, overwrite?:boolean):TransformOptions;
		
		
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
		public static tween (target:any, duration:number, properties:Object, overwrite?:boolean, customActuator?:any):GenericActuator;
		
		
		public static unload (actuator:any):void;
		
		
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
		public static update (target:any, duration:number, start?:Array<any>, end?:Array<any>, overwrite?:boolean):GenericActuator;
		

	}
	
	
	class EffectsOptions {
		
		
		// public function new (target:DisplayObject, duration:Float, overwrite:Bool) {
		
		
		/**
		 * Creates a new BitmapFilter tween
		 * @param	reference		A reference to the target's filter, which can be an array index or the class of the filter
		 * @param	properties		The end properties to use for the tween
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public filter (reference:any, properties:Object):IGenericActuator;
		
		
	}
	
	
	class TransformOptions {
		
		
		// public function new (target:T, duration:Float, overwrite:Bool) {
		
		
		/**
		 * Creates a new ColorTransform tween
		 * @param	color		The color value
		 * @param	strength		The percentage amount of tint to apply (Default is 1)
		 * @param	alpha		The end alpha of the target. If you wish to tween alpha and tint simultaneously, you must do them both as part of the ColorTransform. A value of null will make no change to the alpha of the object (Default is null)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public color (value?:number, strength?:number, alpha?:number):IGenericActuator;
		
		
		/**
		 * Creates a new SoundTransform tween
		 * @param	volume		The end volume for the target, or null if you would like to ignore this property (Default is null)
		 * @param	pan		The end pan for the target, or null if you would like to ignore this property (Default is null)
		 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
		 */
		public sound (volume?:number, pan?:number):IGenericActuator;
		
		
	}
	
	
}


export default motion.Actuate;