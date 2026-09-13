//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_DEPTH_CHARGE
// FUNCTION: Resolves Depth Charge.
//           Deals linear magical damage to the selected target.
//           Deals 25% additional damage while Cerulean Weather is active.
//
// ARGUMENTS: _stct_card is the Depth Charge card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_depth_charge(_stct_card,_ref_caster,_ref_target){

	//================//
	//GET BASE DAMAGE//
	//================//
	var _val_damage = _stct_card._val_card_magnitude;

	//=======================//
	//CHECK CERULEAN WEATHER//
	//=======================//
	if (scr_status_has_cerulean_weather()){
		_val_damage *= 1.25;
	}

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_val_damage,
		_ref_target
	);
}