//////////////////////////////////////////////////////////////////////
//							OBJ_MINION DRAW							//
//																	//
// > DRAWS THE MINION'S SHADOW CIRCLE								//
//////////////////////////////////////////////////////////////////////
draw_self();
if (_minion_unit_attached != undefined){
	scr_rearrange_minion(self,_minion_unit_attached._creature_minion_limit);
}	
	
draw_sprite(spr_minion_circle,0,x,y+16);	

////////////////////////
// HOVER INTERACTIONS //
////////////////////////
if ((global.flag_gui_open == false) && position_meeting(mouse_x,mouse_y,self) && (global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CHANNEL || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_TARGET || global.player_enc_state=PLAYER_ENCOUNTER_STATE.PICK_CARD)){
	draw_sprite_ext(_minion_sprite,0,x,y,0.3,0.3,0,c_white,1);
} else { 
	draw_sprite_ext(_minion_sprite,0,x,y,0.2,0.2,0,c_white,1);
}
	
	
//leech icon
if(_minion_name == "Bloodbeak" || _minion_name == "Serpent"){
	draw_sprite(spr_minion_leech,0,x+16, y + 40);
}