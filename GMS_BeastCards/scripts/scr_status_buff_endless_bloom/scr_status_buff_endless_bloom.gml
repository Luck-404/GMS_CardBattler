
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ENDLESS_BLOOM
// FUNCTION: Handles Endless Bloom.
//           Unstackable Timed Global Buff lasting 5 rounds by default.
//           Records which team is protected by Endless Bloom.
//           Lifetime decrements at the START of the protected team's turn.
//           Allied Minion death handling queries this Status separately.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH.
//            _ref_status is the existing Status for non-APPLY commands.
//            _val_magnitude and _val_lifetime retain their original order.
//            _ref_target is retained for APPLY caller compatibility.
// RETURNS: Command-specific Status reference or undefined.
//
//===============================================================================//

function scr_status_buff_endless_bloom(_str_tag,_ref_status,_val_magnitude=undefined,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//======================//
			//VALIDATE GLOBAL LIST//
			//======================//
			if (!variable_global_exists("list_statuses")){
				return undefined;
			}

			if (!ds_exists(global.list_statuses,ds_type_list)){
				return undefined;
			}

			//==========//
			//DEFAULTS//
			//==========//
			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			_val_lifetime = max(1,_val_lifetime);

			//================//
			//GET BUFF TEAM//
			//================//
			var _str_team = "PLAYER";

			if (instance_exists(global.ref_caster_beast)){
				_str_team = global.ref_caster_beast._str_team;
			}

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"ENDLESS_BLOOM",
				global.list_statuses
			);

			//==================//
			//REFRESH EXISTING//
			//==================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				if (_ref_existing_status._str_team != _str_team){
					return undefined;
				}

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				room_width * 0.5,
				room_height * 0.5,
				"ily_status",
				obj_battle_status
			);

			//=====================//
			//INITIALIZE LIFETIME//
			//=====================//
			scr_status_init_lifetime(
				_ref_new_status,
				_val_lifetime,
				false,
				false
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_endless_bloom;

			_ref_new_status._ref_host = undefined;
			_ref_new_status._str_team = _str_team;

			_ref_new_status._str_status_type = "GLOBAL";
			_ref_new_status._str_status_name = "ENDLESS_BLOOM";
			_ref_new_status._str_status_desc =
				"ALLIED MINION DEATHS AND SACRIFICES CREATE INHERITED DORMANT SEEDS";

			_ref_new_status._spr_status = spr_status_buff_endless_bloom;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._str_trigger_region = "START";

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(
				global.list_statuses,
				_ref_new_status
			);

			scr_status_reposition(global.list_statuses);

			return _ref_new_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			if (
				!variable_global_exists("list_statuses") ||
				!ds_exists(global.list_statuses,ds_type_list)
			){

				scr_status_destroy(_ref_status);

				return undefined;
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(global.list_statuses);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (instance_exists(_ref_status)){
				scr_status_destroy(_ref_status);
			}

		break;
	}

	return undefined;
}