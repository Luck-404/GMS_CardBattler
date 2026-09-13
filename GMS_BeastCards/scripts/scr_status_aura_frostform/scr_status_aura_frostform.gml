//===============================================================================//
//
// SCRIPT: SCR_STATUS_AURA_FROSTFORM
// FUNCTION: Handles Frostform.
//           Infinite Self Aura.
//           Host is considered Frozen while still able to act.
//           Damage dealt +50%.
//           Damage taken +50%.
//           Attacks apply 1 Frostburn.
//           Host gains 1 Frostbite each round.
//           Owns the persistent Frostform VFX.
//
// ARGUMENTS: _str_tag controls the status callback behavior.
//            _ref_status is the Frostform status and _ref_attack_target is the
//            Beast struck by the host when resolving the Attack trigger.
// RETURNS: Status reference on APPLY, true/false on TRIGGER, otherwise undefined.
//
//===============================================================================//

function scr_status_aura_frostform(_str_tag,_ref_status,_val_magnitude=undefined,_ref_attack_target=undefined){

	switch (_str_tag){

		//================//
		//APPLY//
		//================//
		case "APPLY":

			var _ref_target = global.ref_target_beast;

			if (!instance_exists(_ref_target)){
				return undefined;
			}

			//----------------//
			//CHECK EXISTING//
			//----------------//
			var _ref_existing_status = scr_status_check("FROSTFORM",_ref_target);

			if (_ref_existing_status != -1){
				return _ref_existing_status;
			}

			//----------------//
			//CREATE STATUS//
			//----------------//
			var _ref_new_status = instance_create_layer(
				_ref_target.x,
				_ref_target.y,
				"ily_status",
				obj_battle_status
			);

			scr_status_init_lifetime(
				_ref_new_status,
				-1,
				false,
				true
			);

			_ref_new_status._scr_status = scr_status_aura_frostform;

			_ref_new_status._ref_host = _ref_target;

			_ref_new_status._str_status_type = "AURA";
			_ref_new_status._str_status_name = "FROSTFORM";
			_ref_new_status._str_status_desc = "CONSIDERED FROZEN; DAMAGE +50%; DAMAGE TAKEN +50%; ATTACKS APPLY FROSTBURN";

			_ref_new_status._spr_status = spr_status_aura_frostform;

			_ref_new_status._ct_status_stacks = 1;

			_ref_new_status._val_damage_bonus = 50;
			_ref_new_status._val_damage_taken_bonus = 50;

			_ref_new_status._str_aura_scope = "SELF";
			_ref_new_status._str_aura_trigger = "ATTACK";

			_ref_new_status._str_trigger_region = "END";

			_ref_new_status._flag_status_prevent_reposition = true;

			//----------------//
			//MODIFY DAMAGE//
			//----------------//
			_ref_target._val_dmg_scalar_bonus += _ref_new_status._val_damage_bonus;
			_ref_target._val_dmg_taken_scalar_bonus += _ref_new_status._val_damage_taken_bonus;

			//----------------//
			//REGISTER STATUS//
			//----------------//
			ds_list_add(
				_ref_target._list_statuses,
				_ref_new_status
			);

			//----------------//
			//FROSTFORM VFX//
			//----------------//
			_ref_new_status._ref_persistent_vfx = scr_battle_vfx_persistent(
				_ref_target,
				spr_battle_vfx_frostform
			);

			//------------------//
			//REFRESH FORM DRAW//
			//------------------//
			scr_battle_refresh_beast_form_draw(_ref_target);

			scr_status_reposition(_ref_target);

			return _ref_new_status;

		break;

		//================//
		//TRIGGER//
		//================//
		case "TRIGGER":

			if (!instance_exists(_ref_status)){
				return false;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				return false;
			}

			if (!instance_exists(_ref_attack_target)){
				return false;
			}

			if (_ref_attack_target._str_team == _ref_host._str_team){
				return false;
			}

			if (_ref_attack_target._val_cur_hp <= 0){
				return false;
			}

			//----------------//
			//TARGET ENEMY//
			//----------------//
			var _ref_original_target = global.ref_target_beast;
			global.ref_target_beast = _ref_attack_target;

			//----------------//
			//APPLY FROSTBURN//
			//----------------//
			scr_status_apply_dot("FROSTBURN");

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast = _ref_original_target;

			return true;

		break;

		//================//
		//REPEAT//
		//================//
		case "REPEAT":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (!instance_exists(_ref_host)){
				scr_status_destroy(_ref_status);
				return undefined;
			}

			//----------------//
			//TARGET HOST//
			//----------------//
			var _ref_original_target = global.ref_target_beast;
			global.ref_target_beast = _ref_host;

			//----------------//
			//GAIN FROSTBITE//
			//----------------//
			scr_status_dot_frostbite(
				"APPLY",
				undefined
			);

			//----------------//
			//RESTORE TARGET//
			//----------------//
			global.ref_target_beast = _ref_original_target;

			scr_status_tick_lifetime(_ref_status);
			scr_status_reposition(_ref_host);

		break;

		//================//
		//DEATH//
		//================//
		case "DEATH":

			if (!instance_exists(_ref_status)){
				return undefined;
			}

			var _ref_host = _ref_status._ref_host;

			if (instance_exists(_ref_host)){

				//----------------//
				//RESTORE DAMAGE//
				//----------------//
				_ref_host._val_dmg_scalar_bonus -= _ref_status._val_damage_bonus;
				_ref_host._val_dmg_taken_scalar_bonus -= _ref_status._val_damage_taken_bonus;

				//------------------//
				//REFRESH FORM DRAW//
				//------------------//
				scr_battle_refresh_beast_form_draw(_ref_host);
			}

			//----------------//
			//REMOVE VFX//
			//----------------//
			if (instance_exists(_ref_status._ref_persistent_vfx)){
				instance_destroy(_ref_status._ref_persistent_vfx);
			}

			_ref_status._ref_persistent_vfx = undefined;

			//----------------//
			//DESTROY STATUS//
			//----------------//
			scr_status_destroy(_ref_status);

		break;
	}

	return undefined;
}