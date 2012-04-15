package com.eclecticdesignstudio.motion.actuators {
	
	
	import com.eclecticdesignstudio.motion.MotionPath;
	import flash.utils.getTimer;
	
	use namespace MotionInternal;
	
	
	/**
	 * @author Joshua Granick
	 * @version 1.2
	 */
	public class MotionPathActuator extends SimpleActuator {
		
		
		public function MotionPathActuator (target:Object, duration:Number, properties:Object) {
			
			super (target, duration, properties);
			
		}
		
		
		MotionInternal override function apply ():void {
			
			for (var propertyName:String in properties) {
				
				target[propertyName] = (properties[propertyName] as MotionPath).MotionInternal::end;
				
			}
			
		}
		
		
		protected override function initialize ():void {
			
			var details:PropertyPathDetails;
			var path:MotionPath;
			
			for (var propertyName:String in properties) {
				
				path = properties[propertyName] as MotionPath;
				
				if (path) {
					
					path.start = Number (target[propertyName]);
					details = new PropertyPathDetails (target, propertyName, path);
					propertyDetails.push (details);
					
				}
				
			}
			
			detailsLength = propertyDetails.length;
			initialized = true;
			
		}
		
		
		MotionInternal override function update (currentTime:Number):void {
			
			if (!paused) {
				
				var details:PropertyPathDetails;
				var easing:Number;
				var i:uint;
				
				var tweenPosition:Number = (currentTime - timeOffset) / duration;
				
				if (tweenPosition > 1) {
					
					tweenPosition = 1;
					
				}
				
				if (!initialized) {
					
					initialize ();
					
				}
				
				if (!MotionInternal::special) {
					
					easing = MotionInternal::ease.calculate (tweenPosition);
					
					for (i = 0; i < detailsLength; ++i) {
						
						details = propertyDetails[i];
						details.target[details.propertyName] = details.path.MotionInternal::calculate (easing);
						
					}
					
				} else {
					
					if (!MotionInternal::reverse) {
						
						easing = MotionInternal::ease.calculate (tweenPosition);
						
					} else {
						
						easing = MotionInternal::ease.calculate (1 - tweenPosition);
						
					}
					
					var endValue:Number;
					
					for (i = 0; i < detailsLength; ++i) {
						
						details = propertyDetails[i];
						
						if (!MotionInternal::snapping) {
							
							details.target[details.propertyName] = details.path.MotionInternal::calculate (easing);
							
						} else {
							
							details.target[details.propertyName] = Math.round (details.path.MotionInternal::calculate (easing));
							
						}
						
					}
					
				}
				
				if (tweenPosition === 1) {
					
					if (MotionInternal::repeat === 0) {
						
						active = false;
						
						if (toggleVisible && target.alpha === 0) {
							
							target.visible = false;
							
						}
						
						complete (true);
						return;
						
					} else {
						
						if (MotionInternal::reflect) {
							
							MotionInternal::reverse = !MotionInternal::reverse;
							
						}
						
						startTime = currentTime;
						timeOffset = startTime + MotionInternal::delay;
						
						if (MotionInternal::repeat > 0) {
							
							MotionInternal::repeat --;
							
						}
						
					}
					
				}
				
				if (sendChange) {
					
					change ();
					
				}
				
			}
			
		}
		
		
	}

	
}


import com.eclecticdesignstudio.motion.MotionPath;


class PropertyPathDetails {
	
	
	public var target:Object;
	public var path:MotionPath;
	public var propertyName:String;
	
	
	public function PropertyPathDetails (target:Object, propertyName:String, path:MotionPath) {
		
		this.target = target;
		this.propertyName = propertyName;
		this.path = path;
		
	}
	
	
}