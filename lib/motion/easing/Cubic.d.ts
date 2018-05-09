import motion_easing_CubicEaseIn from "./../../motion/easing/CubicEaseIn";
import motion_easing_CubicEaseInOut from "./../../motion/easing/CubicEaseInOut";
import motion_easing_CubicEaseOut from "./../../motion/easing/CubicEaseOut";

declare namespace motion.easing {

export class Cubic {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Cubic;