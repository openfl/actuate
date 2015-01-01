package motion.actuators;


import motion.easing.IEasing;


interface IGenericActuator {
	
	
	/**
	 * Flash performs faster when objects are set to visible = false rather than only alpha = 0. autoVisible toggles automatically based on alpha values
	 * @param	value		Whether autoVisible should be enabled (Default is true)
	 * @return		The current actuator instance
	 */
	public function autoVisible (?value:Null<Bool>):IGenericActuator;
	
	/**
	 * Increases the delay before a tween is executed
	 * @param	duration		The amount of seconds to delay
	 * @return		The current actuator instance
	 */
	public function delay (duration:Float):IGenericActuator;
	
	/**
	 * Sets the easing which is used when running the tween
	 * @param	easing		An easing equation, like Elastic.easeIn or Quad.easeOut
	 * @return		The current actuator instance
	 */
	public function ease (easing:IEasing):IGenericActuator;
	
	/**
	 * Defines a function which will be called when the tween finishes
	 * @param	handler		The function you would like to be called
	 * @param	parameters		Parameters you would like to pass to the handler function when it is called
	 * @return		The current actuator instance
	 */
	public function onComplete (handler:Dynamic, ?parameters:Array <Dynamic>):IGenericActuator;
	
	/**
	 * Defines a function which will be called when the tween repeats
	 * @param	handler		The function you would like to be called
	 * @param	parameters		Parameters you would like to pass to the handler function when it is called
	 * @return		The current actuator instance
	 */
	public function onRepeat (handler:Dynamic, ?parameters:Array <Dynamic>):IGenericActuator;
	
	/**
	 * Defines a function which will be called when the tween updates
	 * @param	handler		The function you would like to be called
	 * @param	parameters		Parameters you would like to pass to the handler function when it is called
	 * @return		The current actuator instance
	 */
	public function onUpdate (handler:Dynamic, ?parameters:Array <Dynamic>):IGenericActuator;
	
	/**
	 * Automatically changes the reverse value when the tween repeats. Repeat must be enabled for this to have any effect
	 * @param	value		Whether reflect should be enabled (Default is true)
	 * @return		The current actuator instance
	 */
	public function reflect (?value:Null<Bool>):IGenericActuator;
	
	/**
	 * Repeats the tween after it finishes
	 * @param	times		The number of times you would like the tween to repeat, or -1 if you would like to repeat the tween indefinitely (Default is -1)
	 * @return		The current actuator instance
	 */
	public function repeat (?times:Null<Int>):IGenericActuator;
	
	/**
	 * Sets if the tween should be handled in reverse
	 * @param	value		Whether the tween should be reversed (Default is true)
	 * @return		The current actuator instance
	 */
	public function reverse (?value:Null<Bool>):IGenericActuator;
	
	/**
	 * Enabling smartRotation can prevent undesired results when tweening rotation values
	 * @param	value		Whether smart rotation should be enabled (Default is true)
	 * @return		The current actuator instance
	 */
	public function smartRotation (?value:Null<Bool>):IGenericActuator;
	
	/**
	 * Snapping causes tween values to be rounded automatically
	 * @param	value		Whether tween values should be rounded (Default is true)
	 * @return		The current actuator instance
	 */
	public function snapping (?value:Null<Bool>):IGenericActuator;
	
	/**
	 * Defines a function which will be called when the tween is paused
	 * @param	handler		The function you would like to be called
	 * @param	parameters		Parameters you would like to pass to the handler function when it is called
	 * @return		The current actuator instance
	 */
	public function onPause (handler:Dynamic, ?parameters:Array <Dynamic>):IGenericActuator;
	
	/**
	 * Defines a function which will be called when the tween resumed after pause
	 * @param	handler		The function you would like to be called
	 * @param	parameters		Parameters you would like to pass to the handler function when it is called
	 * @return		The current actuator instance
	 */
	public function onResume (handler:Dynamic, ?parameters:Array <Dynamic>):IGenericActuator;
	
	
	//private var properties:Dynamic;
	private function apply ():Void;
	private function move ():Void;
	private function pause ():Void;
	private function resume ():Void;
	private function stop (properties:Dynamic, complete:Bool, sendEvent:Bool):Void;
	
	
}