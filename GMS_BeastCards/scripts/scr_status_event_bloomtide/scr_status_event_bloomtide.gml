//===============================================================================//
//
// SCRIPT: SCR_STATUS_EVENT_BLOOMTIDE
// FUNCTION: Handles the Bloomtide global Event.
//           Converts excess healing into Overhealth while active.
//           Heals every living Beast by 2 at the end of each round.
//
//===============================================================================//

function scr_status_event_bloomtide(_str_tag,_ref_status,_val_lifetime=undefined){

	switch(_str_tag){

		//-------//
//APPLY//
//-------//
case "APPLY":

	//----------------//
	//DEFAULT LIFETIME//
	//----------------//
	if (_val_lifetime == undefined){
		_val_lifetime = 3;
	}

	_val_lifetime =
		max(
			1,
			_val_lifetime
		);

	//----------------//
	//CHECK EXISTING//
	//----------------//
	var _ref_existing_status =
		scr_status_check(
			"EVENT: BLOOMTIDE",
			global.list_statuses
		);

	//----------------//
	//REFRESH EXISTING//
	//----------------//
	if (_ref_existing_status != -1){

		scr_status_refresh_lifetime(
			_ref_existing_status,
			_val_lifetime
		);

		return _ref_existing_status;
	}

	//---------------//
	//CREATE STATUS//
	//---------------//
	var _ref_new_status =
		instance_create_layer(
			room_width * 0.5,
			room_height * 0.5,
			"ily_status",
			obj_battle_status
		);

	//-------------//
	//STATUS DATA//
	//-------------//
	_ref_new_status._scr_status =
		scr_status_event_bloomtide;

	_ref_new_status._ref_host =
		undefined;

	_ref_new_status._str_status_type =
		"EVENT";

	_ref_new_status._str_status_name =
		"EVENT: BLOOMTIDE";

	_ref_new_status._str_status_desc =
		"HEALING BEYOND MAXIMUM HP BECOMES OVERHEALTH. END OF ROUND: HEAL ALL LIVING BEASTS 2.";

	_ref_new_status._spr_status =
		spr_status_event_bloomtide;

	_ref_new_status._str_trigger_region =
		"END";

	_ref_new_status._ct_status_stacks =
		1;

	//-------------------//
	//INITIALIZE LIFETIME//
	//-------------------//
	scr_status_init_lifetime(
		_ref_new_status,
		_val_lifetime,
		false,
		false
	);

	//----------------//
	//REGISTER STATUS//
	//----------------//
	ds_list_add(
		global.list_statuses,
		_ref_new_status
	);

	//=====================//
	//BLOOMTIDE START VFX//
	//=====================//
	scr_battle_vfx(
		undefined,
		spr_battle_vfx_event_bloomtide_start,
		room_width * 0.5,
		room_height * 0.5,
		0,
		0,
		1,
		0,
		snd_battle_event_bloomtide_start
	);

	//==========================//
	//PERSISTENT BLOOMTIDE VFX//
	//==========================//
	_ref_new_status._ref_persistent_vfx =
		scr_battle_vfx_persistent_loop(
			spr_battle_vfx_event_bloomtide_persist,
			room_width * 0.5,
			room_height * 0.5,
			1
		);

	//======================//
	//BLOOMTIDE AMBIENCE//
	//======================//
	scr_status_start_persistent_audio(
		_ref_new_status,
		bgm_battle_event_bloomtide,
		0.25
	);

	//------------------//
	//REPOSITION STATUS//
	//------------------//
	scr_status_reposition(
		global.list_statuses
	);

	return _ref_new_status;

break;


//--------//
//REPEAT//
//--------//
case "REPEAT":

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return undefined;
	}

	//====================//
	//BLOOMTIDE TICK VFX//
	//====================//
	scr_battle_vfx(
		undefined,
		spr_battle_vfx_event_bloomtide_start,
		room_width * 0.5,
		room_height * 0.5,
		0,
		0,
		1,
		0,
		undefined
	);

	//----------------//
	//GET TEAM LISTS//
	//----------------//
	var _arr_team_lists = [
		obj_battle_player_controller._list_beasts_alive,
		obj_battle_enemy_controller._list_beasts_alive
	];

	//=================//
	//HEAL ALL BEASTS//
	//=================//
	for (
		var _it_team = 0;
		_it_team < array_length(_arr_team_lists);
		_it_team++
	){

		var _list_beasts =
			_arr_team_lists[_it_team];

		if (
			!ds_exists(
				_list_beasts,
				ds_type_list
			)
		){
			continue;
		}

		for (
			var _it_beast = 0;
			_it_beast < ds_list_size(_list_beasts);
			_it_beast++
		){

			var _ref_beast =
				ds_list_find_value(
					_list_beasts,
					_it_beast
				);

			if (!instance_exists(_ref_beast)){
				continue;
			}

			if (
				_ref_beast._str_list != "ALIVE" ||
				_ref_beast._val_cur_hp <= 0
			){
				continue;
			}

			//----------------//
			//TARGET HEAL VFX//
			//----------------//
			scr_battle_vfx(
				undefined,
				spr_battle_vfx_event_bloomtide_tick,
				_ref_beast.x,
				_ref_beast.y - 48,
				0,
				0,
				1,
				0,
				undefined
			);

			//-----------//
			//HEAL BEAST//
			//-----------//
			scr_battle_heal_target(
				2,
				_ref_beast
			);
		}
	}

	//----------------//
	//TICK LIFETIME//
	//----------------//
	scr_status_tick_lifetime(
		_ref_status
	);

	//------------------//
	//REPOSITION STATUS//
	//------------------//
	scr_status_reposition(
		global.list_statuses
	);

break;


//-------//
//DEATH//
//-------//
case "DEATH":

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return undefined;
	}

	//---------------//
	//DESTROY STATUS//
	//---------------//
	scr_status_destroy(
		_ref_status
	);

break;
	}

	return undefined;
}