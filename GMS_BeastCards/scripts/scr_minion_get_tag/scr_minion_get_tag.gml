//===============================================================================//
//
// SCRIPT: SCR_MINION_GET_TAG
// FUNCTION: Returns the gameplay tag assigned to a Minion ID.
//           Minion tags are used by Talents and other tag-based effects.
//           Returns NONE when the Minion has no assigned tag.
//
// INPUT:    _str_minion_id - Minion ID whose gameplay tag is requested.
//
//===============================================================================//

function scr_minion_get_tag(_str_minion_id){

	switch (_str_minion_id){

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
		case "ABYSSAL_HARPOON":

			return "TURRET";
	}

	//--------//
	//NO TAG//
	//--------//
	return "NONE";
}