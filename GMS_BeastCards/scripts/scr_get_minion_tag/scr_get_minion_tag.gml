//===============================================================================//
//
// SCRIPT: SCR_GET_MINION_TAG
// FUNCTION: Returns the gameplay tag assigned to a Minion ID.
//           Minion tags are used by Talents and other tag-based effects.
//
//===============================================================================//

function scr_get_minion_tag(_str_id){

	switch(_str_id){

		//=========//
		//BEASTLING//
		//=========//
		case "THORNLING":
		case "SERPENT":
		case "WASP_DRONE":
		case "SPORELING":
		case "TENTACLE":
		case "ASH_PHOENIX":

			return "BEASTLING";


		//=========//
		//ELEMENTAL//
		//=========//
		case "LIFE_SPIRIT":
		case "BLOOMING_SPRITE":
		case "FUNGI":
		case "DORMANT_SEED":
		case "GROVE_SPIRIT":
		case "RIMEFROST_ELEMENTAL":
		case "STORM_WISP":
		case "LIVING_FLAME":
		case "CINDERLING":

			return "ELEMENTAL";


		//=========//
		//CONSTRUCT//
		//=========//
		case "ICE_WALL":
		case "CORAL_GUARDIAN":
		case "ANCHOR_STONE":
		case "FLAMEGUARD":

			return "CONSTRUCT";


		//======//
		//TURRET//
		//======//
		case "MAGMA_CANNON":

			return "TURRET";
	}

	//--------------------//
	//NO TAG / FUTURE TAG//
	//--------------------//
	return "NONE";
}