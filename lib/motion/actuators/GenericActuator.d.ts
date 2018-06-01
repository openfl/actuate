import IEasing from "./../actuators/IEasing";
import IGenericActuator from "./IGenericActuator";


declare namespace motion.actuators {
	
	
	export class GenericActuator implements IGenericActuator {
		
		
		public constructor (target:any, duration:number, properties:any);
		
		/**
		 * Flash performs faster when objects are set to visible = false rather than only alpha = 0. autoVisible toggles automatically based on alpha values
		 * @param	value		Whether autoVisible should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public autoVisible (value?:boolean | null):GenericActuator;
		
		/**
		 * Increases the delay before a tween is executed
		 * @param	duration		The amount of seconds to delay
		 * @return		The current actuator instance
		 */
		public delay (duration:number):GenericActuator;
		
		/**
		 * Sets the easing which is used when running the tween
		 * @param	easing		An easing equation, like Elastic.easeIn or Quad.easeOut
		 * @return		The current actuator instance
		 */
		public ease (easing:IEasing):GenericActuator;
		
		/**
		 * Defines a function which will be called when the tween finishes
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public onComplete (handler:Function, parameters?:Array<any>):GenericActuator;
		
		/**
		 * Defines a function which will be called when the tween repeats
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public onRepeat (handler:Function, parameters?:Array<any>):GenericActuator;
		
		/**
		 * Defines a function which will be called when the tween updates
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public onUpdate (handler:Function, parameters?:Array<any>):GenericActuator;
		
		/**
		 * Defines a function which will be called when the tween is paused
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public onPause (handler:Function, parameters?:Array<any>):GenericActuator;
		
		/**
		 * Defines a function which will be called when the tween resumed after pause
		 * @param	handler		The function you would like to be called
		 * @param	parameters		Parameters you would like to pass to the handler function when it is called
		 * @return		The current actuator instance
		 */
		public onResume (handler:Function, parameters?:Array<any>):GenericActuator;
		
		/**
		 * Automatically changes the reverse value when the tween repeats. Repeat must be enabled for this to have any effect
		 * @param	value		Whether reflect should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public reflect (value?:boolean | null):GenericActuator;
		
		/**
		 * Repeats the tween after it finishes
		 * @param	times		The number of times you would like the tween to repeat, or -1 if you would like to repeat the tween indefinitely (Default is -1)
		 * @return		The current actuator instance
		 */
		public repeat (times?:number | null):GenericActuator;
		
		/**
		 * Sets if the tween should be handled in reverse
		 * @param	value		Whether the tween should be reversed (Default is true)
		 * @return		The current actuator instance
		 */
		public reverse (value?:boolean | null):GenericActuator;
		
		/**
		 * Enabling smartRotation can prevent undesired results when tweening rotation values
		 * @param	value		Whether smart rotation should be enabled (Default is true)
		 * @return		The current actuator instance
		 */
		public smartRotation (value?:boolean | null):GenericActuator;
		
		/**
		 * Snapping causes tween values to be rounded automatically
		 * @param	value		Whether tween values should be rounded (Default is true)
		 * @return		The current actuator instance
		 */
		public snapping (value?:boolean | null):GenericActuator;
		
		
	}
	
	
}


export default motion.actuators.GenericActuator;