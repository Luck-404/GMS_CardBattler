//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_TYPE_SHADOW
// FUNCTION: Returns the shadow sprite corresponding to a beast color subtype.
//
//===============================================================================//

function scr_get_beast_type_shadow(_str_beast_type){

	switch (_str_beast_type){

		#region CERULEAN

		#endregion

		#region VERMILION

		#endregion

		#region VIRIDIAN
		case "BOTANICAL":
			return spr_beast_viridian_shadow_botanical;

		case "NATURAL":
			return spr_beast_viridian_shadow_natural;

		case "WILD":
			return spr_beast_viridian_shadow_wild;
		#endregion
	}

	return undefined;
}