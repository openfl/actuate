import motion_easing_QuintEaseIn from "./../../motion/easing/QuintEaseIn";
import motion_easing_QuintEaseInOut from "./../../motion/easing/QuintEaseInOut";
import motion_easing_QuintEaseOut from "./../../motion/easing/QuintEaseOut";

declare namespace motion.easing {

export class Quint {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Quint;