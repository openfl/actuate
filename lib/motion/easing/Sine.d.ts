import motion_easing_SineEaseIn from "./../../motion/easing/SineEaseIn";
import motion_easing_SineEaseInOut from "./../../motion/easing/SineEaseInOut";
import motion_easing_SineEaseOut from "./../../motion/easing/SineEaseOut";

declare namespace motion.easing {

export class Sine {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Sine;