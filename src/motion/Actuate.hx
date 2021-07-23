package motion;


import haxe.ds.ObjectMap;
import motion.actuators.FilterActuator;
import motion.actuators.GenericActuator;
import motion.actuators.IGenericActuator;
import motion.actuators.MethodActuator;
import motion.actuators.MotionPathActuator;
import motion.actuators.SimpleActuator;
import motion.actuators.TransformActuator;
import motion.easing.Expo;
import motion.easing.IEasing;
#if (flash || nme || openfl)
import flash.display.DisplayObject;
#end

@:access(motion.actuators)


class Actuate {
	
	
	public static var defaultActuator:Class<IGenericActuator> = SimpleActuator;
	public static var defaultEase:IEasing = Expo.easeOut;
	private static var targetLibraries = new ObjectMap<Dynamic, Array<IGenericActuator>> ();
	#if neko
	private static var methodLibraries = new FunctionMap<Dynamic, Array<IGenericActuator>> ();
	#end
	
	
	/**
	 * Copies properties from one object to another. Conflicting tweens are stopped automatically
	 * @example		<code>Actuate.apply (MyClip, { alpha: 1 } );</code>
	 * @param	target		The object to copy to
	 * @param	properties		The object to copy from
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or onUpdate handlers
	 */
	/*@:generic*/ public static function apply<T> (target:T, properties:Dynamic, customActuator:Class<GenericActuator<T>> = null):GenericActuator<T> {
		
		stop (target, properties);
		
		if (customActuator == null) {
			
			customActuator = cast defaultActuator;
			
		}
		
		var actuator:GenericActuator<T> = Type.createInstance (customActuator, [ target, 0, properties ]);
		actuator.apply ();
		
		return actuator;
		
	}
	
	
	#if (flash || nme || openfl)
	
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
	
	#end
	
	
	private static function getLibrary<T> (target:T, allowCreation:Bool = true):Array<IGenericActuator> {
		
		#if neko
		
		if (Reflect.isFunction (target)) {
			
			if (!methodLibraries.exists (target) && allowCreation) {
				
				methodLibraries.set (target, new Array<IGenericActuator> ());
				
			}
			
			return methodLibraries.get (target);
			
		}
			
		#end
		
		if (!targetLibraries.exists (target) && allowCreation) {
			
			targetLibraries.set (target, new Array<IGenericActuator> ());
			
		}
		
		return targetLibraries.get (target);
		
	}
	
	
	/**
	 * Checks if Actuate has any active tweens 
	 * @return		Whether Actuate is active
	 */
	public static function isActive ():Bool {
		
		var result = false;
		
		for (library in targetLibraries) {
			
			result = true;
			break;
			
		}
		
		return result;
		
	}
	
	
	/**
	 * Creates a new MotionPath tween
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	properties		An object containing a motion path for each property you wish to tween
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		The current actuator instance, which can be used to apply properties like ease, delay, onComplete or onUpdate
	 */
	/*@:generic*/ public static function motionPath<T> (target:T, duration:Float, properties:Dynamic, overwrite:Bool = true):GenericActuator<T> {
		
		return tween (target, duration, properties, overwrite, MotionPathActuator);
		
	}
	
	
	/**
	 * Pauses tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens paused. Passing no value pauses tweens for all objects
	 */
	///*@:generic*/ public static function pause (... targets:Array):void {
	/*@:generic*/ public static function pause<T> (target:T):Void {
		
		if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (target, IGenericActuator)) {
			
			var actuator:IGenericActuator = cast target;
			actuator.pause ();
			
		} else {
			
			var library = getLibrary (target, false);
			
			if (library != null) {
				
				for (actuator in library) {
					
					actuator.pause ();
					
				}
				
			}
			
		}
		
	}
	
	
	public static function pauseAll ():Void {
		
		#if neko
		
		for (library in methodLibraries) {
			
			for (actuator in library) {
				
				actuator.pause ();
				
			}
			
		}
		
		#end
		
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
		
		#if neko
		
		for (library in methodLibraries) {
			
			var i = library.length - 1;
			
			while (i >= 0) {
				
				library[i].stop (null, false, false);
				i--;
				
			}
			
		}
		
		methodLibraries = new FunctionMap<Dynamic, Array<IGenericActuator>> ();
		
		#end
		
		for (library in targetLibraries) {
			
			var i = library.length - 1;
			
			while (i >= 0) {
				
				library[i].stop (null, false, false);
				i--;
				
			}
			
		}
		
		targetLibraries = new ObjectMap<Dynamic, Array<IGenericActuator>> ();
		
	}
	
	
	/**
	 * Resumes paused tweens for the specified target objects
	 * @param	... targets		The target objects which will have their tweens resumed. Passing no value resumes tweens for all objects
	 */
	/*@:generic*/ public static function resume<T> (target:T):Void {
		
		if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (target, IGenericActuator)) {
			
			var actuator:IGenericActuator = cast target;
			actuator.resume ();
			
		} else {
			
			var library = getLibrary (target, false);
			
			if (library != null) {
				
				for (actuator in library) {
					
					actuator.resume ();
					
				}
				
			}
			
		}
		
	}
	
	
	public static function resumeAll ():Void {
		
		#if neko
		
		for (library in methodLibraries) {
			
			for (actuator in library) {
				
				actuator.resume ();
				
			}
			
		}
		
		#end
		
		for (library in targetLibraries) {
			
			for (actuator in library) {
				
				actuator.resume ();
				
			}
			
		}
		
	}
	
	
	/**
	 * Stops all tweens for an individual object
	 * @param	target		The target object which will have its tweens stopped, or a generic actuator instance
	 * @param	properties		A string, array or object which contains the properties you wish to stop, like "alpha", [ "x", "y" ] or { alpha: null }. Passing no value removes all tweens for the object (Optional)
	 * @param	complete		If tweens should apply their final target values before stopping. Default is false (Optional) 
	 * @param	sendEvent	If a complete() event should be dispatched for the specified target. Default is true (Optional)
	 */
	/*@:generic*/ public static function stop<T> (target:T, properties:Dynamic = null, complete:Bool = false, sendEvent:Bool = true):Void {
		
		if (target != null) {
			
			if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (target, IGenericActuator)) {
				
				var actuator:IGenericActuator = cast target;
				actuator.stop (null, complete, sendEvent);
				
			} else {
				
				var library = getLibrary (target, false);
				
				if (library != null) {
					
					if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (properties, String)) {
						
						var temp = { };
						Reflect.setField (temp, properties, null);
						properties = temp;
						
					} else if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (properties, Array)) {
						
						var temp = {};
						
						for (property in cast (properties, Array <Dynamic>)) {
							
							Reflect.setField (temp, property, null);
							
						}
						
						properties = temp;
						
					}
					
					var i = library.length - 1;
					
					while (i >= 0) {
						
						library[i].stop (properties, complete, sendEvent);
						i--;
						
					}
					
				}
				
			}
			
		}
		
	}
	
	
	/**
	 * Creates a tween-based timer, which is useful for synchronizing function calls with other animations
	 * @example		<code>Actuate.timer (1).onComplete (trace, [ "Timer is now complete" ]);</code>
	 * @param	duration		The length of the timer in seconds
	 * @param	customActuator		A custom actuator to use instead of the default (Optional)
	 * @return		The current actuator instance, which can be used to apply properties like onComplete or to gain a reference to the target timer object
	 */
	public static function timer (duration:Float, customActuator:Class<GenericActuator<TweenTimer>> = null):GenericActuator<TweenTimer> {
		
		return cast tween (new TweenTimer (0), duration, new TweenTimer (1), false, cast customActuator);
		
	}
	
	
	#if (flash || nme || openfl)
	
	/**
	 * Creates a new transform tween
	 * @example		<code>Actuate.transform (MyClip, 1).color (0xFF0000);</code>
	 * @param	target		The object to tween
	 * @param	duration		The length of the tween in seconds
	 * @param	overwrite		Sets whether previous tweens for the same target and properties will be overwritten (Default is true)
	 * @return		A TransformOptions instance, which is used to select the kind of transform you would like to apply to the target
	 */
	/*@:generic*/ public static function transform<T> (target:T, duration:Float = 0, overwrite:Bool = true):TransformOptions<T> {
		
		return new TransformOptions (target, duration, overwrite);
		
	}
	
	#end
	
	
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
	/*@:generic*/ public static function tween<T> (target:T, duration:Float, properties:Dynamic, overwrite:Bool = true, customActuator:Class<GenericActuator<T>> = null):GenericActuator<T> {
		
		if (target != null) {
			
			if (duration > 0) {
				
				if (customActuator == null) {
					
					customActuator = cast defaultActuator;
					
				}
				
				var actuator:GenericActuator<T> = Type.createInstance (customActuator, [ target, duration, properties ]);
				var library = getLibrary (actuator.target);
				
				if (overwrite) {
					
					var i = library.length - 1;
					
					while (i >= 0) {
						library[i].stop (actuator.properties, false, false);
						i--;
					}
					
					library = getLibrary (actuator.target);
					
				}
				
				library.push (actuator);
				actuator.move ();
				
				return actuator;
				
			} else {
				
				return apply (target, properties, customActuator);
				
			}
			
		}
		
		return null;
		
	}
	
	
	/*@:generic*/ public static function unload<T> (actuator:GenericActuator<T>):Void {
		
		var target = actuator.target;
		
		#if neko
		
		if (Reflect.isFunction (target)) {
			
			if (methodLibraries.exists (target)) {
				
				methodLibraries.get (target).remove (actuator);
				
				if (methodLibraries.get (target).length == 0) {
					
					methodLibraries.remove (target);
					
				}
				
			}
			
			return;
			
		}
		
		#end
		
		if (targetLibraries.exists (target)) {
			
			targetLibraries.get (target).remove (actuator);
			
			if (targetLibraries.get (target).length == 0) {
				
				targetLibraries.remove (target);
				
			}
			
		}
		
	}
	
	
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
	/*@:generic*/ public static function update<T> (target:T, duration:Float, start:Array <Dynamic> = null, end:Array <Dynamic> = null, overwrite:Bool = true):GenericActuator<T> {
				
		var properties:Dynamic = { start: start, end: end };
		
		return tween (target, duration, properties, overwrite, MethodActuator);
		
	}
	
	
}


#if !haxe3
import com.eclecticdesignstudio.motion.actuators.FilterActuator;
import com.eclecticdesignstudio.motion.actuators.GenericActuator;
import com.eclecticdesignstudio.motion.actuators.TransformActuator;
import com.eclecticdesignstudio.motion.Actuate;
import flash.display.DisplayObject;
import flash.filters.BitmapFilter;
//import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
#end


#if (flash || nme || openfl)

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


private class TransformOptions<T> {
	
	
	private var duration:Float;
	private var overwrite:Bool;
	private var target:T;
	
	
	public function new (target:T, duration:Float, overwrite:Bool) {
		
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
	public function color (value:Int = 0x000000, strength:Float = 1, alpha:Null <Float> = null):IGenericActuator {
		
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
	public function sound (volume:Null <Float> = null, pan:Null <Float> = null):IGenericActuator {
		
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

#end


private class TweenTimer {
	
	
	public var progress:Float;
	
	
	public function new (progress:Float):Void {
		
		this.progress = progress;
		
	}
	
	
}


#if neko
private class KVPairMap<K, V> {
	var keyList:Array<K>;
	var valList:Array<V>;
	public function new() {
		this.keyList = [];
		this.valList = [];
	}
	function equals(k1:K, k2:K):Bool 
		return throw 'base';
	
	function indexOf(k:K):Int {
		for (i in 0...keyList.length)
			if (equals(k, keyList[i])) return i;
		return -1;
	}
	public function get(k:K):Null<V> 
		return valList[indexOf(k)];
	
	public function set(k:K, v:V):V {
		var i = indexOf(k);
		if (i == -1) {
			keyList.push(k);
			valList.push(v);
		}
		else {
			keyList[i] = k;
			valList[i] = v;
		}
		return v;
	}
	public function exists(k:K):Bool 
		return indexOf(k) != -1;
	
	public function remove(k:K):Bool {
		var i = indexOf(k);
		return
			if (i == -1) false;
			else {
				keyList.splice(i, 1);
				valList.splice(i, 1);
				true;
			}
	}
	public inline function keys():Iterator<K> 
		return keyList.iterator();
	
	public inline function iterator():Iterator<V> 
		return valList.iterator();
	
	public function toString() {
		return [for (i in 0...keyList.length) Std.string(keyList[i]) => valList[i]].toString();
	}
	
}

private class FunctionMap < K, V > extends KVPairMap < K, V > {
                override function equals(k1:K, k2:K):Bool {
                        return Reflect.compareMethods(k1, k2);
                }
        }

#end