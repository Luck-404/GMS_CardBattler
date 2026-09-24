//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_VENOM
// FUNCTION: Handles the Venom damage-over-time Status.
//           Stackable Timed.
//           Deals 1 damage below 4 stacks, then +4 damage every 4 stacks.
//           Each stack reduces PPOW, MPOW, PDEF, and MDEF by up to 4.
//           Reapplications add one stack and refresh to the stored maximum life.
//           Restores the exact stat reductions when the Status ends.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_lifetime=undefined,
//            _flag_trigger_plague_garden=true.
//            _ref_target is the explicit host ONLY for APPLY.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_dot_venom(_str_tag,_ref_status,_val_lifetime=undefined,_flag_trigger_plague_garden=true,_ref_target=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			//----------------//
			//VALIDATE TARGET//
			//----------------//
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
				_val_lifetime = 3;
			}

			_val_lifetime = max(1,_val_lifetime);

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"VENOM",
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

				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

				//--------------------//
				//REDUCE TARGET STATS//
				//--------------------//
				var _val_old_ppow =
					_ref_target._ref_unit._val_beast_ppow_stat;

				var _val_old_mpow =
					_ref_target._ref_unit._val_beast_mpow_stat;

				var _val_old_pdef =
					_ref_target._ref_unit._val_beast_pdef_stat;

				var _val_old_mdef =
					_ref_target._ref_unit._val_beast_mdef_stat;

				_ref_target._ref_unit._val_beast_ppow_stat = max(
					0,
					_val_old_ppow - 4
				);

				_ref_target._ref_unit._val_beast_mpow_stat = max(
					0,
					_val_old_mpow - 4
				);

				_ref_target._ref_unit._val_beast_pdef_stat = max(
					0,
					_val_old_pdef - 4
				);

				_ref_target._ref_unit._val_beast_mdef_stat = max(
					0,
					_val_old_mdef - 4
				);

				//-------------------------//
				//TRACK ACTUAL REDUCTIONS//
				//-------------------------//
				_ref_existing_status._val_venom_ppow_reduction +=
					_val_old_ppow -
					_ref_target._ref_unit._val_beast_ppow_stat;

				_ref_existing_status._val_venom_mpow_reduction +=
					_val_old_mpow -
					_ref_target._ref_unit._val_beast_mpow_stat;

				_ref_existing_status._val_venom_pdef_reduction +=
					_val_old_pdef -
					_ref_target._ref_unit._val_beast_pdef_stat;

				_ref_existing_status._val_venom_mdef_reduction +=
					_val_old_mdef -
					_ref_target._ref_unit._val_beast_mdef_stat;

				_ref_applied_status = _ref_existing_status;
			}

			//================//
			//CREATE STATUS//
			//================//
			else{

				var _ref_new_status = instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

				//---------------------//
				//INITIALIZE LIFETIME//
				//---------------------//
				scr_status_init_lifetime(
					_ref_new_status,
					_val_lifetime,
					true,
					false
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_new_status._scr_status =
					scr_status_dot_venom;

				_ref_new_status._ref_host =
					_ref_target;

				_ref_new_status._str_status_type =
					"DOT";

				_ref_new_status._str_status_name =
					"VENOM";

				_ref_new_status._str_status_desc =
					"DAMAGE INCREASES EVERY 4 STACKS; " +
					"EACH STACK REDUCES PPOW, MPOW, PDEF, AND MDEF BY 4";

				_ref_new_status._spr_status =
					spr_status_dot_venom;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = true;

				_ref_new_status._str_trigger_region = "START";

				//-----------------------//
				//TRACK STAT REDUCTIONS//
				//-----------------------//
				_ref_new_status._val_venom_ppow_reduction = 0;
				_ref_new_status._val_venom_mpow_reduction = 0;
				_ref_new_status._val_venom_pdef_reduction = 0;
				_ref_new_status._val_venom_mdef_reduction = 0;

				//--------------------//
				//REDUCE TARGET STATS//
				//--------------------//
				var _val_old_ppow =
					_ref_target._ref_unit._val_beast_ppow_stat;

				var _val_old_mpow =
					_ref_target._ref_unit._val_beast_mpow_stat;

				var _val_old_pdef =
					_ref_target._ref_unit._val_beast_pdef_stat;

				var _val_old_mdef =
					_ref_target._ref_unit._val_beast_mdef_stat;

				_ref_target._ref_unit._val_beast_ppow_stat = max(
					0,
					_val_old_ppow - 4
				);

				_ref_target._ref_unit._val_beast_mpow_stat = max(
					0,
					_val_old_mpow - 4
				);

				_ref_target._ref_unit._val_beast_pdef_stat = max(
					0,
					_val_old_pdef - 4
				);

				_ref_target._ref_unit._val_beast_mdef_stat = max(
					0,
					_val_old_mdef - 4
				);

				//-------------------------//
				//STORE ACTUAL REDUCTIONS//
				//-------------------------//
				_ref_new_status._val_venom_ppow_reduction =
					_val_old_ppow -
					_ref_target._ref_unit._val_beast_ppow_stat;

				_ref_new_status._val_venom_mpow_reduction =
					_val_old_mpow -
					_ref_target._ref_unit._val_beast_mpow_stat;

				_ref_new_status._val_venom_pdef_reduction =
					_val_old_pdef -
					_ref_target._ref_unit._val_beast_pdef_stat;

				_ref_new_status._val_venom_mdef_reduction =
					_val_old_mdef -
					_ref_target._ref_unit._val_beast_mdef_stat;

				//----------------//
				//REGISTER STATUS//
				//----------------//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_new_status
				);

				scr_status_reposition(_ref_target);

				_ref_applied_status = _ref_new_status;
			}

			//=================//
			//PLAGUE GARDEN//
			//=================//
			if (_flag_trigger_plague_garden){

				scr_status_trigger_plague_garden(
					_ref_target,
					"VENOM"
				);
			}

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_venom,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_venom
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

				scr_status_dot_venom(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//=======================//
			//CALCULATE VENOM DAMAGE//
			//=======================//
			var _ct_venom_stacks = max(
				0,
				_ref_status._ct_status_stacks
			);

			var _val_damage = max(
				1,
				floor(_ct_venom_stacks / 4) * 4
			);

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
					c_purple,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);

				_ref_host._val_cur_hp = max(
					0,
					_ref_host._val_cur_hp -
					_val_actual_damage
				);
			}

			//==========//
			//TICK VFX//
			//==========//
			scr_battle_vfx(
				_ref_host,
				spr_battle_vfx_venom_tick,
				undefined,
				undefined,
				16,
				16,
				1,
				0,
				snd_battle_venom
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

			//====================//
			//RESTORE VENOM STATS//
			//====================//
			if (
				instance_exists(_ref_host) &&
				is_struct(_ref_host._ref_unit)
			){

				_ref_host._ref_unit._val_beast_ppow_stat +=
					_ref_status._val_venom_ppow_reduction;

				_ref_host._ref_unit._val_beast_mpow_stat +=
					_ref_status._val_venom_mpow_reduction;

				_ref_host._ref_unit._val_beast_pdef_stat +=
					_ref_status._val_venom_pdef_reduction;

				_ref_host._ref_unit._val_beast_mdef_stat +=
					_ref_status._val_venom_mdef_reduction;
			}

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}