//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_EQUIP_HELD_ITEM
// FUNCTION: Equips a Held Item from Inventory to a target Party Beast.
//
//           Unequips and returns the previous Held Item when swapping.
//           Applies UNEQUIP and EQUIP effects and logs the final Held Item state.
//
//           UNIQUE HELD ITEMS:
//           Items with _flag_unique_team = true are limited to one equipped copy
//           across the active player Party. The Unique check occurs BEFORE any
//           inventory removal or old-item unequip, so a rejected equip leaves
//           the player's inventory and current Held Item state unchanged.
//           Rejected Unique equips use SCR_GUI_SPAWN_POPUP_ERROR.
//
// ARGUMENTS: _stct_new_item - Held Item being equipped.
//            _stct_target_unit - Persistent Party Beast receiving the item.
//            _val_popup_x/_val_popup_y - Feedback popup coordinates.
// RETURNS: True when the item is successfully equipped, otherwise false.
//
//===============================================================================//

function scr_inventory_equip_held_item(_stct_new_item,_stct_target_unit,_val_popup_x,_val_popup_y){

	#region VALIDATION

	if (
		!is_struct(_stct_new_item) ||
		!is_struct(_stct_target_unit)
	){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_new_item,
			"_str_item_type"
		) ||
		_stct_new_item._str_item_type !=
			"HELD"
	){
		return false;
	}

	if (
		!variable_struct_exists(
			_stct_new_item,
			"_scr_item"
		) ||
		_stct_new_item._scr_item ==
			undefined
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"NO EFFECT",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	#endregion

	#region UNIQUE TEAM VALIDATION

	if (
		!scr_inventory_can_equip_unique_held_item(
			_stct_new_item,
			_stct_target_unit
		)
	){

		scr_gui_spawn_popup_error(
			"ERR, 1 OF THOSE PER TEAM ALLOWED",
			60
		);

		scr_debug_log(
			"INVENTORY",
			"EQUIP",
			undefined,
			"UNIQUE HELD ITEM EQUIP BLOCKED" +
			" | ITEM: " +
			string_upper(
				string(
					_stct_new_item
						._str_item_name
				)
			) +
			" | ID: " +
			string_upper(
				string(
					_stct_new_item
						._str_item_id
				)
			) +
			" | TARGET: " +
			string_upper(
				string(
					_stct_target_unit
						._str_beast_name
				)
			) +
			" | REASON: 1 PER TEAM",
			"WARNING",
			"SCR_INVENTORY_EQUIP_HELD_ITEM"
		);

		return false;
	}

	#endregion

	#region GET OLD ITEM

	var _stct_old_item =
		_stct_target_unit
			._stct_beast_held_item;

	var _str_old_item_name =
		"EMPTY";

	if (
		is_struct(_stct_old_item)
	){

		_str_old_item_name =
			string_upper(
				string(
					_stct_old_item
						._str_item_name
				)
			);
	}

	#endregion

	#region REMOVE NEW ITEM

	if (
		!scr_inventory_remove_item(
			_stct_new_item,
			1
		)
	){

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		return false;
	}

	#endregion

	#region UNEQUIP OLD ITEM

	if (is_struct(_stct_old_item)){

		if (
			variable_struct_exists(
				_stct_old_item,
				"_scr_item"
			) &&
			_stct_old_item._scr_item !=
				undefined
		){

			_stct_old_item._scr_item(
				"UNEQUIP",
				_stct_old_item,
				_stct_target_unit
			);
		}

		scr_inventory_add_item_struct(
			_stct_old_item
		);
	}

	#endregion

	#region EQUIP NEW ITEM

	_stct_target_unit
		._stct_beast_held_item =
		_stct_new_item;

	var _flag_equipped =
		_stct_new_item._scr_item(
			"EQUIP",
			_stct_new_item,
			_stct_target_unit
		);

	#endregion

	#region ROLL BACK FAILURE

	if (!_flag_equipped){

		_stct_target_unit
			._stct_beast_held_item =
			_stct_old_item;

		scr_inventory_add_item_struct(
			_stct_new_item
		);

		if (is_struct(_stct_old_item)){

			scr_inventory_remove_item(
				_stct_old_item,
				1
			);

			if (
				variable_struct_exists(
					_stct_old_item,
					"_scr_item"
				) &&
				_stct_old_item._scr_item !=
					undefined
			){

				_stct_old_item._scr_item(
					"EQUIP",
					_stct_old_item,
					_stct_target_unit
				);
			}
		}

		scr_gui_spawn_popup_scrolling(
			"TEXT",
			"FAILED",
			undefined,
			c_white,
			_val_popup_x,
			_val_popup_y
		);

		scr_debug_log(
			"INVENTORY",
			"EQUIP",
			undefined,
			"HELD ITEM EQUIP FAILED" +
			" | ITEM: " +
			string_upper(
				string(
					_stct_new_item
						._str_item_name
				)
			) +
			" | TARGET: " +
			string_upper(
				string(
					_stct_target_unit
						._str_beast_name
				)
			) +
			" | PREVIOUS: " +
			_str_old_item_name +
			" | STATE ROLLED BACK",
			"WARNING",
			"SCR_INVENTORY_EQUIP_HELD_ITEM"
		);

		return false;
	}

	#endregion

	#region FEEDBACK

	scr_gui_spawn_popup_scrolling(
		"TEXT",
		"EQUIPPED",
		undefined,
		c_white,
		_val_popup_x,
		_val_popup_y
	);

	#endregion

	#region DEBUG EQUIP

	scr_debug_log(
		"INVENTORY",
		"EQUIP",
		undefined,
		"HELD ITEM EQUIPPED" +
		" | ITEM: " +
		string_upper(
			string(
				_stct_new_item
					._str_item_name
			)
		) +
		" | UID: " +
		string(
			_stct_new_item
				._uid_item
		) +
		" | HOLDER: " +
		string_upper(
			string(
				_stct_target_unit
					._str_beast_name
			)
		) +
		" | BEAST UID: " +
		string(
			_stct_target_unit
				._uid_beast
		) +
		" | PREVIOUS: " +
		_str_old_item_name,
		"INFO",
		"SCR_INVENTORY_EQUIP_HELD_ITEM"
	);

	#endregion

	return true;
}
