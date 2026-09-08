//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_CALM_SEAS
// FUNCTION: Resolves Calm Seas.
//           Applies an encounter-long Team Aura to the caster.
//
//===============================================================================//

function scr_card_cerulean_calm_seas(_stct_card,_ref_caster,_ref_target){

	//----------------------//
	//STORE ORIGINAL TARGET//
	//----------------------//
	var _ref_original_target =
		global.ref_target_beast;

	//--------------//
	//TARGET CASTER//
	//--------------//
	global.ref_target_beast =
		_ref_caster;

	//----------------//
	//APPLY CALM SEAS//
	//----------------//
	scr_status_apply_aura("CALM_SEAS",0);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

}