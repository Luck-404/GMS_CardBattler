//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOODCOATED
// FUNCTION: Resolves Bloodcoated.
//           Cleanses all Bleed from the caster.
//           Heals 2 HP per Bleed stack successfully removed.
//           If the caster has at least 1 Rage, grants Bloodcoated for 3 rounds.
//           Rage is not consumed.
//
// ARGUMENTS: _stct_card, _ref_caster, _ref_target.
// RETURNS: No value.
//
//===============================================================================//

function scr_card_vermilion_bloodcoated(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//==================//
	//CLEAR BLEED STACKS//
	//==================//
	var _stct_cleanse = scr_status_cleanse(
		_ref_caster,
		"DOT",
		"ALL",
		{
			_str_status_id: "BLEED"
		}
	);

	var _val_healing =
		_stct_cleanse._ct_stacks_removed *
		_stct_card._val_card_magnitude;

	scr_battle_heal_target(
		"FIXED",
		_val_healing,
		_ref_caster
	);

	//================//
	//CHECK RAGE//
	//================//
	var _ref_rage = scr_status_check("RAGE",_ref_caster);

	if (
		_ref_rage == -1 ||
		!instance_exists(_ref_rage)
	){
		return;
	}

	if (_ref_rage._ct_status_stacks < 1){
		return;
	}

	//================//
	//APPLY BLOODCOATED//
	//================//


	var _ref_bloodcoated = scr_status_buff_bloodcoated(
		"APPLY",
		undefined,
		1,
		3,
		undefined,
		undefined,
		_ref_caster
	);


	//==========//
	//FEEDBACK//
	//==========//
	if (instance_exists(_ref_bloodcoated)){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"BLOODCOATED",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}
}