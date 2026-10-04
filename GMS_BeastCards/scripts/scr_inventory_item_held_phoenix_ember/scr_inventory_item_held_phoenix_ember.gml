//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_PHOENIX_EMBER
// FUNCTION: Handles Phoenix Ember Held Item behavior.
//
//           On fatal damage:
//           - Prevents defeat.
//           - Removes every hosted Status effect except OUTLEVELED and the
//             remaining resurrection/death-prevention effects.
//           - Restores the holder to 5% Maximum HP, minimum 1 HP.
//           - Returns true so SCR_STATUS_TRY_SECOND_LIFE consumes the item and
//             cancels normal death handling.
//
//           Phoenix Ember resolves before Last Stand, Phoenix Rebirth, and
//           Second Life.
//
// ARGUMENTS: _str_state - EQUIP, TRIGGER, or UNEQUIP.
//            _stct_item - Phoenix Ember Item struct.
//            _ref_holder - Battle Beast holding Phoenix Ember for TRIGGER.
// RETURNS: True when the requested behavior resolves; otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_phoenix_ember(_str_state,_stct_item,_ref_holder=undefined){

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

			if (_ref_holder._val_cur_hp > 0){
				return false;
			}

			//================//
			//CLEAR EFFECTS//
			//================//
			scr_status_clear_for_phoenix_ember(
				_ref_holder
			);

			//================//
			//RESTORE 5% HP//
			//================//
			var _val_restore =
				max(
					1,
					ceil(
						_ref_holder._val_max_hp *
						0.05
					)
				);

			_ref_holder._val_cur_hp =
				min(
					_ref_holder._val_max_hp,
					_val_restore
				);

			//================//
			//FEEDBACK//
			//================//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"+" +
				string(
					_ref_holder._val_cur_hp
				) +
				" HP",
				undefined,
				c_green,
				_ref_holder.x,
				_ref_holder.y - 24
			);

			scr_gui_spawn_popup_trigger_banner(
				_stct_item._str_item_name
			);

			audio_play_sound(
				snd_battle_heal,
				0,
				false
			);

			//================//
			//DEBUG//
			//================//
			scr_debug_log_battle_trigger(
				"PHOENIX EMBER",
				_ref_holder,
				_ref_holder,
				"DEATH PREVENTED" +
				" | HP RESTORED: " +
				string(
					_ref_holder._val_cur_hp
				) +
				"/" +
				string(
					_ref_holder._val_max_hp
				),
				"SCR_INVENTORY_ITEM_HELD_PHOENIX_EMBER"
			);

			return true;

		case "UNEQUIP":
			return true;
	}

	#endregion

	return false;
}
