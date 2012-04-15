package com.eclecticdesignstudio.motion.actuators;


import flash.display.DisplayObject;
import flash.filters.BitmapFilter;


/**
 * @author Joshua Granick
 * @version 1.2
 */
class FilterActuator extends SimpleActuator {
	
	
	private var filter:BitmapFilter;
	private var filterClass:Class <BitmapFilter>;
	private var filterIndex:Int;
	
	
	public function new (target:Dynamic, duration:Float, properties:Dynamic) {
		
		filterIndex = -1;
		
		super (target, duration, properties);
		
		if (Std.is (properties.filter, Class)) {
			
			filterClass = properties.filter;
			
			for (filter in cast (target, DisplayObject).filters) {
				
				if (Std.is (filter, filterClass)) {
					
					this.filter = filter;
					
				}
				
			}
			
		} else {
			
			filterIndex = properties.filter;
			this.filter = cast (target, DisplayObject).filters [filterIndex];
			
		}
		
	}
	
	
	public override function apply ():Void {
		
		for (propertyName in Reflect.fields (properties)) {
			
			if (propertyName != "filter") {
				
				Reflect.setField (filter, propertyName, Reflect.field (properties, propertyName));
				
			}
			
		}
		
		var filters:Array <BitmapFilter> = target.filters;
		Reflect.setField (filters, properties.filter, filter);
		target.filters = filters;
		
	}
	
	
	private override function initialize ():Void {
		
		var details:PropertyDetails;
		var start:Float;
		
		for (propertyName in Reflect.fields (properties)) {
			
			if (propertyName != "filter") {
				
				start = Reflect.field (filter, propertyName);
				details = new PropertyDetails (filter, propertyName, start, Reflect.field (properties, propertyName) - start);
				propertyDetails.push (details);
				
			}
			
		}
		
		detailsLength = propertyDetails.length;
		initialized = true;
		
	}
	
	
	private override function update (currentTime:Float):Void {
		
		super.update (currentTime);
		
		var filters:Array <Dynamic> = cast (target, DisplayObject).filters;
		
		if (filterIndex > -1) {
			
			Reflect.setField (filters, properties.filter, filter);
			
		} else {
			
			for (i in 0...filters.length) {
				
				if (Std.is (filters[i], filterClass)) {
					
					filters[i] = filter;
					
				}
				
			}
			
		}
		
		target.filters = filters;
		
	}
	
	
}