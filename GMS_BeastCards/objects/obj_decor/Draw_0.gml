//
//
// DRAW: OBJ_DECOR
//
//

//MAKE DULL WHEN TOUCHING PLAYER
if (instance_place(x,y-(sprite_height/2)+16,obj_player)){
	depth = -100;
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.75);
}
//ELSE DRAW NORMALLY
else{
	depth = 100;
	draw_self();	
}

//DRAW SHADOW
draw_sprite_ext(spr_decor_shadow,0,x,y,0.75,0.75,0,c_white,1);