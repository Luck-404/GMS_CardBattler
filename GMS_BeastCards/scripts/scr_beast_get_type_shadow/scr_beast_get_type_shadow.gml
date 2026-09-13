//===============================================================================//
//
// SCRIPT: SCR_BEAST_GET_TYPE_SHADOW
// FUNCTION: Returns the shadow sprite assigned to a Beast color subtype.
//
// ARGUMENTS: _str_beast_type is the Beast subtype whose shadow sprite is needed.
// RETURNS: The matching shadow sprite, or undefined if the subtype is unknown.
//
//===============================================================================//

function scr_beast_get_type_shadow(_str_beast_type){

	//====================//
	//TYPE SHADOW TABLE//
	//====================//
	static _stct_type_shadows = {

		#region CERULEAN
		ABYSS     : spr_beast_shadow_cerulean_abyss,
		WAVE      : spr_beast_shadow_cerulean_wave,
		FROST     : spr_beast_shadow_cerulean_frost,
		#endregion

		#region VERMILION
		ASH       : spr_beast_shadow_vermilion_ash,
		MAGMA     : spr_beast_shadow_vermilion_magma,
		PYRE      : spr_beast_shadow_vermilion_pyre,
		#endregion

		#region VIRIDIAN
		BOTANICAL : spr_beast_shadow_viridian_botanical,
		NATURAL   : spr_beast_shadow_viridian_natural,
		WILD      : spr_beast_shadow_viridian_wild
		#endregion
	};

	//==================//
	//GET TYPE SHADOW//
	//==================//
	if (variable_struct_exists(_stct_type_shadows,_str_beast_type)){
		return variable_struct_get(_stct_type_shadows,_str_beast_type);
	}

	return undefined;
}