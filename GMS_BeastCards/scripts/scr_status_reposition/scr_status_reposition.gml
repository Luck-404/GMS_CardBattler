//===============================================================================//
//
// SCRIPT: SCR_STATUS_REPOSITION
// FUNCTION: Repositions Status icons for every battle Status ownership scope.
//
//           Shared layout targets:
//           - Weather: centered top-left slot at room center - 24, y 48.
//           - Event: centered top-right slot at room center + 24, y 48.
//           - PLAYER Team Statuses: centered at room center - 138, y 108.
//           - ENEMY Team Statuses: centered at room center + 138, y 108.
//           Host-bound Elite Beasts preserve visual slot 0 for their Elite badge.
//           Elite Status rows mirror the normal 30 px spacing above the HP bar.
//
//           TEAM-scope Statuses may retain a compatibility/source-death link in
//           their source Beast's Status list, but are drawn only in the Team HUD.
//           Statuses without sprites are also excluded from host visual slots.
//
// ARGUMENTS: _ref_host may be a Beast, a Status DS list, PLAYER, ENEMY,
//            WEATHER, EVENT, or undefined.
// RETURNS: Nothing.
//
//===============================================================================//
function scr_status_reposition(_ref_host){

	var _str_shared_owner = "";

	if (is_string(_ref_host)){
		_str_shared_owner =
			string_upper(
				string(_ref_host)
			);
	}

	//========================//
	//WEATHER / EVENT SLOTS//
	//========================//
	if (_str_shared_owner != ""){

		if (_str_shared_owner == "WEATHER"){

			if (
				variable_global_exists("ref_status_weather") &&
				instance_exists(global.ref_status_weather)
			){
				global.ref_status_weather.x = room_width * 0.5 - 24;
				global.ref_status_weather.y = 48;
			}

			return;
		}

		if (_str_shared_owner == "EVENT"){

			if (
				variable_global_exists("ref_status_event") &&
				instance_exists(global.ref_status_event)
			){
				global.ref_status_event.x = room_width * 0.5 + 24;
				global.ref_status_event.y = 48;
			}

			return;
		}
	}

	//==================//
	//SHARED LIST SCOPE//
	//==================//
	var _list_shared_statuses = undefined;
	var _val_shared_center_x = room_width * 0.5;
	var _val_shared_center_y = 108;
	var _ct_shared_cols = 6;

	if (_str_shared_owner == "PLAYER"){
		_list_shared_statuses =
			scr_status_get_team_status_list("PLAYER");
		_val_shared_center_x = room_width * 0.5 - 138;
	}
	else if (_str_shared_owner == "ENEMY"){
		_list_shared_statuses =
			scr_status_get_team_status_list("ENEMY");
		_val_shared_center_x = room_width * 0.5 + 138;
	}
	else if (
		is_real(_ref_host) &&
		ds_exists(_ref_host,ds_type_list)
	){

		var _list_player_statuses =
			scr_status_get_team_status_list("PLAYER");

		var _list_enemy_statuses =
			scr_status_get_team_status_list("ENEMY");

		if (
			_list_player_statuses != undefined &&
			ds_exists(_list_player_statuses,ds_type_list) &&
			_ref_host == _list_player_statuses
		){
			_list_shared_statuses = _list_player_statuses;
			_val_shared_center_x = room_width * 0.5 - 138;
		}
		else if (
			_list_enemy_statuses != undefined &&
			ds_exists(_list_enemy_statuses,ds_type_list) &&
			_ref_host == _list_enemy_statuses
		){
			_list_shared_statuses = _list_enemy_statuses;
			_val_shared_center_x = room_width * 0.5 + 138;
		}
	}

	if (
		_list_shared_statuses != undefined &&
		ds_exists(_list_shared_statuses,ds_type_list)
	){

		scr_status_prune_list(
			_list_shared_statuses
		);

		var _ct_shared_statuses =
			ds_list_size(
				_list_shared_statuses
			);

		if (_ct_shared_statuses <= 0){
			return;
		}

		var _val_shared_x_spacing = 24;
		var _val_shared_y_spacing = 24;

		for (
			var _it_status = 0;
			_it_status < _ct_shared_statuses;
			_it_status++
		){

			var _val_shared_row =
				_it_status div _ct_shared_cols;

			var _val_shared_col =
				_it_status mod _ct_shared_cols;

			var _ct_shared_row =
				min(
					_ct_shared_cols,
					_ct_shared_statuses -
						(_val_shared_row * _ct_shared_cols)
				);

			var _val_shared_start_x =
				_val_shared_center_x -
					((_ct_shared_row - 1) * _val_shared_x_spacing * 0.5);

			var _ref_shared_status =
				ds_list_find_value(
					_list_shared_statuses,
					_it_status
				);

			if (!instance_exists(_ref_shared_status)){
				continue;
			}

			_ref_shared_status.x =
				_val_shared_start_x +
					(_val_shared_col * _val_shared_x_spacing);

			_ref_shared_status.y =
				_val_shared_center_y +
					(_val_shared_row * _val_shared_y_spacing);
		}

		return;
	}

	//======================//
	//HOST-BOUND STATUSES//
	//======================//
	if (!instance_exists(_ref_host)){
		return;
	}

	var _list_statuses = _ref_host._list_statuses;

	if (!ds_exists(_list_statuses,ds_type_list)){
		return;
	}

	//====================//
	//PURGE INVALID REFS//
	//====================//
	scr_status_prune_list(_list_statuses);

	//======================//
	//BUILD VISUAL STATUSES//
	//======================//
	var _arr_visual_statuses = [];

	for (
		var _it_status = 0;
		_it_status < ds_list_size(_list_statuses);
		_it_status++
	){

		var _ref_status =
			ds_list_find_value(
				_list_statuses,
				_it_status
			);

		if (!instance_exists(_ref_status)){
			continue;
		}

		if (
			variable_instance_exists(
				_ref_status,
				"_str_status_scope"
			) &&
			_ref_status._str_status_scope == "TEAM"
		){
			continue;
		}

		if (_ref_status._spr_status == undefined){
			continue;
		}

		array_push(
			_arr_visual_statuses,
			_ref_status
		);
	}

	var _ct_statuses =
		array_length(
			_arr_visual_statuses
		);

	//----------------//
	//DEAD HOST//
	//----------------//
	if (_ref_host._val_cur_hp <= 0){
		return;
	}

	//================//
	//ELITE SLOT 0//
	//================//
	var _flag_elite_slot =
		variable_instance_exists(
			_ref_host,
			"_flag_elite"
		) &&
		_ref_host._flag_elite;

	if (
		_ct_statuses <= 0 &&
		!_flag_elite_slot
	){
		return;
	}

	//=========================//
	//ELITE STATUS BAR ANCHOR//
	//=========================//
	/*
		Mirror the normal Beast relationship between the Status row and HP bar.

		Normal Beast:
		- HP bar top: y - 70.
		- Bottom Status row center: y - 100.
		- Status row therefore sits 30 px above the HP bar.

		Elite HP bars use the same scale-proportional vertical lift as the Beast
		presentation, plus the current 10 px motif-clearance adjustment. Apply that
		same lift here so the bottom Status row remains exactly 30 px above the
		Elite HP bar instead of using a fixed -50 px Elite offset.
	*/
	var _val_elite_hp_bar_lift = 0;

	if (_flag_elite_slot){

		var _val_elite_scale = 1;

		if (
			variable_instance_exists(
				_ref_host,
				"_val_elite_draw_scale_multiplier"
			)
		){
			_val_elite_scale =
				max(
					1,
					_ref_host
						._val_elite_draw_scale_multiplier
				);
		}

		var _val_elite_lift_raw =
			25 *
			(
				max(
					0,
					_val_elite_scale - 1
				) /
				0.40
			);

		var _val_elite_vertical_lift =
			floor(
				(
					_val_elite_lift_raw +
					2.5
				) /
				5
			) *
			5;

		_val_elite_hp_bar_lift =
			_val_elite_vertical_lift +
			10;
	}

	var _val_center_x = _ref_host.x;
	var _val_center_y =
		_ref_host.y -
		100 -
		_val_elite_hp_bar_lift;

	var _ct_cols = 4;
	var _val_x_spacing = 24;
	var _val_y_spacing = 24;

	var _ct_visual_slots =
		_ct_statuses +
		(_flag_elite_slot ? 1 : 0);

	var _ct_rows =
		ceil(
			_ct_visual_slots /
			_ct_cols
		);

	//====================//
	//POSITION ELITE BADGE//
	//====================//
	if (_flag_elite_slot){

		var _val_elite_slot = 0;
		var _val_elite_row =
			_val_elite_slot div _ct_cols;

		var _val_elite_col =
			_val_elite_slot mod _ct_cols;

		var _ct_elite_row =
			min(
				_ct_cols,
				_ct_visual_slots -
				(
					_val_elite_row *
					_ct_cols
				)
			);

		var _val_elite_start_x =
			_val_center_x -
			(
				(
					_ct_elite_row -
					1
				) *
				_val_x_spacing *
				0.5
			);

		_ref_host._val_elite_status_icon_x =
			_val_elite_start_x +
			(
				_val_elite_col *
				_val_x_spacing
			);

		_ref_host._val_elite_status_icon_y =
			_val_center_y -
			(
				(
					_ct_rows -
					1 -
					_val_elite_row
				) *
				_val_y_spacing
			);
	}

	//-------------------//
	//POSITION STATUSES//
	//-------------------//
	for (var _it_status = 0;_it_status < _ct_statuses;_it_status++){

		var _val_slot =
			_it_status +
			(_flag_elite_slot ? 1 : 0);

		var _val_row =
			_val_slot div _ct_cols;

		var _val_col =
			_val_slot mod _ct_cols;

		var _ct_row =
			min(
				_ct_cols,
				_ct_visual_slots -
				(
					_val_row *
					_ct_cols
				)
			);

		var _val_start_x =
			_val_center_x -
			(
				(
					_ct_row -
					1
				) *
				_val_x_spacing *
				0.5
			);

		var _ref_status =
			_arr_visual_statuses[
				_it_status
			];

		if (!instance_exists(_ref_status)){
			continue;
		}

		_ref_status.x =
			_val_start_x +
			(
				_val_col *
				_val_x_spacing
			);

		_ref_status.y =
			_val_center_y -
			(
				(
					_ct_rows -
					1 -
					_val_row
				) *
				_val_y_spacing
			);
	}
}
