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
	private var objectSubClassGetterSetter:ObjectSubClassGetterSetter;
	private var objectSubClassSetter:ObjectSubClassSetter;
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
		objectSubClassSetter = new ObjectSubClassSetter (100);
		objectSubClassGetterSetter = new ObjectSubClassGetterSetter (100);
		
	}
	
	
	@Test public function testDynamic ():Void {
		
		Assert.areEqual (100, objectDynamic.x);
		
		update (0);
		
		Actuate.tween (objectDynamic, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectDynamic.x);
		
		update (1);
		
		Assert.areEqual (200, objectDynamic.x);
		
		Actuate.stop (objectDynamic);
		
		update (2);
		
		Assert.areEqual (200, objectDynamic.x);
		
	}
	
	
	@Test public function testTypedef ():Void {
		
		Assert.areEqual (100, objectTypedef.x);
		
		update (0);
		
		Actuate.tween (objectTypedef, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectTypedef.x);
		
		update (1);
		
		Assert.areEqual (200, objectTypedef.x);
		
		Actuate.stop (objectTypedef);
		
		update (2);
		
		Assert.areEqual (200, objectTypedef.x);
		
	}
	
	
	@Test public function testClass ():Void {
		
		Assert.areEqual (100, objectClass.x);
		
		update (0);
		
		Actuate.tween (objectClass, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectClass.x);
		
		update (1);
		
		Assert.areEqual (200, objectClass.x);
		
		Actuate.stop (objectClass);
		
		update (2);
		
		Assert.areEqual (200, objectClass.x);
		
	}
	
	
	@Test public function testSetter ():Void {
		
		Assert.areEqual (100, objectSetter.x);
		
		update (0);
		
		Actuate.tween (objectSetter, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectSetter.x);
		
		Actuate.stop (objectSetter);
		
		update (2);
		
		Assert.areEqual (200, objectSetter.x);
		
	}
	
	
	@Test public function testGetterSetter ():Void {
		
		Assert.areEqual (100, objectGetterSetter.x);
		
		update (0);
		
		Actuate.tween (objectGetterSetter, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectGetterSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectGetterSetter.x);
		
		Actuate.stop (objectGetterSetter);
		
		update (2);
		
		Assert.areEqual (200, objectGetterSetter.x);
		
	}
	
	
	@Test public function testSubClassSetter ():Void {
		
		Assert.areEqual (100, objectSubClassSetter.x);
		
		update (0);
		
		Actuate.tween (objectSubClassSetter, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectSubClassSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectSubClassSetter.x);
		
		Actuate.stop (objectSubClassSetter);
		
		update (2);
		
		Assert.areEqual (200, objectSubClassSetter.x);
		
	}
	
	
	@Test public function testSubClassGetterSetter ():Void {
		
		Assert.areEqual (100, objectSubClassGetterSetter.x);
		
		update (0);
		
		Actuate.tween (objectSubClassGetterSetter, 2, { x: 300 }).ease (Linear.easeNone);
		
		update (0.5);
		
		Assert.areEqual (150, objectSubClassGetterSetter.x);
		
		update (1);
		
		Assert.areEqual (200, objectSubClassGetterSetter.x);
		
		Actuate.stop (objectSubClassGetterSetter);
		
		update (2);
		
		Assert.areEqual (200, objectSubClassGetterSetter.x);
		
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