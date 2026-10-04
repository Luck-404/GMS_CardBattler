//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_HEALING_FRUIT
// FUNCTION: Handles Healing Fruit Held Item behavior.
//
//           After the holder takes direct HP damage, the normal ON_TARGET Held
//           Item hook calls TRIGGER.
//
//           If the holder is alive and below 50% Maximum HP, Healing Fruit
//           attempts to restore 25% Maximum HP through the normal FIXED healing
//           pipeline. This preserves Antiheal/Event/healing-modifier behavior.
//
//           A successful trigger consumes the Held Item.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Healing Fruit Item struct.
//            _ref_target - Holder receiving the heal.
// RETURNS: True when the Fruit successfully heals and should be consumed;
//          otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_healing_fruit(_str_state,_stct_item,_ref_target=undefined){

	#region VALIDATION

	if (!is_struct(_stct_item)){
		return false;
	}

	#endregion

	#region HANDLE STATE

	switch (_str_state){

		case "EQUIP":
			return true;

		case "TRIGGER":

			//================//
			//VALIDATE HOLDER//
			//================//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_ref_target._val_cur_hp <= 0){
				return false;
			}

			//================//
			//CHECK THRESHOLD//
			//================//
			if (
				_ref_target._val_cur_hp >=
				(
					_ref_target._val_max_hp *
					0.5
				)
			){
				return false;
			}

			//================//
			//HEAL 25% MAX HP//
			//================//
			var _val_heal =
				max(
					1,
					ceil(
						_ref_target._val_max_hp *
						0.25
					)
				);

			if (
				!scr_battle_heal_target(
					"FIXED",
					_val_heal,
					_ref_target
				)
			){
				return false;
			}

			//================//
			//TRIGGER FEEDBACK//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				_stct_item._str_item_name +
				" " +
				_stct_item._str_trigger_text
			);

			return true;

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
