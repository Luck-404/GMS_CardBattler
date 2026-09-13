//===============================================================================//
//
// SCRIPT: SCR_CARD_VIRIDIAN_PROLIFERATE
// FUNCTION: Resolves Proliferate.
//           Uses the team belonging to the selected Beast.
//           Copies current DoTs from front to back through that formation.
//           Reverses at the back and copies them back toward the front.
//           DoTs gained during this effect are included in later copies.
//
// ARGUMENTS: _stct_card is the card struct. _ref_caster is the casting Beast.
//            _ref_target is the selected target.
// RETURNS: Nothing.
//
//===============================================================================//

function scr_card_viridian_proliferate(_stct_card,_ref_caster,_ref_target){

	//================//
	//VALIDATE BEASTS//
	//================//
	if (!instance_exists(_ref_caster)){
		return;
	}

	if (!instance_exists(_ref_target)){
		return;
	}

	//=================//
	//GET SELECTED TEAM//
	//=================//
	var _list_targets = scr_battle_get_target_team_list(_ref_target);

	if (_list_targets == undefined){
		return;
	}

	//================//
	//GET TEAM SIZE//
	//================//
	var _ct_targets = ds_list_size(_list_targets);

	if (_ct_targets <= 1){
		audio_play_sound(snd_gui_error,0,false);
		return;
	}

	//=========================//
	//COPY FRONT TOWARD BACK//
	//=========================//
	for (var _it_target = 0; _it_target < _ct_targets - 1; _it_target++){

		var _ref_source = ds_list_find_value(_list_targets,_it_target);
		var _ref_destination = ds_list_find_value(_list_targets,_it_target + 1);

		if (!instance_exists(_ref_source)){
			continue;
		}

		if (!instance_exists(_ref_destination)){
			continue;
		}

		if (
			_ref_source._val_cur_hp <= 0 ||
			_ref_destination._val_cur_hp <= 0
		){
			continue;
		}

		//-----------------//
		//COPY CURRENT DOTS//
		//-----------------//
		var _ct_copied = scr_status_copy_dots(_ref_source,_ref_destination);

		if (_ct_copied > 0){
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"PROLIFERATE",
				undefined,
				c_green,
				_ref_destination.x,
				_ref_destination.y - 48
			);
		}
	}

	//=========================//
	//COPY BACK TOWARD FRONT//
	//=========================//
	for (var _it_target = _ct_targets - 1; _it_target > 0; _it_target--){

		var _ref_source = ds_list_find_value(_list_targets,_it_target);
		var _ref_destination = ds_list_find_value(_list_targets,_it_target - 1);

		if (!instance_exists(_ref_source)){
			continue;
		}

		if (!instance_exists(_ref_destination)){
			continue;
		}

		if (
			_ref_source._val_cur_hp <= 0 ||
			_ref_destination._val_cur_hp <= 0
		){
			continue;
		}

		//-----------------//
		//COPY CURRENT DOTS//
		//-----------------//
		var _ct_copied = scr_status_copy_dots(_ref_source,_ref_destination);

		if (_ct_copied > 0){
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"PROLIFERATE",
				undefined,
				c_green,
				_ref_destination.x,
				_ref_destination.y - 48
			);
		}
	}
}