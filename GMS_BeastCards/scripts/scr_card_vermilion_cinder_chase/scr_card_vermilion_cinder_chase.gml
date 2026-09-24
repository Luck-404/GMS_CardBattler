//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_CINDER_CHASE
// FUNCTION: Resolves Cinder Chase.
//           Deals linear Magical damage to the selected target.
//           EXECUTE draws 2 cards if the triggering attack defeats the target.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_vermilion_cinder_chase(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//====================//
	//STORE EXECUTE STATE//
	//====================//
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

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
	//EXECUTE//
	//================//
	if (
		!scr_battle_trigger_execute(
			_ref_caster,
			_ref_target,
			_flag_target_alive
		)
	){
		return;
	}

	//================//
	//DRAW 2 CARDS//
	//================//
	if (_ref_caster._str_team == "PLAYER"){

		var _ct_drawn = scr_battle_draw_cards(2);

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
