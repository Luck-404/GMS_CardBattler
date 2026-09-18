//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_FLASHPOINT
// FUNCTION: Resolves Flashpoint.
//           Deals 4 neutral damage to the selected target.
//           ERUPTION 3 deals 3 additional neutral damage.
//
//===============================================================================//

function scr_card_vermilion_flashpoint(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE TARGET//
	//----------------//
	if (!instance_exists(_ref_target)){
		return;
	}

	//================//
	//SET NEU DAMAGE//
	//================//
	var _str_original_stat = _stct_card._str_card_stat;

	_stct_card._str_card_stat = "NEU";

	//================//
	//DEAL BASE DAMAGE//
	//================//
	scr_battle_damage_target(
		_stct_card._val_card_magnitude,
		_ref_target
	);

	//================//
	//ERUPTION 3//
	//================//
	if (
		instance_exists(_ref_target) &&
		_ref_target._val_cur_hp > 0 &&
		scr_battle_trigger_eruption(_ref_target,3)
	){

		scr_battle_damage_target(
			3,
			_ref_target
		);
	}

	//-----------------//
	//RESTORE CARD STAT//
	//-----------------//
	_stct_card._str_card_stat = _str_original_stat;
}