//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_FROST_WEAPON
// FUNCTION: Resolves Frost Weapon.
//           For 2 rounds, the caster's Attacks apply 1 Frostbite.
//
//===============================================================================//

function scr_card_cerulean_frost_weapon(_stct_card,_ref_caster,_ref_target){

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

	//------------------//
	//APPLY FROST WEAPON//
	//------------------//
	scr_apply_buff_status("FROST_WEAPON",_stct_card._val_card_magnitude,2);

	//----------------//
	//RESTORE TARGET//
	//----------------//
	global.ref_target_beast =
		_ref_original_target;

}