//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_THORNPLATE
// FUNCTION: Handles Thornplate Held Item behavior.
//
//           When the holder is struck by direct Card damage, retaliates against
//           the attacker for 3 FIXED Neutral damage.
//
//           FIXED retaliation deliberately bypasses the direct-Card trigger
//           pipeline, preventing Thornplate from recursively triggering another
//           Thornplate.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Thornplate Item struct.
//            _ref_holder - Battle Beast holding Thornplate for TRIGGER.
//            _ref_attacker - Battle Beast that dealt the direct damage.
// RETURNS: True when the requested behavior resolves; otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_thornplate(_str_state,_stct_item,_ref_holder=undefined,_ref_attacker=undefined){

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
			if (!instance_exists(_ref_holder)){
				return false;
			}

			//==================//
			//VALIDATE ATTACKER//
			//==================//
			if (!instance_exists(_ref_attacker)){
				return false;
			}

			if (_ref_attacker._val_cur_hp <= 0){
				return false;
			}

			if (_ref_attacker._str_team == _ref_holder._str_team){
				return false;
			}

			//================//
			//TRIGGER FEEDBACK//
			//================//
			scr_gui_spawn_popup_trigger_banner(
				_stct_item._str_item_name
			);

			//================//
			//RETALIATE//
			//================//
			return scr_battle_damage_target(
				"FIXED",
				undefined,
				_ref_attacker,
				3
			);

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
