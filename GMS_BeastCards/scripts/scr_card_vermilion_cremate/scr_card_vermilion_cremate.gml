//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CREMATE
// FUNCTION: Resolves Cremate.
//           If a valid corpse was selected, sacrifices that corpse.
//           Otherwise the caster loses 10 HP.
//           Draws 2 cards and grants the caster 2 Rage.
//
// ARGUMENTS: _stct_card is the Cremate Card struct.
//            _ref_caster is the casting Beast.
//            _ref_target is the selected corpse, or undefined when the player
//            chooses to sacrifice HP.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_cremate(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//===================//
	//PAY SACRIFICE COST//
	//===================//
	var _flag_sacrificed = scr_battle_sacrifice_corpse(
		_ref_target
	);

	//==================//
	//SACRIFICE 10 HP//
	//==================//
	if (!_flag_sacrificed){

		var _val_hp_loss = min(
			10,
			_ref_caster._val_cur_hp
		);

		_ref_caster._val_cur_hp = max(
			0,
			_ref_caster._val_cur_hp - _val_hp_loss
		);

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
	//DRAW 2 CARDS//
	//================//
	scr_battle_draw_cards(
		_stct_card._val_card_magnitude
	);

	//================//
	//GAIN 2 RAGE//
	//================//
	scr_status_gain_rage(
		_ref_caster,
		_stct_card._val_card_magnitude
	);
}