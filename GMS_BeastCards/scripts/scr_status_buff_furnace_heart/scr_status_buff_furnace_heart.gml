//===============================================================================//
//
// SCRIPT: SCR_STATUS_BUFF_FURNACE_HEART
// FUNCTION: Handles Furnace Heart.
//           Infinite unstackable Buff.
//           Initially waits to absorb the next MAG Attack.
//           After absorbing, stores 50% of the absorbed magnitude as stacks.
//           The host's next Attack expends those stacks as fixed NEU damage.
//
// ARGUMENTS: _str_tag selects APPLY/REPEAT/DEATH or the status-specific tag.
//            _ref_status is the existing Status instance for non-APPLY commands.
//            Original optional args, unchanged: _val_absorbed_damage=undefined, _ref_attack_target=undefined.
//            _ref_target is the explicit host ONLY for APPLY. Other commands
//            use their existing arguments and the stored Status host.
// RETURNS: Command-specific Status reference, trigger result or undefined.
//
//===============================================================================//

function scr_status_buff_furnace_heart(_str_tag,_ref_status,_val_absorbed_damage=undefined,_ref_attack_target=undefined,_ref_target=undefined){

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

			if (!ds_exists(_ref_target._list_statuses,ds_type_list)){
				return undefined;
			}

			//================//
			//CHECK EXISTING//
			//================//
			var _ref_existing_status = scr_status_check("FURNACE_HEART",_ref_target);

			//------------------//
			//UNSTACKABLE BUFF//
			//------------------//
			if (
				_ref_existing_status != -1 &&
				instance_exists(_ref_existing_status)
			){
				return _ref_existing_status;
			}

			//===============//
			//CREATE STATUS//
			//===============//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			//===================//
			//INFINITE LIFETIME//
			//===================//
			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			//=============//
			//STATUS DATA//
			//=============//
			_ref_new_status._scr_status = scr_status_buff_furnace_heart;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "BUFF";
			_ref_new_status._str_status_name = "FURNACE_HEART";
			_ref_new_status._str_status_desc = "ABSORB NEXT MAG ATTACK";

			_ref_new_status._spr_status = spr_status_buff_furnace_heart;

			_ref_new_status._ct_status_stacks = 0;
			_ref_new_status._flag_status_stackable = false;

			_ref_new_status._flag_furnace_heart_charged = false;
			_ref_new_status._val_furnace_heart_absorbed = 0;

			_ref_new_status._str_trigger_region = undefined;

			//================//
			//REGISTER STATUS//
			//================//
			ds_list_add(_ref_target._list_statuses,_ref_new_status);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//========//
		//ABSORB//
		//========//
		case "ABSORB":

			//----------------//
			//VALIDATE STATUS//
			//----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			if (_ref_status._flag_furnace_heart_charged){
				return false;
			}

			if (_val_absorbed_damage == undefined){
				_val_absorbed_damage = 0;
			}

			_val_absorbed_damage = max(0,ceil(_val_absorbed_damage));

			//=======================//
			//STORE ABSORBED DAMAGE//
			//=======================//
			_ref_status._val_furnace_heart_absorbed = _val_absorbed_damage;

			_ref_status._ct_status_stacks = ceil(
				_val_absorbed_damage * 0.5
			);

			_ref_status._flag_furnace_heart_charged = true;

			_ref_status._str_status_desc =
				"NEXT ATTACK DEALS +" +
				string(_ref_status._ct_status_stacks) +
				" NEU DAMAGE";

			//================//
			//REFRESH STATUS//
			//================//
			if (instance_exists(_ref_status._ref_host)){
				scr_status_reposition(_ref_status._ref_host);
			}

			return true;

		break;

		//=========//
		//TRIGGER//
		//=========//
		case "TRIGGER":

			//----------------//
			//VALIDATE STATUS//
			//----------------//
			if (!instance_exists(_ref_status)){
				return false;
			}

			if (!_ref_status._flag_furnace_heart_charged){
				return false;
			}

			var _ref_host = _ref_status._ref_host;
			var _val_bonus_damage = max(0,_ref_status._ct_status_stacks);

			//======================//
			//CONSUME FURNACE HEART//
			//======================//
			scr_status_buff_furnace_heart("DEATH",_ref_status);

			//----------------//
			//VALIDATE TARGET//
			//----------------//
			if (!instance_exists(_ref_attack_target)){
				return true;
			}

			if (_ref_attack_target._val_cur_hp <= 0){
				return true;
			}

			if (_val_bonus_damage <= 0){
				return true;
			}

			//==========//
			//FEEDBACK//
			//==========//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"FURNACE HEART",
				undefined,
				c_red,
				_ref_host.x,
				_ref_host.y - 48
			);

			scr_battle_vfx_damage_hit(
				_ref_attack_target,
				"NEU",
				_val_bonus_damage
			);

			//================//
			//DEAL BONUS NEU//
			//================//
			scr_battle_damage_target(
				"FIXED",
				undefined,
				_ref_attack_target,
				_val_bonus_damage
			);

			//================//
			//DEBUG TRIGGER//
			//================//
			scr_debug_log_battle_trigger(
				"FURNACE HEART",
				_ref_host,
				_ref_attack_target,
				"BONUS NEU DAMAGE: " + string(_val_bonus_damage),
				"SCR_STATUS_BUFF_FURNACE_HEART"
			);

			return true;

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
