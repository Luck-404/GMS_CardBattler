//===============================================================================//
//
// SCR_CAST_CARD
// FUNCTION: Resolves the currently selected card.
//           Executes the card script, handles Echo, spends mana,
//           moves the card to the correct pile, and clears selection.
//
//===============================================================================//
function scr_cast_card(){

	var _ref_card = global.ref_cast_card;
	var _stct_card = _ref_card._ref_card;

	var _ref_caster = global.ref_caster_beast;
	var _ref_target = global.ref_target_beast;

	var _fn_script = _stct_card._scr_card;
	var _val_cost = _stct_card._val_card_mana_cost;

	//
	// CAST CARD
	//
	if (_ref_caster._str_team == "PLAYER" &&
		global.ct_echo != 0 &&
		_stct_card._str_card_name != "ECHO"){

		for (var _it_echo = 0; _it_echo < global.ct_echo + 1; _it_echo++){
			_fn_script(_stct_card,_ref_caster,_ref_target);
		}

		global.ct_echo = 0;
	}
	else{
		_fn_script(_stct_card,_ref_caster,_ref_target);
	}

	//
	// SPEND MANA
	//
	if (_ref_caster._str_team == "PLAYER"){
		obj_battle_player_controller._val_cur_mana -= _val_cost;
	}

	//
	// CARD DESTINATION
	//
	if (_ref_caster._str_team == "PLAYER"){

		if (_stct_card._flag_card_exhausts){
			scr_exhaust_card(_ref_card);
		}
		else{
			scr_discard_card(_ref_card);
		}
	}

	//
	// CLEAR SELECTION
	//
	global.ref_cast_card = undefined;
	global.ref_caster_beast = undefined;
	global.ref_target_beast = undefined;
}