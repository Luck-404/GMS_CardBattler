//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_HEALING_FRUIT
// FUNCTION: Handles Healing Fruit held item behavior.
//           Triggers when the holder falls below 50% HP after taking damage.
//           Restores 50% of maximum HP and consumes the battle-held item.
//
//===============================================================================//

function scr_item_held_healing_fruit(_str_state,_stct_item,_ref_target){

	if (_stct_item == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			return true;
		break;

		case "TRIGGER":

			if (!instance_exists(_ref_target)){
				return false;
			}

			// DEAD BEASTS CANNOT EAT THE FRUIT
			if (_ref_target._val_cur_hp <= 0){
				return false;
			}

			// ONLY TRIGGER BELOW 50% HP
			if (_ref_target._val_cur_hp >= (_ref_target._val_max_hp * 0.5)){
				return false;
			}

			var _val_heal = ceil(_ref_target._val_max_hp * 0.5);

			_ref_target._val_cur_hp += _val_heal;
			_ref_target._val_cur_hp = min(_ref_target._val_cur_hp,_ref_target._val_max_hp);

			scr_spawn_popup_scrolling(
				"TEXT",
				"+" + string(_val_heal),
				undefined,
				c_green,
				_ref_target.x + irandom_range(-32,32),
				_ref_target.y - 24 + irandom_range(-32,32)
			);

			scr_spawn_popup_trigger_banner(_stct_item._str_item_name + " " + _stct_item._str_trigger_text);

			return true;

		break;

		case "UNEQUIP":
			return true;
		break;
	}

	return false;
}