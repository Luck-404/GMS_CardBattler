//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_echo(_card,_caster,_target){
	global.echo_counter+=_card[?"card_magnitude"];
	
	//PLAY ANIMATION
	
	//PLAY SOUND
	
	//POPUP
	scr_spawn_popup_scrolling("TEXT","+1 ECHO",undefined,c_white,room_width/2-300,room_height/2);			
}