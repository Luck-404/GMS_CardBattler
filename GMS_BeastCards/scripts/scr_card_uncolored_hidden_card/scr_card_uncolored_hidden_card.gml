//
//
// SCRIPT: SCR_CARD_UNCOLORED_STRIKE | Melee, ST, Deals [linear] melee damage | RETURNS VOID
//
//
function scr_card_uncolored_hidden_card(_card,_caster,_target){
	scr_draw_battle_cards(1);
	
	//PLAY ANIMATION
	
	//PLAY SOUND
	
	//POPUP
	scr_spawn_scrolling_popup("TEXT","+1 CARD",undefined,c_black,room_width/2-300,room_height/2);			
}