import motion_easing_QuartEaseIn from "./../../motion/easing/QuartEaseIn";
import motion_easing_QuartEaseInOut from "./../../motion/easing/QuartEaseInOut";
import motion_easing_QuartEaseOut from "./../../motion/easing/QuartEaseOut";

declare namespace motion.easing {

export class Quart {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Quart;