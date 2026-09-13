//===============================================================================//
//
// SCRIPT: SCR_CARD_CERULEAN_WHITEWATER
// FUNCTION: Resolves Whitewater.
//           Deals linear physical damage to the selected target.
//           If the target survives, moves it forward 1 position.
//
// ARGUMENTS: _stct_card is the Whitewater card struct.
//            _ref_caster and _ref_target are the casting and targeted Beasts.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_cerulean_whitewater(_stct_card,_ref_caster,_ref_target){

	//================//
	//DEAL DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//===================//
	//REPOSITION FORWARD//
	//===================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0
	){
		scr_battle_reposition_beast(
			_ref_target,
			-1
		);
	}
}