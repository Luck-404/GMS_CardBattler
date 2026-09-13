//===============================================================================//
//
// SCRIPT: SCR_STATUS_DOT_BURN
// FUNCTION: Handles the Burn damage-over-time Status.
//           Stackable Timed.
//           Deals one separate 1-damage hit per Burn stack.
//           After Burn damage resolves, checks the current Char threshold.
//           Burn is not consumed when Char triggers.
//
// ARGUMENTS: _str_tag selects the Status action, _ref_status references an
//            existing Status, and _val_lifetime optionally sets its duration.
// RETURNS: The active Burn Status on APPLY; otherwise undefined.
//
//===============================================================================//

function scr_status_dot_burn(_str_tag,_ref_status,_val_lifetime=undefined){

	switch (_str_tag){

		//=======//
		//APPLY//
		//=======//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_target)){
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
			var _ref_existing_status = scr_status_check("BURN",_ref_target);
			var _ref_applied_status = undefined;

			//================//
			//STACK EXISTING//
			//================//
			if (_ref_existing_status != -1){

				if (!instance_exists(_ref_existing_status)){
					return undefined;
				}

				_ref_existing_status._ct_status_stacks++;

				scr_status_refresh_lifetime(
					_ref_existing_status,
					_val_lifetime
				);

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
				_ref_new_status._scr_status = scr_status_dot_burn;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "DOT";
				_ref_new_status._str_status_name = "BURN";
				_ref_new_status._str_status_desc = "DEALS 1 DAMAGE PER STACK";

				_ref_new_status._spr_status = spr_status_dot_burn;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = true;

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

			//=========================//
			//APPLICATION PRESENTATION//
			//=========================//
			scr_battle_vfx(
				_ref_target,
				spr_battle_vfx_burn,
				undefined,
				undefined,
				32,
				32,
				1,
				0,
				snd_battle_burn
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

				scr_status_dot_burn(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			var _ct_burn = max(0,_ref_status._ct_status_stacks);

			//=========================//
			//ONE HIT FOR EACH STACK//
			//=========================//
			repeat (_ct_burn){

				if (_ref_host._val_cur_hp <= 0){
					break;
				}

				//----------//
				//TICK VFX//
				//----------//
				scr_battle_vfx(
					_ref_host,
					spr_battle_vfx_burn_tick,
					undefined,
					undefined,
					32,
					32,
					1,
					0,
					snd_battle_burn
				);

				var _val_damage = 1;

				//============//
				//OVERHEALTH//
				//============//
				if (
					_val_damage > 0 &&
					_ref_host._val_overhealth > 0
				){

					var _val_blocked = min(_ref_host._val_overhealth,_val_damage);

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

					var _val_actual_damage = min(_val_damage,_ref_host._val_cur_hp);

					scr_gui_spawn_popup_scrolling(
						"TEXT",
						"-" + string(_val_actual_damage),
						undefined,
						c_maroon,
						_ref_host.x + irandom_range(-32,32),
						_ref_host.y - 24 + irandom_range(-32,32)
					);

					_ref_host._val_cur_hp = max(
						0,
						_ref_host._val_cur_hp - _val_actual_damage
					);
				}
			}

			//================//
			//CHECK FOR CHAR//
			//================//
			if (_ref_host._val_cur_hp > 0){

				var _ct_char_vfx_delay = sprite_get_number(spr_battle_vfx_burn_tick);

				scr_status_trigger_char_conversion(
					_ref_host,
					_ct_char_vfx_delay
				);
			}

			//----------------//
			//UPDATE LIFETIME//
			//----------------//
			scr_status_tick_lifetime(_ref_status);

			if (instance_exists(_ref_host)){
				scr_status_reposition(_ref_host);
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