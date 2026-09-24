//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_ENDLESS_RAGE
// FUNCTION: Maintains 5 protected Rage for 3 rounds.
//           Grants +25% outgoing damage and +25 Critical Hit chance.
//           Rage self-damage doubles and spending does not reduce stacks.
//           Removes all Rage and its own stat bonuses on expiration.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _ct_rage=5, _val_lifetime=3.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_endless_rage(_str_tag,_ref_status,_ct_rage=5,_val_lifetime=3,_ref_target=undefined){

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

			if (_ref_target._val_cur_hp <= 0){
				return undefined;
			}

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//================//
			//VALIDATE VALUES//
			//================//
			_ct_rage = clamp(floor(_ct_rage),1,5);
			_val_lifetime = max(1,floor(_val_lifetime));

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing = scr_status_check(
				"ENDLESS_RAGE",
				_ref_target
			);

			var _ref_active = undefined;

			//================//
			//REFRESH EXISTING//
			//================//
			if (
				_ref_existing != -1 &&
				instance_exists(_ref_existing)
			){

				scr_status_refresh_lifetime(
					_ref_existing,
					_val_lifetime
				);

				_ref_existing._str_status_command = "WAIT";

				_ref_active = _ref_existing;
			}

			//================//
			//CREATE NEW BUFF//
			//================//
			else{

				var _ref_new_status = instance_create_layer(
					_ref_target.x,
					_ref_target.y,
					"ily_status",
					obj_battle_status
				);

				//================//
				//INIT LIFETIME//
				//================//
				scr_status_init_lifetime(
					_ref_new_status,
					_val_lifetime,
					false,
					false
				);

				//================//
				//STATUS DATA//
				//================//
				_ref_new_status._scr_status = scr_status_buff_endless_rage;

				_ref_new_status._ref_host = _ref_target;

				_ref_new_status._str_status_type = "BUFF";
				_ref_new_status._str_status_name = "ENDLESS_RAGE";

				_ref_new_status._str_status_desc =
					"5 PROTECTED RAGE. +25% DAMAGE. +25 CRIT. " +
					"RAGE SELF-DAMAGE DOUBLED. SPENDING DOES NOT REDUCE RAGE.";

				_ref_new_status._spr_status = spr_status_buff_endless_rage;

				_ref_new_status._ct_status_stacks = 1;
				_ref_new_status._flag_status_stackable = false;

				_ref_new_status._val_status_magnitude = 25;

				_ref_new_status._str_trigger_region = "START";

				//================//
				//APPLY DAMAGE BONUS//
				//================//
				_ref_target._val_dmg_scalar_bonus += 25;

				//================//
				//APPLY CRIT BONUS//
				//================//
				_ref_target._val_crit_chance += 25;

				//================//
				//REGISTER STATUS//
				//================//
				ds_list_add(
					_ref_target._list_statuses,
					_ref_new_status
				);

				_ref_active = _ref_new_status;
			}

			//================//
			//SET RAGE TO 5//
			//================//
			// Existing Rage is capped at 5 by its own APPLY logic.

			scr_status_gain_rage(
				_ref_target,
				_ct_rage
			);

			var _ref_rage = scr_status_check(
				"RAGE",
				_ref_target
			);

			//================//
			//VALIDATE RAGE//
			//================//
			if (
				_ref_rage == -1 ||
				!instance_exists(_ref_rage)
			){

				scr_status_buff_endless_rage(
					"DEATH",
					_ref_active
				);

				return undefined;
			}

			//================//
			//PROTECT RAGE//
			//================//
			_ref_rage._flag_status_uncleansable = true;

			// Prevent a previously queued expiration from removing Rage.
			_ref_rage._str_status_command = "WAIT";

			_ref_rage._str_status_desc =
				"+" +
				string(_ref_rage._ct_status_stacks) +
				" OUTGOING DAMAGE. DOUBLE SELF-DAMAGE. " +
				"UNCLEANSABLE. SPENDING DOES NOT REDUCE STACKS.";

			//================//
			//REPOSITION ICONS//
			//================//
			scr_status_reposition(_ref_target);

			return _ref_active;

		break;

		//========//
		//REPEAT//
		//========//
		case "REPEAT":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){

				scr_status_buff_endless_rage(
					"DEATH",
					_ref_status
				);

				return undefined;
			}

			//================//
			//UPDATE LIFETIME//
			//================//
			scr_status_tick_lifetime(_ref_status);

			scr_status_reposition(_ref_host);

		break;

		//=======//
		//DEATH//
		//=======//
		case "DEATH":

			//================//
			//VALIDATE STATUS//
			//================//
			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//================//
				//REMOVE DAMAGE BONUS//
				//================//
				_ref_host._val_dmg_scalar_bonus = max(
					0,
					_ref_host._val_dmg_scalar_bonus - 25
				);

				//================//
				//REMOVE CRIT BONUS//
				//================//
				_ref_host._val_crit_chance = max(
					0,
					_ref_host._val_crit_chance - 25
				);

				//================//
				//GET ALL RAGE//
				//================//
				var _ref_rage = scr_status_check(
					"RAGE",
					_ref_host
				);

				//================//
				//REMOVE ALL RAGE//
				//================//
				if (
					_ref_rage != -1 &&
					instance_exists(_ref_rage)
				){

					// Use Rage's normal DEATH callback so its
					// outgoing linear damage bonus is removed too.

					scr_status_dot_rage(
						"DEATH",
						_ref_rage
					);
				}
			}

			//================//
			//DESTROY BUFF//
			//================//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}