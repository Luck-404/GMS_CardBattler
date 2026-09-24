//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_FROSTBITE
// FUNCTION: Handles stackable timed Frostbite.
//           Each stack temporarily reduces:
//             - Maximum HP by 1 (minimum 1)
//             - PHYDEF by 1 (minimum 0)
//             - MAGDEF by 1 (minimum 0)
//           At START, deals 1 NEU damage per stack.
//           Does NOT destroy Armor.
//           Reapplication adds 1 stack and refreshes duration.
//           Restores exact stat reductions when removed.
//
// ARGUMENTS: _str_tag - APPLY, REPEAT or DEATH.
//            _ref_status - stored status for non-APPLY commands.
//            _val_lifetime - optional lifetime.
//            _ref_target - explicit APPLY host.
// RETURNS: APPLY returns the applied status; otherwise undefined.
//
//===============================================================================//

function scr_status_dot_frostbite(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//================//
			//VALIDATE TARGET//
			//================//
			if (!instance_exists(_ref_target)){
				return undefined;
			}

			if (!is_struct(_ref_target._ref_unit)){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
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
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check(
				"FROSTBITE",
				_ref_target
			);

			var _ref_applied_status = undefined;

			//================//
			//STACK EXISTING//
			//================//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){

				_ref_applied_status = _ref_existing_status;

				//----------------//
				//ADD 1 STACK//
				//----------------//
				_ref_applied_status._ct_status_stacks++;

				//----------------//
				//REFRESH LIFETIME//
				//----------------//
				scr_status_refresh_lifetime(
					_ref_applied_status,
					_val_lifetime
				);
			}

			//================//
			//CREATE STATUS//
			//================//
			else{

				_ref_applied_status = instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

				//---------------------//
				//INITIALIZE LIFETIME//
				//---------------------//
				scr_status_init_lifetime(
					_ref_applied_status,
					_val_lifetime,
					true,
					false
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_applied_status._scr_status = scr_status_dot_frostbite;

				_ref_applied_status._ref_host = _ref_target;

				_ref_applied_status._str_status_type = "DOT";
				_ref_applied_status._str_status_name = "FROSTBITE";

				_ref_applied_status._spr_status = spr_status_dot_frostbite;

				_ref_applied_status._ct_status_stacks = 1;
				_ref_applied_status._flag_status_stackable = true;

				_ref_applied_status._str_trigger_region = "START";

				//-----------------------//
				//TRACK ACTUAL REDUCTIONS//
				//-----------------------//
				_ref_applied_status._val_frostbite_max_hp_reduction = 0;
				_ref_applied_status._val_frostbite_pdef_reduction = 0;
				_ref_applied_status._val_frostbite_mdef_reduction = 0;

				//----------------//
				//REGISTER STATUS//
				//----------------//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_applied_status
				);
			}

			//================//
			//STATUS DESCRIPTION//
			//================//
			_ref_applied_status._str_status_desc =
				"PER STACK: -1 MAX HP, PHYDEF, AND MAGDEF. " +
				"START: 1 NEU DAMAGE PER STACK. " +
				"STAT REDUCTIONS RESTORE ON REMOVAL.";

			//==================//
			//REDUCE MAXIMUM HP//
			//==================//
			if (_ref_target._val_max_hp > 1){

				_ref_target._val_max_hp--;

				_ref_applied_status._val_frostbite_max_hp_reduction++;

				_ref_target._val_cur_hp = min(
					_ref_target._val_cur_hp,
					_ref_target._val_max_hp
				);
			}

			//================//
			//REDUCE PHYDEF//
			//================//
			var _val_pdef_before =
				_ref_target._ref_unit._val_beast_pdef_stat;

			_ref_target._ref_unit._val_beast_pdef_stat = max(
				0,
				_val_pdef_before - 1
			);

			//-----------------------//
			//TRACK ACTUAL REDUCTION//
			//-----------------------//
			_ref_applied_status._val_frostbite_pdef_reduction +=
				_val_pdef_before -
				_ref_target._ref_unit._val_beast_pdef_stat;

			//================//
			//REDUCE MAGDEF//
			//================//
			var _val_mdef_before =
				_ref_target._ref_unit._val_beast_mdef_stat;

			_ref_target._ref_unit._val_beast_mdef_stat = max(
				0,
				_val_mdef_before - 1
			);

			//-----------------------//
			//TRACK ACTUAL REDUCTION//
			//-----------------------//
			_ref_applied_status._val_frostbite_mdef_reduction +=
				_val_mdef_before -
				_ref_target._ref_unit._val_beast_mdef_stat;

			//================//
			//REPOSITION STATUS//
			//================//
			scr_status_reposition(_ref_target);

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_frostbite,
				undefined,
				undefined,
				32,
				32,
				1,
				0,
				snd_battle_frostbite
			);

			return _ref_applied_status;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_dot_frostbite(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			var _ct_frostbite = max(
				0,
				_ref_status._ct_status_stacks
			);

			//==================//
			//FROSTBITE DAMAGE//
			//==================//
			// Linear scaling: 1 NEU per stack.
			// Armor is NOT destroyed.

			var _val_damage = _ct_frostbite;

			//============//
			//OVERHEALTH//
			//============//
			if (
				_val_damage > 0 &&
				_ref_host._val_overhealth > 0
			){

				var _val_blocked = min(
					_ref_host._val_overhealth,
					_val_damage
				);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_blocked),
					undefined,
					c_green,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_overhealth -= _val_blocked;
				_val_damage -= _val_blocked;
			}

			//=========//
			//HOST HP//
			//=========//
			if (
				_val_damage > 0 &&
				_ref_host._val_cur_hp > 0
			){

				var _val_actual_damage = min(
					_val_damage,
					_ref_host._val_cur_hp
				);

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_actual_damage),
					undefined,
					c_aqua,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_cur_hp = max(
					0,
					_ref_host._val_cur_hp - _val_actual_damage
				);
			}

			//==========//
			//TICK VFX//
			//==========//
			scr_battle_vfx(
				_ref_host,
				spr_battle_vfx_frostbite_tick,
				undefined,
				undefined,
				32,
				32,
				1,
				0,
				snd_battle_frostbite
			);

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//==================//
				//RESTORE MAXIMUM HP//
				//==================//
				_ref_host._val_max_hp +=
					_ref_status._val_frostbite_max_hp_reduction;

				_ref_host._val_max_hp = max(
					1,
					_ref_host._val_max_hp
				);

				_ref_host._val_cur_hp = min(
					_ref_host._val_cur_hp,
					_ref_host._val_max_hp
				);

				//======================//
				//RESTORE DEFENSE STATS//
				//======================//
				if (is_struct(_ref_host._ref_unit)){

					_ref_host._ref_unit._val_beast_pdef_stat +=
						_ref_status._val_frostbite_pdef_reduction;

					_ref_host._ref_unit._val_beast_mdef_stat +=
						_ref_status._val_frostbite_mdef_reduction;
				}
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}