//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_BURNING_ASH
// FUNCTION: Handles Burning Ash held item behavior.
//           Triggers only when the holder lands a physical card hit.
//           Rolls a chance to apply one Burn stack to the struck target.
//
//===============================================================================//

function scr_item_held_burning_ash(_str_state,_stct_item,_ref_caster,_ref_target,_str_card_stat){

	if (_stct_item == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			return true;
		break;

		case "TRIGGER":

			if (!instance_exists(_ref_caster)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_str_card_stat != "PHY"){
				return false;
			}

			var _val_burn_roll = irandom_range(1,100);

			if (_val_burn_roll > 25){
				return false;
			}

			global.ref_target_beast = _ref_target;

			scr_apply_dot_status("BURN");

			scr_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		break;

		case "UNEQUIP":
			return true;
		break;
	}

	return false;
}