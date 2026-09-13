//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_BURNING_ASH
// FUNCTION: Handles Burning Ash held item behavior.
//           Triggers only when the holder lands a physical card hit.
//           Has a 25% chance to apply 1 Burn to the struck target.
//
// ARGUMENTS: _str_state is the held-item behavior state and _stct_item is the item.
//            _ref_caster/_ref_target are combatants; _str_card_stat is the card stat.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_burning_ash(_str_state,_stct_item,_ref_caster,_ref_target,_str_card_stat){

	//================//
	//VALIDATE ITEM//
	//================//
	if (_stct_item == undefined){
		return false;
	}

	//================//
	//HANDLE STATE//
	//================//
	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			//----------------//
			//VALIDATE HIT//
			//----------------//
			if (!instance_exists(_ref_caster)){
				return false;
			}

			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_str_card_stat != "PHY"){
				return false;
			}

			//----------------//
			//ROLL BURN//
			//----------------//
			var _val_burn_roll = irandom_range(1,100);

			if (_val_burn_roll > 25){
				return false;
			}

			//----------------//
			//APPLY BURN//
			//----------------//
			global.ref_target_beast = _ref_target;

			scr_status_apply_dot("BURN");

			scr_gui_spawn_popup_trigger_banner(_stct_item._str_item_name);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}