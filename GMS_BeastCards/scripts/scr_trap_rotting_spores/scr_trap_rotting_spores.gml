//===============================================================================//
//
// SCRIPT: SCR_TRAP_ROTTING_SPORES
// FUNCTION: Handles Rotting Spores activation.
//           Cancels the next healing received by its host.
//           Deals 5 magical damage and applies 1 Venom.
//           Consumes the Trap after activation.
//
//===============================================================================//
function scr_trap_rotting_spores(
	_str_tag,
	_ref_trap,
	_ref_attacker,
	_ref_target,
	_stct_card
){

	switch(_str_tag){

		//-------//
		//TRIGGER//
		//-------//
		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			//-----------------------//
			//VALIDATE TRAP CONTEXT//
			//-----------------------//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card)
			){

				show_debug_message(
					"ROTTING SPORES ERROR | INVALID OWNER OR SOURCE CARD"
				);

				return false;
			}

			if (
				!is_struct(
					_ref_trap
						._ref_source_card
						._ref_card
				)
			){

				show_debug_message(
					"ROTTING SPORES ERROR | INVALID SOURCE CARD STRUCT"
				);

				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: ROTTING SPORES"
			);

			//----------------------//
			//STORE CURRENT CONTEXT//
			//----------------------//
			var _ref_original_caster =
				global.ref_caster_beast;

			var _ref_original_target =
				global.ref_target_beast;

			var _ref_original_card =
				global.ref_cast_card;

			var _str_original_stat =
				_ref_trap
					._ref_source_card
					._ref_card
					._str_card_stat;

			//------------------//
			//SET TRAP CONTEXT//
			//------------------//
			global.ref_caster_beast =
				_ref_trap._ref_owner;

			global.ref_target_beast =
				_ref_target;

			global.ref_cast_card =
				_ref_trap._ref_source_card;

			_ref_trap
				._ref_source_card
				._ref_card
				._str_card_stat =
					"MAG";

			//-------------------//
			//DEAL MAGIC DAMAGE//
			//-------------------//
			var _flag_damage =
				scr_damage_target(
					_ref_trap._val_magnitude,
					_ref_target
				);

			show_debug_message(
				"ROTTING SPORES DAMAGE RESULT: " +
				string(_flag_damage)
			);

			//-------------//
			//APPLY VENOM//
			//-------------//
			if (
				instance_exists(_ref_target) &&
				_ref_target._val_cur_hp > 0
			){

				global.ref_target_beast =
					_ref_target;

				var _ref_venom =
					scr_apply_dot_status(
						"VENOM"
					);

				show_debug_message(
					"ROTTING SPORES VENOM RESULT: " +
					string(_ref_venom)
				);
			}

			//----------------//
			//RESTORE CONTEXT//
			//----------------//
			_ref_trap
				._ref_source_card
				._ref_card
				._str_card_stat =
					_str_original_stat;

			global.ref_caster_beast =
				_ref_original_caster;

			global.ref_target_beast =
				_ref_original_target;

			global.ref_cast_card =
				_ref_original_card;

			//-------------//
			//DESTROY TRAP//
			//-------------//
			scr_destroy_trap(
				_ref_trap
			);

			//----------------//
			//CANCEL HEALING//
			//----------------//
			return true;

		break;
	}

	return false;
}