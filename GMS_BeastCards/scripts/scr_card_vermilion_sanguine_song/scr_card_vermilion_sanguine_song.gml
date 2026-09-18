//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_SANGUINE_SONG
// FUNCTION: Resolves Sanguine Song.
//           Grants the caster 1 Rage.
//           Sacrifices 10% of the caster's Maximum HP.
//           Adds 1 stack to the global Echo counter.
//
// ARGUMENTS: _stct_card is the Sanguine Song Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is unused for this Global Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_sanguine_song(_stct_card,_ref_caster,_ref_target){

	//================//
	//GAIN 1 RAGE//
	//================//
	scr_status_gain_rage(_ref_caster,1);

	//===================//
	//SACRIFICE 10% HP//
	//===================//
	var _val_hp_cost = ceil(_ref_caster._val_max_hp * 0.10);

	var _val_hp_loss = min(
		_val_hp_cost,
		_ref_caster._val_cur_hp
	);

	_ref_caster._val_cur_hp = max(
		0,
		_ref_caster._val_cur_hp - _val_hp_loss
	);

	//================//
	//HP LOSS FEEDBACK//
	//================//
	if (_val_hp_loss > 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"-" + string(_val_hp_loss) + " HP",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);
	}

	//================//
	//GAIN 1 ECHO//
	//================//
	scr_status_gain_echo(1);
}