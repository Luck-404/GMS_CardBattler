//////////////////////////////////////////////////////////////////////
//							OBJ_THICK_TREE DRAW						//
//																	//
// > DRAW SELF SLIGHTLY TRANSPARENT WHEN A PLAYER IS BEHIND ME.		//
//////////////////////////////////////////////////////////////////////
if (place_meeting(x,y,obj_player) && obj_player.y-16 < self.y-50){
	image_alpha = 0.7;
} else {
	image_alpha = 1.0;	
}
draw_sprite(spr_large_terrain_circle,0,x,y);
draw_self();