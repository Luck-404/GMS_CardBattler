//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_COLD_SNAP
// FUNCTION: Resolves Cold Snap.
//           Deals linear magical damage to the selected target.
//           Freezes the surviving target if it has Frostbite.
//
// ARGUMENTS: _stct_card is the Cold Snap card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_cold_snap(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		"LINEAR",
		_ref_caster,
		_ref_target,
		_stct_card._val_card_magnitude,
		{card: _stct_card, card_instance: global.ref_cast_card}
	);

	//================//
	//CHECK FROSTBITE//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){

		var _ref_frostbite = scr_status_check("FROSTBITE",_ref_target);

		if (_ref_frostbite != -1){

			//----------------//
			//APPLY FROZEN//
			//----------------//
			scr_status_apply_cc("FROZEN", _ref_target);
		}
	}
}