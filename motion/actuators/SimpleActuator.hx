package motion.actuators;


import motion.actuators.GenericActuator;

#if (flash || nme || openfl)
import flash.display.DisplayObject;
import flash.events.Event;
import flash.Lib;
#else
#if neko
import haxe.Log;
import haxe.PosInfos;
#end
import haxe.Timer;
#end


/**
 * @author Joshua Granick
 * @version 1.2
 */
class SimpleActuator extends GenericActuator {
	
	
	private var timeOffset:Float;
	
	private static var actuators:Array <SimpleActuator> = new Array <SimpleActuator> ();
	private static var actuatorsLength:Int = 0;
	private static var addedEvent:Bool = false;
	
	#if (!flash && !nme && !openfl)
	private static var timer:Timer;
	#end
	
	private var active:Bool;
	private var cacheVisible:Bool;
	private var detailsLength:Int;
	private var initialized:Bool;
	private var paused:Bool;
	private var pauseTime:Float;
	private var propertyDetails:Array <PropertyDetails>;
	private var sendChange:Bool;
	private var setVisible:Bool;
	private var startTime:Float;
	private var toggleVisible:Bool;
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic) {
		
		active = true;
		propertyDetails = new Array <PropertyDetails> ();
		sendChange = false;
		paused = false;
		cacheVisible = false;
		initialized = false;
		setVisible = false;
		toggleVisible = false;
		
		#if (flash || nme || openfl)
		startTime = Lib.getTimer () / 1000;
		#else
		startTime = Timer.stamp ();
		#end
		
		super (target, duration, properties);
		
		if (!addedEvent) {
			
			addedEvent = true;
			
			#if (flash || nme || openfl)
			Lib.current.stage.addEventListener (Event.ENTER_FRAME, stage_onEnterFrame);
			#else
			timer = new Timer (Std.int(1000 / 30));
			timer.run = stage_onEnterFrame;
			#end
			
		}
		
	}
	
	
	/**
	 * @inheritDoc
	 */
	public override function autoVisible (?value:Null<Bool>):IGenericActuator {
		
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
	public override function delay (duration:Float):IGenericActuator {
		
		_delay = duration;
		timeOffset = startTime + duration;
		
		return this;
		
	}
	
	
	private inline function getField (target:Dynamic, propertyName:String):Dynamic {
		
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
		
		var details:PropertyDetails;
		var start:Float;
		
		for (i in Reflect.fields (properties)) {
			
			var isField = true;
			
			#if (haxe_209 || haxe3)
			
			if (Reflect.hasField (target, i)) {
				
				start = Reflect.field (target, i);
				
			} else {
				
				isField = false;
				start = Reflect.getProperty (target, i);
				
			}
			
			#else
			
			start = Reflect.field (target, i);
			
			#end
			
			if (Std.is (start, Float)) {
				
				details = new PropertyDetails (target, i, start, getField (properties, i) - start, isField);
				propertyDetails.push (details);
				
			}
			
		}
		
		detailsLength = propertyDetails.length;
		initialized = true;
		
	}
	
	
	public override function move ():Void {
		
		#if (flash || nme || openfl)
		toggleVisible = (Reflect.hasField (properties, "alpha") && Std.is (target, DisplayObject));
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
	public override function onUpdate (handler:Dynamic, parameters:Array <Dynamic> = null):IGenericActuator {
		
		_onUpdate = handler;
		
		if (parameters == null) {
			
			_onUpdateParams = [];
			
		} else {
			
			_onUpdateParams = parameters;
			
		}
		
		sendChange = true;
		
		return this;
		
	}
	
	
	public override function pause ():Void {
		
		paused = true;
		
		#if (flash || nme || openfl)
		pauseTime = Lib.getTimer ();
		#else
		pauseTime = Timer.stamp ();
		#end
		
	}
	
	
	public override function resume ():Void {
		
		if (paused) {
			
			paused = false;
			
			#if (flash || nme || openfl)
			timeOffset += (Lib.getTimer () - pauseTime) / 1000;
			#else
			timeOffset += (Timer.stamp () - pauseTime) / 1000;
			#end
			
		}
		
	}
	
	
	private inline function setField (target:Dynamic, propertyName:String, value:Dynamic):Void {
		
		if (Reflect.hasField (target, propertyName)) {
			
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
	
	
	private inline function setProperty (details:PropertyDetails, value:Dynamic):Void {
		
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
	
	
	public override function stop (properties:Dynamic, complete:Bool, sendEvent:Bool):Void {
		
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
			
			var details:PropertyDetails;
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
	
	
	
	
	private static function stage_onEnterFrame (#if (flash || nme || openfl) event:Event #end):Void {
		
		#if (flash || nme || openfl)
		var currentTime:Float = Lib.getTimer () / 1000;
		#else
		var currentTime = Timer.stamp ();
		#end
		
		var actuator:SimpleActuator;
		
		var j:Int = 0;
		var cleanup = false;
		
		for (i in 0...actuatorsLength) {
			
			actuator = actuators[j];
			
			if (actuator.active) {
				
				if (currentTime > actuator.timeOffset) {
					
					actuator.update (currentTime);
					
				}
				
				j++;
				
			} else {
				
				actuators.splice (j, 1);
				--actuatorsLength;
				
			}
			
		}
		
	}
	
	
}


#if (!nme && neko)


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
