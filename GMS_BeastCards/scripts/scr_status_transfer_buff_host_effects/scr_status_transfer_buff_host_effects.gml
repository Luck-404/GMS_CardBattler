//===============================================================================//
//
// SCRIPT: SCR_STATUS_TRANSFER_BUFF_HOST_EFFECTS
// FUNCTION: Removes or applies host-bound contributions belonging to a Buff.
//           Used when an existing Buff Status instance changes hosts.
//           Buffs whose effects are read directly from the Status require
//           no special case.
//
//===============================================================================//

function scr_status_transfer_buff_host_effects(_str_action,_ref_status,_ref_source,_ref_target){

	//-----------------//
	//VALIDATE STATUS//
	//-----------------//
	if (!instance_exists(_ref_status)){
		return false;
	}

	//-----------------//
	//VALIDATE ACTION//
	//-----------------//
	if (
		_str_action != "REMOVE" &&
		_str_action != "APPLY"
	){
		return false;
	}

	if (
		_str_action == "REMOVE" &&
		!instance_exists(_ref_source)
	){
		return false;
	}

	if (
		_str_action == "APPLY" &&
		!instance_exists(_ref_target)
	){
		return false;
	}

	var _str_status_name = _ref_status._str_status_name;

	switch (_str_status_name){

		//===============//
		//APEX PREDATOR//
		//===============//
		case "APEX_PREDATOR":

			var _val_damage_bonus = _ref_status._ct_status_stacks * _ref_status._val_status_magnitude;

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_linear_bonus =
					max(
						0,
						_ref_source._val_dmg_linear_bonus -
						_val_damage_bonus
					);
			}
			else{

				_ref_target._val_dmg_linear_bonus += _val_damage_bonus;
			}

		break;

		//=======//
		//BOOST//
		//=======//
		case "BOOST":

			var _val_damage_bonus = _ref_status._ct_status_stacks * _ref_status._val_status_magnitude;

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_scalar_bonus =
					max(
						0,
						_ref_source._val_dmg_scalar_bonus -
						_val_damage_bonus
					);
			}
			else{

				_ref_target._val_dmg_scalar_bonus += _val_damage_bonus;
			}

		break;

		//=================//
		//VERDANT INSIGHT//
		//=================//
		case "VERDANT_INSIGHT":

			if (_str_action == "REMOVE"){

				if (!is_struct(_ref_source._ref_unit)){
					return false;
				}

				_ref_source._ref_unit._val_beast_mpow_stat =
					max(
						0,
						_ref_source._ref_unit._val_beast_mpow_stat -
						_ref_status._val_status_magnitude
					);

				_ref_source._ref_unit._val_beast_mdef_stat =
					max(
						0,
						_ref_source._ref_unit._val_beast_mdef_stat -
						_ref_status._val_status_magnitude
					);
			}
			else{

				if (!is_struct(_ref_target._ref_unit)){
					return false;
				}

				_ref_target._ref_unit._val_beast_mpow_stat += _ref_status._val_status_magnitude;
				_ref_target._ref_unit._val_beast_mdef_stat += _ref_status._val_status_magnitude;
			}

		break;

		//============//
		//WILD VIGOR//
		//============//
		case "WILD_VIGOR":

			if (_str_action == "REMOVE"){

				if (!is_struct(_ref_source._ref_unit)){
					return false;
				}

				_ref_source._ref_unit._val_beast_ppow_stat =
					max(
						0,
						_ref_source._ref_unit._val_beast_ppow_stat -
						_ref_status._val_status_magnitude
					);

				_ref_source._ref_unit._val_beast_pdef_stat =
					max(
						0,
						_ref_source._ref_unit._val_beast_pdef_stat -
						_ref_status._val_status_magnitude
					);
			}
			else{

				if (!is_struct(_ref_target._ref_unit)){
					return false;
				}

				_ref_target._ref_unit._val_beast_ppow_stat += _ref_status._val_status_magnitude;
				_ref_target._ref_unit._val_beast_pdef_stat += _ref_status._val_status_magnitude;
			}

		break;

		//==============//
		//MALLEABILITY//
		//==============//
		case "MALLEABILITY":

			if (_str_action == "REMOVE"){
				_ref_source._flag_ignore_caster_requirements = false;
			}
			else{
				_ref_target._flag_ignore_caster_requirements = true;
			}

		break;

		//==========================================//
		//OVERHEALTH / PERSISTENT OVERHEALTH//
		//==========================================//
		case "OVERHEALTH":
		case "PERSISTENT_OVERHEALTH":

			//===========================//
			//REMOVE FROM ORIGINAL HOST//
			//===========================//
			if (_str_action == "REMOVE"){

				scr_status_sync_overhealth_ownership(
					_ref_source
				);

				var _val_owned_overhealth = max(
					0,
					_ref_status._val_status_remaining
				);

				_ref_source._val_overhealth =
					max(
						0,
						_ref_source._val_overhealth -
						_val_owned_overhealth
					);

				scr_status_sync_overhealth_ownership(
					_ref_source
				);
			}

			//======================//
			//APPLY TO NEW HOST//
			//======================//
			else{

				/*
					The transferred Status is already registered on
					the new host when this callback runs.

					Temporarily hide its contribution so the target's
					pre-existing Overhealth ownership can synchronize
					before the transferred amount is added.
				*/
				var _val_transferred_overhealth = max(
					0,
					_ref_status._val_status_remaining
				);

				_ref_status._val_status_remaining = 0;

				scr_status_sync_overhealth_ownership(
					_ref_target
				);

				_ref_status._val_status_remaining =
					_val_transferred_overhealth;

				_ref_target._val_overhealth +=
					_val_transferred_overhealth;

				scr_status_sync_overhealth_ownership(
					_ref_target
				);
			}

		break;

		//===============//
		//PACK INSTINCT//
		//===============//
		case "PACK_INSTINCT":

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_linear_bonus =
					max(
						0,
						_ref_source._val_dmg_linear_bonus -
						_ref_status._val_pack_damage_bonus
					);

				_ref_source._val_max_hp =
					max(
						1,
						_ref_source._val_max_hp -
						_ref_status._val_pack_max_hp_bonus
					);

				_ref_source._val_cur_hp = min(_ref_source._val_cur_hp,_ref_source._val_max_hp);

				_ref_status._val_pack_damage_bonus = 0;
				_ref_status._val_pack_max_hp_bonus = 0;
			}
			else{

				/*
					The Buff now belongs to the new host.

					Recalculate Pack Instinct from that Beast's
					current Minion count rather than carrying the
					old host's Minion-derived bonus across.
				*/
				if (_ref_status._scr_status != undefined){
					_ref_status._scr_status("TRIGGER",_ref_status);
				}
			}

		break;
	}

	return true;
}