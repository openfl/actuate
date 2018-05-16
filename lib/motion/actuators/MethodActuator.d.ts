import SimpleActuator from "./SimpleActuator";


declare namespace motion.actuators {
	
	
	export class MethodActuator extends SimpleActuator {
		
		
		public constructor (target:any, duration:number, properties:any);
		
		
	}
	
	
}


export default motion.actuators.MethodActuator;