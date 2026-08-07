//===============================================================================//
//
// SCRIPT: SCR_TRAP_THORN_NET
// FUNCTION: Handles Thorn Net activation.
//           Cancels the trapped Beast's next Attack.
//           Deals 4 neutral damage and applies Vulnerable.
//           Consumes the Trap after activation.
//
//===============================================================================//
function scr_trap_thorn_net(_str_tag,_ref_trap,_ref_attacker,_ref_target,_stct_card){

	switch(_str_tag){

		case "TRIGGER":

			if (!instance_exists(_ref_trap)){
				return false;
			}

			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (
				_stct_card == undefined ||
				_stct_card._str_card_type != "ATTACK"
			){
				return false;
			}

			_ref_trap._flag_triggered =
				true;

			//----------------//
			//REVEAL TRAP//
			//----------------//
			scr_spawn_popup_trigger_banner(
				"TRAP TRIGGERED: THORN NET"
			);

			//-----------------------//
			//VALIDATE TRAP CONTEXT//
			//-----------------------//
			if (
				!instance_exists(_ref_trap._ref_owner) ||
				!instance_exists(_ref_trap._ref_source_card)
			){

				scr_destroy_trap(_ref_trap);

				return true;
			}

			//----------------------//
			//STORE CURRENT CONTEXT//
			//----------------------//
			var _ref_original_caster =
				global.ref_caster_beast;

			var _ref_original_target =
				global.ref_target_beast;

			var _ref_original_card =
				global.ref_cast_card;

			//------------------//
			//SET TRAP CONTEXT//
			//------------------//
			global.ref_caster_beast =
				_ref_trap._ref_owner;

			global.ref_target_beast =
				_ref_attacker;

			global.ref_cast_card =
				_ref_trap._ref_source_card;

			//------------//
			//DEAL DAMAGE//
			//------------//
			scr_damage_target(
				_ref_trap._val_magnitude,
				_ref_attacker
			);

			//------------------//
			//APPLY VULNERABLE//
			//------------------//
			if (
				instance_exists(_ref_attacker) &&
				_ref_attacker._val_cur_hp > 0
			){

				global.ref_target_beast =
					_ref_attacker;

				scr_apply_debuff_status(
					"VULNERABLE"
				);
			}

			//----------------//
			//RESTORE CONTEXT//
			//----------------//
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

			//---------------//
			//CANCEL ATTACK//
			//---------------//
			return true;

		break;
	}

	return false;
}