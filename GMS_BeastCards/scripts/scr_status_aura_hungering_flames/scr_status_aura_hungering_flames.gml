//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_HUNGERING_FLAMES
// FUNCTION: Handles Hungering Flames as one visible Team Aura plus one hidden
//           host-bound penalty Status for each affected Beast.
//
//           The Team Aura owns the shared round-end healing rule and Team HUD
//           icon. Each hidden child preserves the old per-Beast Maximum-HP
//           penalty lifecycle, including immediate cleanup when that Beast dies
//           or its Aura is removed through a host-bound cleanse.
//
// ARGUMENTS: _str_tag selects APPLY/TRIGGER/REPEAT/DEATH.
//            _ref_status is the Team Aura or hidden child Status.
//            _val_magnitude is healing per Burning enemy.
//            _ct_burning_enemies is supplied by the round-end trigger.
//            _ref_target is a representative Beast on the selected team.
// RETURNS: Command-specific Status reference, trigger result, or undefined.
//
//===============================================================================//

function scr_status_aura_hungering_flames(_str_tag,_ref_status,_val_magnitude=undefined,_ct_burning_enemies=undefined,_ref_target=undefined){

	//=======================//
	//HIDDEN CHILD IDENTIFIER//
	//=======================//
	var _flag_child_status =
		instance_exists(_ref_status) &&
		variable_instance_exists(
			_ref_status,
			"_flag_hungering_flames_child"
		) &&
		_ref_status._flag_hungering_flames_child;

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (_val_magnitude == undefined){
				_val_magnitude = 2;
			}

			_val_magnitude = max(0,floor(_val_magnitude));

			var _str_team = _ref_target._str_team;
			var _list_team_statuses =
				scr_status_get_team_status_list(
					_str_team
				);

			if (
				_list_team_statuses == undefined ||
				!ds_exists(_list_team_statuses,ds_type_list)
			){
				return undefined;
			}

			var _ref_existing_status =
				scr_status_check(
					"HUNGERING_FLAMES",
					_str_team
				);

			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				return _ref_existing_status;
			}

			var _list_team =
				(_str_team == "PLAYER")
				? obj_battle_player_controller._list_beasts_alive
				: obj_battle_enemy_controller._list_beasts_alive;

			if (!ds_exists(_list_team,ds_type_list)){
				return undefined;
			}

			//===================//
			//CREATE TEAM STATUS//
			//===================//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status =
				scr_status_aura_hungering_flames;

			_ref_new_status._ref_host = undefined;
			_ref_new_status._ref_status_source = _ref_target;
			_ref_new_status._str_team = _str_team;
			_ref_new_status._str_status_scope = "TEAM";
			_ref_new_status._flag_status_source_bound = false;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "HUNGERING_FLAMES";
			_ref_new_status._str_status_desc =
				"ROUND END: ALLIES HEAL " +
				string(_val_magnitude) +
				" HP PER BURNING ENEMY; AFFECTED ALLIES MAX HP -20%";

			_ref_new_status._spr_status =
				spr_status_aura_hungering_flames;

			_ref_new_status._ct_status_stacks = 1;
			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._val_status_magnitude = _val_magnitude;

			_ref_new_status._str_trigger_region = undefined;
			_ref_new_status._str_aura_scope = "TEAM";
			_ref_new_status._str_aura_trigger = "ROUND_END";

			_ref_new_status._arr_hungering_children = [];

			//=======================//
			//CREATE HOST PENALTIES//
			//=======================//
			for (
				var _it_beast = 0;
				_it_beast < ds_list_size(_list_team);
				_it_beast++
			){

				var _ref_beast =
					ds_list_find_value(
						_list_team,
						_it_beast
					);

				if (
					!instance_exists(_ref_beast) ||
					_ref_beast._val_cur_hp <= 0 ||
					!ds_exists(_ref_beast._list_statuses,ds_type_list)
				){
					continue;
				}

				var _val_hp_reduction = 0;

				if (_ref_beast._val_max_hp > 1){

					_val_hp_reduction =
						round(
							_ref_beast._val_max_hp * 0.20
						);

					_val_hp_reduction =
						clamp(
							_val_hp_reduction,
							1,
							_ref_beast._val_max_hp - 1
						);
				}

				var _ref_child = instance_create_layer(
					_ref_beast.x,
					_ref_beast.y,
					"ily_status",
					obj_battle_status
				);

				scr_status_init_lifetime(
					_ref_child,
					-1,
					false,
					true
				);

				_ref_child._scr_status =
					scr_status_aura_hungering_flames;

				_ref_child._ref_host = _ref_beast;
				_ref_child._ref_status_source = _ref_target;
				_ref_child._str_team = _str_team;
				_ref_child._str_status_scope = "HOST";
				_ref_child._flag_status_source_bound = false;

				_ref_child._str_status_type = "AURA";
				_ref_child._str_status_name = "HUNGERING_FLAMES";
				_ref_child._str_status_desc =
					"HUNGERING FLAMES TEAM PENALTY: MAX HP -20%";

				// The shared Team Status owns the visible HUD icon.
				_ref_child._spr_status = undefined;

				_ref_child._ct_status_stacks = 1;
				_ref_child._flag_status_stackable = false;
				_ref_child._val_status_magnitude = _val_magnitude;
				_ref_child._str_trigger_region = undefined;
				_ref_child._str_aura_scope = "TEAM";
				_ref_child._str_aura_trigger = undefined;

				_ref_child._flag_hungering_flames_child = true;
				_ref_child._ref_hungering_team_status = _ref_new_status;
				_ref_child._val_hungering_max_hp_reduction =
					_val_hp_reduction;

				//================//
				//REDUCE MAX HP//
				//================//
				_ref_beast._val_max_hp =
					max(
						1,
						_ref_beast._val_max_hp - _val_hp_reduction
					);

				_ref_beast._val_cur_hp =
					min(
						_ref_beast._val_cur_hp,
						_ref_beast._val_max_hp
					);

				ds_list_add(
					_ref_beast._list_statuses,
					_ref_child
				);

				array_push(
					_ref_new_status._arr_hungering_children,
					_ref_child
				);

				scr_status_reposition(
					_ref_beast
				);
			}

			//=====================//
			//REGISTER TEAM STATUS//
			//=====================//
			ds_list_add(
				_list_team_statuses,
				_ref_new_status
			);

			scr_status_reposition(_str_team);

			return _ref_new_status;

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			if (
				!instance_exists(_ref_status) ||
				_flag_child_status
			){
				return false;
			}

			if (
				_ct_burning_enemies == undefined ||
				_ct_burning_enemies <= 0
			){
				return false;
			}

			var _val_healing =
				_ct_burning_enemies *
				_ref_status._val_status_magnitude;

			if (_val_healing <= 0){
				return false;
			}

			var _flag_triggered = false;
			var _arr_valid_children = [];

			for (
				var _it_child = 0;
				_it_child < array_length(_ref_status._arr_hungering_children);
				_it_child++
			){

				var _ref_child =
					_ref_status._arr_hungering_children[
						_it_child
					];

				if (!instance_exists(_ref_child)){
					continue;
				}

				array_push(
					_arr_valid_children,
					_ref_child
				);

				var _ref_beast = _ref_child._ref_host;

				if (
					!instance_exists(_ref_beast) ||
					_ref_beast._str_team != _ref_status._str_team ||
					_ref_beast._str_list != "ALIVE" ||
					_ref_beast._val_cur_hp <= 0
				){
					continue;
				}

				var _flag_healed =
					scr_battle_heal_target(
						"FIXED",
						_val_healing,
						_ref_beast
					);

				if (_flag_healed){
					_flag_triggered = true;
				}
			}

			_ref_status._arr_hungering_children =
				_arr_valid_children;

			return _flag_triggered;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (instance_exists(_ref_status)){

				if (_flag_child_status){
					_ref_status._str_status_command = "WAIT";
				}
				else{
					scr_status_reposition(
						_ref_status._str_team
					);
				}
			}

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			//========================//
			//HOST PENALTY CHILD DEATH//
			//========================//
			if (_flag_child_status){

				var _ref_host = _ref_status._ref_host;
				var _val_restore =
					max(
						0,
						_ref_status._val_hungering_max_hp_reduction
					);

				// Zero first so a repeated cleanup path cannot restore twice.
				_ref_status._val_hungering_max_hp_reduction = 0;

				if (instance_exists(_ref_host)){
					_ref_host._val_max_hp += _val_restore;
				}

				scr_status_destroy(
					_ref_status
				);

				return undefined;
			}

			//=====================//
			//TEAM CONTROLLER DEATH//
			//=====================//
			if (
				variable_instance_exists(
					_ref_status,
					"_arr_hungering_children"
				)
			){

				var _arr_children =
					_ref_status._arr_hungering_children;

				_ref_status._arr_hungering_children = [];

				for (
					var _it_child = 0;
					_it_child < array_length(_arr_children);
					_it_child++
				){

					var _ref_child =
						_arr_children[_it_child];

					if (!instance_exists(_ref_child)){
						continue;
					}

					scr_status_aura_hungering_flames(
						"DEATH",
						_ref_child
					);
				}
			}

			if (instance_exists(_ref_status)){
				scr_status_destroy(
					_ref_status
				);
			}

		break;
	}

	return undefined;
}
