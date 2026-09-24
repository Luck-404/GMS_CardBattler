//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_GREENFLOW
// FUNCTION: Resolves Greenflow.
//           Fires 1 damage bolt for each Minion controlled by the caster.
//           Each bolt deals 5 NEU damage to the selected target.
//           EXECUTE Cultivates all Minions on the caster by 1.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_greenflow(_stct_card,_ref_caster,_ref_target){

	//----------------//
	//VALIDATE BEASTS//
	//----------------//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	if (!ds_exists(_ref_caster._list_minions,ds_type_list)){
		return;
	}

	//======================//
	//COUNT CASTER'S MINIONS//
	//======================//
	var _ct_bolts = ds_list_size(_ref_caster._list_minions);

	//==================//
	//NO MINIONS — FAIL//
	//==================//
	if (_ct_bolts <= 0){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED: NO MINIONS",
			undefined,
			c_red,
			_ref_caster.x,
			_ref_caster.y - 48
		);

		return;
	}

	//====================//
	//STORE EXECUTE STATE//
	//====================//
	var _flag_target_alive = _ref_target._val_cur_hp > 0;

	//================//
	//FIRE BOLTS//
	//================//
	repeat (_ct_bolts){

		if (
			!instance_exists(_ref_target) ||
			_ref_target._val_cur_hp <= 0
		){
			break;
		}

		scr_battle_damage_target(
			"LINEAR",
			_ref_caster,
			_ref_target,
			_stct_card._val_card_magnitude,
			{card: _stct_card, card_instance: global.ref_cast_card}
		);
	}

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
	//CULTIVATE MINIONS//
	//================//
	for (var _it_minion = 0;_it_minion < ds_list_size(_ref_caster._list_minions);_it_minion++){

		var _ref_minion = ds_list_find_value(
			_ref_caster._list_minions,
			_it_minion
		);

		if (!instance_exists(_ref_minion)){
			continue;
		}

		scr_minion_grow(
			_ref_minion,
			1
		);
	}
}