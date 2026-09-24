
//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_FLAMEGUARD_TAUNT
// FUNCTION: Handles Flameguard's source-bound Taunt passive.
//           Participates in newest-Taunt targeting priority.
//           An older Flameguard Taunt is suppressed while a newer Taunt
//           controls hostile targeting, but is not destroyed.
//           Remains active until its exact source Minion is removed.
//           Cannot be cleansed.
//           Uses the existing Taunt icon and persistent VFX.
//
// ARGUMENTS: _str_tag selects APPLY or DEATH.
//            _ref_status references an existing Flameguard Taunt.
//            _ref_source_minion is the source Flameguard.
// RETURNS: Applied Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_buff_flameguard_taunt(_str_tag,_ref_status,_ref_source_minion=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//-----------------------//
			//VALIDATE SOURCE MINION//
			//-----------------------//
			if (!instance_exists(_ref_source_minion)){
				return undefined;
			}

			if (_ref_source_minion._val_cur_hp <= 0){
				return undefined;
			}

			if (_ref_source_minion._str_name != "FLAMEGUARD"){
				return undefined;
			}

			//----------------//
			//VALIDATE HOST//
			//----------------//
			var _ref_host = _ref_source_minion._ref_host;

			if (!instance_exists(_ref_host)){
				return undefined;
			}

			if (
				_ref_host._str_list != "ALIVE" ||
				_ref_host._val_cur_hp <= 0
			){
				return undefined;
			}

			if (!ds_exists(_ref_host._list_statuses,ds_type_list)){
				return undefined;
			}

			//==================================//
			//CHECK EXISTING EXACT SOURCE BUFF//
			//==================================//
			for (
				var _it_status = 0;
				_it_status < ds_list_size(_ref_host._list_statuses);
				_it_status++
			){

				var _ref_existing_status = ds_list_find_value(
					_ref_host._list_statuses,
					_it_status
				);

				if (!instance_exists(_ref_existing_status)){
					continue;
				}

				if (_ref_existing_status._str_status_name != "FLAMEGUARD_TAUNT"){
					continue;
				}

				if (_ref_existing_status._ref_source_minion == _ref_source_minion){
					return _ref_existing_status;
				}
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_host.x,
				_ref_host.y,
				"ily_status",
				obj_battle_status
			);

			//-------------------//
			//INFINITE LIFETIME//
			//-------------------//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_flameguard_taunt;

			_ref_new_status._ref_host = _ref_host;
			_ref_new_status._ref_source_minion = _ref_source_minion;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "FLAMEGUARD_TAUNT";

			_ref_new_status._str_status_desc =
				"FLAMEGUARD TAUNT: CONTROLS HOSTILE PRIMARY TARGETING " +
				"ONLY WHILE NEWEST. SUPPRESSED BY NEWER TAUNT. " +
				"IGNORES RANGE AND BLIND. DOES NOT PREVENT AOE. " +
				"LASTS WHILE SOURCE FLAMEGUARD LIVES.";

			_ref_new_status._spr_status = spr_status_buff_taunt;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._flag_status_stackable = false;
			_ref_new_status._flag_status_uncleansable = true;
			_ref_new_status._flag_status_requires_live_source_minion = true;

			//================//
			//NEWEST PRIORITY//
			//================//
			if (!variable_global_exists("_ct_taunt_sequence")){
				global._ct_taunt_sequence = 0;
			}

			global._ct_taunt_sequence++;

			_ref_new_status._val_taunt_priority =
				global._ct_taunt_sequence;

			_ref_new_status._str_trigger_region = undefined;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_host._list_statuses,
				_ref_new_status
			);

			//----------------//
			//PERSISTENT VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_host,
				spr_battle_vfx_taunting,
				0,
				-110,
				1
			);

			//------------------//
			//REPOSITION STATUS//
			//------------------//
			scr_status_reposition(_ref_host);

			return _ref_new_status;

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}