//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_TIDAL_BREAK
// FUNCTION: Resolves Tidal Break.
//           Deals linear physical damage to the selected target.
//           Applies 2 Stormstruck if the attack breaks the target's Armor.
//
// ARGUMENTS: _stct_card is the Tidal Break card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_cerulean_tidal_break(_stct_card,_ref_caster,_ref_target){

	//================//
	//STORE OLD ARMOR//
	//================//
	var _val_armor_before = _ref_target._val_armor;

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

	//=================//
	//CHECK ARMOR BREAK//
	//=================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0 &&
		_val_armor_before > 0 &&
		_ref_target._val_armor <= 0
	){

		//------------------//
		//APPLY STORMSTRUCK//
		//------------------//
		repeat (2){
			scr_status_apply_dot("STORMSTRUCK", _ref_target);
		}
	}
}