package motion.actuators;


import motion.actuators.GenericActuator;
#if (flash || nme || openfl)
import flash.display.DisplayObject;
import flash.events.Event;
import flash.Lib;
#elseif lime
import lime.app.Application;
import lime.system.System;
#elseif js
import js.Browser;
#else
#if neko
import haxe.Log;
import haxe.PosInfos;
#end
import haxe.Timer;
#end


class SimpleActuator<T, U> extends GenericActuator<T> {
	
	
	#if actuate_manual_time
	public static var getTime:Void->Float;
	#end
	
	private var timeOffset:Float;
	
	private static var actuators = new Array<SimpleActuator<Dynamic, Dynamic>> ();
	private static var actuatorsLength = 0;
	private static var addedEvent = false;
	
	#if (!flash && !nme && !openfl && !lime && !js)
	private static var timer:Timer;
	#end
	
	private var active:Bool;
	private var cacheVisible:Bool;
	private var detailsLength:Int;
	private var initialized:Bool;
	private var paused:Bool;
	private var pauseTime:Float;
	private var propertyDetails:Array <PropertyDetails<U>>;
	private var sendChange:Bool;
	private var setVisible:Bool;
	private var startTime:Float;
	private var toggleVisible:Bool;
	
	
	public function new (target:T, duration:Float, properties:Dynamic) {
		
		active = true;
		propertyDetails = new Array ();
		sendChange = false;
		paused = false;
		cacheVisible = false;
		initialized = false;
		setVisible = false;
		toggleVisible = false;
		
		#if !actuate_manual_time
			#if (flash || nme || openfl)
			startTime = Lib.getTimer () / 1000;
			#elseif lime
			startTime = System.getTimer () / 1000;
			#elseif js
			startTime = Browser.window.performance.now () / 1000;
			#else
			startTime = Timer.stamp ();
			#end
		#else
		startTime = getTime();
		#end
		
		super (target, duration, properties);
		
		if (!addedEvent) {
			
			addedEvent = true;
			#if !actuate_manual_update
				#if (flash || nme || openfl)
				Lib.current.stage.addEventListener (Event.ENTER_FRAME, stage_onEnterFrame);
				#elseif lime
				Application.current.onUpdate.add (stage_onEnterFrame);
				#elseif js
				Browser.window.requestAnimationFrame(stage_onEnterFrame);
				#else
				timer = new Timer (Std.int(1000 / 30));
				timer.run = stage_onEnterFrame;
				#end
			#end
		}
		
	}
	
	//For instant transition to start state without shaking
	override public function reverse(?value:Null<Bool>):GenericActuator<T> 
	{
		var ga = super.reverse(value);
		
		
		var startTime:Float = 0;
		#if !actuate_manual_time
			#if (flash || nme || openfl)
			startTime = Lib.getTimer () / 1000;
			#elseif lime
			startTime = System.getTimer () / 1000;
			#elseif js
			startTime = Browser.window.performance.now () / 1000;
			#else
			startTime = Timer.stamp ();
			#end
		#else
		startTime = getTime();
		#end
		
		
		update(startTime);
		
		
		return ga;
	}
	
	/**
	 * @inheritDoc
	 */
	private override function apply ():Void {
		
		super.apply();
		
		if (toggleVisible && Reflect.hasField (properties, "alpha")) {
			
			if (getField (target, "visible") != null) {
				
				setField (target, "visible", Reflect.field (properties, "alpha") > 0);
				
			}
			
		}
		
	}
	
	
	/**
	 * @inheritDoc
	 */
	public override function autoVisible (?value:Null<Bool>):GenericActuator<T> {
		
		if (value == null) {
			
			value = true;
			
		}
		
		_autoVisible = value;
		
		if (!value) {
			
			toggleVisible = false;
			
			if (setVisible) {
				
				setField (target, "visible", cacheVisible);
				
			}
			
		}
		
		return this;
		
	}
	
	
	/**
	 * @inheritDoc
	 */
	public override function delay (duration:Float):GenericActuator<T> {
		
		_delay = duration;
		timeOffset = startTime + duration;
		
		return this;
		
	}
	
	
	private inline function getField<V> (target:V, propertyName:String):Dynamic {
		
		#if (haxe_209 || haxe3)
		
		var value = null;
		
		if (Reflect.hasField (target, propertyName)) {
			
			#if flash
			value = untyped target[propertyName];
			#else
			value = Reflect.field (target, propertyName);
			#end
			
		} else {
			
			value = Reflect.getProperty (target, propertyName);
			
		}
		
		return value;
		
		#else
		
		return Reflect.field (target, propertyName);
		
		#end
		
	}
	
	
	private function initialize ():Void {
		
		var details:PropertyDetails<U>;
		var start:Dynamic;
		
		for (i in Reflect.fields (properties)) {
			
			var isField = true;
			
			#if (haxe_209 || haxe3)
			
			#if (!neko && !hl)
			if (Reflect.hasField (target, i) #if flash && !untyped (target).hasOwnProperty ("set_" + i) #elseif js && !(untyped (target).__properties__ && untyped (target).__properties__["set_" + i]) #end) {
				
				start = Reflect.field (target, i);
				
			} else
			#end
			{
				
				isField = false;
				start = Reflect.getProperty (target, i);
				
			}
			
			#else
			
			start = Reflect.field (target, i);
			
			#end
			
			if (#if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (start, Float)) {
				
				var value:Dynamic = getField (properties, i);
				
				#if (neko || js)
				if (start == null) start = 0;
				if (value == null) value = 0;
				#end
				
				details = new PropertyDetails (cast target, i, start, value - start, isField);
				propertyDetails.push (details);
				
			}
			
		}
		
		detailsLength = propertyDetails.length;
		initialized = true;
		
	}
	
	
	private override function move ():Void {
		
		#if (flash || nme || openfl)
		toggleVisible = (Reflect.hasField (properties, "alpha") && #if (haxe_ver >= 4.2) Std.isOfType #else Std.is #end (target, DisplayObject));
		#else
		toggleVisible = (Reflect.hasField (properties, "alpha") && Reflect.hasField (properties, "visible"));
		#end
		
		if (toggleVisible && properties.alpha != 0 && !getField (target, "visible")) {
			
			setVisible = true;
			cacheVisible = getField (target, "visible");
			setField (target, "visible", true);
			
		}
		
		timeOffset = startTime;
		actuators.push (this);
		++actuatorsLength;
		
	}
	
	
	/**
	 * @inheritDoc
	 */
	public override function onUpdate (handler:Dynamic, parameters:Array <Dynamic> = null):GenericActuator<T> {
		
		_onUpdate = handler;
		
		if (parameters == null) {
			
			_onUpdateParams = [];
			
		} else {
			
			_onUpdateParams = parameters;
			
		}
		
		sendChange = true;
		
		return this;
		
	}
	
	
	private override function pause ():Void {
		
		if (!paused) {
			
			paused = true;
			
			super.pause();
			
			#if !actuate_manual_time
				#if (flash || nme || openfl)
				pauseTime = Lib.getTimer ();
				#elseif lime
				pauseTime = System.getTimer ();
				#elseif js
				pauseTime = Browser.window.performance.now ();
				#else
				pauseTime = Timer.stamp ();
				#end
			#else
			pauseTime = getTime();
			#end
			
		}
		
	}
	
	
	private override function resume ():Void {
		
		if (paused) {
			
			paused = false;
			
			#if !actuate_manual_time
				#if (flash || nme || openfl)
				timeOffset += (Lib.getTimer () - pauseTime) / 1000;
				#elseif lime
				timeOffset += (System.getTimer () - pauseTime) / 1000;
				#elseif js
				timeOffset += (Browser.window.performance.now () - pauseTime) / 1000;
				#else
				timeOffset += (Timer.stamp () - pauseTime);
				#end
			#else
			timeOffset += (getTime() - pauseTime);
			#end
			
			super.resume ();
			
		}
		
	}
	
	
	#if !js @:generic #end private inline function setField<V> (target:V, propertyName:String, value:Dynamic):Void {
		
		if (Reflect.hasField (target, propertyName) #if flash && !untyped (target).hasOwnProperty ("set_" + propertyName) #elseif js && !(untyped (target).__properties__ && untyped (target).__properties__["set_" + propertyName]) #end) {
			
			#if flash
			untyped target[propertyName] = value;
			#else
			Reflect.setField (target, propertyName, value);
			#end
			
		} else {
			
			#if (haxe_209 || haxe3)
			Reflect.setProperty (target, propertyName, value);
			#end
			
		}
		
	}
	
	
	private function setProperty (details:PropertyDetails<U>, value:Dynamic):Void {
		
		if (details.isField) {
			
			#if flash
			untyped details.target[details.propertyName] = value;
			#else
			Reflect.setField (details.target, details.propertyName, value);
			#end
			
		} else {
			
			#if (haxe_209 || haxe3)
			Reflect.setProperty (details.target, details.propertyName, value);
			#end
			
		}
		
	}
	
	
	private override function stop (properties:Dynamic, complete:Bool, sendEvent:Bool):Void {
		
		if (active) {
			
			if (properties == null) {
				
				active = false;
				
				if (complete) {
					
					apply ();
					
				}
				
				this.complete (sendEvent);
				return;
				
			}
			
			for (i in Reflect.fields (properties)) {
				
				if (Reflect.hasField (this.properties, i)) {
					
					active = false;
					
					if (complete) {
						
						apply ();
						
					}
					
					this.complete (sendEvent);
					return;
					
				}
				
			}
			
		}
		
	}
	
	
	private function update (currentTime:Float):Void {
		
		if (!paused) {
			
			var details:PropertyDetails<U>;
			var easing:Float;
			var i:Int;
			
			var tweenPosition:Float = (currentTime - timeOffset) / duration;
			
			if (tweenPosition > 1) {
				
				tweenPosition = 1;
				
			}
			
			if (!initialized) {
				
				initialize ();
				
			}
			
			if (!special) {
				
				easing = _ease.calculate (tweenPosition);
				
				for (i in 0...detailsLength) {
					
					details = propertyDetails[i];
					setProperty (details, details.start + (details.change * easing));
					
				}
				
			} else {
				
				if (!_reverse) {
					
					easing = _ease.calculate (tweenPosition);
					
				} else {
					
					easing = _ease.calculate (1 - tweenPosition);
					
				}
				
				var endValue:Float;
				
				for (i in 0...detailsLength) {
					
					details = propertyDetails[i];
					
					if (_smartRotation && (details.propertyName == "rotation" || details.propertyName == "rotationX" || details.propertyName == "rotationY" || details.propertyName == "rotationZ")) {
						
						var rotation:Float = details.change % 360;
						
						if (rotation > 180) {
							
							rotation -= 360;
							
						} else if (rotation < -180) {
							
							rotation += 360;
							
						}
						
						endValue = details.start + rotation * easing;
						
					} else {
						
						endValue = details.start + (details.change * easing);
						
					}
					
					if (!_snapping) {
						
						setProperty (details, endValue);
						
					} else {
						
						setProperty (details, Math.round (endValue));
						
					}
					
				}
				
			}
			
			if (tweenPosition == 1) {
				
				if (_repeat == 0) {
					
					active = false;
					
					if (toggleVisible && getField (target, "alpha") == 0) {
						
						setField (target, "visible", false);
						
					}
					
					complete (true);
					return;
					
				} else {
					
					if (_onRepeat != null) {
						
						callMethod (_onRepeat, _onRepeatParams);
						
					}
					
					if (_reflect) {
						
						_reverse = !_reverse;
						
					}
					
					startTime = currentTime;
					timeOffset = startTime + _delay;
					
					if (_repeat > 0) {
						
						_repeat --;
						
					}
					
				}
				
			}
			
			if (sendChange) {
				
				change ();
				
			}
			
		}
		
	}
	
	
	
	
	// Event Handlers
	
	
	#if actuate_manual_update 
	public 
	#else 
	private 
	#end
	static function stage_onEnterFrame (#if (flash || nme || openfl) event:Event #elseif lime deltaTime:Int #elseif js deltaTime:Float #end):Void {
		#if !actuate_manual_time
			#if (flash || nme || openfl)
			var currentTime:Float = Lib.getTimer () / 1000;
			#elseif lime
			var currentTime = System.getTimer () / 1000;
			#elseif js
			var currentTime = deltaTime / 1000;
			#else
			var currentTime = Timer.stamp ();
			#end
		#else
			var currentTime = getTime ();
		#end
		
		var actuator:SimpleActuator<Dynamic, Dynamic>;
		
		var j:Int = 0;
		var cleanup = false;
		
		for (i in 0...actuatorsLength) {
			
			actuator = actuators[j];
			
			if (actuator != null && actuator.active) {
				
				if (currentTime >= actuator.timeOffset) {
					
					actuator.update (currentTime);
					
				}
				
				j++;
				
			} else {
				
				actuators.splice (j, 1);
				--actuatorsLength;
				
			}
			
		}
		
		#if (!flash && !nme && !openfl && !lime && !actuate_manual_update && js)
		Browser.window.requestAnimationFrame(stage_onEnterFrame);
		#end
		
	}
	
	
}


#if ((cpp || neko) && (!openfl && !lime && !nme))

// Custom haxe.Timer implementation for C++ and Neko

typedef TimerList = Array <Timer>;


class Timer {
	
	
	static var sRunningTimers:TimerList = [];
	
	var mTime:Float;
	var mFireAt:Float;
	var mRunning:Bool;
	
	
	public function new (time:Float) {
		
		mTime = time;
		sRunningTimers.push (this);
		mFireAt = GetMS () + mTime;
		mRunning = true;
		
	}
	
	
	public static function measure<T>( f : Void -> T, ?pos : haxe.PosInfos ) : T {
		var t0 = stamp();
		var r = f();
		haxe.Log.trace((stamp() - t0) + "s", pos);
		return r;
	}
	
	
	// Set this with "run=..."
	dynamic public function run () {
		
		
		
	}
   
	
	public function stop ():Void {
		
		if (mRunning) {
			
			mRunning = false;
			sRunningTimers.remove (this);
			
		}
		
	}
	
	
	static function GetMS ():Float {
		
		return stamp () * 1000.0;
		
	}
	

   // From std/haxe/Timer.hx
	public static function delay (f:Void -> Void, time:Int) {
		
		var t = new Timer (time);
		
		t.run = function () {
			t.stop ();
			f ();
		};
		
		return t;
		
	}
	
	
	static public function stamp ():Float {
		
		return Date.now().getTime ();
		
	}
	
	
}


#end
