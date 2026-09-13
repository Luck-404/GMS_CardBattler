//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_SHATTER_STRIKE
// FUNCTION: Resolves Shatter Strike.
//           Deals linear physical damage to the selected target.
//           If the target survives, SHATTER consumes all Frostbite
//           and deals 3 neutral damage per stack consumed.
//
// ARGUMENTS: _stct_card is the Shatter Strike card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_shatter_strike(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//SHATTER//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_battle_trigger_shatter(
			_ref_target
		);
	}
}