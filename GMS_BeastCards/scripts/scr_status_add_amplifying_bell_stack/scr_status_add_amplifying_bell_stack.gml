//===============================================================================//
//
// SCRIPT: SCR_STATUS_ADD_AMPLIFYING_BELL_STACK
// FUNCTION: Adds exactly 1 bonus stack to an already-created stackable Buff.
//
//           Called only by SCR_STATUS_APPLY_BUFF after the normal Buff APPLY has
//           succeeded and only when the actual caster holds Amplifying Bell.
//
//           The helper preserves Buff-specific mechanical state where adding a
//           stack requires more than incrementing _ct_status_stacks.
//
// ARGUMENTS: _ref_status - Newly created stackable Buff Status.
//            _ref_target - Buff host.
//            _val_magnitude - Original incoming Buff magnitude.
//            _val_lifetime - Original incoming Buff lifetime.
// RETURNS: True when 1 bonus stack was added, otherwise false.
//
//===============================================================================//

function scr_status_add_amplifying_bell_stack(_ref_status,_ref_target,_val_magnitude=undefined,_val_lifetime=undefined){

	#region VALIDATION

	if (!instance_exists(_ref_status)){
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

	var _str_status_name =
		string_upper(
			string(
				_ref_status._str_status_name
			)
		);

	#endregion

	#region ADD EXACT STACK

	switch (_str_status_name){

		//================//
		//BATTLE FRENZY//
		//================//
		case "BATTLE_FRENZY":

			_ref_status._ct_status_stacks++;

			_ref_status._str_status_desc =
				"NEXT ATTACK: " +
				string(
					_ref_status._ct_status_stacks
				) +
				" DAMAGE-ONLY NEU REPEAT(S) AT 25% EACH.";

		break;

		//===============//
		//APEX PREDATOR//
		//===============//
		case "APEX_PREDATOR":

			_ref_status._ct_status_stacks++;

			if (
				instance_exists(_ref_target) &&
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				_ref_target._val_dmg_linear_bonus +=
					_ref_status._val_status_magnitude;

				var _val_total_damage =
					_ref_status._ct_status_stacks *
					_ref_status._val_status_magnitude;

				_ref_status._str_status_desc =
					"+" +
					string(
						_val_total_damage
					) +
					" LINEAR DAMAGE | +" +
					string(
						_ref_status._val_status_magnitude
					) +
					" PER STACK";
			}

		break;

		//=============//
		//SECOND WIND//
		//=============//
		case "SECOND_WIND":

			_ref_status._ct_status_stacks++;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				var _val_total_bonus =
					_ref_status._val_status_magnitude *
					_ref_status._ct_status_stacks;

				_ref_status._str_status_desc =
					"NEXT ATTACK: +" +
					string(
						_val_total_bonus
					) +
					"% DIRECT DAMAGE (" +
					string(
						_ref_status._val_status_magnitude
					) +
					"% PER STACK)";
			}

		break;

		//============//
		//TOXIC HIDE//
		//============//
		case "TOXIC_HIDE":

			_ref_status._ct_status_stacks++;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				var _ct_total_poison =
					_ref_status._ct_status_stacks *
					_ref_status._val_status_magnitude;

				_ref_status._str_status_desc =
					"MELEE ATTACKERS RECEIVE " +
					string(
						_ct_total_poison
					) +
					" POISON";
			}

		break;

		//==============//
		//NATURES BOND//
		//==============//
		case "NATURES_BOND":

			_ref_status._ct_status_stacks++;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				_ref_status._str_status_desc =
					"WHEN HEALED, GAIN " +
					string(
						_ref_status._val_status_magnitude
					) +
					" ARMOR PER STACK";
			}

		break;

		//==============//
		//REGENERATION//
		//==============//
		case "REGENERATION":

			_ref_status._ct_status_stacks++;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				var _val_stack_magnitude =
					_val_magnitude;

				if (!is_real(_val_stack_magnitude)){
					_val_stack_magnitude = 1;
				}

				_val_stack_magnitude =
					max(
						1,
						_val_stack_magnitude
					);

				_ref_status._val_status_magnitude +=
					_val_stack_magnitude;

				_ref_status._str_status_desc =
					"HEAL " +
					string(
						_ref_status._val_status_magnitude
					) +
					" HP AT ROUND START";
			}

		break;

		//========//
		//THORNS//
		//========//
		case "THORNS":

			_ref_status._ct_status_stacks++;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){

				var _val_stack_magnitude =
					_val_magnitude;

				if (!is_real(_val_stack_magnitude)){
					_val_stack_magnitude = 3;
				}

				_val_stack_magnitude =
					max(
						0,
						_val_stack_magnitude
					);

				_ref_status._val_status_magnitude +=
					_val_stack_magnitude;

				_ref_status._str_status_desc =
					"MELEE ATTACKERS TAKE " +
					string(
						_ref_status._val_status_magnitude
					) +
					" NEUTRAL DAMAGE";
			}

		break;

		//============//
		//OVERHEALTH//
		//============//
		case "OVERHEALTH":

			if (
				!instance_exists(_ref_target) ||
				!variable_instance_exists(
					_ref_status,
					"_val_status_magnitude"
				)
			){
				return false;
			}

			var _val_stack_amount =
				max(
					0,
					_ref_status._val_status_magnitude
				);

			_ref_target._val_overhealth +=
				_val_stack_amount;

			if (
				variable_instance_exists(
					_ref_status,
					"_val_status_remaining"
				)
			){

				_ref_status._val_status_remaining +=
					_val_stack_amount;
			}

			_ref_status._ct_status_stacks++;

		break;

		//================//
		//GENERIC STACK//
		//================//
		default:

			_ref_status._ct_status_stacks++;

		break;
	}

	#endregion

	#region PRESENTATION SYNC

	if (
		instance_exists(_ref_target)
	){
		scr_status_reposition(
			_ref_target
		);
	}

	#endregion

	return true;
}
