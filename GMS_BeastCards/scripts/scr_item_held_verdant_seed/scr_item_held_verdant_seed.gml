//===============================================================================//
//
// SCRIPT: SCR_ITEM_HELD_VERDANT_SEED
// FUNCTION: Handles Verdant Seed held item behavior.
//           Triggers SEEDFALL when activated in battle.
//           Returns whether the trigger successfully resolved.
//
//===============================================================================//

function scr_item_held_verdant_seed(_str_state,_stct_item,_stct_target_unit){

	if (_stct_target_unit == undefined){
		return false;
	}

	switch(_str_state){

		case "EQUIP":
			return true;
		break;

		case "TRIGGER":

			scr_apply_weather_status("SEEDFALL");

			audio_play_sound(snd_buff,0,false);

			return true;

		break;

		case "UNEQUIP":
			return true;
		break;
	}

	return false;
}