//////////////////////////////////////////////////////////////////////
//							OBJ_TREE DRAW						//
//																	//
// > DRAW SELF SLIGHTLY TRANSPARENT WHEN A PLAYER IS BEHIND ME.		//
//////////////////////////////////////////////////////////////////////
if (place_meeting(x,y,obj_player) && obj_player.y-16 < self.y){
	image_alpha = 0.7;
} else {
	image_alpha = 1.0;	
}
draw_sprite(spr_small_terrain_circle,0,x,y);
draw_self();