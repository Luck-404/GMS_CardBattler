//===============================================================================//
//
// SCRIPT: SCR_CARD_VERMILION_BLOOD_RUSH
// FUNCTION: Sacrifices 8 caster HP, then draws the card's magnitude for a
//           player caster using the shared draw system.
//
// ARGUMENTS: _stct_card is the Card struct. _ref_caster is the casting Beast.
//            _ref_target is the caster for this Self-target Card.
// RETURNS: No value.
//
//===============================================================================//
function scr_card_vermilion_blood_rush(_stct_card,_ref_caster,_ref_target){

	if (_ref_caster._val_cur_hp <= 0){
		return;
	}

	//================//
	//SACRIFICE 8 HP//
	//================//
	scr_battle_sacrifice("HOST_HEALTH",_ref_caster,8);

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