package;


import massive.munit.Assert;
import motion.actuators.SimpleActuator;
import motion.easing.Linear;
import motion.Actuate;


class TweenTest {
	
	
	@Test public function testDynamic ():Void {
		
		var object:Dynamic = { x: 100 };
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testTypedef ():Void {
		
		var object:ObjectTypedef = { x: 100 };
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testClass ():Void {
		
		var object = new ObjectClass (100);
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testSetter ():Void {
		
		var object = new ObjectSetter (100);
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testGetterSetter ():Void {
		
		var object = new ObjectGetterSetter (100);
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testSubClassSetter ():Void {
		
		var object = new ObjectSubClassSetter (100);
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	@Test public function testSubClassGetterSetter ():Void {
		
		var object = new ObjectSubClassGetterSetter (100);
		
		Assert.areEqual (100, object.x);
		
		update (0);
		
		Actuate.tween (object, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, object.x);
		
		update (1);
		
		Assert.areEqual (200, object.x);
		
		Actuate.stop (object);
		
		update (2);
		
		Assert.areEqual (200, object.x);
		
	}
	
	
	private function update (time:Float):Void {
		
		SimpleActuator.getTime = function () return time;
		#if flash
		SimpleActuator.stage_onEnterFrame (null);
		#elseif js
		SimpleActuator.stage_onEnterFrame (0);
		#else
		SimpleActuator.stage_onEnterFrame ();
		#end
		
	}
	
	
}


private typedef ObjectTypedef = {
	
	var x:Float;
	
}


private class ObjectClass {
	
	
	public var x:Float;
	
	
	public function new (x:Float) {
		
		this.x = x;
		
	}
	
	
}


private class ObjectSetter {
	
	
	public var x (default, set):Float;
	
	
	public function new (x:Float) {
		
		this.x = x;
		
	}
	
	
	private function set_x (value:Float):Float {
		
		return this.x = value;
		
	}
	
	
}


private class ObjectGetterSetter {
	
	
	public var x (get, set):Float;
	
	private var _x:Float;
	
	
	public function new (x:Float) {
		
		this.x = x;
		
	}
	
	
	private function get_x ():Float {
		
		return _x;
		
	}
	
	
	private function set_x (value:Float):Float {
		
		return _x = value;
		
	}
	
	
}


private class ObjectSubClassSetter extends ObjectSetter {
	
	
	public function new (x:Float) {
		
		super (x);
		
	}
	
	
}


private class ObjectSubClassGetterSetter extends ObjectGetterSetter {
	
	
	public function new (x:Float) {
		
		super (x);
		
	}
	
	
}