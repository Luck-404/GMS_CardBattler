//===============================================================================//
//
// SCRIPT: SCR_CARD_UNCOLORED_CLEARCAST
// FUNCTION: Resolves the Clearcast card effect.
//           Removes the active weather event, if one exists.
//           Plays the associated animation, sound, and popup effects.
//
//===============================================================================//
function scr_card_uncolored_clearcast(_stct_card,_ref_caster,_ref_target){

	//---------------------//
	//REMOVE ACTIVE WEATHER//
	//---------------------//
	var _ref_status = scr_check_for_status("WEATHER: RAPID GROWTH",global.list_statuses);

	if (_ref_status != -1){
		var _id_layer = layer_get_id("bly_event");
		layer_background_change(_id_layer,spr_bg_blank);
		scr_destroy_status(_ref_status);
	}

	//----------------//
	//PLAY ANIMATION//
	//----------------//

	//-----------//
	//PLAY SOUND//
	//-----------//
	audio_play_sound(snd_buff,0,false);
	
	//-------------//
	//SPAWN POPUP//
	//-------------//
	scr_spawn_popup_scrolling("TEXT","WEATHER CLEARED",undefined,c_black,room_width / 2 - 300,room_height / 2);
}