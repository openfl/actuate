package com.eclecticdesignstudio.motion.actuators;


import com.eclecticdesignstudio.motion.Actuate;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.ColorTransform;
import flash.media.SoundTransform;


/**
 * @author Joshua Granick
 * @version 1.2
 */
class TransformActuator extends SimpleActuator {
	
	
	private var endColorTransform:ColorTransform;
	private var endSoundTransform:SoundTransform;
	private var tweenColorTransform:ColorTransform;
	private var tweenSoundTransform:SoundTransform;
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic) {
		
		super (target, duration, properties);
		
	}
	
	
	public override function apply ():Void {
		
		initialize ();
		
		if (endColorTransform != null) {
			
			target.transform.colorTransform = endColorTransform;
			
		}
		
		if (endSoundTransform != null) {
			
			target.soundTransform = endSoundTransform;
			
		}
		
	}
	
	
	private override function initialize ():Void {
		
		if (Reflect.hasField (properties, "colorValue") && Std.is (target, DisplayObject)) {
			
			initializeColor ();
			
		}
		
		if (Reflect.hasField (properties, "soundVolume") || Reflect.hasField (properties, "soundPan")) {
			
			initializeSound ();
			
		}
		
		detailsLength = propertyDetails.length;
		initialized = true;
		
	}
	
	
	private function initializeColor ():Void {
		
		endColorTransform = new ColorTransform ();
		
		var color:Int = properties.colorValue;
		var strength:Float = properties.colorStrength;
		
		if (strength < 1) {
			
			var multiplier:Float;
			var offset:Float;
			
			if (strength < 0.5) {
				
				multiplier = 1;
				offset = (strength * 2);
				
			} else {
				
				multiplier = 1 - ((strength - 0.5) * 2);
				offset = 1;
				
			}
			
			endColorTransform.redMultiplier = multiplier;
			endColorTransform.greenMultiplier = multiplier;
			endColorTransform.blueMultiplier = multiplier;
			
			endColorTransform.redOffset = offset * ((color >> 16) & 0xFF);
			endColorTransform.greenOffset = offset * ((color >> 8) & 0xFF);
			endColorTransform.blueOffset = offset * (color & 0xFF);
			
		} else {
			
			//endColorTransform.color = color;
			
			endColorTransform.redMultiplier = 0;
			endColorTransform.greenMultiplier = 0;
			endColorTransform.blueMultiplier = 0;
			
			endColorTransform.redOffset = ((color >> 16) & 0xFF);
			endColorTransform.greenOffset = ((color >> 8) & 0xFF);
			endColorTransform.blueOffset = (color & 0xFF);
			
		}
		
		var propertyNames:Array <String> = [ "redMultiplier", "greenMultiplier", "blueMultiplier", "redOffset", "greenOffset", "blueOffset" ];
		
		if (Reflect.hasField (properties, "colorAlpha")) {
			
			endColorTransform.alphaMultiplier = properties.colorAlpha;
			propertyNames.push ("alphaMultiplier");
			
		} else {
			
			endColorTransform.alphaMultiplier = target.alpha;
			
		}
		
		var begin:ColorTransform = target.transform.colorTransform;
		tweenColorTransform = new ColorTransform ();
		
		var details:PropertyDetails;
		var start:Float;
		
		for (propertyName in propertyNames) {
			
			start = Reflect.field (begin, propertyName);
			details = new PropertyDetails (tweenColorTransform, propertyName, start, Reflect.field (endColorTransform, propertyName) - start);
			propertyDetails.push (details);
			
		}
		
	}
	
	
	private function initializeSound ():Void {
		
		var start:SoundTransform = target.soundTransform;
		endSoundTransform = target.soundTransform;
		tweenSoundTransform = new SoundTransform ();
		
		if (Reflect.hasField (properties, "soundVolume")) {
			
			endSoundTransform.volume = properties.soundVolume;
			propertyDetails.push (new PropertyDetails (tweenSoundTransform, "volume", start.volume, endSoundTransform.volume - start.volume));
			
		}
		
		if (Reflect.hasField (properties, "soundPan")) {
			
			endSoundTransform.pan = properties.soundPan;
			propertyDetails.push (new PropertyDetails (tweenSoundTransform, "pan", start.pan, endSoundTransform.pan - start.pan));
			
		}
		
	}
	
	
	private override function update (currentTime:Float):Void {
		
		super.update (currentTime);
		
		if (endColorTransform != null) {
			
			target.transform.colorTransform = tweenColorTransform;
			
		}
		
		if (endSoundTransform != null) {
			
			target.soundTransform = tweenSoundTransform;
			
		}
		
	}
	
	
}