
//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_FROSTBURN
// FUNCTION: Handles stackable infinite Frostburn.
//           Application adds 1 stack without destroying Armor.
//           At START, resolves in this order:
//             1. Destroy up to 3 Armor (total, not per stack).
//             2. Deal 3 NEU damage per stack.
//             3. Remove the oldest cleansable positive Buff or Aura
//                if the host is still alive.
//           Uses normal status DEATH cleanup for the removed effect.
//
// ARGUMENTS: _str_tag - APPLY, REPEAT or DEATH.
//            _ref_status - stored status for non-APPLY commands.
//            _val_lifetime - retained for compatibility.
//            _ref_target - explicit APPLY host.
// RETURNS: APPLY returns the applied status; otherwise undefined.
//
//===============================================================================//

function scr_status_dot_frostburn(_str_tag,_ref_status,_val_lifetime=undefined,_ref_target=undefined){

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

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check(
				"FROSTBURN",
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

				//------------------//
				//SET DAMAGE PER STACK//
				//------------------//
				_ref_existing_status._val_status_magnitude = 3;

				//--------------------//
				//UPDATE DESCRIPTION//
				//--------------------//
				_ref_existing_status._str_status_desc =
					"START: DESTROY UP TO 3 ARMOR, DEAL " +
					string(
						_ref_existing_status._ct_status_stacks *
						_ref_existing_status._val_status_magnitude
					) +
					" NEU DAMAGE, THEN REMOVE THE OLDEST " +
					"CLEANSABLE POSITIVE EFFECT";

				scr_status_reposition(_ref_target);

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
					-1,
					true,
					true
				);

				//-------------//
				//STATUS DATA//
				//-------------//
				_ref_new_status._scr_status = scr_status_dot_frostburn;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "DOT";
				_ref_new_status._str_status_name = "FROSTBURN";

				_ref_new_status._spr_status = spr_status_dot_frostburn;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = true;

				//------------------//
				//DAMAGE PER STACK//
				//------------------//
				_ref_new_status._val_status_magnitude = 3;

				_ref_new_status._str_status_desc =
					"START: DESTROY UP TO 3 ARMOR, DEAL " +
					string(_ref_new_status._val_status_magnitude) +
					" NEU DAMAGE, THEN REMOVE THE OLDEST " +
					"CLEANSABLE POSITIVE EFFECT";

				_ref_new_status._str_trigger_region = "START";

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

			//========================//
			//APPLICATION PRESENTATION//
			//========================//
			// No Armor destruction on application.

			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_frostburn,
				undefined,
				undefined,
				32,
				32,
				1,
				0,
				snd_battle_frostburn
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

				scr_status_dot_frostburn(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//================//
			//1. DESTROY ARMOR//
			//================//
			// Destroy up to 3 Armor per tick, regardless of stacks.

			var _stct_armor_result = scr_battle_destroy_armor(
				_ref_host,
				3
			);

			var _val_armor_destroyed =
				_stct_armor_result._val_armor_removed;

			if (_val_armor_destroyed > 0){

				scr_gui_spawn_popup_scrolling(
					"TEXT",
					"-" + string(_val_armor_destroyed) + " ARMOR",
					undefined,
					c_aqua,
					_ref_host.x + irandom_range(-32,32),
					_ref_host.y - 24 + irandom_range(-32,32)
				);
			}

			//================//
			//2. CALCULATE DAMAGE//
			//================//
			var _val_damage =
				_ref_status._ct_status_stacks *
				_ref_status._val_status_magnitude;

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

			//================================//
			//3. REMOVE OLDEST POSITIVE EFFECT//
			//================================//
			if (_ref_host._val_cur_hp > 0){

				scr_status_cleanse(
					_ref_host,
					"POSITIVE",
					"OLDEST"
				);
			}

			//==========//
			//TICK VFX//
			//==========//
			if (instance_exists(_ref_host)){

				scr_battle_vfx(
					_ref_host,
					spr_battle_vfx_frostburn_tick,
					undefined,
					undefined,
					32,
					32,
					1,
					0,
					snd_battle_frostburn
				);
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			if (instance_exists(_ref_status)){

				scr_status_tick_lifetime(_ref_status);

				if (instance_exists(_ref_host)){
					scr_status_reposition(_ref_host);
				}
			}

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