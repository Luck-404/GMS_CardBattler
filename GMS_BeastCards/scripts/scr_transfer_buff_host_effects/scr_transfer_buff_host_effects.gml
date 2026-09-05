//===============================================================================//
//
// SCRIPT: SCR_TRANSFER_BUFF_HOST_EFFECTS
// FUNCTION: Removes or applies host-bound contributions belonging to a Buff.
//           Used when an existing Buff status instance changes hosts.
//           Buffs whose effects are read directly from the status require
//           no special case.
//
//===============================================================================//

function scr_transfer_buff_host_effects(_str_action,_ref_status,_ref_source,_ref_target){

	if (!instance_exists(_ref_status)){
		return false;
	}

	var _str_status_name =
		_ref_status._str_status_name;

	switch(_str_status_name){

		//==============//
		//APEX PREDATOR//
		//==============//
		case "APEX_PREDATOR":

			var _val_damage_bonus =
				_ref_status._ct_status_stacks *
				_ref_status._val_status_magnitude;

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_linear_bonus =
					max(
						0,
						_ref_source._val_dmg_linear_bonus -
						_val_damage_bonus
					);
			}
			else{

				_ref_target._val_dmg_linear_bonus +=
					_val_damage_bonus;
			}

		break;


		//=====//
		//BOOST//
		//=====//
		case "BOOST":

			var _val_damage_bonus =
				_ref_status._ct_status_stacks *
				_ref_status._val_status_magnitude;

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_scalar_bonus -=
					_val_damage_bonus;
			}
			else{

				_ref_target._val_dmg_scalar_bonus +=
					_val_damage_bonus;
			}

		break;


		//================//
		//VERDANT INSIGHT//
		//================//
		case "VERDANT_INSIGHT":

			if (
				!is_struct(_ref_source._ref_unit) ||
				!is_struct(_ref_target._ref_unit)
			){
				break;
			}

			if (_str_action == "REMOVE"){

				_ref_source._ref_unit._val_beast_mpow_stat -=
					_ref_status._val_status_magnitude;

				_ref_source._ref_unit._val_beast_mdef_stat -=
					_ref_status._val_status_magnitude;

				_ref_source._ref_unit._val_beast_mpow_stat =
					max(0,_ref_source._ref_unit._val_beast_mpow_stat);

				_ref_source._ref_unit._val_beast_mdef_stat =
					max(0,_ref_source._ref_unit._val_beast_mdef_stat);
			}
			else{

				_ref_target._ref_unit._val_beast_mpow_stat +=
					_ref_status._val_status_magnitude;

				_ref_target._ref_unit._val_beast_mdef_stat +=
					_ref_status._val_status_magnitude;
			}

		break;


		//==========//
		//WILD VIGOR//
		//==========//
		case "WILD_VIGOR":

			if (
				!is_struct(_ref_source._ref_unit) ||
				!is_struct(_ref_target._ref_unit)
			){
				break;
			}

			if (_str_action == "REMOVE"){

				_ref_source._ref_unit._val_beast_ppow_stat -=
					_ref_status._val_status_magnitude;

				_ref_source._ref_unit._val_beast_pdef_stat -=
					_ref_status._val_status_magnitude;

				_ref_source._ref_unit._val_beast_ppow_stat =
					max(0,_ref_source._ref_unit._val_beast_ppow_stat);

				_ref_source._ref_unit._val_beast_pdef_stat =
					max(0,_ref_source._ref_unit._val_beast_pdef_stat);
			}
			else{

				_ref_target._ref_unit._val_beast_ppow_stat +=
					_ref_status._val_status_magnitude;

				_ref_target._ref_unit._val_beast_pdef_stat +=
					_ref_status._val_status_magnitude;
			}

		break;


		//============//
		//MALLEABILITY//
		//============//
		case "MALLEABILITY":

			if (_str_action == "REMOVE"){

				_ref_source._flag_ignore_caster_requirements =
					false;
			}
			else{

				_ref_target._flag_ignore_caster_requirements =
					true;
			}

		break;


		//==========//
		//OVERHEALTH//
		//==========//
		case "OVERHEALTH":

			var _val_owned_overhealth =
				min(
					_ref_status._val_status_remaining,
					_ref_source._val_overhealth
				);

			if (_str_action == "REMOVE"){

				_ref_source._val_overhealth =
					max(
						0,
						_ref_source._val_overhealth -
						_val_owned_overhealth
					);

				_ref_status._val_status_remaining =
					_val_owned_overhealth;
			}
			else{

				_ref_target._val_overhealth +=
					_ref_status._val_status_remaining;
			}

		break;


		//=====//
		//BLOOM//
		//=====//
		case "BLOOM":

			var _val_owned_overhealth =
				min(
					_ref_status._val_status_remaining,
					_ref_source._val_overhealth
				);

			if (_str_action == "REMOVE"){

				_ref_source._val_overhealth =
					max(
						0,
						_ref_source._val_overhealth -
						_val_owned_overhealth
					);

				_ref_status._val_status_remaining =
					_val_owned_overhealth;
			}
			else{

				_ref_target._val_overhealth +=
					_ref_status._val_status_remaining;
			}

		break;


		//=============//
		//PACK INSTINCT//
		//=============//
		case "PACK_INSTINCT":

			if (_str_action == "REMOVE"){

				_ref_source._val_dmg_linear_bonus -=
					_ref_status._val_pack_damage_bonus;

				_ref_source._val_dmg_linear_bonus =
					max(
						0,
						_ref_source._val_dmg_linear_bonus
					);

				_ref_source._val_max_hp -=
					_ref_status._val_pack_max_hp_bonus;

				_ref_source._val_max_hp =
					max(
						1,
						_ref_source._val_max_hp
					);

				_ref_source._val_cur_hp =
					min(
						_ref_source._val_cur_hp,
						_ref_source._val_max_hp
					);

				_ref_status._val_pack_damage_bonus =
					0;

				_ref_status._val_pack_max_hp_bonus =
					0;
			}
			else{

				/*
					The Buff now belongs to the new host.

					Recalculate Pack Instinct from that Beast's
					current Minion count rather than carrying the
					old host's Minion-derived bonus across.
				*/
				_ref_status._scr_status(
					"TRIGGER",
					_ref_status
				);
			}

		break;
	}

	return true;
}