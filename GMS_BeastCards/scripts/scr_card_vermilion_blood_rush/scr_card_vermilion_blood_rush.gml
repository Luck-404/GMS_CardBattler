//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_RUSH
// FUNCTION: Resolves Blood Rush.
//           Sacrifices up to 8 HP directly from the caster.
//           Draws 2 cards for the player using the shared draw system.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_blood_rush(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE CASTER//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//LOSE 8 HP//
	//================//
	var _val_hp_loss = min(8,_ref_caster._val_cur_hp);

	_ref_caster._val_cur_hp = max(0,_ref_caster._val_cur_hp - _val_hp_loss);

	//==========//
	//FEEDBACK//
	//==========//
	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"-" + string(_val_hp_loss) + " HP",
		undefined,
		c_red,
		_ref_caster.x,
		_ref_caster.y - 48
	);

	//================//
	//DRAW 2 CARDS//
	//================//
	if (_ref_caster._str_team == "PLAYER"){

		var _ct_drawn = scr_battle_draw_cards(_stct_card._val_card_magnitude);

		if (_ct_drawn > 0){

			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"+" + string(_ct_drawn) + " CARD DRAW",
				undefined,
				c_red,
				_ref_caster.x,
				_ref_caster.y - 48
			);
		}
	}
}