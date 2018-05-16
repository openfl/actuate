import GenericActuator from "./GenericActuator";


declare namespace motion.actuators {
	
	
	export class SimpleActuator extends GenericActuator {
		
		
		public constructor (target:any, duration:number, properties:any);
		
		
	}
	
	
}


export default motion.actuators.SimpleActuator;