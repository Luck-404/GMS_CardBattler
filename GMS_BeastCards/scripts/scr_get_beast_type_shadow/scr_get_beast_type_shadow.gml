//===============================================================================//
//
// SCRIPT: SCR_GET_BEAST_TYPE_SHADOW
// FUNCTION: Returns the shadow sprite corresponding to a beast color subtype.
//
//===============================================================================//

function scr_get_beast_type_shadow(_str_beast_type){

	switch (_str_beast_type){

		#region CERULEAN
		case "ABYSS":
			return spr_beast_shadow_cerulean_abyss;

		case "WAVE":
			return spr_beast_shadow_cerulean_wave;

		case "FROST":
			return spr_beast_shadow_cerulean_frost;
		#endregion

		#region VERMILION
		case "ASH":
			return spr_beast_shadow_vermilion_ash;

		case "MAGMA":
			return spr_beast_shadow_vermilion_magma;

		case "PYRE":
			return spr_beast_shadow_vermilion_pyre;
		#endregion

		#region VIRIDIAN
		case "BOTANICAL":
			return spr_beast_shadow_viridian_botanical;

		case "NATURAL":
			return spr_beast_shadow_viridian_natural;

		case "WILD":
			return spr_beast_shadow_viridian_wild;
		#endregion
	}

	return undefined;
}