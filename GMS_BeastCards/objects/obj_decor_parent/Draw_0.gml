//
//
// DRAW: OBJ_DECOR
//
//
//DRAW SHADOW
draw_sprite_ext(spr_decor_shadow,image_index,x,y,1*_shadow_scalar,0.5*_shadow_scalar,0,c_white,1);

//MAKE DULL WHEN TOUCHING PLAYER
if (instance_place(x,y-12,obj_player)){
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.75);
}
//ELSE DRAW NORMALLY when player is nearby
else if (distance_to_object(obj_player) < 32){
	draw_self();	
}
else {
	draw_self();	
}

