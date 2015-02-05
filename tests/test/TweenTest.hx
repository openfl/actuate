package;


import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import motion.actuators.SimpleActuator;
import motion.easing.Linear;
import motion.Actuate;


class TweenTest {
	
	
	private var objectClass:ObjectClass;
	private var objectDynamic:Dynamic;
	private var objectGetterSetter:ObjectGetterSetter;
	private var objectSetter:ObjectSetter;
	private var objectTypedef:ObjectTypedef;
	private var timer:Timer;
	
	
	public function new () {
		
		
		
	}
	
	
	@Before public function setup ():Void {
		
		objectDynamic = { x: 100 };
		objectTypedef = { x: 100 };
		objectClass = new ObjectClass (100);
		objectSetter = new ObjectSetter (100);
		objectGetterSetter = new ObjectGetterSetter (100);
		
	}
	
	
	@Test public function testDynamic ():Void {
		
		Assert.areEqual (100, objectDynamic.x);
		
		update (0);
		
		Actuate.tween (objectDynamic, 1, { x: 200 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectDynamic.x);
		
		update (1);
		
		Assert.areEqual (200, objectDynamic.x);
		
	}
	
	
	@Test public function testTypedef ():Void {
		
		Assert.areEqual (100, objectTypedef.x);
		
		update (0);
		
		Actuate.tween (objectTypedef, 1, { x: 200 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectTypedef.x);
		
		update (1);
		
		Assert.areEqual (200, objectTypedef.x);
		
	}
	
	
	@Test public function testClass ():Void {
		
		Assert.areEqual (100, objectClass.x);
		
		update (0);
		
		Actuate.tween (objectClass, 1, { x: 200 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectClass.x);
		
		update (1);
		
		Assert.areEqual (200, objectClass.x);
		
	}
	
	
	@Test public function testSetter ():Void {
		
		Assert.areEqual (100, objectSetter.x);
		
		update (0);
		
		Actuate.tween (objectSetter, 1, { x: 200 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectSetter.x);
		
	}
	
	
	@Test public function testGetterSetter ():Void {
		
		Assert.areEqual (100, objectGetterSetter.x);
		
		update (0);
		
		Actuate.tween (objectGetterSetter, 1, { x: 200 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectGetterSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectGetterSetter.x);
		
	}
	
	
	private function update (time:Float):Void {
		
		SimpleActuator.getTime = function () return time;
		#if flash
		SimpleActuator.stage_onEnterFrame (null);
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