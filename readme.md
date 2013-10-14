# Actuate

Actuate is a tweening library for Haxe that has a focus on speed and simplicity.

## Installation

The easiest way to install Actuate (and to keep it up-to-date with stable builds) is with the Haxelib tool. From your command line:
	
	haxelib install actuate
	
If you want to install the bleeding-edge direct-from-git version of actuate (or, say, any of it's forks):
	
	haxelib git actuate
	
(You will then be prompted to enter the git URL. Example: `https://github.com/jgranick/actuate.git` )
	
## Usage

Tweening your objects is handled with very simple syntax:

	Actuate.tween (MySprite, 1, { alpha: 1 } );

Actuate is designed to be simple to use and to take advantage strong code completion support in code editors like FlashDevelop and Flex Builder, which means no more "reserved" keywords or "special" properties

	Actuate.tween (MySprite, 1, { alpha: 1 } ).onComplete (trace, "Hello World!");

Instance-based tweens can be a pain. When you don't keep track of each tween instance, you run the risk of creating conflicting tweens, which almost never turns out well. With first-class tween overwrite support, Actuate manages your tweens so you don't have to. Actuate also makes it simple to disable overwriting when you need to sequence multiple animations

	Actuate.tween (MySprite, 1, { alpha: 1 } );
	Actuate.tween (MySprite, 1, { alpha: 0 }, false).delay (1);

It's also easy to stop, pause or resume your tweens, too

	Actuate.stop (MySprite);
	Actuate.stop (MySprite, "alpha");
	Actuate.pause ();
	Actuate.pause (MySprite);
	Actuate.pause (MySprite, MyOtherSprite);
	Actuate.resume ();
	Actuate.resume (MySprite);
	Actuate.resume (MySprite, MyOtherSprite);
	Actuate.reset ();

There also are additional shortcuts you can use to help you be even more productive. For example, you can use Actuate to create quick tween-based timers for sequencing events

	Actuate.timer (1).onComplete (trace, "Hello World!");
	
Or you can use the "apply" method to stop conflicting tweens and instantly set an object's properties

	Actuate.apply (MySprite, { alpha: 1 } );

## Advanced Features

For advanced animations, you can also tween function calls instead of properties

	Actuate.update (customResize, 1, [100, 100], [300, 300]);

Actuate also includes shortcuts for some special types of animation. Here is how you might apply a 50% tint using a color transform

	Actuate.transform (MySprite, 1).color (0xFF0000, 0.5);

You can also control the volume and pan of a sound transform as well

	Actuate.transform (MySprite, 1).sound (0.5, 1);
	Actuate.transform (MySoundChannel, 1).sound (0.5, 1);

You can also tween filters. You can reference the filter by its class, or by the value of its index in the filter array, whichever is easier

	Actuate.effects (MySprite, 1).filter (BlurFilter, { blurX: 10, blurY: 10 } );

You even can create bezier curves, and complete motion paths, like in the Flash IDE. Chain multiple path commands together to create one solid path you can tween your objects across using the MotionPathActuator

	var path = new MotionPath ().bezier (100, 100, 50, 50).line (20, 20);
	Actuate.motionPath (MySprite, 1, { x: path.x, y: path.y });
	
(Note the use of `Actuate.motionPath` as opposed to `Actuate.tween` in this example)

Each line and bezier segment has an optional “strength” parameter that controls the ratio between them. By default, the strength of every segment is 1. For example, if you have two segments with the same strength, they each will make up half the motion path. The actual speed will depend on the length of each segment and the easing function you use.

Another bezier example:
	
	var path = new MotionPath ().bezier (300, 100, 100, 200, 2.5).line (450, 25);
	Actuate.motionPath (circle, 4, { x: path.x, y: path.y } ).repeat ().reflect ().ease (Linear.easeNone);

## Tween Modifiers

Each tween Actuate creates can be modified with many different tween modifiers. You can link tween modifiers to add delay, complete handlers, or configure many different options about the way your tween behaves

### autoVisible

	Actuate.tween (MySprite, 1, { alpha: 1 } ).autoVisible (false);

Changing the visible property results in better performance than only an alpha of zero, so the autoVisible modifier toggles the visible property automatically based upon the alpha value of the target. It is enabled by default, but it can be disabled if you choose

### delay

	Actuate.tween (MySprite, 1, { alpha: 1 } ).delay (1);

Controls how many seconds should pass before your animation begins

### ease

	Actuate.tween (MySprite, 1, { alpha: 1 } ).ease (Quad.easeOut);

Defines a custom easing equation for your animation. Actuate includes many popular easing functions in both standard and optimized formats. The default is Expo.easeOut, but you can change the default equation through Actuate.defaultEase

### onComplete

	Actuate.tween (MySprite, 1, { alpha: 1 } ).onComplete (trace, "Tween finished");

Calls a function when the tween is finished. You can also define parameters to be used when calling the function

### onUpdate

	Actuate.tween (MySprite, 1, { alpha: 1 } ).onUpdate (trace, "Tween updated");

Calls a function every time the tween updates. You can also define parameters to be used when calling the function

### reflect

	Actuate.tween (MySprite, 1, { alpha: 1 } ).repeat ().reflect ();

Automatically reverses the animation every other time it is repeated. You must enable repeat in order to see any effect

### repeat

	Actuate.tween (MySprite, 1, { alpha: 1 } ).repeat (10);

Runs your animation multiple times before it finishes. You can make your tween repeat indefinitely by passing no value, or you can define the number of times it should repeat

### reverse

	Actuate.tween (MySprite, 1, { alpha: 1 } ).reverse ();

Reverses the direction of your tween

### smartRotation

	Actuate.tween (MySprite, 1, { rotation: 180 } ).smartRotation ();

Rotation is circular, so it can be strange to animate. What should be positive one moment is negative the next. As a result, treating rotation like a standard tween will result in jerking once the signs change. Smart rotation always applies rotation in the nearest direction, alleviating this issue.

### snapping

	Actuate.tween (MySprite, 1, { alpha: 1 } ).snapping ();

Rounds all of your tween values