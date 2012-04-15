/**
 * @author Joshua Granick
 * @version 1.38
 */


package com.eclecticdesignstudio.motion;


import com.eclecticdesignstudio.motion.actuators.FilterActuator;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import com.eclecticdesignstudio.motion.actuators.MethodActuator;
import com.eclecticdesignstudio.motion.actuators.SimpleActuator;
import com.eclecticdesignstudio.motion.actuators.TransformActuator;
import com.eclecticdesignstudio.motion.easing.Expo;
import com.eclecticdesignstudio.motion.easing.IEasing;
import flash.display.DisplayObject;
import flash.events.Event;


class Actuate {
	
	
	public static var defaultActuator:Class <GenericActuator> = SimpleActuator;
	public static var defaultEase:IEasing = Expo.easeOut;
	private static var targetLibraries:ObjectHash <Array <GenericActuator>> = new ObjectHash <Array <GenericActuator>> ();
	
	
	/**
	 * Copies properties from one object to another. Conflicting tweens are stopped automatically
	 * @example		<code>Actuate.apply (MyClip, { alpha: 1 } );</code>
	 * @param	target		The object to copy to
	 * @param	properties		The object to copy from
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or onUpdate handlers
	 */
	public static function apply (target:Dynamic, properties:Dynamic, customActuator:Class <GenericActuator> = null):IGenericActuator {
		
		stop (target, properties);
		
		if (customActuator == null) {
			
			customActuator = defaultActuator;
			
		}
		
		var actuator:GenericActuator = createInstance (customActuator, target, 0, properties);
		actuator.apply ();
		
		return actuator;
		
	}
	
	
	private static function createInstance (actuator:Class <GenericActuator>, target:Dynamic, duration:Float, properties:Dynamic):GenericActuator {
		
		// Type.createInstance isn't working properly on CPP, so have to create manually
		
		if (actuator == SimpleActuator) {
			
			return new SimpleActuator (target, duration, properties);
			
		}
		
		if (actuator == FilterActuator) {
			
			return new FilterActuator (target, duration, properties);
			
		}
		
		if (actuator == TransformActuator) {
			
			return new TransformActuator (target, duration, properties);
			
		}
		
		if (actuator == MethodActuator) {
			
			return new MethodActuator (target, duration, properties);
			
		}
		
		return null;
		
	}
	
	
	/**
	 * Creates a new effects tween 
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		An EffectsOptions instance, which is used to select the kind of effect you would like to apply to the target
	 */
	public static function effects (target:DisplayObject, duration:Float, overwrite:Bool = true):EffectsOptions {
		
		return new EffectsOptions (target, duration, overwrite);
		
	}
	
	
	private static function getLibrary (target:Dynamic):Array <GenericActuator> {
		
		if (!targetLibraries.exists (target)) {
			
			targetLibraries.set (target, new Array <GenericActuator> ());
			
		}
		
		return targetLibraries.get (target);
		
	}
	
	
	/**
	 * Creates a new MotionPath tween
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	properties		An object containing a motion path for each property you wish to tween
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	/*public static function motionPath (target:Dynamic, duration:Float, properties:Dynamic, overwrite:Bool = true):GenericActuator {
		
		return tween (target, duration, properties, overwrite, MotionPathActuator);
		
	}*/
	
	
	/**
	 * Pauses tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens paused. Passing no value pauses tweens for all objects
	 */
	//public static function pause (... targets:Array):void {
	public static function pause (target:Dynamic):Void {
		
		if (Std.is (target, GenericActuator)) {
			
			cast (target, GenericActuator).pause ();
			
		} else {
			
			var library:Array <GenericActuator> = getLibrary (target);
			
			for (actuator in library) {
				
				actuator.pause ();
				
			}
			
		}
		
	}
	
	
	public static function pauseAll ():Void {
		
		for (library in targetLibraries) {
			
			for (actuator in library) {
				
				actuator.pause ();
				
			}
			
		}
		
	}
	
	
	/**
	 * Resets Actuate by stopping and removing tweens for all objects
	 */
	public static function reset ():Void {
		
		for (library in targetLibraries) {
			
			for (actuator in library) {
				
				actuator.stop (null, false, false);
				
			}
			
		}
		
		targetLibraries = new ObjectHash <Array <GenericActuator>> ();
		
	}
	
	
	/**
	 * Resumes paused tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens resumed. Passing no value resumes tweens for all objects
	 */
	public static function resume (target:Dynamic):Void {
		
		if (Std.is (target, GenericActuator)) {
			
			cast (target, GenericActuator).resume ();
			
		} else {
			
			var library:Array <GenericActuator> = getLibrary (target);
			
			for (actuator in library) {
				
				actuator.resume ();
				
			}
			
		}
		
	}
	
	
	public static function resumeAll ():Void {
		
		for (library in targetLibraries) {
			
			for (actuator in library) {
				
				actuator.resume ();
				
			}
			
		}
		
	}
	
	
	/**
	 * Stops all tweens for an individual object
	 * @param	target		The target object which will have its tweens stopped, or a generic actuator instance
	 * @param  properties		A string, array or object which contains the properties you wish to stop, like "alpha", [ "x", "y" ] or { alpha: null }. Passing no value removes all tweens for the object (Optional)
	 * @param	complete		If tweens should apply their final target values before stopping. Default is false (Optional) 
	 * @param	sendEvent	If a complete() event should be dispatched for the specified target. Default is true (Optional)
	 */
	public static function stop (target:Dynamic, properties:Dynamic = null, complete:Bool = false, sendEvent:Bool = true):Void {
		
		if (target != null) {
			
			if (Std.is (target, GenericActuator)) {
				
				cast (target, GenericActuator).stop (null, complete, sendEvent);
				
			} else {
				
				var library:Array <GenericActuator> = getLibrary (target);
				
				if (Std.is (properties, String)) {
					
					var temp = { };
					Reflect.setField (temp, properties, null);
					properties = temp;
					
				} else if (Std.is (properties, Array)) {
					
					var temp = {};
					
					for (i in Reflect.fields (properties)) {
						
						Reflect.setField (temp, i, null);
						
					}
					
					properties = temp;
					
				}
				
				for (actuator in library) {
					
					actuator.stop (properties, complete, sendEvent);
					
				}
				
			}
			
		}
		
	}
	
	
	/**
	 * Creates a tween-based timer, which is useful for synchronizing function calls with other animations
	 * @example		<code>Actuate.timer (1).onComplete (trace, "Timer is now complete");</code>
	 * @param	duration		The length of the timer in seconds
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or to gain a reference to the target timer object
	 */
	public static function timer (duration:Float, customActuator:Class <GenericActuator> = null):IGenericActuator {
		
		return tween (new TweenTimer (0), duration, new TweenTimer (1), false, customActuator);
		
	}
	
	
	/**
	 * Creates a new transform tween
	 * @example		<code>Actuate.transform (MyClip, 1).color (0xFF0000);</code>
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		A TransformOptions instance, which is used to select the kind of transform you would like to apply to the target
	 */
	public static function transform (target:Dynamic, duration:Float = 0, overwrite:Bool = true):TransformOptions {
		
		return new TransformOptions (target, duration, overwrite);
		
	}
	
	
	/**
	 * Creates a new tween
	 * @example		<code>Actuate.tween (MyClip, 1, { alpha: 1 } ).onComplete (trace, "MyClip is now visible");</code>
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	properties		The end values to tween the target to
	 * @param	overwrite			Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */ 
	public static function tween (target:Dynamic, duration:Float, properties:Dynamic, overwrite:Bool = true, customActuator:Class <GenericActuator> = null):IGenericActuator {
		
		if (target != null) {
			
			if (duration > 0) {
				
				if (customActuator == null) {
					
					customActuator = defaultActuator;
					
				}
				
				var actuator:GenericActuator = createInstance (customActuator, target, duration, properties);
				var library:Array <GenericActuator> = getLibrary (actuator.target);
				
				if (overwrite) {
					
					for (childActuator in library) {
						
						childActuator.stop (actuator.properties, false, false);
						
					}
					
				}
				
				library.push (actuator);
				actuator.move ();
				
				/*var actuator:GenericActuator = createInstance (customActuator, target, duration, properties);
				
				if (overwrite) {
					
					stop (target, properties, false, false);
					
				}
				
				var library:Array <GenericActuator> = getLibrary (target);
				library.push (actuator);
				
				actuator.move ();*/
				
				return actuator;
				
			} else {
				
				return apply (target, properties, customActuator);
				
			}
			
		}
		
		return null;
		
	}
	
	
	public static function unload (actuator:GenericActuator):Void {
		
		var target = actuator.target;
		
		if (targetLibraries.exists (target)) {
			
			targetLibraries.get (target).remove (actuator);
			
			if (targetLibraries.get (target).length == 0) {
				
				targetLibraries.remove (target);
				
			}
			
		}
		
	}
	
	
	/**
	 * Creates a new tween that updates a method rather than setting the properties of an object
	 * @example		<code>Actuate.update (trace, 1, ["Value: ", 0], ["", 1]).onComplete (trace, "Finished tracing values between 0 and 1");</code>
	 * @param	target		The method to update		
	 * @param	duration		The length of the tween in seconds
	 * @param	start		The starting parameters of the method call. You may use both numeric and non-numeric values
	 * @param	end		The ending parameters of the method call. You may use both numeric and non-numeric values, but the signature should match the start parameters
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public static function update (target:Dynamic, duration:Float, start:Array <Dynamic> = null, end:Array <Dynamic> = null, overwrite:Bool = true):IGenericActuator {
		
		var properties:Dynamic = { start: start, end: end };
		
		return tween (target, duration, properties, overwrite, MethodActuator);
		
	}
	
	
}


import com.eclecticdesignstudio.motion.actuators.FilterActuator;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import com.eclecticdesignstudio.motion.actuators.TransformActuator;
import com.eclecticdesignstudio.motion.Actuate;
import flash.display.DisplayObject;
import flash.filters.BitmapFilter;
//import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;


private class EffectsOptions {


	private var duration:Float;
	private var overwrite:Bool;
	private var target:DisplayObject;


	public function new (target:DisplayObject, duration:Float, overwrite:Bool) {
		
		this.target = target;
		this.duration = duration;
		this.overwrite = overwrite;
		
	}


	/**
	 * Creates a new BitmapFilter tween
	 * @param	reference		A reference to the target's filter, which can be an array index or the class of the filter
	 * @param	properties		The end properties to use for the tween
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function filter (reference:Dynamic, properties:Dynamic):IGenericActuator {
		
		properties.filter = reference;
		
		return Actuate.tween (target, duration, properties, overwrite, FilterActuator);
		
	}


}


private class TransformOptions {


	private var duration:Float;
	private var overwrite:Bool;
	private var target:Dynamic;


	public function new (target:Dynamic, duration:Float, overwrite:Bool) {
		
		this.target = target;
		this.duration = duration;
		this.overwrite = overwrite;
		
	}


	/**
	 * Creates a new ColorTransform tween
	 * @param	color		The color value
	 * @param	strength		The percentage amount of tint to apply (Default is 1)
	 * @param	alpha		The end alpha of the target. If you wish to tween alpha and tint simultaneously, you must do them both as part of the ColorTransform. A value of null will make no change to the alpha of the object (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function color (value:Float = 0x000000, strength:Float = 1, alpha:Null <Float>):IGenericActuator {
		
		var properties:Dynamic = { colorValue: value, colorStrength: strength };
		
		if (alpha != null) {
			
			properties.colorAlpha = alpha;
			
		}
		
		return Actuate.tween (target, duration, properties, overwrite, TransformActuator);
		
	}


	/**
	 * Creates a new SoundTransform tween
	 * @param	volume		The end volume for the target, or null if you would like to ignore this property (Default is null)
	 * @param	pan		The end pan for the target, or null if you would like to ignore this property (Default is null)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	public function sound (volume:Null <Float>, pan:Null <Float>):IGenericActuator {
		
		var properties:Dynamic = {};
		
		if (volume != null) {
			
			properties.soundVolume = volume;
			
		}
		
		if (pan != null) {
			
			properties.soundPan = pan;
			
		}
		
		return Actuate.tween (target, duration, properties, overwrite, TransformActuator);
		
	}


}


private class TweenTimer {


	public var progress:Float;


	public function new (progress:Float):Void {
		
		this.progress = progress;
		
	}


}


#if flash
import flash.utils.TypedDictionary;
#end


private class ObjectHash <T> {
	
	
	#if flash
	
	private var dictionary:TypedDictionary <Dynamic, T>;
	
	#else
	
	private var hash:IntHash <T>;
	
	#end
	
	private static var nextObjectID:Int = 0;
	
	
	public function new () {
		
		#if flash
		
		dictionary = new TypedDictionary <Dynamic, T> ();
		
		#else
		
		hash = new IntHash <T> ();
		
		#end
		
	}
	
	
	public inline function exists (key:Dynamic):Bool {
		
		#if flash
		
		return dictionary.exists (key);
		
		#else
		
		return hash.exists (getID (key));
		
		#end
		
	}
	
	
	public inline function get (key:Dynamic):T {
		
		#if flash
		
		return dictionary.get (key);
		
		#else
		
		return hash.get (getID (key));
		
		#end
		
	}
	
	
	private inline function getID (key:Dynamic):Int {
		
		#if cpp
		
		return untyped __global__.__hxcpp_obj_id (key);
		
		#else
		
		if (key.___id___ == null) {
			
			key.___id___ = nextObjectID ++;
			
			if (nextObjectID == 0x3FFFFFFF) {
				
				nextObjectID = 0;
				
			}
			
		}
		
		return key.___id___;
		
		#else
		
		return 0;
		
		#end
		
	}
	
	
	public inline function iterator ():Iterator <T> {
		
		#if flash
		
		var values:Array <T> = new Array <T> ();
		
		for (key in dictionary.iterator ()) {
			
			values.push (dictionary.get (key));
			
		}
		
		return values.iterator ();
		
		#else
		
		return hash.iterator ();
		
		#end
		
	}
	
	
	public inline function remove (key:Dynamic):Void {
		
		#if flash
		
		dictionary.delete (key);
		
		#else
		
		hash.remove (getID (key));
		
		#end
		
	}
	
	
	public inline function set (key:Dynamic, value:T):Void {
		
		#if flash
		
		dictionary.set (key, value);
		
		#else
		
		hash.set (getID (key), value);
		
		#end
		
	}
	
	
}