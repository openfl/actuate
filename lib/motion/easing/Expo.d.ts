import motion_easing_ExpoEaseIn from "./../../motion/easing/ExpoEaseIn";
import motion_easing_ExpoEaseInOut from "./../../motion/easing/ExpoEaseInOut";
import motion_easing_ExpoEaseOut from "./../../motion/easing/ExpoEaseOut";

declare namespace motion.easing {

export class Expo {

	static easeIn:any;
	static easeInOut:any;
	static easeOut:any;
	static get_easeIn():any;
	static get_easeInOut():any;
	static get_easeOut():any;


}

}

export default motion.easing.Expo;