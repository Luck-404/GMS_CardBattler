//===============================================================================//
//
// SCRIPT: SCR_STATUS_ADD_BLIGHT_VIAL_STACK
// FUNCTION: Adds exactly 1 bonus stack to an already-created stackable DoT.
//
//           Called only by SCR_STATUS_APPLY_DOT after the normal DoT APPLY has
//           succeeded and only when the actual caster holds Blight Vial.
//
//           This does not run the generic DoT application a second time, so the
//           bonus cannot duplicate application-only effects such as Bloodlet,
//           Plague Garden, shared DoT Traps, or application VFX/SFX.
//
//           Per-stack mechanical state is updated where required.
//
// ARGUMENTS: _str_status_name - DoT Status ID.
//            _ref_status - Newly created stackable DoT Status.
//            _ref_target - DoT host.
//            _val_lifetime - Original incoming lifetime.
// RETURNS: True when 1 bonus stack was added, otherwise false.
//
//===============================================================================//

function scr_status_add_blight_vial_stack(_str_status_name,_ref_status,_ref_target,_val_lifetime=undefined){

	#region VALIDATION

	if (!instance_exists(_ref_status)){
		return false;
	}

	if (!instance_exists(_ref_target)){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_status,
			"_flag_status_stackable"
		) ||
		!_ref_status._flag_status_stackable
	){
		return false;
	}

	if (
		!variable_instance_exists(
			_ref_status,
			"_ct_status_stacks"
		)
	){
		return false;
	}

	_str_status_name =
		string_upper(
			string(
				_str_status_name
			)
		);

	#endregion

	#region ADD EXACT STACK

	switch (_str_status_name){

		//==============//
		//STORMSTRUCK//
		//==============//
		case "STORMSTRUCK":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

			scr_battle_trigger_discharge(
				_ref_target
			);

		break;

		//===========//
		//FROSTBITE//
		//===========//
		case "FROSTBITE":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

			//==================//
			//REDUCE MAXIMUM HP//
			//==================//
			if (_ref_target._val_max_hp > 1){

				_ref_target._val_max_hp--;

				if (
					variable_instance_exists(
						_ref_status,
						"_val_frostbite_max_hp_reduction"
					)
				){

					_ref_status
						._val_frostbite_max_hp_reduction++;
				}

				_ref_target._val_cur_hp =
					min(
						_ref_target._val_cur_hp,
						_ref_target._val_max_hp
					);
			}

			//================//
			//REDUCE PHYDEF//
			//================//
			var _val_pdef_before =
				_ref_target
					._ref_unit
					._val_beast_pdef_stat;

			_ref_target
				._ref_unit
				._val_beast_pdef_stat =
				max(
					0,
					_val_pdef_before - 1
				);

			if (
				variable_instance_exists(
					_ref_status,
					"_val_frostbite_pdef_reduction"
				)
			){

				_ref_status
					._val_frostbite_pdef_reduction +=
					_val_pdef_before -
					_ref_target
						._ref_unit
						._val_beast_pdef_stat;
			}

			//================//
			//REDUCE MAGDEF//
			//================//
			var _val_mdef_before =
				_ref_target
					._ref_unit
					._val_beast_mdef_stat;

			_ref_target
				._ref_unit
				._val_beast_mdef_stat =
				max(
					0,
					_val_mdef_before - 1
				);

			if (
				variable_instance_exists(
					_ref_status,
					"_val_frostbite_mdef_reduction"
				)
			){

				_ref_status
					._val_frostbite_mdef_reduction +=
					_val_mdef_before -
					_ref_target
						._ref_unit
						._val_beast_mdef_stat;
			}

		break;

		//=======//
		//VENOM//
		//=======//
		case "VENOM":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

			//===================//
			//REDUCE TARGET STATS//
			//===================//
			var _val_old_ppow =
				_ref_target
					._ref_unit
					._val_beast_ppow_stat;

			var _val_old_mpow =
				_ref_target
					._ref_unit
					._val_beast_mpow_stat;

			var _val_old_pdef =
				_ref_target
					._ref_unit
					._val_beast_pdef_stat;

			var _val_old_mdef =
				_ref_target
					._ref_unit
					._val_beast_mdef_stat;

			_ref_target._ref_unit._val_beast_ppow_stat =
				max(
					0,
					_val_old_ppow - 4
				);

			_ref_target._ref_unit._val_beast_mpow_stat =
				max(
					0,
					_val_old_mpow - 4
				);

			_ref_target._ref_unit._val_beast_pdef_stat =
				max(
					0,
					_val_old_pdef - 4
				);

			_ref_target._ref_unit._val_beast_mdef_stat =
				max(
					0,
					_val_old_mdef - 4
				);

			if (
				variable_instance_exists(
					_ref_status,
					"_val_venom_ppow_reduction"
				)
			){

				_ref_status._val_venom_ppow_reduction +=
					_val_old_ppow -
					_ref_target
						._ref_unit
						._val_beast_ppow_stat;
			}

			if (
				variable_instance_exists(
					_ref_status,
					"_val_venom_mpow_reduction"
				)
			){

				_ref_status._val_venom_mpow_reduction +=
					_val_old_mpow -
					_ref_target
						._ref_unit
						._val_beast_mpow_stat;
			}

			if (
				variable_instance_exists(
					_ref_status,
					"_val_venom_pdef_reduction"
				)
			){

				_ref_status._val_venom_pdef_reduction +=
					_val_old_pdef -
					_ref_target
						._ref_unit
						._val_beast_pdef_stat;
			}

			if (
				variable_instance_exists(
					_ref_status,
					"_val_venom_mdef_reduction"
				)
			){

				_ref_status._val_venom_mdef_reduction +=
					_val_old_mdef -
					_ref_target
						._ref_unit
						._val_beast_mdef_stat;
			}

		break;

		//========================//
		//NORMAL STACK-ONLY DOTS//
		//========================//
		case "BLEED":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 4;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

		break;

		case "BURN":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 3;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

		break;

		case "POISON":

			_ref_status._ct_status_stacks++;

			if (_val_lifetime == undefined){
				_val_lifetime = 5;
			}

			scr_status_refresh_lifetime(
				_ref_status,
				max(
					1,
					_val_lifetime
				)
			);

		break;

		case "FROSTBURN":

			_ref_status._ct_status_stacks++;

		break;

		default:

			_ref_status._ct_status_stacks++;

		break;
	}

	#endregion

	scr_status_reposition(
		_ref_target
	);

	return true;
}
