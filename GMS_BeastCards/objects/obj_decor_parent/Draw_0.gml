//===============================================================================//
//
// DRAW: OBJ_DECOR_PARENT
// FUNCTION:	Draws a shared ground shadow beneath decor objects
//				Fades decorations when overlapping the player
//				Renders common decoration visuals for child objects
//
//===============================================================================//

//—------------------------------------------------------------------------------//
// DRAW SHADOW
//—------------------------------------------------------------------------------//
draw_sprite_ext(spr_decor_shadow,image_index,x,y,_val_shadow_scalar,_val_shadow_scalar,0,c_white,1);

//—------------------------------------------------------------------------------//
// ADJUST OPACITY WHEN TOUCHING PLAYER
//—------------------------------------------------------------------------------//
if (instance_place(x,y-12,obj_player)){	//MAKE DULL WHEN TOUCHING PLAYER
	draw_sprite_ext(sprite_index,0,x,y,1,1,0,c_white,0.75);
}
else { //ELSE DRAW NORMALLY
	draw_self();	
}

