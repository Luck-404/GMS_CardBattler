//===============================================================================//
//
// SCRIPT: SCR_INVENTORY_ITEM_HELD_HEALING_FRUIT
// FUNCTION: Handles Healing Fruit held item behavior.
//           Triggers when the holder falls below 50% HP after taking damage.
//           Restores 50% of Max HP and consumes the battle-held item.
//
// ARGUMENTS: _str_state is the held-item behavior state.
//            _stct_item is the item struct and _ref_target is the holder.
// RETURNS: True when the requested behavior succeeds, otherwise false.
//
//===============================================================================//

function scr_inventory_item_held_healing_fruit(_str_state,_stct_item,_ref_target){

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
			//VALIDATE HOLDER//
			//----------------//
			if (!instance_exists(_ref_target)){
				return false;
			}

			if (_ref_target._val_cur_hp <= 0){
				return false;
			}

			//----------------//
			//CHECK HP THRESHOLD//
			//----------------//
			if (_ref_target._val_cur_hp >= (_ref_target._val_max_hp * 0.5)){
				return false;
			}

			//----------------//
			//HEAL HOLDER//
			//----------------//
			var _val_hp_before = _ref_target._val_cur_hp;
			var _val_heal = ceil(_ref_target._val_max_hp * 0.5);

			_ref_target._val_cur_hp = min(
				_ref_target._val_cur_hp + _val_heal,
				_ref_target._val_max_hp
			);

			var _val_healed = _ref_target._val_cur_hp - _val_hp_before;

			//----------------//
			//SPAWN FEEDBACK//
			//----------------//
			scr_gui_spawn_popup_scrolling(
				"TEXT",
				"+" + string(_val_healed),
				undefined,
				c_green,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			scr_gui_spawn_popup_trigger_banner(
				_stct_item._str_item_name + " " + _stct_item._str_trigger_text
			);

			return true;

		case "UNEQUIP":
			return true;
	}

	return false;
}