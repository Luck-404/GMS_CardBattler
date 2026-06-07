//
//
//
//
//
function scr_apply_event_status(_name){
	switch(_name){
		case "RAPID GROWTH":
			scr_status_event_rapid_growth("APPLY",undefined);
			//POPUP
			scr_spawn_scrolling_popup("TEXT","WEATHER: RAPID GROWTH",undefined,c_black,room_width/2,room_height/2);					
		break;
	}
}