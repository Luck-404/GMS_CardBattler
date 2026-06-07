//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_clearcast(){
	var _status = scr_check_unit_status("WEATHER: RAPID GROWTH",global.statuses);
	if (_status != -1){
		//UNDO RAIN EFFECT
		var _lid = layer_get_id("bly_event")
		layer_background_change(_lid,spr_bg_blank);
		scr_destroy_status(_status);		
	}

	//PLAY ANIMATION
	
	//PLAY SOUND
	
	//POPUP
	scr_spawn_scrolling_popup("TEXT","WEATHER CLEARED",undefined,c_black,room_width/2-300,room_height/2);
}