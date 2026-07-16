//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_EMERALD_TALISMAN
// FUNCTION: Handles Emerald Talisman held item behavior.
//           Triggers once at turn start to summon a random Viridian minion.
//           Returns whether the trigger successfully resolved.
//
//===============================================================================//

function scr_item_held_emerald_talisman(_str_state,_stct_item,_stct_target_unit){

	if (_stct_target_unit == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			return true;
		break;

		case "TRIGGER":

			if (!instance_exists(_stct_target_unit)){
				return false;
			}

			if (ds_list_size(global.list_pool_viridian_minions) <= 0){
				return false;
			}

			var _it_minion = irandom(ds_list_size(global.list_pool_viridian_minions) - 1);
			var _str_minion = ds_list_find_value(global.list_pool_viridian_minions,_it_minion);

			scr_init_minion(
				_str_minion,
				undefined,
				_stct_target_unit,
				_stct_target_unit
			);

			audio_play_sound(snd_buff,0,false);
			
			return true;

		break;

		case "UNEQUIP":
			return true;
		break;
	}

	return false;
}